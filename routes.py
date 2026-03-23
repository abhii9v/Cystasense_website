from flask import render_template, session, request, redirect, url_for, flash, jsonify, send_from_directory, make_response
from flask_wtf.csrf import CSRFProtect
from flask_login import LoginManager, login_user, logout_user, current_user, login_required
from werkzeug.security import generate_password_hash, check_password_hash
from app import app, db
from models import *
from datetime import datetime, date, timedelta
import json
import uuid
import logging

# Initialize CSRF protection
csrf = CSRFProtect(app)

# Initialize login manager
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login'
login_manager.login_message = 'Please log in to access this page.'
login_manager.session_protection = 'basic'
login_manager.login_message_category = 'info'

@login_manager.user_loader
def load_user(user_id):
    try:
        return User.query.get(user_id)
    except Exception as e:
        logging.error(f"Error loading user {user_id}: {str(e)}")
        # Try to reconnect to database
        try:
            db.session.rollback()
            db.session.execute(db.text('SELECT 1'))
            return User.query.get(user_id)
        except:
            return None

# Make session permanent
@app.before_request
def make_session_permanent():
    session.permanent = True

@app.route('/favicon.ico')
def favicon():
    """Serve favicon"""
    return send_from_directory(app.static_folder, 'images/cystasense-logo.png', mimetype='image/png')

