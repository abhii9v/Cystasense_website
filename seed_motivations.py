"""Seed daily motivational messages into the database"""
from app import app, db
from models import DailyMotivation

motivational_messages = [
    {"message": "Your health journey matters. Take a moment today to track how you're feeling! 💜", "category": "health", "icon": "💜"},
    {"message": "Small steps every day lead to big changes. Track your symptoms and celebrate your progress!", "category": "mindset", "icon": "✨"},
    {"message": "You're stronger than PCOS. Check in with yourself today!", "category": "mindset", "icon": "💪"},
    {"message": "Remember to drink water, track your meals, and be kind to yourself today.", "category": "self_care", "icon": "💧"},
    {"message": "Every symptom you track helps you understand your body better. Keep going!", "category": "health", "icon": "📊"},
    {"message": "Your menstrual cycle is unique to you. Track it to understand your patterns better!", "category": "health", "icon": "📅"},
    {"message": "Take 5 minutes today to log your symptoms. Future you will thank you! 🌸", "category": "health", "icon": "🌸"},
    {"message": "PCOS doesn't define you, but tracking it helps you manage it. You've got this!", "category": "mindset", "icon": "🌟"},
    {"message": "Stress affects PCOS. Take a deep breath, track your mood, and be gentle with yourself.", "category": "self_care", "icon": "🧘"},
    {"message": "Movement is medicine. Track your exercise and celebrate every step!", "category": "health", "icon": "🏃"},
    {"message": "Sleep matters for hormone balance. Track your rest tonight! 😴", "category": "self_care", "icon": "😴"},
    {"message": "You're not alone in this journey. Check in with CystaSense today! 💚", "category": "mindset", "icon": "💚"},
    {"message": "Food is fuel, not the enemy. Track your meals with kindness and curiosity.", "category": "health", "icon": "🥗"},
    {"message": "Your body is doing its best. Honor it by tracking what it's telling you today.", "category": "self_care", "icon": "🌺"},
    {"message": "Progress isn't linear. Track today, even if yesterday wasn't perfect! 🌈", "category": "mindset", "icon": "🌈"},
    {"message": "Hormones can be tricky, but you're tracking them like a pro! Keep it up! 🎯", "category": "health", "icon": "🎯"},
    {"message": "One tracked symptom at a time. You're building valuable data about your health! 📝", "category": "health", "icon": "📝"},
    {"message": "Consistency beats perfection. Log in today, even if it's just for a minute! ⏰", "category": "mindset", "icon": "⏰"},
    {"message": "Your health data helps your doctor help you better. Track with purpose! 👩‍⚕️", "category": "health", "icon": "👩‍⚕️"},
    {"message": "PCOS taught you resilience. Track your journey and see how far you've come! 🦋", "category": "mindset", "icon": "🦋"},
    {"message": "Be patient with your body. Track today's symptoms and trust the process. 🌿", "category": "self_care", "icon": "🌿"},
    {"message": "Knowledge is power. The more you track, the more you understand your PCOS! 📚", "category": "health", "icon": "📚"},
    {"message": "You're doing better than you think. Check in and give yourself credit! ⭐", "category": "mindset", "icon": "⭐"},
    {"message": "Hydration, nutrition, rest, movement - track them all! Your body will thank you. 💖", "category": "self_care", "icon": "💖"},
    {"message": "Every cycle teaches you something new. Track it and learn! 🔄", "category": "health", "icon": "🔄"},
    {"message": "You deserve to feel good. Track your symptoms to find what helps! 🌞", "category": "mindset", "icon": "🌞"},
    {"message": "Weight is just one number. Track how you FEEL - that matters more! 💙", "category": "mindset", "icon": "💙"},
    {"message": "Skin changes, mood swings, energy dips - track it all. Patterns matter! 🎨", "category": "health", "icon": "🎨"},
    {"message": "Your fertility journey is yours alone. Track with hope and self-compassion. 🌸", "category": "health", "icon": "🌸"},
    {"message": "Celebrate the good days by tracking them! You need that data too! 🎉", "category": "mindset", "icon": "🎉"},
]

def seed_motivations():
    """Add motivational messages to database"""
    with app.app_context():
        # Check if we already have messages
        existing_count = DailyMotivation.query.count()
        
        if existing_count > 0:
            print(f"⚠️  Database already has {existing_count} motivational messages. Skipping seed.")
            return
        
        # Add all messages
        for msg_data in motivational_messages:
            motivation = DailyMotivation(
                message=msg_data['message'],
                category=msg_data['category'],
                icon=msg_data['icon'],
                is_active=True
            )
            db.session.add(motivation)
        
        db.session.commit()
        print(f"✅ Successfully added {len(motivational_messages)} motivational messages!")

if __name__ == '__main__':
    seed_motivations()
