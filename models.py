from datetime import datetime
from app import db
from flask_dance.consumer.storage.sqla import OAuthConsumerMixin
from flask_login import UserMixin
from sqlalchemy import UniqueConstraint

# User authentication and profile model
class User(UserMixin, db.Model):
    __tablename__ = 'users'
    id = db.Column(db.String, primary_key=True)  # Keep existing String ID structure
    email = db.Column(db.String(120), unique=True, nullable=True)  # Keep nullable for existing users
    password_hash = db.Column(db.String(255), nullable=True)  # Add password support
    first_name = db.Column(db.String(50), nullable=True)
    last_name = db.Column(db.String(50), nullable=True)
    profile_image_url = db.Column(db.String, nullable=True)
    is_active = db.Column(db.Boolean, default=True)
    last_login = db.Column(db.DateTime, nullable=True)
    
    # PCOD-specific user profile fields
    age = db.Column(db.Integer, nullable=True)
    height = db.Column(db.Float, nullable=True)  # in cm
    weight = db.Column(db.Float, nullable=True)  # in kg
    contact_number = db.Column(db.String, nullable=True)
    emergency_contact = db.Column(db.String, nullable=True)
    medical_history = db.Column(db.Text, nullable=True)
    
    # Onboarding & Role Management
    user_role = db.Column(db.String, nullable=True)  # 'pcos_user' or 'family_member'
    onboarding_completed = db.Column(db.Boolean, default=False)
    
    # Consent & Disclaimers
    data_consent = db.Column(db.Boolean, default=False)
    research_consent = db.Column(db.Boolean, default=False)
    consent_timestamp = db.Column(db.DateTime, nullable=True)
    
    # PCOS User Profile
    goals = db.Column(db.Text, nullable=True)  # JSON: symptom_control, fertility, weight, mood
    menstrual_status = db.Column(db.String, nullable=True)  # regular, irregular, absent
    current_medications = db.Column(db.Text, nullable=True)
    constraints = db.Column(db.Text, nullable=True)  # JSON: time, equipment, culture_diet
    devices_available = db.Column(db.Text, nullable=True)  # JSON: wearables list
    
    # Family Member Profile
    family_relation = db.Column(db.String, nullable=True)  # parent, sibling, spouse, partner
    family_involvement = db.Column(db.Text, nullable=True)  # JSON: learn, coach, plan_meals, encourage_activity
    
    # Accessibility Preferences
    font_size = db.Column(db.String, default='medium')  # small, medium, large, extra_large
    high_contrast = db.Column(db.Boolean, default=False)
    captions_enabled = db.Column(db.Boolean, default=False)
    text_to_speech = db.Column(db.Boolean, default=False)
    
    # Daily Reminder Preferences
    reminder_enabled = db.Column(db.Boolean, default=False)
    reminder_time = db.Column(db.String, nullable=True)  # Format: "09:00" (24-hour)
    reminder_timezone = db.Column(db.String, nullable=True)  # e.g., "America/New_York"
    last_reminder_shown = db.Column(db.DateTime, nullable=True)
    
    created_at = db.Column(db.DateTime, default=datetime.now)
    updated_at = db.Column(db.DateTime, default=datetime.now, onupdate=datetime.now)
    
    def set_password(self, password):
        """Hash and set the user password"""
        from werkzeug.security import generate_password_hash
        self.password_hash = generate_password_hash(password)
    
    def check_password(self, password):
        """Check if provided password matches the hash"""
        from werkzeug.security import check_password_hash
        return check_password_hash(self.password_hash, password)
    
    @property
    def full_name(self):
        """Get user's full name"""
        if self.first_name and self.last_name:
            return f"{self.first_name} {self.last_name}"
        elif self.first_name:
            return self.first_name
        return self.email

# (IMPORTANT) This table is mandatory for Replit Auth, don't drop it.
class OAuth(OAuthConsumerMixin, db.Model):
    user_id = db.Column(db.String, db.ForeignKey(User.id))
    browser_session_key = db.Column(db.String, nullable=False)
    user = db.relationship(User)

    __table_args__ = (UniqueConstraint(
        'user_id',
        'browser_session_key',
        'provider',
        name='uq_user_browser_session_key_provider',
    ),)

# PCOD-specific models

