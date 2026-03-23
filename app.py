from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.orm import DeclarativeBase
import os
from werkzeug.middleware.proxy_fix import ProxyFix
import logging

# Configure logging - use INFO level for production
log_level = logging.DEBUG if os.environ.get('FLASK_ENV') == 'development' else logging.INFO
logging.basicConfig(level=log_level)

class Base(DeclarativeBase):
    pass

# Initialize Flask app
app = Flask(__name__, static_folder='assets', static_url_path='/assets')
# Require SESSION_SECRET for security
if not os.environ.get("SESSION_SECRET"):
    raise ValueError("SESSION_SECRET environment variable must be set")
app.secret_key = os.environ.get("SESSION_SECRET")
app.wsgi_app = ProxyFix(app.wsgi_app, x_proto=1, x_host=1) # needed for url_for to generate with https

# Database configuration
app.config["SQLALCHEMY_DATABASE_URI"] = os.environ.get("DATABASE_URL", "sqlite:///pcod_app.db")
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ENGINE_OPTIONS"] = {
    'pool_pre_ping': True,
    "pool_recycle": 300,
}

# Security configurations - relaxed for Replit environment
# SameSite=None requires Secure=True for cross-origin iframe support
app.config['SESSION_COOKIE_SECURE'] = True  # Required for SameSite=None
app.config['SESSION_COOKIE_HTTPONLY'] = True
app.config['SESSION_COOKIE_SAMESITE'] = 'None'  # Required for iframe embedding in Replit
app.config['PERMANENT_SESSION_LIFETIME'] = 3600  # 1 hour
app.config['WTF_CSRF_ENABLED'] = True
app.config['WTF_CSRF_TIME_LIMIT'] = None
app.config['REMEMBER_COOKIE_SAMESITE'] = 'None'  # Also set for remember me cookie
app.config['REMEMBER_COOKIE_SECURE'] = True  # Required for SameSite=None

# Security headers
@app.after_request
def add_security_headers(response):
    """Add security headers to all responses"""
    response.headers['X-Content-Type-Options'] = 'nosniff'
    response.headers['X-Frame-Options'] = 'SAMEORIGIN'
    response.headers['X-XSS-Protection'] = '1; mode=block'
    
    # Prevent caching of HTML pages to ensure fresh auth state
    # This fixes the issue where Login button shows after successful login
    if response.content_type and 'text/html' in response.content_type:
        response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate, private'
        response.headers['Pragma'] = 'no-cache'
        response.headers['Expires'] = '0'
    
    return response

# Initialize SQLAlchemy
db = SQLAlchemy(app, model_class=Base)

# Add custom Jinja2 filter to convert YouTube URLs to embed format
@app.template_filter('youtube_embed')
def youtube_embed_filter(url):
    """Convert YouTube watch URL to embed URL"""
    if not url:
        return url
    
    import re
    
    # Handle different YouTube URL formats
    patterns = [
        r'youtube\.com/watch\?v=([a-zA-Z0-9_-]+)',
        r'youtu\.be/([a-zA-Z0-9_-]+)',
        r'youtube\.com/shorts/([a-zA-Z0-9_-]+)',
        r'youtube\.com/embed/([a-zA-Z0-9_-]+)'
    ]
    
    for pattern in patterns:
        match = re.search(pattern, url)
        if match:
            video_id = match.group(1)
            return f'https://www.youtube.com/embed/{video_id}'
    
    # If no match or already an embed URL, return as is
    return url

# Context processor to inject unread messages count for all users
@app.context_processor
def inject_unread_messages():
    """Make unread_messages available in all templates"""
    from flask_login import current_user
    from flask import g
    
    try:
        if current_user.is_authenticated:
            # Cache unread count in request context to avoid multiple DB queries per request
            if not hasattr(g, 'unread_messages'):
                from models import SentNudge
                g.unread_messages = SentNudge.query.filter_by(
                    recipient_id=current_user.id,
                    is_read=False
                ).count()
            return {'unread_messages': g.unread_messages}
    except Exception:
        # Database not ready, return default
        pass
    return {'unread_messages': 0}

# Track if database has been initialized
_db_initialized = False

def init_database():
    """Initialize database tables and indexes - called lazily on first request"""
    global _db_initialized
    if _db_initialized:
        return
    
    import models  # noqa: F401
    try:
        db.create_all()
        logging.info("Database tables created")
        
        # Create database indexes for performance
        try:
            indexes = [
                "CREATE INDEX IF NOT EXISTS idx_users_email ON users(LOWER(email))",
                "CREATE INDEX IF NOT EXISTS idx_symptom_tracker_user_date ON symptom_tracker(user_id, date DESC)",
                "CREATE INDEX IF NOT EXISTS idx_menstrual_cycle_user_date ON menstrual_cycles(user_id, start_date DESC)",
                "CREATE INDEX IF NOT EXISTS idx_reminders_user_completed ON reminders(user_id, is_completed)",
                "CREATE INDEX IF NOT EXISTS idx_sent_nudges_recipient_read ON sent_nudges(recipient_id, is_read)",
                "CREATE INDEX IF NOT EXISTS idx_family_connections_primary ON family_connections(primary_user_id, connection_status)",
                "CREATE INDEX IF NOT EXISTS idx_family_connections_member ON family_connections(family_member_id, connection_status)",
                "CREATE INDEX IF NOT EXISTS idx_forum_posts_category ON forum_posts(category_id, created_at DESC)",
                "CREATE INDEX IF NOT EXISTS idx_forum_posts_user ON forum_posts(user_id)",
                "CREATE INDEX IF NOT EXISTS idx_forum_replies_post ON forum_replies(post_id, created_at DESC)",
                "CREATE INDEX IF NOT EXISTS idx_lesson_progress_user ON user_lesson_progress(user_id, lesson_id)"
            ]
            for index_sql in indexes:
                db.session.execute(db.text(index_sql))
            db.session.commit()
            logging.info("Database indexes created successfully")
        except Exception as e:
            logging.warning(f"Index creation skipped or failed: {e}")
            db.session.rollback()
        
        # Auto-enhance curriculum on startup if needed
        from models import EducationalTrack, Lesson
        track1 = EducationalTrack.query.filter_by(title="Getting Started with PCOS").first()
        if track1 and len(track1.lessons) < 3:  # Check if enhancement is needed
            logging.info("Enhancing curriculum with additional lessons...")
            try:
                from enhance_curriculum import enhance_curriculum
                enhance_curriculum()
                logging.info("Curriculum enhancement complete")
            except Exception as e:
                logging.error(f"Curriculum enhancement failed: {e}")
        
        _db_initialized = True
    except Exception as e:
        logging.error(f"Database initialization failed (may be auto-suspended): {e}")
        logging.info("Database will reconnect on first request")

@app.before_request
def ensure_db_initialized():
    """Initialize database on first real request (not health checks)"""
    from flask import request
    # Skip DB init for health check endpoints
    if request.endpoint in ('health_check', 'index', 'static'):
        return
    init_database()