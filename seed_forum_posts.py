"""
Seed Forum with Sample Posts and Replies
Adds realistic, helpful discussions across all 9 forum categories
"""

from app import app, db
from models import User, ForumCategory, ForumPost, ForumReply
from datetime import datetime, timedelta
import random

def seed_forum_posts():
    with app.app_context():
        # Get or create demo users using direct SQL
        demo_users = []
        user_profiles = [
            {'email': 'sarah.demo@example.com', 'name': 'Sarah'},
            {'email': 'priya.demo@example.com', 'name': 'Priya'},
            {'email': 'maya.demo@example.com', 'name': 'Maya'},
            {'email': 'emma.demo@example.com', 'name': 'Emma'},
            {'email': 'jasmine.demo@example.com', 'name': 'Jasmine'},
        ]
        
        from werkzeug.security import generate_password_hash
        import uuid
        
        for profile in user_profiles:
            user = User.query.filter_by(email=profile['email']).first()
            if not user:
                # Create using SQL with UUID
                user_id = str(uuid.uuid4())
                password_hash = generate_password_hash('demo123')
                result = db.session.execute(
                    db.text("""
                        INSERT INTO users (id, email, password_hash, first_name, last_name, 
                                         user_role, onboarding_completed, is_active, 
                                         created_at, updated_at)
                        VALUES (:id, :email, :password, :first, :last, 
                               'pcos_user', true, true, NOW(), NOW())
                    """),
                    {
                        'id': user_id,
                        'email': profile['email'],
                        'password': password_hash,
                        'first': profile['name'],
                        'last': 'Community'
                    }
                )
                db.session.commit()
                user = User.query.filter_by(email=profile['email']).first()
            demo_users.append(user)
        
        # Get all categories
        categories = ForumCategory.query.all()
        category_map = {cat.name: cat for cat in categories}
        
        # Sample posts for each category
        sample_posts = {
            'Causes and Diagnosis': [
                {
                    'title': 'How long did it take you to get diagnosed?',
                    'content': 'I struggled with irregular periods for 3 years before my doctor finally mentioned PCOS. Just wondering how long it took others to get a proper diagnosis?',
                    'replies': [
                        'Took me 5 years! Had to see 3 different doctors before one finally did an ultrasound and blood tests.',
                        'I was lucky - my gynecologist diagnosed me within 6 months. She really listened to all my symptoms.',
                    ]
                },
                {
                    'title': 'What tests confirmed your PCOS diagnosis?',
                    'content': 'My doctor mentioned I might have PCOS. What specific tests should I ask for to confirm? I want to be prepared for my next appointment.',
                    'replies': [
                        'I had an ultrasound to check for cysts, hormone blood tests (testosterone, LH, FSH), and glucose tolerance test.',
                        'Same here - ultrasound and blood work. Also tracked my periods for 3 months to show the irregularity.',
                    ]
                }
            ],
            'Fertility': [
                {
                    'title': 'Success story: Got pregnant after 2 years!',
                    'content': 'Just wanted to share some hope! After being told PCOS would make pregnancy difficult, I just found out I am 8 weeks pregnant. Lost 15 pounds, took inositol, and tracked ovulation. Do not give up!',
                    'replies': [
                        'Congratulations! This gives me so much hope. How did you track ovulation?',
                        'Amazing news! Wishing you a healthy pregnancy!',
                    ]
                },
                {
                    'title': 'Anyone try Letrozole for ovulation?',
                    'content': 'My doctor suggested Letrozole instead of Clomid. Has anyone had experience with this? What were your results?',
                    'replies': [
                        'Yes! Letrozole worked better for me than Clomid. Fewer side effects and I ovulated on the second cycle.',
                    ]
                }
            ],
            'Periods and Cycles': [
                {
                    'title': 'Irregular periods - what is normal for PCOS?',
                    'content': 'My cycles vary from 35 to 70 days. Is this typical for PCOS? Should I be concerned about the long gaps?',
                    'replies': [
                        'My cycles are similar - anywhere from 40-90 days. My doctor said as long as you have at least 4 periods a year, it is manageable.',
                        'I would talk to your doctor about progesterone to induce a period if you go more than 3 months without one.',
                    ]
                },
                {
                    'title': 'Best period tracking apps for irregular cycles?',
                    'content': 'Regular period apps do not work well with my irregular PCOS cycles. What do you all use to track?',
                    'replies': [
                        'I love CystaSense for tracking! It is designed specifically for PCOS with irregular cycles in mind, so it does not try to predict based on 28-day cycles like regular apps.',
                    ]
                }
            ],
            'Skin and Hair': [
                {
                    'title': 'Facial hair removal options - what works?',
                    'content': 'The chin hair is getting worse and I am tired of plucking daily. What removal methods have worked for you? Considering laser but worried about cost.',
                    'replies': [
                        'Laser has been life-changing for me! Expensive upfront but worth it. Did 8 sessions and hair growth reduced by 80%.',
                        'I use an epilator and spironolactone. The medication has definitely slowed the growth over 6 months.',
                    ]
                },
                {
                    'title': 'Acne finally clearing up after diet changes',
                    'content': 'Cut out dairy and reduced sugar 2 months ago and my skin has improved so much! Still get some breakouts around my period but nothing like before.',
                    'replies': [
                        'Dairy was my trigger too! Switched to oat milk and my cystic acne cleared within weeks.',
                    ]
                }
            ],
            'Long-term Health Conditions': [
                {
                    'title': 'Prediabetes diagnosis - feeling overwhelmed',
                    'content': 'Just got test results showing prediabetes. I know PCOS increases diabetes risk but I am still shocked. Anyone else dealing with this? What changes did you make?',
                    'replies': [
                        'I was diagnosed with prediabetes 2 years ago. Cut carbs, started walking 30 min daily, and my A1C is now normal! You can reverse it.',
                        'Same boat. Taking metformin and watching carbs. My doctor said catching it early is key - you have got this!',
                    ]
                },
            ],
            'Management and Treatment': [
                {
                    'title': 'Metformin side effects - do they go away?',
                    'content': 'Started metformin 2 weeks ago and the stomach issues are rough. Does this get better or should I talk to my doctor about alternatives?',
                    'replies': [
                        'Give it 4-6 weeks. The side effects mostly went away for me after a month. Taking it with food helps a lot.',
                        'Ask about the extended-release version! Much easier on the stomach.',
                    ]
                },
                {
                    'title': 'Inositol - has it helped anyone?',
                    'content': 'Thinking about trying myo-inositol supplements. Has anyone had success with this for regulating cycles or reducing symptoms?',
                    'replies': [
                        'Been taking it for 4 months - my cycles went from 60+ days to 35-40 days! Also lost some weight.',
                    ]
                }
            ],
            'Sexual Health and Relationships': [
                {
                    'title': 'How to explain PCOS to your partner?',
                    'content': 'My boyfriend tries to be supportive but I do not think he really understands what PCOS involves. How do you explain it to partners in a way they get it?',
                    'replies': [
                        'I showed my husband some videos and articles. Once he understood it is a hormonal condition, not just about periods, he was more supportive.',
                        'I explained it affects insulin, hormones, fertility, weight, and mood - it is not just one thing. That helped my partner understand why I have tough days.',
                    ]
                },
            ],
            'Weight and Body Image': [
                {
                    'title': 'Learning to love my body despite PCOS',
                    'content': 'The weight gain, facial hair, and acne have made me struggle with self-image. Starting therapy and it is helping. How do you practice self-compassion?',
                    'replies': [
                        'Therapy was huge for me too. Also following body-positive PCOS accounts on social media helped me see I am not alone.',
                        'Remembering my body is fighting a hormonal condition, not failing me. Be gentle with yourself!',
                    ]
                },
            ],
            'Inspirational Stories': [
                {
                    'title': 'One year of lifestyle changes - my journey',
                    'content': 'A year ago I was diagnosed with PCOS, prediabetes, and depression. Today: lost 30 pounds, cycles are regular, A1C is normal, and I feel like myself again. It was hard but so worth it. Keep going!',
                    'replies': [
                        'This is so motivating! What were your biggest changes that made a difference?',
                        'Thank you for sharing! Stories like this give me hope on tough days.',
                    ]
                },
                {
                    'title': 'Small wins matter too!',
                    'content': 'Did not binge eat this week, walked 4 days, and drank more water. These might seem small but they are victories for me. Celebrating progress, not perfection!',
                    'replies': [
                        'Love this mindset! Small consistent changes add up to big results.',
                    ]
                }
            ]
        }
        
        # Create posts and replies
        post_count = 0
        reply_count = 0
        
        for category_name, posts in sample_posts.items():
            category = category_map.get(category_name)
            if not category:
                continue
            
            for post_data in posts:
                # Create post
                author = random.choice(demo_users)
                post = ForumPost(
                    title=post_data['title'],
                    content=post_data['content'],
                    category_id=category.id,
                    user_id=author.id,
                    created_at=datetime.now() - timedelta(days=random.randint(1, 30))
                )
                db.session.add(post)
                db.session.commit()
                post_count += 1
                
                # Add some likes
                post.like_count = random.randint(3, 15)
                post.view_count = random.randint(20, 100)
                
                # Create replies
                for reply_text in post_data.get('replies', []):
                    reply_author = random.choice([u for u in demo_users if u.id != author.id])
                    reply = ForumReply(
                        content=reply_text,
                        post_id=post.id,
                        user_id=reply_author.id,
                        created_at=post.created_at + timedelta(hours=random.randint(1, 48))
                    )
                    db.session.add(reply)
                    reply_count += 1
                
                db.session.commit()
        
        print(f"✅ Successfully seeded {post_count} forum posts and {reply_count} replies!")
        print(f"Demo users: {', '.join([u.first_name for u in demo_users])}")

if __name__ == '__main__':
    seed_forum_posts()