class SymptomTracker(db.Model):
    __tablename__ = 'symptom_tracker'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.String, db.ForeignKey('users.id'), nullable=False)
    date = db.Column(db.Date, nullable=False)
    
    # Physical symptoms
    acne_severity = db.Column(db.Integer, nullable=True)  # 0-5 scale
    hair_loss_level = db.Column(db.Integer, nullable=True)  # 0-5 scale
    weight_gain_level = db.Column(db.Integer, nullable=True)  # 0-5 scale
    fatigue_level = db.Column(db.Integer, nullable=True)  # 0-5 scale
    bloating_level = db.Column(db.Integer, nullable=True)  # 0-5 scale
    
    # Emotional symptoms
    mood_swings = db.Column(db.Integer, nullable=True)  # 0-5 scale
    anxiety_level = db.Column(db.Integer, nullable=True)  # 0-5 scale
    depression_level = db.Column(db.Integer, nullable=True)  # 0-5 scale
    
    # Additional notes
    notes = db.Column(db.Text, nullable=True)
    
    created_at = db.Column(db.DateTime, default=datetime.now)
    
    user = db.relationship('User', backref='symptoms')

class MenstrualCycle(db.Model):
    __tablename__ = 'menstrual_cycles'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.String, db.ForeignKey('users.id'), nullable=False)
    
    # Cycle tracking
    start_date = db.Column(db.Date, nullable=False)
    end_date = db.Column(db.Date, nullable=True)
    cycle_length = db.Column(db.Integer, nullable=True)  # days
    flow_intensity = db.Column(db.String, nullable=True)  # light, medium, heavy
    
    # Symptoms during cycle
    cramps_severity = db.Column(db.Integer, nullable=True)  # 1-5 scale
    mood_changes = db.Column(db.String, nullable=True)
    other_symptoms = db.Column(db.Text, nullable=True)
    
    created_at = db.Column(db.DateTime, default=datetime.now)
    
    user = db.relationship('User', backref='cycles')

class DietPlan(db.Model):
    __tablename__ = 'diet_plans'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.String, db.ForeignKey('users.id'), nullable=False)
    
    meal_type = db.Column(db.String, nullable=False)  # breakfast, lunch, dinner, snack
    food_items = db.Column(db.Text, nullable=False)
    calories = db.Column(db.Integer, nullable=True)
    carbs = db.Column(db.Float, nullable=True)  # grams
    protein = db.Column(db.Float, nullable=True)  # grams
    fat = db.Column(db.Float, nullable=True)  # grams
    
    date = db.Column(db.Date, nullable=False)
    is_pcod_friendly = db.Column(db.Boolean, default=True)
    
    created_at = db.Column(db.DateTime, default=datetime.now)
    
    user = db.relationship('User', backref='diet_plans')

class ExercisePlan(db.Model):
    __tablename__ = 'exercise_plans'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.String, db.ForeignKey('users.id'), nullable=False)
    
    exercise_name = db.Column(db.String, nullable=False)
    exercise_type = db.Column(db.String, nullable=False)  # cardio, strength, yoga, etc.
    duration_minutes = db.Column(db.Integer, nullable=False)
    calories_burned = db.Column(db.Integer, nullable=True)
    
    date = db.Column(db.Date, nullable=False)
    completed = db.Column(db.Boolean, default=False)
    notes = db.Column(db.Text, nullable=True)
    
    created_at = db.Column(db.DateTime, default=datetime.now)
    
    user = db.relationship('User', backref='exercises')

class Reminder(db.Model):
    __tablename__ = 'reminders'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.String, db.ForeignKey('users.id'), nullable=False)
    
    title = db.Column(db.String, nullable=False)
    description = db.Column(db.Text, nullable=True)
    reminder_type = db.Column(db.String, nullable=False)  # medication, appointment, exercise, hydration
    reminder_time = db.Column(db.DateTime, nullable=False)
    is_recurring = db.Column(db.Boolean, default=False)
    recurrence_pattern = db.Column(db.String, nullable=True)  # daily, weekly, monthly
    
    is_completed = db.Column(db.Boolean, default=False)
    created_at = db.Column(db.DateTime, default=datetime.now)
    
    user = db.relationship('User', backref='reminders')