@app.route('/')
def index():
    """Landing page - shows different content based on login status"""
    # Quick health check response for deployment - no cookies = likely health check
    if not request.cookies:
        return 'OK', 200
    
    try:
        if current_user.is_authenticated:
            return redirect(url_for('dashboard'))
    except Exception:
        # Database not ready yet, just show landing page
        pass
    return render_template('landing.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    """Login page and handler"""
    if current_user.is_authenticated:
        return redirect(url_for('dashboard'))
        
    if request.method == 'POST':
        email = request.form.get('email', '').strip()
        password = request.form.get('password')
        remember = bool(request.form.get('remember_me'))
        
        if not email or not password:
            flash('Please provide both email and password.', 'error')
            return render_template('login.html')
        
        try:
            # Case-insensitive email lookup
            user = User.query.filter(db.func.lower(User.email) == email.lower()).first()
            
            if not user:
                logging.warning(f"Login failed: User not found for email {email}")
                flash('Account not found. Please check your email for typos (like "gmai.com" vs "gmail.com") or sign up if you\'re new.', 'error')
                return render_template('login.html')
            
            if not user.password_hash:
                logging.warning(f"Login failed: No password hash for user {email}")
                flash('This account was created with a different login method. Please use the appropriate sign-in option.', 'error')
                return render_template('login.html')
            
            if not check_password_hash(user.password_hash, password):
                logging.warning(f"Login failed: Invalid password for user {email}")
                flash('Incorrect password. Please try again. Passwords are case-sensitive.', 'error')
                return render_template('login.html')
            
            # Successful login
            user.last_login = datetime.now()
            db.session.commit()
            login_user(user, remember=remember, duration=None)
            logging.info(f"Successful login for user {email}")
            next_page = request.args.get('next')
            return redirect(next_page) if next_page else redirect(url_for('dashboard'))
            
        except Exception as e:
            logging.error(f"Login error for {email}: {str(e)}")
            flash('A system error occurred. Please try again.', 'error')
            # Try to wake up database if it's suspended
            try:
                db.session.rollback()
                db.session.execute(db.text('SELECT 1'))
                db.session.commit()
            except:
                pass
            
    return render_template('login.html')

@app.route('/register', methods=['GET', 'POST'])
def register():
    """Registration page and handler"""
    if current_user.is_authenticated:
        return redirect(url_for('dashboard'))
        
    if request.method == 'POST':
        first_name = request.form.get('first_name')
        last_name = request.form.get('last_name') 
        email = request.form.get('email')
        password = request.form.get('password')
        confirm_password = request.form.get('confirm_password')
        
        if not all([first_name, last_name, email, password, confirm_password]):
            flash('Please fill in all fields.', 'error')
            return render_template('register.html')
            
        if password != confirm_password:
            flash('Passwords do not match.', 'error')
            return render_template('register.html')
            
        if User.query.filter_by(email=email).first():
            flash('Email already registered. Please use a different email.', 'error')
            return render_template('register.html')
            
        user = User()
        user.id = str(uuid.uuid4())
        user.first_name = first_name
        user.last_name = last_name
        user.email = email
        user.set_password(password)
        user.is_active = True
        user.created_at = datetime.now()
        user.updated_at = datetime.now()
        
        try:
            db.session.add(user)
            db.session.commit()
            login_user(user)
            flash('Welcome to CystaSense! Let\'s personalize your experience.', 'success')
            return redirect(url_for('onboarding_role'))
        except Exception as e:
            db.session.rollback()
            flash('Registration failed. Please try again.', 'error')
            
    return render_template('register.html')

@app.route('/logout')
def logout():
    """Logout handler"""
    logout_user()
    flash('You have been logged out.', 'info')
    return redirect(url_for('index'))

@app.route('/dashboard')
@login_required
def dashboard():
    """Main dashboard for logged-in users"""
    # Check if onboarding is completed
    if not current_user.onboarding_completed:
        return redirect(url_for('onboarding_role'))
    
    # If user is a supporter, redirect to connections page
    if current_user.user_role == 'family_member':
        return redirect(url_for('family_connections'))
    
    # PCOS user - show their own dashboard
    user = current_user
    today_date = datetime.now().strftime('%a, %b %d, %Y')
    recent_symptoms = SymptomTracker.query.filter_by(user_id=user.id).order_by(SymptomTracker.date.desc()).limit(5).all()
    upcoming_reminders = Reminder.query.filter_by(user_id=user.id, is_completed=False).order_by(Reminder.reminder_time).limit(3).all()
    recent_cycle = MenstrualCycle.query.filter_by(user_id=user.id).order_by(MenstrualCycle.start_date.desc()).first()
    
    # Calculate health score based on symptom severity (same as analytics)
    recent_10_symptoms = SymptomTracker.query.filter_by(user_id=user.id).order_by(SymptomTracker.date.desc()).limit(10).all()
    health_score = 0
    health_status = "Getting Started"
    health_emoji = "📊"
    
    if recent_10_symptoms:
        total_scores = 0
        count = 0
        
        for symptom in recent_10_symptoms:
            # Sum up all severity scores (0-5 scale)
            if symptom.acne_severity:
                total_scores += symptom.acne_severity
                count += 1
            if symptom.fatigue_level:
                total_scores += symptom.fatigue_level
                count += 1
            if symptom.mood_swings:
                total_scores += symptom.mood_swings
                count += 1
            if symptom.anxiety_level:
                total_scores += symptom.anxiety_level
                count += 1
            if symptom.depression_level:
                total_scores += symptom.depression_level
                count += 1
        
        if count > 0:
            avg_severity = total_scores / count
            # Calculate inverted health score (lower symptoms = higher score)
            health_score = round(5 - avg_severity, 1)
            
            # Determine status based on 5-level system
            if health_score >= 4.5:
                health_status = "Excellent"
                health_emoji = "🌟"
            elif health_score >= 3.5:
                health_status = "Very Good"
                health_emoji = "💪"
            elif health_score >= 2.5:
                health_status = "Good"
                health_emoji = "😊"
            elif health_score >= 1.5:
                health_status = "Fair"
                health_emoji = "⚠️"
            else:
                health_status = "Needs Attention"
                health_emoji = "🚨"
    
    # Get unread message count
    unread_messages = SentNudge.query.filter_by(
        recipient_id=current_user.id,
        is_read=False
    ).count()
    
    # Get pending connection requests count (for PCOS users)
    pending_requests = FamilyConnection.query.filter_by(
        primary_user_id=current_user.id,
        connection_status='pending'
    ).count()
    
    response = make_response(render_template('dashboard.html',
                         today_date=today_date, 
                         user=user, 
                         recent_symptoms=recent_symptoms,
                         upcoming_reminders=upcoming_reminders,
                         recent_cycle=recent_cycle,
                         health_score=health_score,
                         health_status=health_status,
                         health_emoji=health_emoji,
                         unread_messages=unread_messages,
                         pending_requests=pending_requests))
    
    # Prevent browser caching to ensure dashboard always shows fresh data
    response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = '0'
    
    return response

# Awareness Module Routes
@app.route('/awareness')
def awareness():
    """Educational content and awareness section - shows learning modules"""
    # Get all published educational tracks
    pcos_tracks = EducationalTrack.query.filter_by(
        track_type='pcos_user',
        is_published=True
    ).order_by(EducationalTrack.order_index).all()
    
    family_tracks = EducationalTrack.query.filter_by(
        track_type='family_member',
        is_published=True
    ).order_by(EducationalTrack.order_index).all()
    
    return render_template('awareness.html', 
                         pcos_tracks=pcos_tracks,
                         family_tracks=family_tracks)

@app.route('/quiz')
@login_required
def quiz():
    """Self-assessment quizzes"""
    return render_template('quiz.html')

@app.route('/quiz/submit', methods=['POST'])
@login_required
def submit_quiz():
    """Handle quiz submission"""
    # CSRF protection handled by Flask-WTF
    data = request.json
    if not data:
        return jsonify({'status': 'error', 'message': 'No data provided'}), 400
    quiz_result = QuizResult(
        user_id=current_user.id,
        quiz_type=data.get('quiz_type'),
        score=data.get('score'),
        total_questions=data.get('total_questions'),
        answers=json.dumps(data.get('answers')),
        recommendations=data.get('recommendations')
    )
    db.session.add(quiz_result)
    db.session.commit()
    return jsonify({'status': 'success', 'message': 'Quiz completed successfully!'})

# Self-Management Module Routes
@app.route('/tracker')
@login_required
def tracker():
    """Symptom and cycle tracking"""
    # Get recent symptom history (last 30 entries)
    symptom_history = SymptomTracker.query.filter_by(user_id=current_user.id).order_by(SymptomTracker.date.desc()).limit(30).all()
    
    # Get recent cycle history (last 12 entries)
    cycle_history = MenstrualCycle.query.filter_by(user_id=current_user.id).order_by(MenstrualCycle.start_date.desc()).limit(12).all()
    
    # Calculate tracking progress for the last 7 days
    last_7_days = datetime.now().date() - timedelta(days=7)
    days_tracked = SymptomTracker.query.filter(
        SymptomTracker.user_id == current_user.id,
        SymptomTracker.date >= last_7_days
    ).with_entities(SymptomTracker.date).distinct().count()
    
    tracking_percentage = int((days_tracked / 7) * 100)
    
    return render_template('tracker.html', 
                         symptom_history=symptom_history, 
                         cycle_history=cycle_history,
                         days_tracked=days_tracked,
                         tracking_percentage=tracking_percentage)

@app.route('/tracker/symptoms', methods=['POST'])
@login_required
def log_symptoms():
    """Log daily symptoms"""
    data = request.json
    if not data:
        return jsonify({'status': 'error', 'message': 'No data provided'}), 400
    
    # Basic input validation
    date_str = data.get('date')
    if not date_str:
        return jsonify({'status': 'error', 'message': 'Date is required'}), 400
    
    try:
        date_obj = datetime.strptime(date_str, '%Y-%m-%d').date()
    except ValueError:
        return jsonify({'status': 'error', 'message': 'Invalid date format'}), 400
    symptom_log = SymptomTracker(
        user_id=current_user.id,
        date=datetime.strptime(data.get('date'), '%Y-%m-%d').date(),
        acne_severity=data.get('acne_severity'),
        hair_loss_level=data.get('hair_loss_level'),
        weight_gain_level=data.get('weight_gain_level'),
        fatigue_level=data.get('fatigue_level'),
        bloating_level=data.get('bloating_level'),
        mood_swings=data.get('mood_swings'),
        anxiety_level=data.get('anxiety_level'),
        depression_level=data.get('depression_level'),
        notes=data.get('notes')
    )
    db.session.add(symptom_log)
    db.session.commit()
    return jsonify({'status': 'success', 'message': 'Symptoms logged successfully!'})

@app.route('/tracker/cycle', methods=['POST'])
@login_required
def log_cycle():
    """Log menstrual cycle data"""
    data = request.json
    if not data:
        return jsonify({'status': 'error', 'message': 'No data provided'}), 400
    
    # Basic input validation
    start_date_str = data.get('start_date')
    if not start_date_str:
        return jsonify({'status': 'error', 'message': 'Start date is required'}), 400
    
    try:
        start_date_obj = datetime.strptime(start_date_str, '%Y-%m-%d').date()
    except ValueError:
        return jsonify({'status': 'error', 'message': 'Invalid start date format'}), 400
    end_date_obj = None
    if data.get('end_date'):
        try:
            end_date_obj = datetime.strptime(data.get('end_date'), '%Y-%m-%d').date()
        except ValueError:
            return jsonify({'status': 'error', 'message': 'Invalid end date format'}), 400
    
    cycle_log = MenstrualCycle(
        user_id=current_user.id,
        start_date=start_date_obj,
        end_date=end_date_obj,
        cycle_length=data.get('cycle_length'),
        flow_intensity=data.get('flow_intensity'),
        cramps_severity=data.get('cramps_severity'),
        mood_changes=data.get('mood_changes'),
        other_symptoms=data.get('other_symptoms')
    )
    db.session.add(cycle_log)
    db.session.commit()
    return jsonify({'status': 'success', 'message': 'Cycle data logged successfully!'})

@app.route('/diet-exercise')
@login_required
def diet_exercise():
    """Diet and exercise planning"""
    diet_plans = DietPlan.query.filter_by(user_id=current_user.id).order_by(DietPlan.date.desc()).limit(7).all()
    exercise_plans = ExercisePlan.query.filter_by(user_id=current_user.id).order_by(ExercisePlan.date.desc()).limit(7).all()
    return render_template('diet_exercise.html', diet_plans=diet_plans, exercise_plans=exercise_plans)

@app.route('/diet/add', methods=['POST'])
@login_required
def add_diet_plan():
    """Add diet plan entry"""
    data = request.json
    diet_entry = DietPlan(
        user_id=current_user.id,
        meal_type=data.get('meal_type'),
        food_items=data.get('food_items'),
        calories=data.get('calories'),
        carbs=data.get('carbs'),
        protein=data.get('protein'),
        fat=data.get('fat'),
        date=datetime.strptime(data.get('date'), '%Y-%m-%d').date(),
        is_pcod_friendly=data.get('is_pcod_friendly', True)
    )
    db.session.add(diet_entry)
    db.session.commit()
    return jsonify({'status': 'success', 'message': 'Diet plan added successfully!'})

@app.route('/exercise/add', methods=['POST'])
@login_required
def add_exercise_plan():
    """Add exercise plan entry"""
    data = request.json
    exercise_entry = ExercisePlan(
        user_id=current_user.id,
        exercise_name=data.get('exercise_name'),
        exercise_type=data.get('exercise_type'),
        duration_minutes=data.get('duration_minutes'),
        calories_burned=data.get('calories_burned'),
        date=datetime.strptime(data.get('date'), '%Y-%m-%d').date(),
        completed=data.get('completed', False),
        notes=data.get('notes')
    )
    db.session.add(exercise_entry)
    db.session.commit()
    return jsonify({'status': 'success', 'message': 'Exercise plan added successfully!'})

@app.route('/diet/edit/<int:diet_id>', methods=['POST'])
@login_required
def edit_diet_plan(diet_id):
    """Edit diet plan entry"""
    from models import DietPlan
    diet_entry = DietPlan.query.filter_by(id=diet_id, user_id=current_user.id).first_or_404()
    
    data = request.json
    diet_entry.meal_type = data.get('meal_type')
    diet_entry.food_items = data.get('food_items')
    diet_entry.calories = data.get('calories')
    diet_entry.carbs = data.get('carbs')
    diet_entry.protein = data.get('protein')
    diet_entry.fat = data.get('fat')
    diet_entry.date = datetime.strptime(data.get('date'), '%Y-%m-%d').date()
    diet_entry.is_pcod_friendly = data.get('is_pcod_friendly', False)
    
    db.session.commit()
    return jsonify({'status': 'success', 'message': 'Diet plan updated successfully!'})

@app.route('/diet/delete/<int:diet_id>', methods=['POST'])
@login_required
def delete_diet_plan(diet_id):
    """Delete diet plan entry"""
    from models import DietPlan
    diet_entry = DietPlan.query.filter_by(id=diet_id, user_id=current_user.id).first_or_404()
    db.session.delete(diet_entry)
    db.session.commit()
    return jsonify({'status': 'success', 'message': 'Diet plan deleted successfully!'})

@app.route('/exercise/edit/<int:exercise_id>', methods=['POST'])
@login_required
def edit_exercise_plan(exercise_id):
    """Edit exercise plan entry"""
    from models import ExercisePlan
    exercise_entry = ExercisePlan.query.filter_by(id=exercise_id, user_id=current_user.id).first_or_404()
    
    data = request.json
    exercise_entry.exercise_name = data.get('exercise_name')
    exercise_entry.exercise_type = data.get('exercise_type')
    exercise_entry.duration_minutes = data.get('duration_minutes')
    exercise_entry.calories_burned = data.get('calories_burned')
    exercise_entry.date = datetime.strptime(data.get('date'), '%Y-%m-%d').date()
    exercise_entry.completed = data.get('completed', False)
    exercise_entry.notes = data.get('notes')
    
    db.session.commit()
    return jsonify({'status': 'success', 'message': 'Exercise plan updated successfully!'})

@app.route('/exercise/delete/<int:exercise_id>', methods=['POST'])
@login_required
def delete_exercise_plan(exercise_id):
    """Delete exercise plan entry"""
    from models import ExercisePlan
    exercise_entry = ExercisePlan.query.filter_by(id=exercise_id, user_id=current_user.id).first_or_404()
    db.session.delete(exercise_entry)
    db.session.commit()
    return jsonify({'status': 'success', 'message': 'Exercise plan deleted successfully!'})

@app.route('/reminders')
@login_required
def reminders():
    """Reminders management"""
    user_reminders = Reminder.query.filter_by(user_id=current_user.id).order_by(Reminder.reminder_time).all()
    return render_template('reminders.html', reminders=user_reminders)

@app.route('/reminders/add', methods=['POST'])
@login_required

def add_reminder():
    """Add new reminder"""
    try:
        # Debug CSRF token
        csrf_token = request.headers.get('X-CSRFToken')
        print(f"Received CSRF token: {csrf_token}")  # Debug log
        
        data = request.json
        if not data:
            return jsonify({'status': 'error', 'message': 'No data provided'}), 400
        
        # Validate required fields
        if not data.get('title'):
            return jsonify({'status': 'error', 'message': 'Title is required'}), 400
        if not data.get('reminder_type'):
            return jsonify({'status': 'error', 'message': 'Reminder type is required'}), 400
        if not data.get('reminder_time'):
            return jsonify({'status': 'error', 'message': 'Reminder time is required'}), 400
        
        print(f"Adding reminder for user {current_user.id}: {data}")  # Debug log
        
        reminder = Reminder(
            user_id=current_user.id,
            title=data.get('title'),
            description=data.get('description'),
            reminder_type=data.get('reminder_type'),
            reminder_time=datetime.strptime(data.get('reminder_time'), '%Y-%m-%dT%H:%M'),
            is_recurring=data.get('is_recurring', False),
            recurrence_pattern=data.get('recurrence_pattern')
        )
        db.session.add(reminder)
        db.session.commit()
        print(f"Successfully added reminder with ID: {reminder.id}")  # Debug log
        return jsonify({'status': 'success', 'message': 'Reminder added successfully!'})
    except Exception as e:
        print(f"Error adding reminder: {str(e)}")  # Debug log
        db.session.rollback()
        return jsonify({'status': 'error', 'message': f'Failed to add reminder: {str(e)}'}), 500

@app.route('/reminders/<int:reminder_id>/complete', methods=['POST'])
@login_required

def complete_reminder(reminder_id):
    """Mark reminder as completed"""
    reminder = Reminder.query.filter_by(id=reminder_id, user_id=current_user.id).first()
    if not reminder:
        return jsonify({'status': 'error', 'message': 'Reminder not found'}), 404
    
    reminder.is_completed = True
    db.session.commit()
    return jsonify({'status': 'success', 'message': 'Reminder marked as completed!'})

@app.route('/reminders/<int:reminder_id>/delete', methods=['DELETE'])
@login_required

def delete_reminder(reminder_id):
    """Delete reminder"""
    reminder = Reminder.query.filter_by(id=reminder_id, user_id=current_user.id).first()
    if not reminder:
        return jsonify({'status': 'error', 'message': 'Reminder not found'}), 404
    
    db.session.delete(reminder)
    db.session.commit()
    return jsonify({'status': 'success', 'message': 'Reminder deleted successfully!'})

@app.route('/analytics')
@login_required
def analytics():
    """Analytics and reports dashboard"""
    # Get symptom trends
    symptoms_data = SymptomTracker.query.filter_by(user_id=current_user.id).order_by(SymptomTracker.date.desc()).limit(30).all()
    
    # Get cycle regularity data
    cycles_data = MenstrualCycle.query.filter_by(user_id=current_user.id).order_by(MenstrualCycle.start_date.desc()).limit(12).all()
    
    # Calculate average symptom severity from recent 10 entries
    recent_symptoms = symptoms_data[:10] if symptoms_data else []
    symptom_feedback = None
    avg_severity = 0
    health_score = 0
    
    if recent_symptoms:
        total_scores = 0
        count = 0
        
        for symptom in recent_symptoms:
            # Sum up all severity scores (1-5 scale)
            if symptom.acne_severity:
                total_scores += symptom.acne_severity
                count += 1
            if symptom.fatigue_level:
                total_scores += symptom.fatigue_level
                count += 1
            if symptom.mood_swings:
                total_scores += symptom.mood_swings
                count += 1
            if symptom.anxiety_level:
                total_scores += symptom.anxiety_level
                count += 1
            if symptom.depression_level:
                total_scores += symptom.depression_level
                count += 1
        
        if count > 0:
            avg_severity = total_scores / count
            
            # Calculate inverted health score (lower symptoms = higher score)
            # avg_severity ranges from 0-5, so we invert it: 5 - avg_severity
            health_score = 5 - avg_severity
            
            # Determine feedback based on 5-level health score system
            if health_score >= 4.5:
                symptom_feedback = {
                    'level': 'excellent',
                    'emoji': '🌟',
                    'title': 'Excellent',
                    'message': "Excellent progress! Your symptoms are well-managed — keep maintaining this great routine! 🌟",
                    'color': 'success'
                }
            elif health_score >= 3.5:
                symptom_feedback = {
                    'level': 'very_good',
                    'emoji': '💪',
                    'title': 'Very Good',
                    'message': "You're doing really well! Just a little more consistency and you'll reach top results! 💪",
                    'color': 'success'
                }
            elif health_score >= 2.5:
                symptom_feedback = {
                    'level': 'good',
                    'emoji': '😊',
                    'title': 'Good',
                    'message': "Nice progress! Your efforts are showing — keep building those healthy habits! 😊",
                    'color': 'primary'
                }
            elif health_score >= 1.5:
                symptom_feedback = {
                    'level': 'fair',
                    'emoji': '⚠️',
                    'title': 'Fair / Needs Improvement',
                    'message': "You're getting there! Stay focused and follow your health plan regularly. Every effort counts! 💙",
                    'color': 'warning'
                }
            else:
                symptom_feedback = {
                    'level': 'poor',
                    'emoji': '🚨',
                    'title': 'Poor / Needs Attention',
                    'message': "Your progress needs attention. Try to stick to your routine and seek support if needed — you can do it! ❤️",
                    'color': 'danger'
                }
    
    response = make_response(render_template('analytics.html', 
                         symptoms_data=symptoms_data, 
                         cycles_data=cycles_data,
                         symptom_feedback=symptom_feedback,
                         health_score=round(health_score, 1)))
    
    # Prevent browser caching to ensure analytics always shows fresh data
    response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = '0'
    
    return response

# Clinical Support Module Routes
@app.route('/doctors')
@login_required
def doctors():
    """Find doctors and specialists"""
    verified_doctors = DoctorProfile.query.filter_by(is_verified=True).all()
    return render_template('doctors.html', doctors=verified_doctors)

# Footer Pages
@app.route('/privacy-policy')
def privacy_policy():
    """Privacy Policy page"""
    return render_template('privacy_policy.html')

@app.route('/help-center')
def help_center():
    """Help Center page"""
    return render_template('help_center.html')

@app.route('/contact', methods=['GET', 'POST'])
def contact():
    """Contact Us page"""
    if request.method == 'POST':
        name = request.form.get('name')
        email = request.form.get('email')
        subject = request.form.get('subject')
        message = request.form.get('message')
        
        if name and email and subject and message:
            contact_msg = ContactMessage(
                name=name,
                email=email,
                subject=subject,
                message=message
            )
            db.session.add(contact_msg)
            db.session.commit()
            flash('Thank you for contacting us! We have received your message and will respond within 24-48 hours.', 'success')
            return redirect(url_for('contact'))
        else:
            flash('Please fill in all required fields.', 'error')
    
    return render_template('contact.html')

@app.route('/emergency-support')
def emergency_support():
    """Emergency Support page"""
    return render_template('emergency_support.html')

# Profile management
@app.route('/profile')
@login_required
def profile():
    """User profile management"""
    return render_template('profile.html', user=current_user)

@app.route('/profile/update', methods=['POST'])
@login_required
def update_profile():
    """Update user profile"""
    data = request.json
    current_user.age = data.get('age')
    current_user.height = data.get('height')
    current_user.weight = data.get('weight')
    current_user.contact_number = data.get('contact_number')
    current_user.emergency_contact = data.get('emergency_contact')
    current_user.medical_history = data.get('medical_history')
    current_user.updated_at = datetime.now()
    db.session.commit()
    return jsonify({'status': 'success', 'message': 'Profile updated successfully!'})

@app.route('/profile/switch-role', methods=['POST'])
@login_required
def switch_role():
    """Switch user role between PCOS user and Family Supporter"""
    current_role = current_user.user_role
    
    if current_role == 'pcos_user':
        new_role = 'family_member'
        redirect_url = '/family/connections'
    elif current_role == 'family_member':
        new_role = 'pcos_user'
        redirect_url = '/dashboard'
    else:
        return jsonify({'status': 'error', 'message': 'Invalid current role'}), 400
    
    current_user.user_role = new_role
    current_user.updated_at = datetime.now()
    db.session.commit()
    
    return jsonify({
        'status': 'success', 
        'message': f'Role switched to {new_role} successfully! Your data is preserved.',
        'redirect_url': redirect_url
    })

# Daily Reminder routes
@app.route('/reminder-settings')
@login_required
def reminder_settings():
    """Daily reminder settings page"""
    return render_template('reminder_settings.html')

@app.route('/reminder-settings/save', methods=['POST'])
@login_required
def save_reminder_settings():
    """Save user's daily reminder preferences"""
    data = request.json
    current_user.reminder_enabled = data.get('reminder_enabled', False)
    current_user.reminder_time = data.get('reminder_time')
    current_user.reminder_timezone = data.get('reminder_timezone')
    current_user.updated_at = datetime.now()
    db.session.commit()
    return jsonify({'status': 'success', 'message': 'Reminder settings saved!'})

@app.route('/api/daily-motivation')
@login_required
def get_daily_motivation():
    """Get a random daily motivation message"""
    from models import DailyMotivation
    import random
    
    motivations = DailyMotivation.query.filter_by(is_active=True).all()
    if motivations:
        motivation = random.choice(motivations)
        return jsonify({
            'message': motivation.message,
            'icon': motivation.icon,
            'category': motivation.category
        })
    
    default_message = {
        'message': 'Your health journey matters. Take a moment today to track how you\'re feeling! 💜',
        'icon': '💜',
        'category': 'health'
    }
    return jsonify(default_message)

# Forum routes
@app.route('/forum')
def forum():
    """Discussion forum home - list categories based on user role"""
    from models import ForumCategory, ForumPost, User
    
    # Get all categories
    categories = ForumCategory.query.order_by(ForumCategory.display_order).all()
    
    # Filter categories based on user role
    # Family supporters see only "Inspirational Stories"
    # PCOS users see all categories
    is_supporter = False
    if current_user.is_authenticated:
        user = User.query.get(current_user.id)
        if user and user.user_role == 'family_member':
            is_supporter = True
    
    if is_supporter:
        # Supporters see only Inspirational Stories
        categories = [c for c in categories if c.name == 'Inspirational Stories']
    
    category_data = []
    for category in categories:
        posts_count = ForumPost.query.filter_by(category_id=category.id).count()
        latest_post = ForumPost.query.filter_by(category_id=category.id).order_by(ForumPost.created_at.desc()).first()
        
        category_data.append({
            'category': category,
            'posts_count': posts_count,
            'latest_post': latest_post
        })
    
    return render_template('forum.html', category_data=category_data, is_supporter=is_supporter)

@app.route('/forum/category/<int:category_id>')
def forum_category(category_id):
    """View posts in a specific category"""
    from models import ForumCategory, ForumPost, ForumReply
    category = ForumCategory.query.get_or_404(category_id)
    posts = ForumPost.query.filter_by(category_id=category_id).order_by(
        ForumPost.is_pinned.desc(), 
        ForumPost.created_at.desc()
    ).all()
    
    posts_with_replies = []
    for post in posts:
        replies_count = ForumReply.query.filter_by(post_id=post.id).count()
        posts_with_replies.append({
            'post': post,
            'replies_count': replies_count
        })
    
    return render_template('forum_category.html', category=category, posts_with_replies=posts_with_replies)

@app.route('/forum/post/<int:post_id>')
def forum_post(post_id):
    """View a single post with replies"""
    from models import ForumPost, ForumReply, ForumReaction, ForumPostView
    post = ForumPost.query.get_or_404(post_id)
    
    # Track unique view
    view_recorded = False
    if current_user.is_authenticated:
        # Check if user already viewed this post
        existing_view = ForumPostView.query.filter_by(
            post_id=post_id,
            user_id=current_user.id
        ).first()
        
        if not existing_view:
            new_view = ForumPostView(
                post_id=post_id,
                user_id=current_user.id
            )
            db.session.add(new_view)
            post.views_count += 1
            view_recorded = True
    else:
        # Track by session for anonymous users
        if 'session_id' not in session:
            import uuid
            session['session_id'] = str(uuid.uuid4())
        
        existing_view = ForumPostView.query.filter_by(
            post_id=post_id,
            session_id=session['session_id']
        ).first()
        
        if not existing_view:
            new_view = ForumPostView(
                post_id=post_id,
                session_id=session['session_id']
            )
            db.session.add(new_view)
            post.views_count += 1
            view_recorded = True
    
    db.session.commit()
    
    # Get post reaction data
    post_like_count = ForumReaction.query.filter_by(post_id=post_id, reaction_type='like').count()
    post_dislike_count = ForumReaction.query.filter_by(post_id=post_id, reaction_type='dislike').count()
    
    replies = ForumReply.query.filter_by(post_id=post_id).order_by(ForumReply.created_at).all()
    
    replies_data = []
    for reply in replies:
        like_count = ForumReaction.query.filter_by(reply_id=reply.id, reaction_type='like').count()
        dislike_count = ForumReaction.query.filter_by(reply_id=reply.id, reaction_type='dislike').count()
        
        replies_data.append({
            'reply': reply,
            'like_count': like_count,
            'dislike_count': dislike_count
        })
    
    return render_template('forum_post.html', 
                         post=post, 
                         replies_data=replies_data,
                         post_like_count=post_like_count,
                         post_dislike_count=post_dislike_count)

@app.route('/forum/category/<int:category_id>/new', methods=['GET', 'POST'])
@login_required
def create_post(category_id):
    """Create a new forum post"""
    from models import ForumCategory, ForumPost
    from content_moderation import check_content, get_moderation_message
    
    category = ForumCategory.query.get_or_404(category_id)
    
    if request.method == 'POST':
        data = request.json
        title = data.get('title', '')
        content = data.get('content', '')
        
        # Check title for inappropriate content
        title_check = check_content(title)
        if not title_check['is_appropriate']:
            message = get_moderation_message(title_check['flagged_words'], title_check['suggestions'])
            return jsonify({'status': 'error', 'message': message}), 400
        
        # Check content for inappropriate content
        content_check = check_content(content)
        if not content_check['is_appropriate']:
            message = get_moderation_message(content_check['flagged_words'], content_check['suggestions'])
            return jsonify({'status': 'error', 'message': message}), 400
        
        new_post = ForumPost(
            user_id=current_user.id,
            category_id=category_id,
            title=title,
            content=content
        )
        db.session.add(new_post)
        db.session.commit()
        return jsonify({'status': 'success', 'post_id': new_post.id})
    
    return render_template('forum_new_post.html', category=category)

@app.route('/forum/post/<int:post_id>/reply', methods=['POST'])
@login_required
def add_reply(post_id):
    """Add a reply to a forum post"""
    from models import ForumPost, ForumReply
    from content_moderation import check_content, get_moderation_message
    
    post = ForumPost.query.get_or_404(post_id)
    
    data = request.json
    content = data.get('content', '')
    
    # Check reply content for inappropriate content
    content_check = check_content(content)
    if not content_check['is_appropriate']:
        message = get_moderation_message(content_check['flagged_words'], content_check['suggestions'])
        return jsonify({'status': 'error', 'message': message}), 400
    
    new_reply = ForumReply(
        post_id=post_id,
        user_id=current_user.id,
        content=content
    )
    db.session.add(new_reply)
    db.session.commit()
    
    return jsonify({'status': 'success', 'reply_id': new_reply.id})

@app.route('/forum/post/<int:post_id>/edit', methods=['POST'])
@login_required
def edit_post(post_id):
    """Edit a forum post"""
    from models import ForumPost
    from content_moderation import check_content, get_moderation_message
    
    post = ForumPost.query.get_or_404(post_id)
    
    if post.user_id != current_user.id:
        return jsonify({'status': 'error', 'message': 'Unauthorized'}), 403
    
    data = request.json
    new_title = data.get('title', post.title)
    new_content = data.get('content', post.content)
    
    # Check title for inappropriate content
    title_check = check_content(new_title)
    if not title_check['is_appropriate']:
        message = get_moderation_message(title_check['flagged_words'], title_check['suggestions'])
        return jsonify({'status': 'error', 'message': message}), 400
    
    # Check content for inappropriate content
    content_check = check_content(new_content)
    if not content_check['is_appropriate']:
        message = get_moderation_message(content_check['flagged_words'], content_check['suggestions'])
        return jsonify({'status': 'error', 'message': message}), 400
    
    post.title = new_title
    post.content = new_content
    db.session.commit()
    
    return jsonify({'status': 'success'})

@app.route('/forum/reply/<int:reply_id>/react', methods=['POST'])
@login_required
def toggle_reaction(reply_id):
    """Toggle a reaction on a forum reply"""
    from models import ForumReply, ForumReaction
    reply = ForumReply.query.get_or_404(reply_id)
    
    data = request.json
    reaction_type = data.get('reaction_type', 'like')
    
    # Check if user already has THIS reaction type
    existing_same_reaction = ForumReaction.query.filter_by(
        reply_id=reply_id,
        user_id=current_user.id,
        reaction_type=reaction_type
    ).first()
    
    if existing_same_reaction:
        # User clicked same reaction - remove it
        db.session.delete(existing_same_reaction)
        db.session.commit()
        return jsonify({'status': 'success', 'action': 'removed', 'reaction_type': reaction_type})
    else:
        # Remove any other reaction type first
        other_reaction = ForumReaction.query.filter_by(
            reply_id=reply_id,
            user_id=current_user.id
        ).first()
        
        if other_reaction:
            db.session.delete(other_reaction)
        
        # Add new reaction
        new_reaction = ForumReaction(
            reply_id=reply_id,
            user_id=current_user.id,
            reaction_type=reaction_type
        )
        db.session.add(new_reaction)
        db.session.commit()
        return jsonify({'status': 'success', 'action': 'added', 'reaction_type': reaction_type, 'removed_type': other_reaction.reaction_type if other_reaction else None})

@app.route('/forum/post/<int:post_id>/react', methods=['POST'])
@login_required
def toggle_post_reaction(post_id):
    """Toggle a reaction on a forum post"""
    from models import ForumPost, ForumReaction
    post = ForumPost.query.get_or_404(post_id)
    
    data = request.json
    reaction_type = data.get('reaction_type', 'like')
    
    # Check if user already has THIS reaction type
    existing_same_reaction = ForumReaction.query.filter_by(
        post_id=post_id,
        user_id=current_user.id,
        reaction_type=reaction_type
    ).first()
    
    if existing_same_reaction:
        # User clicked same reaction - remove it
        db.session.delete(existing_same_reaction)
        db.session.commit()
        return jsonify({'status': 'success', 'action': 'removed', 'reaction_type': reaction_type})
    else:
        # Remove any other reaction type first
        other_reaction = ForumReaction.query.filter_by(
            post_id=post_id,
            user_id=current_user.id
        ).first()
        
        if other_reaction:
            db.session.delete(other_reaction)
        
        # Add new reaction
        new_reaction = ForumReaction(
            post_id=post_id,
            user_id=current_user.id,
            reaction_type=reaction_type
        )
        db.session.add(new_reaction)
        db.session.commit()
        return jsonify({'status': 'success', 'action': 'added', 'reaction_type': reaction_type, 'removed_type': other_reaction.reaction_type if other_reaction else None})

# Onboarding routes
@app.route('/onboarding/role', methods=['GET', 'POST'])
@login_required
def onboarding_role():
    """Step 1: Role selection"""
    if request.method == 'POST':
        data = request.json if request.is_json else request.form
        current_user.user_role = data.get('role')
        db.session.commit()
        return jsonify({'status': 'success', 'next': '/onboarding/consent'}) if request.is_json else redirect(url_for('onboarding_consent'))
    
    return render_template('onboarding_role.html')

@app.route('/onboarding/consent', methods=['GET', 'POST'])
@login_required
def onboarding_consent():
    """Step 2: Consent & disclaimers"""
    if not current_user.user_role:
        return redirect(url_for('onboarding_role'))
    
    if request.method == 'POST':
        data = request.json if request.is_json else request.form
        current_user.data_consent = data.get('data_consent') == 'true' or data.get('data_consent') == True
        current_user.research_consent = data.get('research_consent') == 'true' or data.get('research_consent') == True
        current_user.consent_timestamp = datetime.now()
        db.session.commit()
        return jsonify({'status': 'success', 'next': '/onboarding/profile'}) if request.is_json else redirect(url_for('onboarding_profile'))
    
    return render_template('onboarding_consent.html')

@app.route('/onboarding/profile', methods=['GET', 'POST'])
@login_required
def onboarding_profile():
    """Step 3: Profile capture (different for PCOS user vs family member)"""
    if not current_user.data_consent:
        return redirect(url_for('onboarding_consent'))
    
    if request.method == 'POST':
        data = request.json if request.is_json else request.form
        import json
        
        if current_user.user_role == 'pcos_user':
            current_user.age = data.get('age')
            current_user.goals = json.dumps(data.getlist('goals') if hasattr(data, 'getlist') else data.get('goals', []))
            current_user.menstrual_status = data.get('menstrual_status')
            current_user.current_medications = data.get('current_medications')
            current_user.constraints = json.dumps({
                'time': data.get('time_constraints'),
                'equipment': data.get('equipment_constraints'),
                'culture_diet': data.get('culture_diet_constraints')
            })
            current_user.devices_available = json.dumps(data.getlist('devices') if hasattr(data, 'getlist') else data.get('devices', []))
        else:  # family_member
            current_user.family_relation = data.get('family_relation')
            current_user.family_involvement = json.dumps(data.getlist('involvement') if hasattr(data, 'getlist') else data.get('involvement', []))
        
        db.session.commit()
        return jsonify({'status': 'success', 'next': '/onboarding/accessibility'}) if request.is_json else redirect(url_for('onboarding_accessibility'))
    
    return render_template('onboarding_profile.html', role=current_user.user_role)

@app.route('/onboarding/accessibility', methods=['GET', 'POST'])
@login_required
def onboarding_accessibility():
    """Step 4: Accessibility preferences"""
    # Validate that previous steps are completed
    if not current_user.user_role:
        return redirect(url_for('onboarding_role'))
    if not current_user.data_consent:
        return redirect(url_for('onboarding_consent'))
    
    # Check profile completion based on role
    if current_user.user_role == 'pcos_user':
        if not current_user.age or not current_user.menstrual_status:
            return redirect(url_for('onboarding_profile'))
    elif current_user.user_role == 'family_member':
        if not current_user.family_relation:
            return redirect(url_for('onboarding_profile'))
    
    if request.method == 'POST':
        data = request.json if request.is_json else request.form
        current_user.font_size = data.get('font_size', 'medium')
        current_user.high_contrast = data.get('high_contrast') == 'true' or data.get('high_contrast') == True
        current_user.captions_enabled = data.get('captions') == 'true' or data.get('captions') == True
        current_user.text_to_speech = data.get('text_to_speech') == 'true' or data.get('text_to_speech') == True
        current_user.onboarding_completed = True
        db.session.commit()
        
        # Redirect based on user role
        if current_user.user_role == 'family_member':
            # Family supporters go to Learn track to start their education
            next_url = '/learn'
        else:
            # PCOS users go to dashboard
            next_url = '/dashboard'
        
        return jsonify({'status': 'success', 'next': next_url}) if request.is_json else redirect(next_url)
    
    return render_template('onboarding_accessibility.html')

# Educational Content / Learn Track Routes
@app.route('/learn')
@login_required
def learn():
    """Educational tracks listing page"""
    if not current_user.onboarding_completed:
        return redirect(url_for('onboarding_role'))
    
    # Get tracks based on user role
    track_type = current_user.user_role
    tracks = EducationalTrack.query.filter_by(
        track_type=track_type,
        is_published=True
    ).order_by(EducationalTrack.order_index).all()
    
    # Get progress for each track
    track_progress = {}
    for track in tracks:
        total_lessons = len(track.lessons)
        if total_lessons > 0:
            completed = UserLessonProgress.query.filter_by(
                user_id=current_user.id
            ).filter(
                UserLessonProgress.lesson_id.in_([l.id for l in track.lessons]),
                UserLessonProgress.completed_at.isnot(None)
            ).count()
            track_progress[track.id] = {
                'completed': completed,
                'total': total_lessons,
                'percentage': int((completed / total_lessons) * 100)
            }
        else:
            track_progress[track.id] = {'completed': 0, 'total': 0, 'percentage': 0}
    
    return render_template('learn.html', tracks=tracks, track_progress=track_progress)

@app.route('/learn/track/<int:track_id>')
@login_required
def track_detail(track_id):
    """Track detail page showing all lessons"""
    if not current_user.onboarding_completed:
        return redirect(url_for('onboarding_role'))
    
    track = EducationalTrack.query.get_or_404(track_id)
    
    # Verify user has access to this track type
    if track.track_type != current_user.user_role:
        flash('You do not have access to this track.', 'error')
        return redirect(url_for('learn'))
    
    # Get lessons with progress
    lessons_with_progress = []
    for lesson in track.lessons:
        progress = UserLessonProgress.query.filter_by(
            user_id=current_user.id,
            lesson_id=lesson.id
        ).first()
        lessons_with_progress.append({
            'lesson': lesson,
            'progress': progress
        })
    
    return render_template('track_detail.html', track=track, lessons_with_progress=lessons_with_progress)

@app.route('/learn/lesson/<int:lesson_id>')
@login_required
def lesson(lesson_id):
    """Individual lesson page"""
    if not current_user.onboarding_completed:
        return redirect(url_for('onboarding_role'))
    
    lesson = Lesson.query.get_or_404(lesson_id)
    track = lesson.track
    
    # Verify access
    if track.track_type != current_user.user_role:
        flash('You do not have access to this lesson.', 'error')
        return redirect(url_for('learn'))
    
    # Get or create progress
    progress = UserLessonProgress.query.filter_by(
        user_id=current_user.id,
        lesson_id=lesson.id
    ).first()
    
    if not progress:
        progress = UserLessonProgress(
            user_id=current_user.id,
            lesson_id=lesson.id,
            started_at=datetime.now()
        )
        db.session.add(progress)
        db.session.commit()
    elif not progress.started_at:
        progress.started_at = datetime.now()
        db.session.commit()
    
    # Parse dos and donts
    dos = json.loads(lesson.dos) if lesson.dos else []
    donts = json.loads(lesson.donts) if lesson.donts else []
    
    # Get completed actions
    completed_actions = json.loads(progress.completed_actions) if progress.completed_actions else []
    
    # Find previous and next lessons in the same track
    all_lessons = Lesson.query.filter_by(track_id=track.id).order_by(Lesson.order_index).all()
    current_index = next((i for i, l in enumerate(all_lessons) if l.id == lesson.id), None)
    
    prev_lesson = all_lessons[current_index - 1] if current_index and current_index > 0 else None
    next_lesson = all_lessons[current_index + 1] if current_index is not None and current_index < len(all_lessons) - 1 else None
    
    return render_template('lesson.html', 
                         lesson=lesson, 
                         track=track,
                         progress=progress,
                         dos=dos,
                         donts=donts,
                         completed_actions=completed_actions,
                         prev_lesson=prev_lesson,
                         next_lesson=next_lesson)

@app.route('/learn/lesson/<int:lesson_id>/complete-action', methods=['POST'])
@login_required
def complete_action(lesson_id):
    """Mark an action as complete"""
    action_id = request.json.get('action_id')
    
    progress = UserLessonProgress.query.filter_by(
        user_id=current_user.id,
        lesson_id=lesson_id
    ).first()
    
    if progress:
        completed_actions = json.loads(progress.completed_actions) if progress.completed_actions else []
        if action_id not in completed_actions:
            completed_actions.append(action_id)
            progress.completed_actions = json.dumps(completed_actions)
            db.session.commit()
            return jsonify({'status': 'success'})
    
    return jsonify({'status': 'error'}), 400

@app.route('/learn/lesson/<int:lesson_id>/quiz', methods=['GET', 'POST'])
@login_required
def lesson_quiz(lesson_id):
    """Lesson quiz page"""
    if not current_user.onboarding_completed:
        return redirect(url_for('onboarding_role'))
    
    lesson = Lesson.query.get_or_404(lesson_id)
    
    # Get the quiz for this lesson
    quiz = LessonQuiz.query.filter_by(lesson_id=lesson_id).first()
    
    if not quiz:
        flash('This lesson does not have a quiz.', 'info')
        return redirect(url_for('lesson', lesson_id=lesson_id))
    
    # Verify access
    if lesson.track.track_type != current_user.user_role:
        flash('You do not have access to this quiz.', 'error')
        return redirect(url_for('learn'))
    
    if request.method == 'POST':
        answers = request.json if request.is_json else request.form
        
        # Calculate score
        correct_count = 0
        total_questions = len(quiz.questions)
        
        for question in quiz.questions:
            user_answer = answers.get(f'question_{question.id}')
            if user_answer == question.correct_answer:
                correct_count += 1
        
        score = int((correct_count / total_questions) * 100) if total_questions > 0 else 0
        
        # Update progress
        progress = UserLessonProgress.query.filter_by(
            user_id=current_user.id,
            lesson_id=lesson_id
        ).first()
        
        if progress:
            progress.quiz_score = score
            progress.quiz_attempts += 1
            
            # Mark lesson as complete if passed
            if score >= quiz.passing_score and not progress.completed_at:
                progress.completed_at = datetime.now()
            
            db.session.commit()
            
            # Find next lesson in the track
            track = lesson.track
            current_order = lesson.order_index
            next_lesson = Lesson.query.filter_by(
                track_id=track.id
            ).filter(
                Lesson.order_index > current_order
            ).order_by(Lesson.order_index).first()
            
            response_data = {
                'status': 'success',
                'score': score,
                'passing_score': quiz.passing_score,
                'passed': score >= quiz.passing_score,
                'correct': correct_count,
                'total': total_questions
            }
            
            if next_lesson and score >= quiz.passing_score:
                response_data['next_lesson'] = {
                    'id': next_lesson.id,
                    'title': next_lesson.title,
                    'url': url_for('lesson', lesson_id=next_lesson.id)
                }
            
            return jsonify(response_data)
        
        return jsonify({'status': 'error'}), 400
    
    # GET request - show quiz
    # Parse question options
    questions_data = []
    for q in quiz.questions:
        options = json.loads(q.options) if q.options else []
        questions_data.append({
            'id': q.id,
            'text': q.question_text,
            'type': q.question_type,
            'options': options
        })
    
    progress = UserLessonProgress.query.filter_by(
        user_id=current_user.id,
        lesson_id=lesson_id
    ).first()
    
    # Find previous and next lessons in the same track
    track = lesson.track
    all_lessons = Lesson.query.filter_by(track_id=track.id).order_by(Lesson.order_index).all()
    current_index = next((i for i, l in enumerate(all_lessons) if l.id == lesson.id), None)
    
    prev_lesson = all_lessons[current_index - 1] if current_index and current_index > 0 else None
    next_lesson = all_lessons[current_index + 1] if current_index is not None and current_index < len(all_lessons) - 1 else None
    
    return render_template('lesson_quiz.html', 
                         lesson=lesson, 
                         quiz=quiz, 
                         questions=questions_data,
                         progress=progress,
                         prev_lesson=prev_lesson,
                         next_lesson=next_lesson)

# Family Support Routes
@app.route('/family/connections')
@login_required
def family_connections():
    """Manage family connections"""
    if not current_user.onboarding_completed:
        return redirect(url_for('onboarding_role'))
    
    if current_user.user_role == 'pcos_user':
        # PCOS users see their supporters
        connections_as_primary = FamilyConnection.query.filter_by(
            primary_user_id=current_user.id
        ).all()
        
        return render_template('family_connections.html',
                             connections_as_primary=connections_as_primary,
                             connections_as_member=[])
    else:
        # Supporters see enhanced dashboard with goals and symptoms
        connections = FamilyConnection.query.filter_by(
            family_member_id=current_user.id,
            is_active=True,
            connection_status='active'
        ).all()
        
        # Build connection data with goals and symptoms
        connection_data = []
        from datetime import timedelta
        seven_days_ago = datetime.now().date() - timedelta(days=7)
        
        for conn in connections:
            data = {
                'connection': conn,
                'user': conn.primary_user,
                'goals': [],
                'symptoms': []
            }
            
            # Get goals if permitted
            if conn.can_view_goals and conn.primary_user.goals:
                try:
                    import json
                    goals_list = json.loads(conn.primary_user.goals) if isinstance(conn.primary_user.goals, str) else conn.primary_user.goals
                    data['goals'] = goals_list if isinstance(goals_list, list) else []
                except:
                    data['goals'] = []
            
            # Get recent symptoms if permitted
            if conn.can_view_symptoms:
                symptoms = SymptomTracker.query.filter(
                    SymptomTracker.user_id == conn.primary_user_id,
                    SymptomTracker.date >= seven_days_ago
                ).order_by(SymptomTracker.date.desc()).limit(5).all()
                data['symptoms'] = symptoms
            
            connection_data.append(data)
        
        # Get unread message count for supporter
        unread_messages = SentNudge.query.filter_by(
            recipient_id=current_user.id,
            is_read=False
        ).count()
        
        return render_template('supporter_connections.html',
                             connection_data=connection_data,
                             unread_messages=unread_messages)

@app.route('/family/invite', methods=['POST'])
@login_required
def invite_family_member():
    """Send connection invite to another user (any role can send)"""
    invite_email = request.json.get('email')
    
    # Prevent self-invite
    if invite_email.lower() == current_user.email.lower():
        return jsonify({'status': 'error', 'message': 'You cannot send an invite to yourself'}), 400
    
    # Find the other user
    other_user = User.query.filter(db.func.lower(User.email) == invite_email.lower()).first()
    
    if not other_user:
        return jsonify({'status': 'error', 'message': 'User not found. Make sure they have registered.'}), 404
    
    # Determine connection structure based on roles
    if current_user.user_role == 'pcos_user':
        # PCOS user inviting someone (supporter)
        if other_user.user_role != 'family_member':
            return jsonify({'status': 'error', 'message': 'You can only invite users who are registered as supporters'}), 400
        primary_user_id = current_user.id
        family_member_id = other_user.id
    elif current_user.user_role == 'family_member':
        # Supporter inviting someone (PCOS user)
        if other_user.user_role != 'pcos_user':
            return jsonify({'status': 'error', 'message': 'You can only support users who have PCOS'}), 400
        primary_user_id = other_user.id
        family_member_id = current_user.id
    else:
        return jsonify({'status': 'error', 'message': 'Invalid user role'}), 403
    
    # Check if connection already exists
    existing = FamilyConnection.query.filter_by(
        primary_user_id=primary_user_id,
        family_member_id=family_member_id
    ).first()
    
    if existing:
        return jsonify({'status': 'error', 'message': 'Connection already exists'}), 400
    
    # Create connection
    connection = FamilyConnection(
        primary_user_id=primary_user_id,
        family_member_id=family_member_id,
        connection_status='pending'
    )
    db.session.add(connection)
    db.session.commit()
    
    return jsonify({'status': 'success', 'message': 'Invitation sent'})

@app.route('/family/request-connection', methods=['POST'])
@login_required
def request_family_connection():
    """Request connection to another user (any role can send)"""
    request_email = request.json.get('email')
    
    # Prevent self-request
    if request_email.lower() == current_user.email.lower():
        return jsonify({'status': 'error', 'message': 'You cannot send a request to yourself'}), 400
    
    # Find the other user
    other_user = User.query.filter(db.func.lower(User.email) == request_email.lower()).first()
    
    if not other_user:
        return jsonify({'status': 'error', 'message': 'User not found. Make sure they have registered.'}), 404
    
    # Determine connection structure based on roles
    if current_user.user_role == 'pcos_user':
        # PCOS user requesting someone (supporter)
        if other_user.user_role != 'family_member':
            return jsonify({'status': 'error', 'message': 'You can only connect with users who are registered as supporters'}), 400
        primary_user_id = current_user.id
        family_member_id = other_user.id
    elif current_user.user_role == 'family_member':
        # Supporter requesting someone (PCOS user)
        if other_user.user_role != 'pcos_user':
            return jsonify({'status': 'error', 'message': 'You can only support users who have PCOS'}), 400
        primary_user_id = other_user.id
        family_member_id = current_user.id
    else:
        return jsonify({'status': 'error', 'message': 'Invalid user role'}), 403
    
    # Check if connection already exists
    existing = FamilyConnection.query.filter_by(
        primary_user_id=primary_user_id,
        family_member_id=family_member_id
    ).first()
    
    if existing:
        return jsonify({'status': 'error', 'message': 'Connection request already exists'}), 400
    
    # Create connection request
    connection = FamilyConnection(
        primary_user_id=primary_user_id,
        family_member_id=family_member_id,
        connection_status='pending'
    )
    db.session.add(connection)
    db.session.commit()
    
    return jsonify({'status': 'success', 'message': f'Connection request sent to {other_user.first_name}! They will be notified.'})

@app.route('/family/connection/<int:connection_id>/activate', methods=['POST'])
@login_required
def activate_family_connection(connection_id):
    """Activate a family connection (opt-in by primary user)"""
    connection = FamilyConnection.query.get_or_404(connection_id)
    
    # Only primary user can activate
    if connection.primary_user_id != current_user.id:
        return jsonify({'status': 'error', 'message': 'Unauthorized'}), 403
    
    permissions = request.json
    connection.is_active = True
    connection.connection_status = 'active'
    connection.activated_at = datetime.now()
    connection.can_view_goals = permissions.get('can_view_goals', False)
    connection.can_view_symptoms = permissions.get('can_view_symptoms', False)
    connection.can_send_nudges = permissions.get('can_send_nudges', False)
    
    db.session.commit()
    
    return jsonify({'status': 'success', 'message': 'Connection activated'})

@app.route('/family/view-dashboard/<int:connection_id>')
@login_required
def view_user_dashboard(connection_id):
    """View the dashboard of a connected PCOS user (for supporters)"""
    if current_user.user_role != 'family_member':
        flash('Access denied. This feature is for family supporters only.', 'error')
        return redirect(url_for('dashboard'))
    
    # Get the connection and verify it belongs to this supporter
    connection = FamilyConnection.query.filter_by(
        id=connection_id,
        family_member_id=current_user.id,
        is_active=True,
        connection_status='active'
    ).first()
    
    if not connection:
        flash('Connection not found or not active.', 'error')
        return redirect(url_for('family_connections'))
    
    pcos_user = connection.primary_user
    from datetime import timedelta
    
    # Get data based on permissions
    seven_days_ago = datetime.now().date() - timedelta(days=7)
    recent_symptoms = SymptomTracker.query.filter(
        SymptomTracker.user_id == pcos_user.id,
        SymptomTracker.date >= seven_days_ago
    ).order_by(SymptomTracker.date.desc()).limit(5).all() if connection.can_view_symptoms else []
    
    upcoming_reminders = []  # Don't show user's reminders to supporters
    
    recent_cycle = MenstrualCycle.query.filter_by(
        user_id=pcos_user.id
    ).order_by(MenstrualCycle.start_date.desc()).first() if connection.can_view_symptoms else None
    
    today_date = datetime.now().strftime('%a, %b %d, %Y')
    
    # Calculate health score (if allowed to view symptoms)
    health_score = 0
    health_status = "Getting Started"
    health_emoji = "📊"
    
    if connection.can_view_symptoms:
        recent_10_symptoms = SymptomTracker.query.filter_by(user_id=pcos_user.id).order_by(SymptomTracker.date.desc()).limit(10).all()
        
        if recent_10_symptoms:
            total_scores = 0
            count = 0
            
            for symptom in recent_10_symptoms:
                # Sum up all severity scores (0-5 scale)
                if symptom.acne_severity:
                    total_scores += symptom.acne_severity
                    count += 1
                if symptom.fatigue_level:
                    total_scores += symptom.fatigue_level
                    count += 1
                if symptom.mood_swings:
                    total_scores += symptom.mood_swings
                    count += 1
                if symptom.anxiety_level:
                    total_scores += symptom.anxiety_level
                    count += 1
                if symptom.depression_level:
                    total_scores += symptom.depression_level
                    count += 1
            
            if count > 0:
                avg_severity = total_scores / count
                # Calculate inverted health score (lower symptoms = higher score)
                health_score = round(5 - avg_severity, 1)
                
                # Determine status based on 5-level system
                if health_score >= 4.5:
                    health_status = "Excellent"
                    health_emoji = "🌟"
                elif health_score >= 3.5:
                    health_status = "Very Good"
                    health_emoji = "💪"
                elif health_score >= 2.5:
                    health_status = "Good"
                    health_emoji = "😊"
                elif health_score >= 1.5:
                    health_status = "Fair"
                    health_emoji = "⚠️"
                else:
                    health_status = "Needs Attention"
                    health_emoji = "🚨"
    
    # Get unread message count for supporter
    unread_messages = SentNudge.query.filter_by(
        recipient_id=current_user.id,
        is_read=False
    ).count()
    
    response = make_response(render_template('dashboard.html',
                         today_date=today_date,
                         user=pcos_user,
                         recent_symptoms=recent_symptoms,
                         upcoming_reminders=upcoming_reminders,
                         recent_cycle=recent_cycle,
                         health_score=health_score,
                         health_status=health_status,
                         health_emoji=health_emoji,
                         is_supporter_view=True,
                         connection=connection,
                         unread_messages=unread_messages))
    
    # Prevent browser caching
    response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = '0'
    
    return response

@app.route('/family/send-nudge', methods=['POST'])
@login_required
def send_nudge():
    """Send a nudge to a family member"""
    connection_id = request.json.get('connection_id')
    nudge_id = request.json.get('nudge_id')
    message = request.json.get('message')
    nudge_type = request.json.get('nudge_type', 'encouragement')
    
    connection = FamilyConnection.query.get_or_404(connection_id)
    
    # Verify the sender is part of the connection
    if connection.family_member_id != current_user.id and connection.primary_user_id != current_user.id:
        return jsonify({'status': 'error', 'message': 'Unauthorized'}), 403
    
    # Verify permissions (only for nudge templates, not regular chat messages)
    if nudge_type != 'message' and not connection.can_send_nudges:
        return jsonify({'status': 'error', 'message': 'You do not have permission to send nudges'}), 403
    
    # Determine recipient
    recipient_id = connection.primary_user_id if current_user.id == connection.family_member_id else connection.family_member_id
    
    # Create sent nudge
    sent_nudge = SentNudge(
        connection_id=connection_id,
        nudge_id=nudge_id,
        sender_id=current_user.id,
        recipient_id=recipient_id,
        message=message,
        nudge_type=nudge_type
    )
    db.session.add(sent_nudge)
    db.session.commit()
    
    return jsonify({'status': 'success', 'message': 'Nudge sent'})

@app.route('/message/<int:message_id>/react', methods=['POST'])
@login_required
def toggle_message_reaction(message_id):
    """Toggle a reaction on a chat message"""
    from models import SentNudge, MessageReaction
    
    message = SentNudge.query.get_or_404(message_id)
    
    # Verify user has access to this message (is sender or recipient)
    if message.sender_id != current_user.id and message.recipient_id != current_user.id:
        return jsonify({'status': 'error', 'message': 'Unauthorized'}), 403
    
    data = request.json
    reaction_type = data.get('reaction_type', 'like')
    
    # Check if user already has THIS reaction type
    existing_same_reaction = MessageReaction.query.filter_by(
        message_id=message_id,
        user_id=current_user.id,
        reaction_type=reaction_type
    ).first()
    
    if existing_same_reaction:
        # User clicked same reaction - remove it
        db.session.delete(existing_same_reaction)
        db.session.commit()
        
        # Get updated counts
        likes_count = MessageReaction.query.filter_by(message_id=message_id, reaction_type='like').count()
        dislikes_count = MessageReaction.query.filter_by(message_id=message_id, reaction_type='dislike').count()
        
        return jsonify({
            'status': 'success', 
            'action': 'removed', 
            'reaction_type': reaction_type,
            'likes_count': likes_count,
            'dislikes_count': dislikes_count
        })
    else:
        # Remove any other reaction type first
        other_reaction = MessageReaction.query.filter_by(
            message_id=message_id,
            user_id=current_user.id
        ).first()
        
        if other_reaction:
            db.session.delete(other_reaction)
        
        # Add new reaction
        new_reaction = MessageReaction(
            message_id=message_id,
            user_id=current_user.id,
            reaction_type=reaction_type
        )
        db.session.add(new_reaction)
        db.session.commit()
        
        # Get updated counts
        likes_count = MessageReaction.query.filter_by(message_id=message_id, reaction_type='like').count()
        dislikes_count = MessageReaction.query.filter_by(message_id=message_id, reaction_type='dislike').count()
        
        return jsonify({
            'status': 'success', 
            'action': 'added', 
            'reaction_type': reaction_type, 
            'removed_type': other_reaction.reaction_type if other_reaction else None,
            'likes_count': likes_count,
            'dislikes_count': dislikes_count
        })

@app.route('/family/nudges')
@login_required
def view_nudges():
    """View received nudges"""
    nudges = SentNudge.query.filter_by(
        recipient_id=current_user.id
    ).order_by(SentNudge.sent_at.desc()).limit(20).all()
    
    # Mark as read
    for nudge in nudges:
        if not nudge.is_read:
            nudge.is_read = True
            nudge.read_at = datetime.now()
    db.session.commit()
    
    return render_template('nudges.html', nudges=nudges)

@app.route('/family/chat')
@app.route('/family/chat/<int:connection_id>')
@login_required
def chat(connection_id=None):
    """WhatsApp-style chat interface"""
    # Get all active connections for current user
    connections_as_primary = FamilyConnection.query.filter_by(
        primary_user_id=current_user.id,
        connection_status='active'
    ).all()
    
    connections_as_member = FamilyConnection.query.filter_by(
        family_member_id=current_user.id,
        connection_status='active'
    ).all()
    
    # Combine and prepare connection data
    all_connections = []
    for conn in connections_as_primary + connections_as_member:
        # Determine the other user
        other_user = conn.family_member if conn.primary_user_id == current_user.id else conn.primary_user
        
        # Get last message
        last_message = SentNudge.query.filter_by(connection_id=conn.id).order_by(SentNudge.sent_at.desc()).first()
        
        # Count unread messages
        unread_count = SentNudge.query.filter_by(
            connection_id=conn.id,
            recipient_id=current_user.id,
            is_read=False
        ).count()
        
        all_connections.append({
            'id': conn.id,
            'other_user': other_user,
            'last_message': last_message,
            'unread_count': unread_count,
            'connection': conn
        })
    
    # Sort by last message time
    all_connections.sort(key=lambda x: x['last_message'].sent_at if x['last_message'] else datetime.min, reverse=True)
    
    # Get active connection if specified
    active_connection = None
    messages = []
    
    if connection_id:
        active_conn = FamilyConnection.query.get_or_404(connection_id)
        
        # Verify user has access to this connection
        if active_conn.primary_user_id != current_user.id and active_conn.family_member_id != current_user.id:
            flash('Unauthorized access to this conversation.', 'error')
            return redirect(url_for('chat'))
        
        # Get all messages for this connection
        messages = SentNudge.query.filter_by(
            connection_id=connection_id
        ).order_by(SentNudge.sent_at.asc()).all()
        
        # Mark messages as read
        for msg in messages:
            if msg.recipient_id == current_user.id and not msg.is_read:
                msg.is_read = True
                msg.read_at = datetime.now()
        db.session.commit()
        
        # Prepare active connection data
        other_user = active_conn.family_member if active_conn.primary_user_id == current_user.id else active_conn.primary_user
        active_connection = {
            'id': active_conn.id,
            'other_user': other_user,
            'connection': active_conn
        }
    
    return render_template('chat.html', 
                         connections=all_connections,
                         active_connection=active_connection,
                         messages=messages)

# ==================== PCOS HEALTH ASSISTANT CHATBOT ====================

@app.route('/health-assistant')
def health_assistant():
    """Dedicated PCOS Health Assistant chat page"""
    from chatbot import get_quick_suggestions
    suggestions = get_quick_suggestions()
    return render_template('health_assistant.html', suggestions=suggestions)


@app.route('/api/chat', methods=['POST'])
def chat_api():
    """API endpoint for chatbot conversations"""
    from chatbot import get_chat_response
    
    data = request.get_json()
    user_message = data.get('message', '').strip()
    conversation_id = data.get('conversation_id')
    
    if not user_message:
        return jsonify({'error': 'Message is required'}), 400
    
    user_id = current_user.id if current_user.is_authenticated else None
    
    result = get_chat_response(user_message, user_id, conversation_id)
    
    return jsonify(result)


@app.route('/api/chat/clear', methods=['POST'])
def clear_chat():
    """Clear conversation history"""
    from chatbot import clear_conversation
    
    data = request.get_json()
    conversation_id = data.get('conversation_id')
    
    if conversation_id:
        clear_conversation(conversation_id)
    
    return jsonify({'status': 'success'})


@app.route('/api/chat/suggestions')
def chat_suggestions():
    """Get quick chat suggestions"""
    from chatbot import get_quick_suggestions
    return jsonify({'suggestions': get_quick_suggestions()})


@app.route('/api/chat/history/<conversation_id>')
def get_chat_history(conversation_id):
    """Get conversation history for a specific conversation"""
    from chatbot import get_conversation_history
    history = get_conversation_history(conversation_id)
    return jsonify({'history': history, 'conversation_id': conversation_id})


# Error handlers
@app.errorhandler(404)
def not_found(error):
    return render_template('404.html'), 404

@app.errorhandler(500)
def internal_error(error):
    db.session.rollback()
    return render_template('500.html'), 500

# Health check endpoint - must respond fast for deployment
@app.route('/health')
def health_check():
    return 'OK', 200