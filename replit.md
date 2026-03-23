# CystaSense - Women's Health Management Platform

## Overview

CystaSense is a comprehensive web application designed to help women manage Polycystic Ovary Syndrome (PCOS/PCOD). The platform provides symptom tracking, educational resources, diet planning, appointment booking, and health analytics. Built with Flask and SQLAlchemy, it features a Bootstrap-responsive frontend and supports both traditional login and OAuth authentication through Replit Auth.

## User Preferences

- Preferred communication style: Simple, everyday language
- Color scheme: Indigo (#6610f2) and Teal (#14b8a6) - no pink or red
- Branding: Application branded as "CystaSense" with DNA helix and lotus logo
- UX: User-friendly authentication without external redirects, intuitive interfaces

## Recent Changes (October 2025)

- **Rebranded from PCOD Care to CystaSense** with new logo (DNA helix with lotus petals)
- **Enhanced Tracker System**: Tabbed interface, quick-log buttons, visual severity indicators, progress tracking
- **Modernized Dashboard**: Gradient stat cards, improved sidebar navigation, quick action buttons, wellness tips
- **Improved Reminder System**: Quick-setup buttons, toast notifications, search/filtering, better categorization
- **Color Scheme Update**: Switched to indigo and teal theme throughout the application
- **Logo**: Custom logo at assets/images/cystasense-logo.png with circular styling and white background
- **Community Forum**: 9 categories including Causes/Diagnosis, Fertility, Periods, Skin/Hair, Long-term Health, Treatment, Relationships, Body Image, and Inspirational Stories; inline post editing for authors, reply system with CSRF protection, like/dislike reactions for posts and replies, unique view tracking (one view per user)
- **4-Step Onboarding System**: Role selection (PCOS user/family member), consent management, profile capture, accessibility preferences
  - **Role-Based Navigation**: Supporters navigate to Learn track after onboarding; PCOS users go to dashboard
  - **Clear Role Communication**: Login/registration pages now clearly indicate support for both PCOS users and family members
- **Educational Learning Tracks**: 7 PCOS tracks (Getting Started, Food, Movement, Sleep/Stress, Skin/Hair, Fertility, Meds) + Family Support Essentials micro-course with lessons, videos, action steps, and quizzes
  - **Supporter Welcome Banner**: Learn page displays targeted welcome message for family supporters with dos/don'ts guidance
  - **Professional Module Layout**: Redesigned Learn page with clean card-based layout, hover effects, and better visual hierarchy
  - **Video Integration**: Automatic YouTube URL converter handles watch/shorts/share formats for seamless video embedding in lessons
- **Family Support System**: Opt-in connections where supporters help PCOS users through education and motivation
  - **Connection Requests**: Supporters request to connect via email; PCOS users control permissions (view goals, view symptoms, send nudges)
  - **Supporter Flow**: Supporters log in → Navigate to "My Connections" → Click "View Dashboard" to see user's health data
  - **Supporter Learning**: Supporters take Family Support Essentials track to learn how to support someone with PCOS
  - **Two-Way Messaging**: PCOS users and supporters can send messages to each other, with unread message badges in navigation for both roles
  - **Messaging Notifications**: Red badges show unread message count; yellow badges alert PCOS users to pending connection requests
  - **Motivation Tools**: Send custom messages (500 char limit) or use 11+ nudge templates (encouragement, recipes, walk invites, etc.)
  - **No Separate Data**: Supporters view user's actual health data with permission-based filtering - no duplicate storage, user controls all visibility
  - **CheerUp Buddy Branding**: All supporter features branded with professional indigo-to-teal gradient design
- **Role Switcher**: Users can easily switch between PCOS User and Family Supporter roles from their profile page
  - **Profile Settings**: Added "Account Role" card showing current role with clear badge and description
  - **One-Click Switch**: Confirmation modal explains role benefits and data preservation before switching
  - **Data Preservation**: ALL data is preserved when switching roles - connections, messages, symptom history, and goals remain intact and accessible when switching back
  - **Smart Redirects**: Automatic navigation to appropriate dashboard based on new role
- **Performance Optimization**: 11 database indexes on frequently queried fields (user logins, symptom tracking, messages, forum posts, connections)
- **Security Enhancements**: Added security headers (X-Content-Type-Options, X-Frame-Options, X-XSS-Protection) and request-level caching
- **Production Deployment**: Configured Gunicorn autoscale deployment with 2 workers, 120s timeout, and proper port binding
- **Login UX Improvements**: Enhanced error messages with specific guidance (email typo hints, password case sensitivity), added "Forgot password" help card with troubleshooting tips for common login issues
- **Password Visibility Toggle**: Professional eye icon buttons on all password fields (login, register) allowing users to show/hide password text for verification
- **WhatsApp-Style Chat Interface**: Replaced list-style messaging with modern chat interface featuring conversation list sidebar, message bubbles (sent messages on right with indigo gradient, received on left), real-time message sending, auto-scroll, character counter, and responsive mobile layout
  - **Chat Permissions Fix**: Chat messages now work for all active connections regardless of "send nudges" permission - only nudge templates require that permission
  - **Message Type Labels**: Messages display type badges (Encouragement 💜, Reminder ⏰, Recipe Tip 🍳, Activity Invite 🚴, Celebration 🏆) for easy identification
  - **Like/Dislike Reactions**: Users can react to any message with thumbs up/down; reaction counts displayed; visual highlighting for user's own reactions
- **5-Level Health Score System**: Upgraded health analytics with detailed 5-level scoring (Excellent 🌟 4.5-5.0, Very Good 💪 3.5-4.4, Good 😊 2.5-3.4, Fair ⚠️ 1.5-2.4, Poor 🚨 0-1.4) based on symptom severity from last 10 entries
  - **Dashboard Integration**: Health score now displays as X/5 with emoji indicators, replaces old percentage-based system
  - **Analytics Page**: Detailed health feedback with personalized messages and color-coded alerts
  - **Cache Prevention**: Added no-cache headers to dashboard and analytics to ensure real-time score updates
  - **Unified Calculation**: Both dashboard and analytics use same inverted severity formula (5 - avg_severity) for consistency
  - **Supporter View**: Family supporters can view health score if granted symptom viewing permission
- **Footer Pages**: Created comprehensive footer pages including Privacy Policy, Help Center (FAQ with accordion), Contact Us (with support emails and contact form), and Emergency Support (crisis hotlines, PCOS resources, mental health support)
- **Navigation UX**: Login button now smartly hides on login/register pages to reduce redundancy; improved session cookie handling for iframe support
- **AI-Powered PCOS Health Assistant**: OpenAI-powered chatbot trained on trusted medical sources
  - **Knowledge Base**: Curated content from Mayo Clinic, Johns Hopkins, WHO, ACOG, CDC, NIH, HHS, MedlinePlus, and Endocrine Society
  - **Dedicated Chat Page**: Full-page health assistant at /health-assistant with quick suggestion buttons, typing indicators, and message formatting
  - **Floating Chat Widget**: Compact chat button on forum pages with expand/collapse functionality and full-page handoff
  - **Conversation History**: 20-turn context window for coherent follow-up questions with session-based conversation management
  - **Navigation Integration**: AI Assistant link in main navigation accessible to all users
  - **CSRF Protection**: All chat API endpoints protected with CSRF tokens

## System Architecture

### Frontend Architecture
- **Template Engine**: Jinja2 templates with Bootstrap 5 for responsive UI
- **Styling Framework**: Bootstrap 5 with custom CSS variables for brand theming
- **Icons**: Bootstrap Icons for consistent iconography
- **Layout Pattern**: Base template inheritance with modular components
- **Client-Side**: Vanilla JavaScript for form interactions and dynamic content

### Backend Architecture
- **Framework**: Flask with modular route organization
- **Database ORM**: SQLAlchemy with declarative base model pattern
- **Authentication**: Dual authentication system supporting both Flask-Login and Replit OAuth
- **Security**: CSRF protection via Flask-WTF, secure session configuration, and password hashing
- **Application Structure**: 
  - `app.py` - Core Flask application and database configuration
  - `routes.py` - URL routing and view logic
  - `models.py` - Database models and relationships
  - `replit_auth.py` - OAuth integration for Replit platform

### Data Storage Solutions
- **Primary Database**: SQLite for development with PostgreSQL support via DATABASE_URL environment variable
- **Connection Management**: SQLAlchemy with connection pooling, pre-ping validation, and connection recycling
- **Session Storage**: Flask sessions with configurable security settings
- **User Data Model**: Comprehensive user profiles with PCOD-specific health tracking fields

### Authentication and Authorization
- **Multi-Provider Auth**: Traditional email/password authentication alongside Replit OAuth
- **Session Management**: Flask-Login with permanent sessions and configurable timeouts
- **Security Features**: Password hashing using Werkzeug, CSRF protection, and secure cookie configuration
- **OAuth Storage**: Custom UserSessionStorage class for managing OAuth tokens per user session

### Core Application Features
- **Health Tracking**: Symptom logging, cycle tracking, and health analytics
- **Educational Learning Tracks**: 
  - 7 comprehensive PCOS tracks: Getting Started, Food Foundations, Movement, Sleep & Stress, Skin & Hair, Fertility & Pregnancy, Medications Literacy
  - Family Support Essentials micro-course (60-minute crash course for supporters)
  - Each lesson includes: "why it matters", video, 3-5 action steps, quiz, conversation prompt
  - Progress tracking with completion status and quiz scores
- **Family Support System**:
  - Opt-in connections between PCOS users and family supporters
  - Granular permissions (view goals, view symptoms, send nudges)
  - Supporter dashboard with shared goals and weekly help suggestions
  - Nudge library: 11 templates for encouragement, recipe swaps, walk invites, reminders, celebrations
- **Care Management**: Diet planning, exercise tracking, and medication reminders
- **Professional Network**: Doctor directory and appointment booking system
- **Community Forum**: Discussion categories, post creation/editing, reply system with inline editing for post authors, like (thumbs up) and dislike (thumbs down) reactions for posts and replies, unique view tracking per user/session
- **User Experience**: Responsive dashboard with sidebar navigation, role-based features, card-based layouts

## External Dependencies

### Core Framework Dependencies
- **Flask**: Web framework with SQLAlchemy ORM integration
- **Flask-Login**: User session management and authentication
- **Flask-WTF**: CSRF protection and form handling
- **Flask-Dance**: OAuth2 integration for third-party authentication
- **Werkzeug**: Password hashing and security utilities

### UI and Frontend Libraries
- **Bootstrap 5**: CSS framework loaded via CDN
- **Bootstrap Icons**: Icon library for consistent UI elements
- **Chart.js**: Implied for analytics visualization (referenced in analytics.html)

### Database and Storage
- **SQLAlchemy**: Database ORM with declarative models
- **SQLite**: Default development database
- **PostgreSQL**: Production database support via environment configuration

### Authentication Services
- **Replit OAuth**: Platform-specific authentication integration
- **JWT**: Token handling for OAuth flows

### Development and Deployment
- **Replit Platform**: Hosting environment with specific proxy configurations
- **Environment Variables**: Configuration management for secrets and database URLs
- **Logging**: Python logging module with environment-based log levels