class EducationalContent(db.Model):
    __tablename__ = 'educational_content'
    id = db.Column(db.Integer, primary_key=True)
    
    title = db.Column(db.String, nullable=False)
    content = db.Column(db.Text, nullable=False)
    content_type = db.Column(db.String, nullable=False)  # article, faq, tip, video
    category = db.Column(db.String, nullable=False)  # diet, exercise, lifestyle, medical
    
    author = db.Column(db.String, nullable=True)
    is_published = db.Column(db.Boolean, default=True)
    
    created_at = db.Column(db.DateTime, default=datetime.now)
    updated_at = db.Column(db.DateTime, default=datetime.now, onupdate=datetime.now)

class DoctorProfile(db.Model):
    __tablename__ = 'doctor_profiles'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.String, db.ForeignKey('users.id'), nullable=False)
    
    # Professional details
    medical_license_number = db.Column(db.String, unique=True, nullable=False)
    specialization = db.Column(db.String, nullable=False)
    qualification = db.Column(db.String, nullable=False)
    experience_years = db.Column(db.Integer, nullable=False)
    
    # Contact and availability
    clinic_name = db.Column(db.String, nullable=True)
    clinic_address = db.Column(db.Text, nullable=True)
    consultation_fee = db.Column(db.Float, nullable=True)
    available_days = db.Column(db.String, nullable=True)  # JSON string of available days
    available_hours = db.Column(db.String, nullable=True)  # JSON string of time slots
    
    # Verification
    is_verified = db.Column(db.Boolean, default=False)
    verification_documents = db.Column(db.Text, nullable=True)
    
    created_at = db.Column(db.DateTime, default=datetime.now)
    
    user = db.relationship('User', backref='doctor_profile')

class QuizResult(db.Model):
    __tablename__ = 'quiz_results'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.String, db.ForeignKey('users.id'), nullable=False)
    
    quiz_type = db.Column(db.String, nullable=False)  # knowledge, symptoms, lifestyle
    score = db.Column(db.Integer, nullable=False)
    total_questions = db.Column(db.Integer, nullable=False)
    answers = db.Column(db.Text, nullable=True)  # JSON string of answers
    
    recommendations = db.Column(db.Text, nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.now)
    
    user = db.relationship('User', backref='quiz_results')

class ForumCategory(db.Model):
    __tablename__ = 'forum_categories'
    id = db.Column(db.Integer, primary_key=True)
    
    name = db.Column(db.String, nullable=False)
    description = db.Column(db.Text, nullable=True)
    icon = db.Column(db.String, nullable=True)
    display_order = db.Column(db.Integer, default=0)
    
    created_at = db.Column(db.DateTime, default=datetime.now)

class ForumPost(db.Model):
    __tablename__ = 'forum_posts'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.String, db.ForeignKey('users.id'), nullable=False)
    category_id = db.Column(db.Integer, db.ForeignKey('forum_categories.id'), nullable=False)
    
    title = db.Column(db.String, nullable=False)
    content = db.Column(db.Text, nullable=False)
    is_pinned = db.Column(db.Boolean, default=False)
    views_count = db.Column(db.Integer, default=0)
    
    created_at = db.Column(db.DateTime, default=datetime.now)
    updated_at = db.Column(db.DateTime, default=datetime.now, onupdate=datetime.now)
    
    user = db.relationship('User', backref='forum_posts')
    category = db.relationship('ForumCategory', backref='posts')

class ForumReply(db.Model):
    __tablename__ = 'forum_replies'
    id = db.Column(db.Integer, primary_key=True)
    post_id = db.Column(db.Integer, db.ForeignKey('forum_posts.id'), nullable=False)
    user_id = db.Column(db.String, db.ForeignKey('users.id'), nullable=False)
    
    content = db.Column(db.Text, nullable=False)
    is_solution = db.Column(db.Boolean, default=False)
    
    created_at = db.Column(db.DateTime, default=datetime.now)
    updated_at = db.Column(db.DateTime, default=datetime.now, onupdate=datetime.now)
    
    post = db.relationship('ForumPost', backref='replies')
    user = db.relationship('User', backref='forum_replies')

class ForumReaction(db.Model):
    __tablename__ = 'forum_reactions'
    id = db.Column(db.Integer, primary_key=True)
    reply_id = db.Column(db.Integer, db.ForeignKey('forum_replies.id'), nullable=True)
    post_id = db.Column(db.Integer, db.ForeignKey('forum_posts.id'), nullable=True)
    user_id = db.Column(db.String, db.ForeignKey('users.id'), nullable=False)
    
    reaction_type = db.Column(db.String, default='like')
    created_at = db.Column(db.DateTime, default=datetime.now)
    
    reply = db.relationship('ForumReply', backref='reactions')
    post = db.relationship('ForumPost', backref='reactions')
    user = db.relationship('User', backref='forum_reactions')
    
    __table_args__ = (
        db.UniqueConstraint('reply_id', 'user_id', name='unique_user_reply_reaction'),
        db.UniqueConstraint('post_id', 'user_id', name='unique_user_post_reaction'),
    )

class ForumPostView(db.Model):
    __tablename__ = 'forum_post_views'
    id = db.Column(db.Integer, primary_key=True)
    post_id = db.Column(db.Integer, db.ForeignKey('forum_posts.id'), nullable=False)
    user_id = db.Column(db.String, db.ForeignKey('users.id'), nullable=True)
    session_id = db.Column(db.String, nullable=True)
    viewed_at = db.Column(db.DateTime, default=datetime.now)
    
    post = db.relationship('ForumPost', backref='post_views')
    user = db.relationship('User', backref='forum_post_views')
    
    __table_args__ = (
        db.UniqueConstraint('post_id', 'user_id', name='unique_user_post_view'),
        db.UniqueConstraint('post_id', 'session_id', name='unique_session_post_view'),
    )

# Educational Content & Learning Tracks
class EducationalTrack(db.Model):
    __tablename__ = 'educational_tracks'
    id = db.Column(db.Integer, primary_key=True)
    
    title = db.Column(db.String, nullable=False)
    description = db.Column(db.Text, nullable=True)
    track_type = db.Column(db.String, nullable=False)  # 'pcos_user' or 'family_member'
    order_index = db.Column(db.Integer, default=0)
    duration_weeks = db.Column(db.Integer, nullable=True)
    icon = db.Column(db.String, nullable=True)
    
    is_published = db.Column(db.Boolean, default=True)
    created_at = db.Column(db.DateTime, default=datetime.now)
    updated_at = db.Column(db.DateTime, default=datetime.now, onupdate=datetime.now)

class Lesson(db.Model):
    __tablename__ = 'lessons'
    id = db.Column(db.Integer, primary_key=True)
    track_id = db.Column(db.Integer, db.ForeignKey('educational_tracks.id'), nullable=False)
    
    title = db.Column(db.String, nullable=False)
    order_index = db.Column(db.Integer, default=0)
    
    # Content structure
    why_it_matters = db.Column(db.Text, nullable=False)
    video_url = db.Column(db.String, nullable=True)
    video_duration_minutes = db.Column(db.Integer, nullable=True)
    conversation_prompt = db.Column(db.Text, nullable=True)
    
    # Additional content
    content = db.Column(db.Text, nullable=True)
    dos = db.Column(db.Text, nullable=True)  # JSON array
    donts = db.Column(db.Text, nullable=True)  # JSON array
    
    is_published = db.Column(db.Boolean, default=True)
    created_at = db.Column(db.DateTime, default=datetime.now)
    updated_at = db.Column(db.DateTime, default=datetime.now, onupdate=datetime.now)
    
    track = db.relationship('EducationalTrack', backref='lessons')

class LessonAction(db.Model):
    __tablename__ = 'lesson_actions'
    id = db.Column(db.Integer, primary_key=True)
    lesson_id = db.Column(db.Integer, db.ForeignKey('lessons.id'), nullable=False)
    
    action_text = db.Column(db.String, nullable=False)
    order_index = db.Column(db.Integer, default=0)
    is_optional = db.Column(db.Boolean, default=False)
    
    created_at = db.Column(db.DateTime, default=datetime.now)
    
    lesson = db.relationship('Lesson', backref='actions')

class LessonQuiz(db.Model):
    __tablename__ = 'lesson_quizzes'
    id = db.Column(db.Integer, primary_key=True)
    lesson_id = db.Column(db.Integer, db.ForeignKey('lessons.id'), nullable=False)
    
    title = db.Column(db.String, nullable=False)
    passing_score = db.Column(db.Integer, default=70)  # percentage
    
    created_at = db.Column(db.DateTime, default=datetime.now)
    
    lesson = db.relationship('Lesson', backref='quiz', uselist=False)

class QuizQuestion(db.Model):
    __tablename__ = 'quiz_questions'
    id = db.Column(db.Integer, primary_key=True)
    quiz_id = db.Column(db.Integer, db.ForeignKey('lesson_quizzes.id'), nullable=False)
    
    question_text = db.Column(db.Text, nullable=False)
    question_type = db.Column(db.String, default='multiple_choice')  # multiple_choice, true_false
    options = db.Column(db.Text, nullable=False)  # JSON array of options
    correct_answer = db.Column(db.String, nullable=False)
    explanation = db.Column(db.Text, nullable=True)
    order_index = db.Column(db.Integer, default=0)
    
    created_at = db.Column(db.DateTime, default=datetime.now)
    
    quiz = db.relationship('LessonQuiz', backref='questions')

class UserLessonProgress(db.Model):
    __tablename__ = 'user_lesson_progress'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.String, db.ForeignKey('users.id'), nullable=False)
    lesson_id = db.Column(db.Integer, db.ForeignKey('lessons.id'), nullable=False)
    
    started_at = db.Column(db.DateTime, nullable=True)
    completed_at = db.Column(db.DateTime, nullable=True)
    quiz_score = db.Column(db.Integer, nullable=True)  # percentage
    quiz_attempts = db.Column(db.Integer, default=0)
    
    # Track action completion
    completed_actions = db.Column(db.Text, nullable=True)  # JSON array of completed action IDs
    
    created_at = db.Column(db.DateTime, default=datetime.now)
    updated_at = db.Column(db.DateTime, default=datetime.now, onupdate=datetime.now)
    
    user = db.relationship('User', backref='lesson_progress')
    lesson = db.relationship('Lesson', backref='user_progress')

# Badge and Achievement System
class Badge(db.Model):
    __tablename__ = 'badges'
    id = db.Column(db.Integer, primary_key=True)
    
    badge_name = db.Column(db.String, nullable=False, unique=True)
    badge_type = db.Column(db.String, nullable=False)  # quiz_perfect, quiz_pass, track_complete
    description = db.Column(db.Text, nullable=False)
    icon = db.Column(db.String, nullable=False)  # Bootstrap icon name
    color = db.Column(db.String, default='#6610f2')  # Badge color (indigo default)
    
    # Criteria for earning this badge
    criteria_type = db.Column(db.String, nullable=False)  # quiz_score, track_completion
    criteria_value = db.Column(db.Integer, nullable=True)  # e.g., 100 for perfect score
    track_id = db.Column(db.Integer, db.ForeignKey('educational_tracks.id'), nullable=True)  # For track-specific badges
    
    created_at = db.Column(db.DateTime, default=datetime.now)
    
    track = db.relationship('EducationalTrack', backref='badges')

class UserBadge(db.Model):
    __tablename__ = 'user_badges'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.String, db.ForeignKey('users.id'), nullable=False)
    badge_id = db.Column(db.Integer, db.ForeignKey('badges.id'), nullable=False)
    lesson_id = db.Column(db.Integer, db.ForeignKey('lessons.id'), nullable=True)  # Which lesson earned this
    
    earned_at = db.Column(db.DateTime, default=datetime.now)
    quiz_score = db.Column(db.Integer, nullable=True)  # Score that earned the badge
    
    user = db.relationship('User', backref='badges')
    badge = db.relationship('Badge', backref='user_badges')
    lesson = db.relationship('Lesson', backref='earned_badges')

# Family Support Features
class FamilyConnection(db.Model):
    __tablename__ = 'family_connections'
    id = db.Column(db.Integer, primary_key=True)
    primary_user_id = db.Column(db.String, db.ForeignKey('users.id'), nullable=False)  # PCOS user
    family_member_id = db.Column(db.String, db.ForeignKey('users.id'), nullable=False)  # Family member
    
    # Opt-in and permissions
    is_active = db.Column(db.Boolean, default=False)  # Must be opt-in by primary user
    can_view_goals = db.Column(db.Boolean, default=False)
    can_view_symptoms = db.Column(db.Boolean, default=False)
    can_send_nudges = db.Column(db.Boolean, default=False)
    
    connection_status = db.Column(db.String, default='pending')  # pending, active, paused, ended
    invited_at = db.Column(db.DateTime, default=datetime.now)
    activated_at = db.Column(db.DateTime, nullable=True)
    
    created_at = db.Column(db.DateTime, default=datetime.now)
    updated_at = db.Column(db.DateTime, default=datetime.now, onupdate=datetime.now)
    
    primary_user = db.relationship('User', foreign_keys=[primary_user_id], backref='family_connections_as_primary')
    family_member = db.relationship('User', foreign_keys=[family_member_id], backref='family_connections_as_member')

class SharedGoal(db.Model):
    __tablename__ = 'shared_goals'
    id = db.Column(db.Integer, primary_key=True)
    connection_id = db.Column(db.Integer, db.ForeignKey('family_connections.id'), nullable=False)
    
    goal_text = db.Column(db.String, nullable=False)
    goal_type = db.Column(db.String, nullable=False)  # diet, exercise, sleep, stress, medication
    target_frequency = db.Column(db.String, nullable=True)  # daily, weekly, etc.
    
    is_active = db.Column(db.Boolean, default=True)
    created_at = db.Column(db.DateTime, default=datetime.now)
    completed_at = db.Column(db.DateTime, nullable=True)
    
    connection = db.relationship('FamilyConnection', backref='shared_goals')

class Nudge(db.Model):
    __tablename__ = 'nudges'
    id = db.Column(db.Integer, primary_key=True)
    
    nudge_type = db.Column(db.String, nullable=False)  # encouragement, recipe_swap, walk_invite, reminder, celebration
    title = db.Column(db.String, nullable=False)
    message = db.Column(db.Text, nullable=False)
    
    # Optional: specific context
    goal_type = db.Column(db.String, nullable=True)  # diet, exercise, sleep, etc.
    
    is_template = db.Column(db.Boolean, default=True)  # True for library templates
    created_at = db.Column(db.DateTime, default=datetime.now)

class SentNudge(db.Model):
    __tablename__ = 'sent_nudges'
    id = db.Column(db.Integer, primary_key=True)
    connection_id = db.Column(db.Integer, db.ForeignKey('family_connections.id'), nullable=False)
    nudge_id = db.Column(db.Integer, db.ForeignKey('nudges.id'), nullable=True)  # Null if custom
    
    sender_id = db.Column(db.String, db.ForeignKey('users.id'), nullable=False)
    recipient_id = db.Column(db.String, db.ForeignKey('users.id'), nullable=False)
    
    message = db.Column(db.Text, nullable=False)
    nudge_type = db.Column(db.String, nullable=False)
    
    is_read = db.Column(db.Boolean, default=False)
    sent_at = db.Column(db.DateTime, default=datetime.now)
    read_at = db.Column(db.DateTime, nullable=True)
    
    connection = db.relationship('FamilyConnection', backref='sent_nudges')
    nudge = db.relationship('Nudge', backref='sent_instances')
    sender = db.relationship('User', foreign_keys=[sender_id], backref='sent_nudges')
    recipient = db.relationship('User', foreign_keys=[recipient_id], backref='received_nudges')

class MessageReaction(db.Model):
    __tablename__ = 'message_reactions'
    id = db.Column(db.Integer, primary_key=True)
    message_id = db.Column(db.Integer, db.ForeignKey('sent_nudges.id'), nullable=False)
    user_id = db.Column(db.String, db.ForeignKey('users.id'), nullable=False)
    
    reaction_type = db.Column(db.String, default='like')  # 'like' or 'dislike'
    created_at = db.Column(db.DateTime, default=datetime.now)
    
    message = db.relationship('SentNudge', backref='reactions')
    user = db.relationship('User', backref='message_reactions')
    
    __table_args__ = (
        db.UniqueConstraint('message_id', 'user_id', name='unique_user_message_reaction'),
    )

# Contact form submissions
class ContactMessage(db.Model):
    __tablename__ = 'contact_messages'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(120), nullable=False)
    subject = db.Column(db.String(100), nullable=False)
    message = db.Column(db.Text, nullable=False)
    status = db.Column(db.String(20), default='new')
    created_at = db.Column(db.DateTime, default=datetime.now)
    responded_at = db.Column(db.DateTime, nullable=True)

class DailyMotivation(db.Model):
    __tablename__ = 'daily_motivations'
    id = db.Column(db.Integer, primary_key=True)
    message = db.Column(db.Text, nullable=False)
    category = db.Column(db.String(50), nullable=True)  # health, mindset, self_care, etc.
    icon = db.Column(db.String(50), nullable=True)  # emoji or icon class
    is_active = db.Column(db.Boolean, default=True)
    created_at = db.Column(db.DateTime, default=datetime.now)