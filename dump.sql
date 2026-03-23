--
-- PostgreSQL database dump
--

\restrict hwaIKiwb3DRTKPaofOacuEFqTim3BmTusDhH0frM2mBymgCRNkN2UmxeSTeDm7n

-- Dumped from database version 16.10
-- Dumped by pg_dump version 16.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: appointments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appointments (
    id integer NOT NULL,
    patient_id character varying NOT NULL,
    doctor_id character varying NOT NULL,
    appointment_date timestamp without time zone NOT NULL,
    duration_minutes integer,
    consultation_type character varying NOT NULL,
    status character varying,
    patient_notes text,
    doctor_notes text,
    prescription text,
    created_at timestamp without time zone
);


ALTER TABLE public.appointments OWNER TO postgres;

--
-- Name: appointments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.appointments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.appointments_id_seq OWNER TO postgres;

--
-- Name: appointments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.appointments_id_seq OWNED BY public.appointments.id;


--
-- Name: badges; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.badges (
    id integer NOT NULL,
    badge_name character varying NOT NULL,
    badge_type character varying NOT NULL,
    description text NOT NULL,
    icon character varying NOT NULL,
    color character varying,
    criteria_type character varying NOT NULL,
    criteria_value integer,
    track_id integer,
    created_at timestamp without time zone
);


ALTER TABLE public.badges OWNER TO postgres;

--
-- Name: badges_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.badges_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.badges_id_seq OWNER TO postgres;

--
-- Name: badges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.badges_id_seq OWNED BY public.badges.id;


--
-- Name: contact_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contact_messages (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(120) NOT NULL,
    subject character varying(100) NOT NULL,
    message text NOT NULL,
    status character varying(20),
    created_at timestamp without time zone,
    responded_at timestamp without time zone
);


ALTER TABLE public.contact_messages OWNER TO postgres;

--
-- Name: contact_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contact_messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contact_messages_id_seq OWNER TO postgres;

--
-- Name: contact_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contact_messages_id_seq OWNED BY public.contact_messages.id;


--
-- Name: daily_motivations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.daily_motivations (
    id integer NOT NULL,
    message text NOT NULL,
    category character varying(50),
    icon character varying(50),
    is_active boolean,
    created_at timestamp without time zone
);


ALTER TABLE public.daily_motivations OWNER TO postgres;

--
-- Name: daily_motivations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.daily_motivations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.daily_motivations_id_seq OWNER TO postgres;

--
-- Name: daily_motivations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.daily_motivations_id_seq OWNED BY public.daily_motivations.id;


--
-- Name: diet_plans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.diet_plans (
    id integer NOT NULL,
    user_id character varying NOT NULL,
    meal_type character varying NOT NULL,
    food_items text NOT NULL,
    calories integer,
    carbs double precision,
    protein double precision,
    fat double precision,
    date date NOT NULL,
    is_pcod_friendly boolean,
    created_at timestamp without time zone
);


ALTER TABLE public.diet_plans OWNER TO postgres;

--
-- Name: diet_plans_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.diet_plans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.diet_plans_id_seq OWNER TO postgres;

--
-- Name: diet_plans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.diet_plans_id_seq OWNED BY public.diet_plans.id;


--
-- Name: doctor_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.doctor_profiles (
    id integer NOT NULL,
    user_id character varying NOT NULL,
    medical_license_number character varying NOT NULL,
    specialization character varying NOT NULL,
    qualification character varying NOT NULL,
    experience_years integer NOT NULL,
    clinic_name character varying,
    clinic_address text,
    consultation_fee double precision,
    available_days character varying,
    available_hours character varying,
    is_verified boolean,
    verification_documents text,
    created_at timestamp without time zone
);


ALTER TABLE public.doctor_profiles OWNER TO postgres;

--
-- Name: doctor_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.doctor_profiles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.doctor_profiles_id_seq OWNER TO postgres;

--
-- Name: doctor_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.doctor_profiles_id_seq OWNED BY public.doctor_profiles.id;


--
-- Name: educational_content; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.educational_content (
    id integer NOT NULL,
    title character varying NOT NULL,
    content text NOT NULL,
    content_type character varying NOT NULL,
    category character varying NOT NULL,
    author character varying,
    is_published boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.educational_content OWNER TO postgres;

--
-- Name: educational_content_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.educational_content_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.educational_content_id_seq OWNER TO postgres;

--
-- Name: educational_content_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.educational_content_id_seq OWNED BY public.educational_content.id;


--
-- Name: educational_tracks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.educational_tracks (
    id integer NOT NULL,
    title character varying NOT NULL,
    description text,
    track_type character varying NOT NULL,
    order_index integer DEFAULT 0,
    duration_weeks integer,
    icon character varying,
    is_published boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.educational_tracks OWNER TO postgres;

--
-- Name: educational_tracks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.educational_tracks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.educational_tracks_id_seq OWNER TO postgres;

--
-- Name: educational_tracks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.educational_tracks_id_seq OWNED BY public.educational_tracks.id;


--
-- Name: exercise_plans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exercise_plans (
    id integer NOT NULL,
    user_id character varying NOT NULL,
    exercise_name character varying NOT NULL,
    exercise_type character varying NOT NULL,
    duration_minutes integer NOT NULL,
    calories_burned integer,
    date date NOT NULL,
    completed boolean,
    notes text,
    created_at timestamp without time zone
);


ALTER TABLE public.exercise_plans OWNER TO postgres;

--
-- Name: exercise_plans_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.exercise_plans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.exercise_plans_id_seq OWNER TO postgres;

--
-- Name: exercise_plans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.exercise_plans_id_seq OWNED BY public.exercise_plans.id;


--
-- Name: family_connections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.family_connections (
    id integer NOT NULL,
    primary_user_id character varying,
    family_member_id character varying,
    is_active boolean DEFAULT false,
    can_view_goals boolean DEFAULT false,
    can_view_symptoms boolean DEFAULT false,
    can_send_nudges boolean DEFAULT false,
    connection_status character varying DEFAULT 'pending'::character varying,
    invited_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    activated_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.family_connections OWNER TO postgres;

--
-- Name: family_connections_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.family_connections_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.family_connections_id_seq OWNER TO postgres;

--
-- Name: family_connections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.family_connections_id_seq OWNED BY public.family_connections.id;


--
-- Name: flask_dance_oauth; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flask_dance_oauth (
    user_id character varying,
    browser_session_key character varying NOT NULL,
    id integer NOT NULL,
    provider character varying(50) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    token json NOT NULL
);


ALTER TABLE public.flask_dance_oauth OWNER TO postgres;

--
-- Name: flask_dance_oauth_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.flask_dance_oauth_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.flask_dance_oauth_id_seq OWNER TO postgres;

--
-- Name: flask_dance_oauth_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.flask_dance_oauth_id_seq OWNED BY public.flask_dance_oauth.id;


--
-- Name: forum_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.forum_categories (
    id integer NOT NULL,
    name character varying NOT NULL,
    description text,
    icon character varying,
    display_order integer,
    created_at timestamp without time zone
);


ALTER TABLE public.forum_categories OWNER TO postgres;

--
-- Name: forum_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.forum_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.forum_categories_id_seq OWNER TO postgres;

--
-- Name: forum_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.forum_categories_id_seq OWNED BY public.forum_categories.id;


--
-- Name: forum_post_views; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.forum_post_views (
    id integer NOT NULL,
    post_id integer NOT NULL,
    user_id character varying,
    session_id character varying,
    viewed_at timestamp without time zone
);


ALTER TABLE public.forum_post_views OWNER TO postgres;

--
-- Name: forum_post_views_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.forum_post_views_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.forum_post_views_id_seq OWNER TO postgres;

--
-- Name: forum_post_views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.forum_post_views_id_seq OWNED BY public.forum_post_views.id;


--
-- Name: forum_posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.forum_posts (
    id integer NOT NULL,
    user_id character varying NOT NULL,
    category_id integer NOT NULL,
    title character varying NOT NULL,
    content text NOT NULL,
    is_pinned boolean,
    views_count integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.forum_posts OWNER TO postgres;

--
-- Name: forum_posts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.forum_posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.forum_posts_id_seq OWNER TO postgres;

--
-- Name: forum_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.forum_posts_id_seq OWNED BY public.forum_posts.id;


--
-- Name: forum_reactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.forum_reactions (
    id integer NOT NULL,
    reply_id integer,
    user_id character varying NOT NULL,
    reaction_type character varying,
    created_at timestamp without time zone,
    post_id integer
);


ALTER TABLE public.forum_reactions OWNER TO postgres;

--
-- Name: forum_reactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.forum_reactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.forum_reactions_id_seq OWNER TO postgres;

--
-- Name: forum_reactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.forum_reactions_id_seq OWNED BY public.forum_reactions.id;


--
-- Name: forum_replies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.forum_replies (
    id integer NOT NULL,
    post_id integer NOT NULL,
    user_id character varying NOT NULL,
    content text NOT NULL,
    is_solution boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.forum_replies OWNER TO postgres;

--
-- Name: forum_replies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.forum_replies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.forum_replies_id_seq OWNER TO postgres;

--
-- Name: forum_replies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.forum_replies_id_seq OWNED BY public.forum_replies.id;


--
-- Name: lesson_actions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lesson_actions (
    id integer NOT NULL,
    lesson_id integer,
    action_text character varying NOT NULL,
    order_index integer DEFAULT 0,
    is_optional boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.lesson_actions OWNER TO postgres;

--
-- Name: lesson_actions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lesson_actions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lesson_actions_id_seq OWNER TO postgres;

--
-- Name: lesson_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lesson_actions_id_seq OWNED BY public.lesson_actions.id;


--
-- Name: lesson_quizzes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lesson_quizzes (
    id integer NOT NULL,
    lesson_id integer,
    title character varying NOT NULL,
    passing_score integer DEFAULT 70,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.lesson_quizzes OWNER TO postgres;

--
-- Name: lesson_quizzes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lesson_quizzes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lesson_quizzes_id_seq OWNER TO postgres;

--
-- Name: lesson_quizzes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lesson_quizzes_id_seq OWNED BY public.lesson_quizzes.id;


--
-- Name: lessons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lessons (
    id integer NOT NULL,
    track_id integer,
    title character varying NOT NULL,
    order_index integer DEFAULT 0,
    why_it_matters text NOT NULL,
    video_url character varying,
    video_duration_minutes integer,
    conversation_prompt text,
    content text,
    dos text,
    donts text,
    is_published boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.lessons OWNER TO postgres;

--
-- Name: lessons_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lessons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lessons_id_seq OWNER TO postgres;

--
-- Name: lessons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lessons_id_seq OWNED BY public.lessons.id;


--
-- Name: menstrual_cycles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menstrual_cycles (
    id integer NOT NULL,
    user_id character varying NOT NULL,
    start_date date NOT NULL,
    end_date date,
    cycle_length integer,
    flow_intensity character varying,
    cramps_severity integer,
    mood_changes character varying,
    other_symptoms text,
    created_at timestamp without time zone
);


ALTER TABLE public.menstrual_cycles OWNER TO postgres;

--
-- Name: menstrual_cycles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.menstrual_cycles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.menstrual_cycles_id_seq OWNER TO postgres;

--
-- Name: menstrual_cycles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.menstrual_cycles_id_seq OWNED BY public.menstrual_cycles.id;


--
-- Name: message_reactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.message_reactions (
    id integer NOT NULL,
    message_id integer NOT NULL,
    user_id character varying NOT NULL,
    reaction_type character varying,
    created_at timestamp without time zone
);


ALTER TABLE public.message_reactions OWNER TO postgres;

--
-- Name: message_reactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.message_reactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.message_reactions_id_seq OWNER TO postgres;

--
-- Name: message_reactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.message_reactions_id_seq OWNED BY public.message_reactions.id;


--
-- Name: nudges; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nudges (
    id integer NOT NULL,
    nudge_type character varying NOT NULL,
    title character varying NOT NULL,
    message text NOT NULL,
    goal_type character varying,
    is_template boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.nudges OWNER TO postgres;

--
-- Name: nudges_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nudges_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nudges_id_seq OWNER TO postgres;

--
-- Name: nudges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nudges_id_seq OWNED BY public.nudges.id;


--
-- Name: quiz_questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quiz_questions (
    id integer NOT NULL,
    quiz_id integer,
    question_text text NOT NULL,
    question_type character varying DEFAULT 'multiple_choice'::character varying,
    options text NOT NULL,
    correct_answer character varying NOT NULL,
    explanation text,
    order_index integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.quiz_questions OWNER TO postgres;

--
-- Name: quiz_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quiz_questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quiz_questions_id_seq OWNER TO postgres;

--
-- Name: quiz_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quiz_questions_id_seq OWNED BY public.quiz_questions.id;


--
-- Name: quiz_results; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quiz_results (
    id integer NOT NULL,
    user_id character varying NOT NULL,
    quiz_type character varying NOT NULL,
    score integer NOT NULL,
    total_questions integer NOT NULL,
    answers text,
    recommendations text,
    created_at timestamp without time zone
);


ALTER TABLE public.quiz_results OWNER TO postgres;

--
-- Name: quiz_results_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quiz_results_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quiz_results_id_seq OWNER TO postgres;

--
-- Name: quiz_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quiz_results_id_seq OWNED BY public.quiz_results.id;


--
-- Name: reminders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reminders (
    id integer NOT NULL,
    user_id character varying NOT NULL,
    title character varying NOT NULL,
    description text,
    reminder_type character varying NOT NULL,
    reminder_time timestamp without time zone NOT NULL,
    is_recurring boolean,
    recurrence_pattern character varying,
    is_completed boolean,
    created_at timestamp without time zone
);


ALTER TABLE public.reminders OWNER TO postgres;

--
-- Name: reminders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reminders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reminders_id_seq OWNER TO postgres;

--
-- Name: reminders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reminders_id_seq OWNED BY public.reminders.id;


--
-- Name: sent_nudges; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sent_nudges (
    id integer NOT NULL,
    connection_id integer,
    nudge_id integer,
    sender_id character varying,
    recipient_id character varying,
    message text NOT NULL,
    nudge_type character varying NOT NULL,
    is_read boolean DEFAULT false,
    sent_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    read_at timestamp without time zone
);


ALTER TABLE public.sent_nudges OWNER TO postgres;

--
-- Name: sent_nudges_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sent_nudges_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sent_nudges_id_seq OWNER TO postgres;

--
-- Name: sent_nudges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sent_nudges_id_seq OWNED BY public.sent_nudges.id;


--
-- Name: shared_goals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shared_goals (
    id integer NOT NULL,
    connection_id integer,
    goal_text character varying NOT NULL,
    goal_type character varying NOT NULL,
    target_frequency character varying,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    completed_at timestamp without time zone
);


ALTER TABLE public.shared_goals OWNER TO postgres;

--
-- Name: shared_goals_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shared_goals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.shared_goals_id_seq OWNER TO postgres;

--
-- Name: shared_goals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shared_goals_id_seq OWNED BY public.shared_goals.id;


--
-- Name: symptom_tracker; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.symptom_tracker (
    id integer NOT NULL,
    user_id character varying NOT NULL,
    date date NOT NULL,
    acne_severity integer,
    fatigue_level integer,
    mood_swings integer,
    anxiety_level integer,
    depression_level integer,
    notes text,
    created_at timestamp without time zone,
    hair_loss_level integer,
    weight_gain_level integer,
    bloating_level integer
);


ALTER TABLE public.symptom_tracker OWNER TO postgres;

--
-- Name: symptom_tracker_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.symptom_tracker_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.symptom_tracker_id_seq OWNER TO postgres;

--
-- Name: symptom_tracker_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.symptom_tracker_id_seq OWNED BY public.symptom_tracker.id;


--
-- Name: user_badges; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_badges (
    id integer NOT NULL,
    user_id character varying NOT NULL,
    badge_id integer NOT NULL,
    lesson_id integer,
    earned_at timestamp without time zone,
    quiz_score integer
);


ALTER TABLE public.user_badges OWNER TO postgres;

--
-- Name: user_badges_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_badges_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_badges_id_seq OWNER TO postgres;

--
-- Name: user_badges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_badges_id_seq OWNED BY public.user_badges.id;


--
-- Name: user_lesson_progress; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_lesson_progress (
    id integer NOT NULL,
    user_id character varying,
    lesson_id integer,
    started_at timestamp without time zone,
    completed_at timestamp without time zone,
    quiz_score integer,
    quiz_attempts integer DEFAULT 0,
    completed_actions text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_lesson_progress OWNER TO postgres;

--
-- Name: user_lesson_progress_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_lesson_progress_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_lesson_progress_id_seq OWNER TO postgres;

--
-- Name: user_lesson_progress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_lesson_progress_id_seq OWNED BY public.user_lesson_progress.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id character varying NOT NULL,
    email character varying,
    first_name character varying,
    last_name character varying,
    profile_image_url character varying,
    age integer,
    height double precision,
    weight double precision,
    contact_number character varying,
    emergency_contact character varying,
    medical_history text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    password_hash character varying(255),
    is_active boolean DEFAULT true,
    last_login timestamp without time zone,
    user_role character varying,
    onboarding_completed boolean DEFAULT false,
    data_consent boolean DEFAULT false,
    research_consent boolean DEFAULT false,
    consent_timestamp timestamp without time zone,
    goals text,
    menstrual_status character varying,
    current_medications text,
    constraints text,
    devices_available text,
    family_relation character varying,
    family_involvement text,
    font_size character varying DEFAULT 'medium'::character varying,
    high_contrast boolean DEFAULT false,
    captions_enabled boolean DEFAULT false,
    text_to_speech boolean DEFAULT false,
    reminder_enabled boolean DEFAULT false,
    reminder_time character varying,
    reminder_timezone character varying,
    last_reminder_shown timestamp without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: appointments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments ALTER COLUMN id SET DEFAULT nextval('public.appointments_id_seq'::regclass);


--
-- Name: badges id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.badges ALTER COLUMN id SET DEFAULT nextval('public.badges_id_seq'::regclass);


--
-- Name: contact_messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_messages ALTER COLUMN id SET DEFAULT nextval('public.contact_messages_id_seq'::regclass);


--
-- Name: daily_motivations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.daily_motivations ALTER COLUMN id SET DEFAULT nextval('public.daily_motivations_id_seq'::regclass);


--
-- Name: diet_plans id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diet_plans ALTER COLUMN id SET DEFAULT nextval('public.diet_plans_id_seq'::regclass);


--
-- Name: doctor_profiles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor_profiles ALTER COLUMN id SET DEFAULT nextval('public.doctor_profiles_id_seq'::regclass);


--
-- Name: educational_content id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educational_content ALTER COLUMN id SET DEFAULT nextval('public.educational_content_id_seq'::regclass);


--
-- Name: educational_tracks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educational_tracks ALTER COLUMN id SET DEFAULT nextval('public.educational_tracks_id_seq'::regclass);


--
-- Name: exercise_plans id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercise_plans ALTER COLUMN id SET DEFAULT nextval('public.exercise_plans_id_seq'::regclass);


--
-- Name: family_connections id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_connections ALTER COLUMN id SET DEFAULT nextval('public.family_connections_id_seq'::regclass);


--
-- Name: flask_dance_oauth id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flask_dance_oauth ALTER COLUMN id SET DEFAULT nextval('public.flask_dance_oauth_id_seq'::regclass);


--
-- Name: forum_categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_categories ALTER COLUMN id SET DEFAULT nextval('public.forum_categories_id_seq'::regclass);


--
-- Name: forum_post_views id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_post_views ALTER COLUMN id SET DEFAULT nextval('public.forum_post_views_id_seq'::regclass);


--
-- Name: forum_posts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_posts ALTER COLUMN id SET DEFAULT nextval('public.forum_posts_id_seq'::regclass);


--
-- Name: forum_reactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_reactions ALTER COLUMN id SET DEFAULT nextval('public.forum_reactions_id_seq'::regclass);


--
-- Name: forum_replies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_replies ALTER COLUMN id SET DEFAULT nextval('public.forum_replies_id_seq'::regclass);


--
-- Name: lesson_actions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_actions ALTER COLUMN id SET DEFAULT nextval('public.lesson_actions_id_seq'::regclass);


--
-- Name: lesson_quizzes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_quizzes ALTER COLUMN id SET DEFAULT nextval('public.lesson_quizzes_id_seq'::regclass);


--
-- Name: lessons id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons ALTER COLUMN id SET DEFAULT nextval('public.lessons_id_seq'::regclass);


--
-- Name: menstrual_cycles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menstrual_cycles ALTER COLUMN id SET DEFAULT nextval('public.menstrual_cycles_id_seq'::regclass);


--
-- Name: message_reactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message_reactions ALTER COLUMN id SET DEFAULT nextval('public.message_reactions_id_seq'::regclass);


--
-- Name: nudges id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nudges ALTER COLUMN id SET DEFAULT nextval('public.nudges_id_seq'::regclass);


--
-- Name: quiz_questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_questions ALTER COLUMN id SET DEFAULT nextval('public.quiz_questions_id_seq'::regclass);


--
-- Name: quiz_results id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_results ALTER COLUMN id SET DEFAULT nextval('public.quiz_results_id_seq'::regclass);


--
-- Name: reminders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reminders ALTER COLUMN id SET DEFAULT nextval('public.reminders_id_seq'::regclass);


--
-- Name: sent_nudges id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sent_nudges ALTER COLUMN id SET DEFAULT nextval('public.sent_nudges_id_seq'::regclass);


--
-- Name: shared_goals id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shared_goals ALTER COLUMN id SET DEFAULT nextval('public.shared_goals_id_seq'::regclass);


--
-- Name: symptom_tracker id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.symptom_tracker ALTER COLUMN id SET DEFAULT nextval('public.symptom_tracker_id_seq'::regclass);


--
-- Name: user_badges id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_badges ALTER COLUMN id SET DEFAULT nextval('public.user_badges_id_seq'::regclass);


--
-- Name: user_lesson_progress id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_lesson_progress ALTER COLUMN id SET DEFAULT nextval('public.user_lesson_progress_id_seq'::regclass);


--
-- Data for Name: appointments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appointments (id, patient_id, doctor_id, appointment_date, duration_minutes, consultation_type, status, patient_notes, doctor_notes, prescription, created_at) FROM stdin;
1	1244bd18-1888-4419-808c-c50c5f3dea38	doc-001	2025-09-26 23:36:00	30		scheduled		\N	\N	2025-09-26 04:36:39.404009
\.


--
-- Data for Name: badges; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.badges (id, badge_name, badge_type, description, icon, color, criteria_type, criteria_value, track_id, created_at) FROM stdin;
1	Quiz Champion	quiz_perfect	Scored 100% on a quiz!	trophy-fill	#ffd700	quiz_score	100	\N	2025-10-10 18:39:45.837195
2	Perfect Scholar	quiz_perfect	Achieved a perfect score!	star-fill	#6610f2	quiz_score	100	\N	2025-10-10 18:39:45.837199
3	Quiz Master	quiz_pass	Passed a quiz with flying colors!	award-fill	#14b8a6	quiz_score	80	\N	2025-10-10 18:39:45.8372
4	Knowledge Seeker	quiz_first	Completed your first quiz!	mortarboard-fill	#6610f2	quiz_first	1	\N	2025-10-10 18:39:45.8372
5	Getting Started with PCOS Graduate	track_complete	Completed all lessons in Getting Started with PCOS	patch-check-fill	#14b8a6	track_completion	100	1	2025-10-10 18:39:45.837202
6	Food Foundations Graduate	track_complete	Completed all lessons in Food Foundations	patch-check-fill	#14b8a6	track_completion	100	2	2025-10-10 18:39:45.837203
7	Move More, Smarter Graduate	track_complete	Completed all lessons in Move More, Smarter	patch-check-fill	#14b8a6	track_completion	100	3	2025-10-10 18:39:45.837204
8	Sleep & Stress Management Graduate	track_complete	Completed all lessons in Sleep & Stress Management	patch-check-fill	#14b8a6	track_completion	100	4	2025-10-10 18:39:45.837204
9	Skin & Hair Care Graduate	track_complete	Completed all lessons in Skin & Hair Care	patch-check-fill	#14b8a6	track_completion	100	5	2025-10-10 18:39:45.837205
10	Fertility & Pregnancy Graduate	track_complete	Completed all lessons in Fertility & Pregnancy	patch-check-fill	#14b8a6	track_completion	100	6	2025-10-10 18:39:45.837205
11	Family Support Essentials Graduate	track_complete	Completed all lessons in Family Support Essentials	patch-check-fill	#14b8a6	track_completion	100	8	2025-10-10 18:39:45.837206
12	Supplements Graduate	track_complete	Completed all lessons in Supplements	patch-check-fill	#14b8a6	track_completion	100	7	2025-10-10 18:39:45.837206
\.


--
-- Data for Name: contact_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contact_messages (id, name, email, subject, message, status, created_at, responded_at) FROM stdin;
\.


--
-- Data for Name: daily_motivations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.daily_motivations (id, message, category, icon, is_active, created_at) FROM stdin;
1	Your health journey matters. Take a moment today to track how you're feeling! 💜	health	💜	t	2025-11-20 06:22:20.100668
2	Small steps every day lead to big changes. Track your symptoms and celebrate your progress!	mindset	✨	t	2025-11-20 06:22:20.100674
3	You're stronger than PCOS. Check in with yourself today!	mindset	💪	t	2025-11-20 06:22:20.100674
4	Remember to drink water, track your meals, and be kind to yourself today.	self_care	💧	t	2025-11-20 06:22:20.100675
5	Every symptom you track helps you understand your body better. Keep going!	health	📊	t	2025-11-20 06:22:20.100677
6	Your menstrual cycle is unique to you. Track it to understand your patterns better!	health	📅	t	2025-11-20 06:22:20.100678
7	Take 5 minutes today to log your symptoms. Future you will thank you! 🌸	health	🌸	t	2025-11-20 06:22:20.100679
8	PCOS doesn't define you, but tracking it helps you manage it. You've got this!	mindset	🌟	t	2025-11-20 06:22:20.10068
9	Stress affects PCOS. Take a deep breath, track your mood, and be gentle with yourself.	self_care	🧘	t	2025-11-20 06:22:20.10068
10	Movement is medicine. Track your exercise and celebrate every step!	health	🏃	t	2025-11-20 06:22:20.100681
11	Sleep matters for hormone balance. Track your rest tonight! 😴	self_care	😴	t	2025-11-20 06:22:20.100682
12	You're not alone in this journey. Check in with CystaSense today! 💚	mindset	💚	t	2025-11-20 06:22:20.100682
13	Food is fuel, not the enemy. Track your meals with kindness and curiosity.	health	🥗	t	2025-11-20 06:22:20.100683
14	Your body is doing its best. Honor it by tracking what it's telling you today.	self_care	🌺	t	2025-11-20 06:22:20.100683
15	Progress isn't linear. Track today, even if yesterday wasn't perfect! 🌈	mindset	🌈	t	2025-11-20 06:22:20.100684
16	Hormones can be tricky, but you're tracking them like a pro! Keep it up! 🎯	health	🎯	t	2025-11-20 06:22:20.100684
17	One tracked symptom at a time. You're building valuable data about your health! 📝	health	📝	t	2025-11-20 06:22:20.100685
18	Consistency beats perfection. Log in today, even if it's just for a minute! ⏰	mindset	⏰	t	2025-11-20 06:22:20.100685
19	Your health data helps your doctor help you better. Track with purpose! 👩‍⚕️	health	👩‍⚕️	t	2025-11-20 06:22:20.100686
20	PCOS taught you resilience. Track your journey and see how far you've come! 🦋	mindset	🦋	t	2025-11-20 06:22:20.100686
21	Be patient with your body. Track today's symptoms and trust the process. 🌿	self_care	🌿	t	2025-11-20 06:22:20.100687
22	Knowledge is power. The more you track, the more you understand your PCOS! 📚	health	📚	t	2025-11-20 06:22:20.100687
23	You're doing better than you think. Check in and give yourself credit! ⭐	mindset	⭐	t	2025-11-20 06:22:20.100688
24	Hydration, nutrition, rest, movement - track them all! Your body will thank you. 💖	self_care	💖	t	2025-11-20 06:22:20.100688
25	Every cycle teaches you something new. Track it and learn! 🔄	health	🔄	t	2025-11-20 06:22:20.100688
26	You deserve to feel good. Track your symptoms to find what helps! 🌞	mindset	🌞	t	2025-11-20 06:22:20.100689
27	Weight is just one number. Track how you FEEL - that matters more! 💙	mindset	💙	t	2025-11-20 06:22:20.100689
28	Skin changes, mood swings, energy dips - track it all. Patterns matter! 🎨	health	🎨	t	2025-11-20 06:22:20.10069
29	Your fertility journey is yours alone. Track with hope and self-compassion. 🌸	health	🌸	t	2025-11-20 06:22:20.10069
30	Celebrate the good days by tracking them! You need that data too! 🎉	mindset	🎉	t	2025-11-20 06:22:20.100691
\.


--
-- Data for Name: diet_plans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.diet_plans (id, user_id, meal_type, food_items, calories, carbs, protein, fat, date, is_pcod_friendly, created_at) FROM stdin;
4	doc-001	breakfast	Oats with berries and almonds	320	45.5	12.3	8.7	2025-09-25	t	2025-09-25 20:17:14.395728
5	doc-001	lunch	Grilled salmon with quinoa and vegetables	420	38.2	35.8	15.4	2025-09-25	t	2025-09-25 20:17:14.395728
6	doc-001	snack	Greek yogurt with walnuts	180	12.1	15.2	9.8	2025-09-24	t	2025-09-25 20:17:14.395728
7	1244bd18-1888-4419-808c-c50c5f3dea38	breakfast	Dosa,eggs,Milk	350	0	150	100	2025-09-26	t	2025-09-26 04:32:28.535174
8	57443a2f-9a90-481c-8872-d69ad93a2eef	breakfast	eggs	\N	\N	\N	\N	2025-10-10	t	2025-10-10 18:03:05.631608
9	e1a97a68-65b4-4cbb-a8df-fb484ee205f6	dinner	chicken	200	10	100	20	2025-10-10	t	2025-10-10 19:44:40.784794
10	86a7716f-9ab3-47c5-acc1-ca44391ed79b	breakfast	eggs	100	50	50	50	2025-10-11	t	2025-10-11 18:56:04.443705
11	31cb937d-a657-4703-8522-aec17fb5c2eb	breakfast	Dosa,Milk,Boiled eggs	380	33	22	20	2025-10-13	t	2025-10-13 03:34:10.552981
13	4c327dc2-679d-46ec-8e66-4212767b6c35	breakfast	Oats with Chia & Berries\nFood Items: Rolled oats + chia seeds + blueberries + almond milk	310	48	10	8	2025-11-21	t	2025-11-21 02:35:11.298368
14	4c327dc2-679d-46ec-8e66-4212767b6c35	lunch	Brown Rice + Dal + Mixed Vegetables\nFood Items:Brown rice + moong dal + carrot/beans stir fry	480	62	18	12	2025-11-21	t	2025-11-21 02:36:53.15555
\.


--
-- Data for Name: doctor_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.doctor_profiles (id, user_id, medical_license_number, specialization, qualification, experience_years, clinic_name, clinic_address, consultation_fee, available_days, available_hours, is_verified, verification_documents, created_at) FROM stdin;
1	doc-001	MH001234	Gynecology & Reproductive Endocrinology	MBBS, MD (Obstetrics & Gynecology), Fellowship in Reproductive Medicine	12	Women's Health Center	Apollo Hospitals, Banjara Hills, Hyderabad	800	["Monday", "Tuesday", "Wednesday", "Friday", "Saturday"]	["09:00-13:00", "15:00-19:00"]	t	\N	2025-09-25 19:19:56.578949
2	doc-002	KA005678	Endocrinology & PCOD Specialist	MBBS, MD (General Medicine), DM (Endocrinology)	8	Diabetes & Hormone Clinic	Manipal Hospital, HAL Airport Road, Bangalore	650	["Monday", "Tuesday", "Thursday", "Friday", "Saturday"]	["10:00-14:00", "16:00-20:00"]	t	\N	2025-09-25 19:19:56.578949
3	doc-003	TN009012	Nutritionist & PCOD Diet Specialist	BSc (Nutrition), MSc (Clinical Nutrition), PhD (Nutrition Sciences)	6	NutriCare Wellness	Anna Nagar, Chennai	500	["Monday", "Wednesday", "Thursday", "Friday", "Saturday"]	["09:00-13:00", "14:00-18:00"]	t	\N	2025-09-25 19:19:56.578949
4	doc-004	MH003456	Gynecologist & PCOD Expert	MBBS, MS (Obstetrics & Gynecology), Fellowship in Minimal Access Surgery	15	Advanced Women's Care	Kokilaben Hospital, Andheri West, Mumbai	900	["Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]	["10:00-14:00", "17:00-21:00"]	t	\N	2025-09-25 19:19:56.578949
5	doc-005	DL007890	Mental Health & PCOD Counseling	MBBS, MD (Psychiatry), Certificate in Women's Mental Health	10	Mind Wellness Center	Max Hospital, Saket, New Delhi	700	["Monday", "Tuesday", "Wednesday", "Friday", "Saturday"]	["11:00-15:00", "16:00-20:00"]	t	\N	2025-09-25 19:19:56.578949
\.


--
-- Data for Name: educational_content; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.educational_content (id, title, content, content_type, category, author, is_published, created_at, updated_at) FROM stdin;
1	Understanding PCOD: A Complete Guide	PCOD (Polycystic Ovary Disorder) is a hormonal disorder affecting millions of women worldwide. Learn about symptoms, causes, and management strategies.	article	medical	Dr. Sarah Wilson	t	2025-09-25 18:50:54.619471	2025-09-25 18:50:54.619471
2	PCOD-Friendly Diet Tips	A balanced diet is crucial for managing PCOD. Focus on whole grains, lean proteins, and plenty of vegetables while limiting processed foods and sugar.	article	diet	Nutritionist Jane Smith	t	2025-09-25 18:50:54.619471	2025-09-25 18:50:54.619471
3	What causes irregular periods in PCOD?	Irregular periods in PCOD are caused by hormonal imbalances, particularly elevated androgen levels and insulin resistance affecting ovulation.	faq	medical	Dr. Emily Chen	t	2025-09-25 18:50:54.619471	2025-09-25 18:50:54.619471
\.


--
-- Data for Name: educational_tracks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.educational_tracks (id, title, description, track_type, order_index, duration_weeks, icon, is_published, created_at, updated_at) FROM stdin;
1	Getting Started with PCOS	PCOS basics, myths, what tests mean, and setting your first 2 habits	pcos_user	1	1	bi-rocket-takeoff	t	2025-10-09 04:27:18.444926	2025-10-09 04:27:18.444932
2	Food Foundations	Plate method, fiber/protein targets, cultural menus, and grocery skills	pcos_user	2	2	bi-egg-fried	t	2025-10-09 04:27:18.890615	2025-10-09 04:27:18.890621
3	Move More, Smarter	Progressive plans aligned with guideline minutes and resistance training primer	pcos_user	3	3	bi-activity	t	2025-10-09 04:27:19.250197	2025-10-09 04:27:19.250203
4	Sleep & Stress Management	Routines, screen time & sleep, and mindful moments	pcos_user	4	2	bi-moon-stars	t	2025-10-09 04:27:19.42495	2025-10-09 04:27:19.424956
5	Skin & Hair Care	Options overview and what to ask your clinician	pcos_user	5	2	bi-stars	t	2025-10-09 04:27:19.599563	2025-10-09 04:27:19.599568
6	Fertility & Pregnancy	Timelines, preconception checklists, when to escalate care	pcos_user	6	3	bi-heart-pulse	t	2025-10-09 04:27:19.774587	2025-10-09 04:27:19.774592
8	Family Support Essentials	60-minute crash course on supporting someone with PCOS - with role cards and checklists	family_member	1	1	bi-people-fill	t	2025-10-09 04:27:20.12721	2025-10-09 04:27:20.127216
7	Supplements	COCs, metformin basics, benefit/risk, and questions for clinicians	pcos_user	7	2	bi-capsule	t	2025-10-09 04:27:19.951321	2025-10-10 17:53:38.327074
\.


--
-- Data for Name: exercise_plans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exercise_plans (id, user_id, exercise_name, exercise_type, duration_minutes, calories_burned, date, completed, notes, created_at) FROM stdin;
1	doc-001	Morning Walk	walking	30	150	2025-09-25	t	Felt energized after the walk	2025-09-25 20:17:04.899657
2	doc-001	Yoga Session	yoga	45	120	2025-09-24	t	Relaxing and peaceful session	2025-09-25 20:17:04.899657
3	doc-001	Swimming	cardio	60	350	2025-09-26	f	Planning to go swimming tomorrow	2025-09-25 20:17:04.899657
4	57443a2f-9a90-481c-8872-d69ad93a2eef	yoga	yoga	30	15	2025-10-10	t	\N	2025-10-10 18:03:54.803681
5	e1a97a68-65b4-4cbb-a8df-fb484ee205f6	walk	yoga	10	10	2025-10-10	f	\N	2025-10-10 19:45:18.445061
6	86a7716f-9ab3-47c5-acc1-ca44391ed79b	Walk	walking	20	100	2025-10-11	f	\N	2025-10-11 18:56:39.366897
7	86a7716f-9ab3-47c5-acc1-ca44391ed79b	yoga	yoga	10	\N	2025-10-11	t	\N	2025-10-11 18:57:05.530747
8	31cb937d-a657-4703-8522-aec17fb5c2eb	Morning walk	walking	30	120	2025-10-13	t	\N	2025-10-13 03:36:07.694409
9	4c327dc2-679d-46ec-8e66-4212767b6c35	Morning Walk	walking	30	120	2025-11-21	t	Helps regulate insulin levels and boosts metabolism	2025-11-21 02:40:22.987697
\.


--
-- Data for Name: family_connections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.family_connections (id, primary_user_id, family_member_id, is_active, can_view_goals, can_view_symptoms, can_send_nudges, connection_status, invited_at, activated_at, created_at, updated_at) FROM stdin;
2	9652f9ec-49ea-4c83-bfba-fc1e3b2cdd31	49af2635-2893-47b6-aafe-d5927c5a20c5	f	f	f	f	pending	2025-10-10 19:24:34.466966	\N	2025-10-10 19:24:34.466971	2025-10-10 19:24:34.466972
3	e1a97a68-65b4-4cbb-a8df-fb484ee205f6	7d378161-2361-473d-9dea-0bc9c7d88eda	t	f	t	t	active	2025-10-10 22:18:06.301979	2025-10-12 14:54:13.503988	2025-10-10 22:18:06.301985	2025-10-12 14:54:13.505841
6	e1a97a68-65b4-4cbb-a8df-fb484ee205f6	eed33b0c-db0f-41f7-b12c-d720eb90e3ea	t	t	t	t	active	2025-10-12 15:19:35.042459	2025-10-12 15:21:13.733625	2025-10-12 15:19:35.042465	2025-10-12 15:21:13.734593
8	4a797d4a-42e4-455b-ab30-d7b96d72e751	24b303b9-0b38-48c4-90d4-3531afb72e3e	t	f	t	t	active	2025-10-15 04:53:04.654173	2025-10-15 05:02:09.901056	2025-10-15 04:53:04.654178	2025-10-15 05:02:09.902224
9	4c327dc2-679d-46ec-8e66-4212767b6c35	d33b031f-277d-45af-839d-f371a33d5d5a	t	t	t	t	active	2025-11-20 21:44:35.385236	2025-11-20 21:46:01.968017	2025-11-20 21:44:35.385242	2025-11-20 21:46:01.969182
10	4c327dc2-679d-46ec-8e66-4212767b6c35	dd592cff-ce60-4992-aa23-7995ae1014ce	t	t	t	t	active	2025-11-21 17:36:14.635223	2025-11-21 17:54:51.081396	2025-11-21 17:36:14.635229	2025-11-21 17:54:51.082504
11	709dac6b-ade7-4e42-bd33-8dad433131e4	03f94b21-d8ba-46ce-8244-13e34eaa24c4	f	f	f	f	pending	2025-12-29 23:58:48.335208	\N	2025-12-29 23:58:48.335216	2025-12-29 23:58:48.335217
\.


--
-- Data for Name: flask_dance_oauth; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flask_dance_oauth (user_id, browser_session_key, id, provider, created_at, token) FROM stdin;
\.


--
-- Data for Name: forum_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.forum_categories (id, name, description, icon, display_order, created_at) FROM stdin;
1	Causes, Diagnosis and Symptoms	Understanding PCOS symptoms, getting diagnosed, and learning about the underlying causes	bi-heart-pulse	1	2025-10-02 04:31:05.152474
2	Fertility	Support and guidance for pregnancy planning and fertility concerns with PCOS	bi-flower1	2	2025-10-02 04:31:05.28292
3	Periods and Cycles	Managing irregular periods, cycle tracking, and menstrual health	bi-calendar-heart	3	2025-10-02 04:31:05.399433
4	Skin and Hair	Dealing with acne, hair loss, hirsutism, and other skin/hair concerns	bi-stars	4	2025-10-02 04:31:05.515433
5	Long-term Health Conditions	Prevention and management of associated health conditions like diabetes and heart disease	bi-heart	5	2025-10-02 04:31:05.631736
6	Management and Treatment	Treatment approaches, medications, lifestyle changes, and management strategies	bi-clipboard-pulse	6	2025-10-02 04:31:05.74817
7	Sexual Health and Relationships	Intimacy, relationships, and sexual health concerns related to PCOS	bi-hearts	7	2025-10-02 04:31:05.865102
8	Weight and Body Image	Weight management, body positivity, and overcoming weight stigma	bi-person-heart	8	2025-10-02 04:31:05.981488
9	Inspirational Stories	Real success stories, victories, and hope from women thriving with PCOS	bi-star-fill	9	2025-10-13 02:58:37.935536
\.


--
-- Data for Name: forum_post_views; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.forum_post_views (id, post_id, user_id, session_id, viewed_at) FROM stdin;
1	1	\N	c14ba68e-5d3b-454e-876b-e19831ee3611	2025-10-11 00:14:49.225105
2	1	7d378161-2361-473d-9dea-0bc9c7d88eda	\N	2025-10-11 00:15:54.48161
3	1	e1a97a68-65b4-4cbb-a8df-fb484ee205f6	\N	2025-10-11 04:54:22.662541
4	1	\N	5e5e682a-f348-48d7-a548-0f93f31ae2f7	2025-10-11 18:02:15.844247
5	1	86a7716f-9ab3-47c5-acc1-ca44391ed79b	\N	2025-10-11 18:51:51.179992
11	1	31cb937d-a657-4703-8522-aec17fb5c2eb	\N	2025-10-13 03:44:09.900516
12	1	\N	a9c8ad20-7117-4424-a4ad-6b5be822a5f4	2025-10-13 15:52:54.347236
13	1	578dc22b-1920-4d79-93cc-7318c91064e6	\N	2025-10-14 19:41:51.854711
14	1	\N	0b84ddd9-ee31-4ace-b419-9279041773ab	2025-10-15 04:34:30.417444
15	22	24b303b9-0b38-48c4-90d4-3531afb72e3e	\N	2025-10-15 14:10:47.515537
16	1	46685628-4d9f-477a-acc8-c89d5fd25fac	\N	2025-11-17 04:42:09.518192
17	1	e716a9bb-4444-48f7-bf73-fd34d8edc984	\N	2025-11-18 05:28:24.11032
18	1	\N	0b5bdab4-8ab6-4584-aa40-25f01b5ab3ba	2025-11-20 03:21:44.201114
19	1	4c327dc2-679d-46ec-8e66-4212767b6c35	\N	2025-11-20 14:25:58.127929
20	1	df37b342-6042-4094-a77e-6b5cb452e272	\N	2025-11-20 15:45:22.267792
21	22	df37b342-6042-4094-a77e-6b5cb452e272	\N	2025-11-20 15:46:23.293783
22	22	4c327dc2-679d-46ec-8e66-4212767b6c35	\N	2025-11-20 23:11:47.064251
23	34	4c327dc2-679d-46ec-8e66-4212767b6c35	\N	2025-11-20 23:45:50.849458
24	37	4c327dc2-679d-46ec-8e66-4212767b6c35	\N	2025-11-20 23:46:41.121902
25	39	4c327dc2-679d-46ec-8e66-4212767b6c35	\N	2025-11-20 23:47:37.884545
26	27	4c327dc2-679d-46ec-8e66-4212767b6c35	\N	2025-11-20 23:48:13.932258
31	37	\N	f6b63b73-c0db-4e56-a769-c74aa5053990	2025-11-20 23:54:39.848286
32	31	4c327dc2-679d-46ec-8e66-4212767b6c35	\N	2025-11-20 23:56:32.805812
33	25	4c327dc2-679d-46ec-8e66-4212767b6c35	\N	2025-11-21 02:19:47.291665
34	26	4c327dc2-679d-46ec-8e66-4212767b6c35	\N	2025-11-21 02:20:36.382785
35	36	4c327dc2-679d-46ec-8e66-4212767b6c35	\N	2025-11-21 04:53:08.776556
36	35	4c327dc2-679d-46ec-8e66-4212767b6c35	\N	2025-11-21 17:28:03.001202
37	1	45e24578-7a60-43ca-b356-072cba779da1	\N	2025-12-29 23:26:24.870733
38	1	\N	60231838-fc07-4cdf-a72f-5940fa300209	2026-01-03 05:04:13.939985
39	25	\N	60231838-fc07-4cdf-a72f-5940fa300209	2026-01-03 05:29:31.271502
40	1	7eb560f8-fd1e-48e2-bdbc-e331d0b7c049	\N	2026-01-06 02:36:54.96875
41	1	\N	0aaa44d7-2207-49e3-9a32-6943f198fb82	2026-01-08 18:51:55.866553
\.


--
-- Data for Name: forum_posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.forum_posts (id, user_id, category_id, title, content, is_pinned, views_count, created_at, updated_at) FROM stdin;
1	1244bd18-1888-4419-808c-c50c5f3dea38	1	My experience	I have affected to pcod at age of 18 but now I completely cured by changing my daily habits.	f	35	2025-10-09 18:43:18.939254	2026-01-08 18:51:55.803728
22	24b303b9-0b38-48c4-90d4-3531afb72e3e	9	When You Succeed And Fail: How to Let go of Loss	What “never give up” should mean: learning to rejoice in success and let go of loss after spending my 30s undergoing fertility treatments.\n\nI’m 37. I’ve spent almost my entire 30s doing fertility treatments.\n\nThis is not a message to give up. It’s also not a message to keep going, because I can tell you – I’ve been in both places with different outcomes. This is a message of doing what’s right for your body and this moment in time of your life.\n\nAt age 29, we decided to try for kids. Not an old age, but right away I knew something was wrong.\n\n“Why is this not working?” said every fertility warrior everywhere.\n\nWe did the typical things, talked to the doctors, and ended up doing a round of IVF and – a miracle later! – got pregnant with our awesome baby boy. I get it. We’re lucky. Even with all the trauma, I’m omitting, we’re still lucky.\n\nBut… flash forward to kid number two. It should go the same way, right? Wrong. That first round of IVF did not work, which was devastating. I don’t know that I’ve cried harder. It was a glimpse into what many know: IVF is NOT a guarantee. It was a hard lesson to learn. I’ve had to refer back to a post-it note I wrote about these experiences because my brain constantly forgets what I’ve been through.\n\nSo here we go with a post-it in hand. Two rounds of IVF and no luck. One hysteroscopy, but nothing was found. Another FET, ERA, FET. No dice. A new retrieval which was miserable (OHSS and 6 liters of fluid removed from around my ovaries) and a vow to never do a retrieval again. Two more FETs with two normal “embabies.” Nothing. And then…Covid.\n\nDuring that pause period, I felt terrible. I experienced body aches, nausea, etc. It was not fun, but no discernible cause was found. Finally, I did a laparoscopy. They found a massive amount of scar tissue; a huge amount of endo.\n\nThe world was on fire. I had to have a second laparoscopy with my fertility doctor and when she woke me up, she declared it the worst of her career (and she’s been doing this for 30 years). In my heart, I said, “Why wasn’t this found sooner?!” In my head, I said, “Thank God you advocated for yourself when no one did.” We did one more FET round with two low mosaics. That was it. No more second chances. I had been through enough. In the end…it didn’t work. I don’t know why. I’ll never know why.\n\nBut my body said enough and this time, I listened.\n\nI’ve been a warrior, pushed forward, and persevered with success. I’ve also been a warrior, pushed forward, persevered, and failed. There is no shame in either. No right or wrong.\n\nI’m here to tell you:\n\nYOU are ENOUGH.\nYOU’VE done ENOUGH.\nYOU are OK.\n\nWhatever that means to you, I want you to know: YOUR choice is the right one. With all the love I can give.\n\nMichelle K., WI\n\nThese personal stories have been vetted by RESOLVE to ensure that specific products or service providers are not mentioned. RESOLVE does not edit any details provided by the author in regards to their personal choices or belief.\n\n	f	3	2025-10-15 14:10:45.11449	2025-11-20 23:11:47.002663
34	d92802b5-d322-40ca-bfd0-4a66eeca7534	2	Success story: Got pregnant after 2 years!	Just wanted to share some hope! After being told PCOS would make pregnancy difficult, I just found out I am 8 weeks pregnant. Lost 15 pounds, took inositol, and tracked ovulation. Do not give up!	f	1	2025-11-16 23:43:01.860088	2025-11-20 23:45:50.789938
28	58e72b9c-1cae-46a5-bb35-08ab34bdc12c	6	Metformin side effects - do they go away?	Started metformin 2 weeks ago and the stomach issues are rough. Does this get better or should I talk to my doctor about alternatives?	f	0	2025-11-13 23:39:08.555922	2025-11-20 23:39:08.556645
29	9446cc89-0de1-48b1-acb6-2db877d79eec	6	Inositol - has it helped anyone?	Thinking about trying myo-inositol supplements. Has anyone had success with this for regulating cycles or reducing symptoms?	f	0	2025-10-25 23:39:09.490044	2025-11-20 23:39:09.491259
30	9446cc89-0de1-48b1-acb6-2db877d79eec	7	How to explain PCOS to your partner?	My boyfriend tries to be supportive but I do not think he really understands what PCOS involves. How do you explain it to partners in a way they get it?	f	0	2025-10-21 23:39:10.431748	2025-11-20 23:39:10.432386
38	9446cc89-0de1-48b1-acb6-2db877d79eec	4	Facial hair removal options - what works?	The chin hair is getting worse and I am tired of plucking daily. What removal methods have worked for you? Considering laser but worried about cost.	f	0	2025-10-23 23:43:05.820712	2025-11-20 23:43:05.821223
39	9446cc89-0de1-48b1-acb6-2db877d79eec	4	Acne finally clearing up after diet changes	Cut out dairy and reduced sugar 2 months ago and my skin has improved so much! Still get some breakouts around my period but nothing like before.	f	1	2025-11-17 23:43:06.807255	2025-11-20 23:47:37.827199
27	9446cc89-0de1-48b1-acb6-2db877d79eec	5	Prediabetes diagnosis - feeling overwhelmed	Just got test results showing prediabetes. I know PCOS increases diabetes risk but I am still shocked. Anyone else dealing with this? What changes did you make?	f	1	2025-11-16 23:39:07.607925	2025-11-20 23:48:13.875985
31	58e72b9c-1cae-46a5-bb35-08ab34bdc12c	8	Learning to love my body despite PCOS	The weight gain, facial hair, and acne have made me struggle with self-image. Starting therapy and it is helping. How do you practice self-compassion?	f	1	2025-11-02 23:39:11.36626	2025-11-20 23:56:32.74649
26	58e72b9c-1cae-46a5-bb35-08ab34bdc12c	9	Small wins matter too!	Did not binge eat this week, walked 4 days, and drank more water. These might seem small but they are victories for me. Celebrating progress, not perfection!	f	1	2025-10-24 23:38:12.738261	2025-11-21 02:20:36.322475
36	4d2f858e-092c-46d5-be3d-43477ea1e723	3	Irregular periods - what is normal for PCOS?	My cycles vary from 35 to 70 days. Is this typical for PCOS? Should I be concerned about the long gaps?	f	1	2025-11-12 23:43:03.854419	2025-11-21 04:53:08.711815
37	4d2f858e-092c-46d5-be3d-43477ea1e723	3	Best period tracking apps for irregular cycles?	Regular period apps do not work well with my irregular PCOS cycles. What do you all use to track?	f	2	2025-11-04 23:43:04.835572	2025-11-20 23:54:39.779054
35	9446cc89-0de1-48b1-acb6-2db877d79eec	2	Anyone try Letrozole for ovulation?	My doctor suggested Letrozole instead of Clomid. Has anyone had experience with this? What were your results?	f	1	2025-11-04 23:43:02.871554	2025-11-21 17:28:02.936317
25	58e72b9c-1cae-46a5-bb35-08ab34bdc12c	9	One year of lifestyle changes - my journey	A year ago I was diagnosed with PCOS, prediabetes, and depression. Today: lost 30 pounds, cycles are regular, A1C is normal, and I feel like myself again. It was hard but so worth it. Keep going!	f	2	2025-11-04 23:38:11.793601	2026-01-03 05:29:31.201872
\.


--
-- Data for Name: forum_reactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.forum_reactions (id, reply_id, user_id, reaction_type, created_at, post_id) FROM stdin;
8	\N	7d378161-2361-473d-9dea-0bc9c7d88eda	like	2025-10-11 00:11:56.868864	1
9	\N	e1a97a68-65b4-4cbb-a8df-fb484ee205f6	like	2025-10-11 04:54:29.726353	1
10	1	86a7716f-9ab3-47c5-acc1-ca44391ed79b	like	2025-10-11 18:51:57.662991	\N
11	\N	24b303b9-0b38-48c4-90d4-3531afb72e3e	like	2025-10-17 14:50:38.824713	22
12	39	4c327dc2-679d-46ec-8e66-4212767b6c35	like	2025-11-20 23:46:16.029543	\N
\.


--
-- Data for Name: forum_replies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.forum_replies (id, post_id, user_id, content, is_solution, created_at, updated_at) FROM stdin;
1	1	e1a97a68-65b4-4cbb-a8df-fb484ee205f6	That's Amazing!!	f	2025-10-11 04:54:54.898775	2025-10-11 04:54:54.89878
24	25	d92802b5-d322-40ca-bfd0-4a66eeca7534	This is so motivating! What were your biggest changes that made a difference?	f	2025-11-06 02:38:11.793601	2025-11-20 23:38:12.385606
25	25	41fd03f2-f23a-4e31-bb82-790cdd5fbe70	Thank you for sharing! Stories like this give me hope on tough days.	f	2025-11-06 17:38:11.793601	2025-11-20 23:38:12.385612
26	26	9446cc89-0de1-48b1-acb6-2db877d79eec	Love this mindset! Small consistent changes add up to big results.	f	2025-10-26 08:38:12.738261	2025-11-20 23:38:13.321917
27	27	58e72b9c-1cae-46a5-bb35-08ab34bdc12c	I was diagnosed with prediabetes 2 years ago. Cut carbs, started walking 30 min daily, and my A1C is now normal! You can reverse it.	f	2025-11-17 02:39:07.607925	2025-11-20 23:39:08.200359
28	27	d92802b5-d322-40ca-bfd0-4a66eeca7534	Same boat. Taking metformin and watching carbs. My doctor said catching it early is key - you have got this!	f	2025-11-17 20:39:07.607925	2025-11-20 23:39:08.200366
29	28	4d2f858e-092c-46d5-be3d-43477ea1e723	Give it 4-6 weeks. The side effects mostly went away for me after a month. Taking it with food helps a lot.	f	2025-11-15 17:39:08.555922	2025-11-20 23:39:09.142644
30	28	9446cc89-0de1-48b1-acb6-2db877d79eec	Ask about the extended-release version! Much easier on the stomach.	f	2025-11-14 16:39:08.555922	2025-11-20 23:39:09.142649
31	29	d92802b5-d322-40ca-bfd0-4a66eeca7534	Been taking it for 4 months - my cycles went from 60+ days to 35-40 days! Also lost some weight.	f	2025-10-26 02:39:09.490044	2025-11-20 23:39:10.082189
32	30	d92802b5-d322-40ca-bfd0-4a66eeca7534	I showed my husband some videos and articles. Once he understood it is a hormonal condition, not just about periods, he was more supportive.	f	2025-10-23 01:39:10.431748	2025-11-20 23:39:11.018744
33	30	d92802b5-d322-40ca-bfd0-4a66eeca7534	I explained it affects insulin, hormones, fertility, weight, and mood - it is not just one thing. That helped my partner understand why I have tough days.	f	2025-10-22 11:39:10.431748	2025-11-20 23:39:11.018749
34	31	9446cc89-0de1-48b1-acb6-2db877d79eec	Therapy was huge for me too. Also following body-positive PCOS accounts on social media helped me see I am not alone.	f	2025-11-04 12:39:11.36626	2025-11-20 23:39:11.957155
35	31	9446cc89-0de1-48b1-acb6-2db877d79eec	Remembering my body is fighting a hormonal condition, not failing me. Be gentle with yourself!	f	2025-11-04 07:39:11.36626	2025-11-20 23:39:11.957162
39	34	9446cc89-0de1-48b1-acb6-2db877d79eec	Congratulations! This gives me so much hope. How did you track ovulation?	f	2025-11-17 22:43:01.860088	2025-11-20 23:43:02.498007
40	34	4d2f858e-092c-46d5-be3d-43477ea1e723	Amazing news! Wishing you a healthy pregnancy!	f	2025-11-18 12:43:01.860088	2025-11-20 23:43:02.498013
41	35	4d2f858e-092c-46d5-be3d-43477ea1e723	Yes! Letrozole worked better for me than Clomid. Fewer side effects and I ovulated on the second cycle.	f	2025-11-05 19:43:02.871554	2025-11-20 23:43:03.48734
42	36	9446cc89-0de1-48b1-acb6-2db877d79eec	My cycles are similar - anywhere from 40-90 days. My doctor said as long as you have at least 4 periods a year, it is manageable.	f	2025-11-13 10:43:03.854419	2025-11-20 23:43:04.469674
43	36	41fd03f2-f23a-4e31-bb82-790cdd5fbe70	I would talk to your doctor about progesterone to induce a period if you go more than 3 months without one.	f	2025-11-13 00:43:03.854419	2025-11-20 23:43:04.469678
45	38	41fd03f2-f23a-4e31-bb82-790cdd5fbe70	Laser has been life-changing for me! Expensive upfront but worth it. Did 8 sessions and hair growth reduced by 80%.	f	2025-10-24 21:43:05.820712	2025-11-20 23:43:06.439084
46	38	58e72b9c-1cae-46a5-bb35-08ab34bdc12c	I use an epilator and spironolactone. The medication has definitely slowed the growth over 6 months.	f	2025-10-24 03:43:05.820712	2025-11-20 23:43:06.439089
47	39	41fd03f2-f23a-4e31-bb82-790cdd5fbe70	Dairy was my trigger too! Switched to oat milk and my cystic acne cleared within weeks.	f	2025-11-19 08:43:06.807255	2025-11-20 23:43:07.422496
44	37	58e72b9c-1cae-46a5-bb35-08ab34bdc12c	I love CystaSense for tracking! It is designed specifically for PCOS with irregular cycles in mind, so it does not try to predict based on 28-day cycles like regular apps.	f	2025-11-06 08:43:04.835572	2025-11-20 23:43:05.45096
\.


--
-- Data for Name: lesson_actions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lesson_actions (id, lesson_id, action_text, order_index, is_optional, created_at) FROM stdin;
1	1	Download and review your recent lab results	1	f	2025-10-09 04:27:18.703718
2	1	Start a symptom journal - note 3 symptoms you experience most	2	f	2025-10-09 04:27:18.703723
3	1	List 3 questions to ask your doctor at next visit	3	f	2025-10-09 04:27:18.703724
4	1	Join the CystaSense community forum	4	t	2025-10-09 04:27:18.766297
5	2	Take a photo of your next meal and identify the protein, veggies, and grains	1	f	2025-10-09 04:27:19.132543
6	2	Plan 3 balanced meals for this week using the plate method	2	f	2025-10-09 04:27:19.132548
7	2	Make a grocery list with items from each category	3	f	2025-10-09 04:27:19.132549
8	3	Schedule 3 movement sessions this week (mark them in your calendar)	1	f	2025-10-09 04:27:19.48272
9	3	Try one new type of activity (yoga, swimming, dancing, walking)	2	f	2025-10-09 04:27:19.482725
10	3	Track how you feel before and after movement	3	f	2025-10-09 04:27:19.482725
11	4	Set a bedtime alarm for 30 minutes before target sleep time	1	f	2025-10-09 04:27:19.657428
12	4	Remove phones/tablets from bedroom or enable Do Not Disturb	2	f	2025-10-09 04:27:19.657434
13	4	Try a 5-minute relaxation technique before bed	3	f	2025-10-09 04:27:19.657435
14	5	Take baseline photos of affected areas	1	f	2025-10-09 04:27:19.833783
15	5	List your top 3 skin/hair concerns to discuss with your doctor	2	f	2025-10-09 04:27:19.833789
16	5	Research one treatment option to discuss	3	f	2025-10-09 04:27:19.83379
17	6	Schedule preconception visit with your OB-GYN	1	f	2025-10-09 04:27:20.009279
18	6	Start taking prenatal vitamin with folate	2	f	2025-10-09 04:27:20.009284
19	6	Learn about ovulation tracking methods	3	f	2025-10-09 04:27:20.009284
23	8	Ask your loved one: 'What's the most helpful way I can support you?'	1	f	2025-10-09 04:27:20.30247
24	8	Read one article about PCOS from a trusted source	2	f	2025-10-09 04:27:20.302477
25	8	Attend a medical appointment if invited	3	t	2025-10-09 04:27:20.360322
26	9	Create a lab results folder (digital or physical)	1	f	2025-10-09 05:26:00.176329
27	9	Highlight any abnormal values in your recent labs	2	f	2025-10-09 05:26:00.176337
28	9	Write down 2 questions about your results	3	f	2025-10-09 05:26:00.176338
29	10	Choose your first nutrition habit (e.g., eat protein with breakfast)	1	f	2025-10-09 05:26:00.425811
30	10	Choose your first movement habit (e.g., 10-minute walk after dinner)	2	f	2025-10-09 05:26:00.425817
31	10	Set up a habit tracker (app or paper)	3	f	2025-10-09 05:26:00.425818
32	10	Tell one person about your habits for accountability	4	f	2025-10-09 05:26:00.425819
33	11	Take a photo of your next 3 meals to check balance	1	f	2025-10-09 05:26:00.719986
34	11	Plan tomorrow's meals using the PCOS plate formula	2	f	2025-10-09 05:26:00.719992
35	11	Prep 3 protein options for the week	3	f	2025-10-09 05:26:00.719993
36	12	Log your meal times for 3 days	1	f	2025-10-09 05:26:00.954192
37	12	Set 3 meal time reminders on your phone	2	f	2025-10-09 05:26:00.954196
38	12	Prepare a balanced breakfast option for tomorrow	3	f	2025-10-09 05:26:00.954197
39	13	Try 3 bodyweight exercises: squats, push-ups, planks	1	f	2025-10-09 05:26:01.24357
40	13	Schedule 2 strength sessions this week	2	f	2025-10-09 05:26:01.243575
41	13	Watch proper form videos for your chosen exercises	3	f	2025-10-09 05:26:01.243575
42	13	Find a workout buddy or accountability partner	4	t	2025-10-09 05:26:01.300967
43	7	Research and consult with your doctor about Inositol supplements (Myo-inositol & D-chiro-inositol)	1	f	2025-10-10 17:26:55.07129
44	7	Check your Vitamin D levels and consider supplementation if deficient	2	f	2025-10-10 17:26:55.071295
45	7	Look into Omega-3 fatty acids for inflammation management	3	f	2025-10-10 17:26:55.071298
46	7	Discuss NAC (N-Acetyl Cysteine) with your healthcare provider for insulin sensitivity	4	f	2025-10-10 17:26:55.0713
47	7	Consider adding Magnesium to support insulin function and mood	5	f	2025-10-10 17:26:55.071301
48	14	Watch the video and note the emotional aspects mentioned	1	f	2025-10-10 18:23:11.132526
49	14	Reflect on how PCOS affects daily life beyond physical symptoms	2	f	2025-10-10 18:23:11.132533
50	14	Think about 3 ways you can provide better emotional support	3	f	2025-10-10 18:23:11.132534
51	14	Have a conversation with your loved one about their PCOS journey	4	f	2025-10-10 18:23:11.132534
52	15	Watch the full video and note key coping strategies mentioned	1	f	2025-10-10 18:24:50.551382
53	15	Identify 2-3 coping techniques your loved one might find helpful	2	f	2025-10-10 18:24:50.551389
54	15	Research local support groups or online communities for PCOS	3	f	2025-10-10 18:24:50.551391
55	15	Create a supportive environment that reduces stress at home	4	f	2025-10-10 18:24:50.551391
56	15	Discuss which coping strategies to try together	5	f	2025-10-10 18:24:50.551392
\.


--
-- Data for Name: lesson_quizzes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lesson_quizzes (id, lesson_id, title, passing_score, created_at) FROM stdin;
1	1	PCOS Basics Check	70	2025-10-09 04:27:18.826219
2	2	Plate Method Mastery	70	2025-10-09 04:27:19.191784
3	8	Supporter Readiness Check	80	2025-10-09 04:27:20.418258
4	9	Lab Results Understanding	70	2025-10-09 05:26:00.240195
5	10	Habit Building Basics	70	2025-10-09 05:26:00.484052
6	11	Balanced Plate Quiz	70	2025-10-09 05:26:00.77817
7	12	Meal Timing Mastery	70	2025-10-09 05:26:01.011898
8	13	Strength Training Essentials	70	2025-10-09 05:26:01.358391
9	14	Understanding Real PCOS Experiences	70	2025-10-10 18:23:11.205801
10	15	Understanding PCOS Coping Strategies	70	2025-10-10 18:24:50.614543
11	3	Exercise & Movement Quiz	70	2025-10-10 22:09:12.155863
12	4	Sleep & PCOS Quiz	70	2025-10-10 22:09:12.339374
13	5	Skin & Hair Management Quiz	70	2025-10-10 22:09:12.514271
14	6	PCOS & Fertility Quiz	70	2025-10-10 22:09:12.690435
15	7	PCOS Supplements Quiz	70	2025-10-10 22:09:12.865848
\.


--
-- Data for Name: lessons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lessons (id, track_id, title, order_index, why_it_matters, video_url, video_duration_minutes, conversation_prompt, content, dos, donts, is_published, created_at, updated_at) FROM stdin;
11	2	Balancing Your Plate	2	Balanced meals help stabilize blood sugar and reduce PCOS symptoms like energy crashes and cravings.	https://www.youtube.com/watch?v=VnAP5NxvZ-E&t=8s	15	What's your biggest challenge with balanced meals? Brainstorm solutions with family.	The PCOS plate: 1/2 vegetables, 1/4 protein, 1/4 complex carbs, plus healthy fats. This combination stabilizes insulin.	["Include protein with every meal", "Fill half your plate with vegetables", "Choose whole grains over refined"]	["Skip meals", "Eat carbs alone", "Cut out entire food groups"]	t	2025-10-09 05:26:00.661749	2025-10-10 17:28:17.646545
2	2	The PCOS Plate Method	1	Balanced meals help regulate blood sugar and hormones, reducing PCOS symptoms like fatigue and cravings.	https://www.youtube.com/watch?v=WM7KcW06Ef8	10	What's one meal you eat regularly? How could you adjust it using the plate method?	The plate method makes balanced eating simple: fill half your plate with non-starchy vegetables, a quarter with lean protein, and a quarter with whole grains or starchy vegetables.	["Include protein at every meal", "Fill half your plate with vegetables", "Choose whole grains over refined"]	["Skip meals", "Eliminate entire food groups", "Ignore hunger cues"]	t	2025-10-09 04:27:19.073481	2025-10-09 23:15:19.813786
3	3	Exercise for PCOS: Finding What Works for You	1	Regular movement improves insulin sensitivity, reduces inflammation, and helps manage PCOS symptoms naturally.	https://www.youtube.com/watch?v=xD4biDlbQmo	12	What type of movement brings you joy? How can you do more of it this week?	Aim for 150 minutes of moderate activity per week. Mix cardio with resistance training for best results. Start where you are - even 10 minutes counts!	["Start with 10-minute movement sessions", "Include both cardio and strength training", "Listen to your body and rest when needed"]	["Push through pain", "Exercise to 'earn' food", "Skip rest days"]	t	2025-10-09 04:27:19.366451	2025-10-09 23:15:19.928626
4	4	Sleep: Your Secret PCOS Weapon	1	Quality sleep regulates hormones, reduces stress, and improves insulin sensitivity - all crucial for PCOS management.	https://www.youtube.com/watch?v=B-GKnsC_5o0	9	What's your biggest sleep challenge? Who in your life could help support better sleep habits?	Aim for 7-9 hours of quality sleep. Create a bedtime routine, limit screens 1 hour before bed, and keep your bedroom cool and dark.	["Set a consistent bedtime", "Create a relaxing bedtime routine", "Keep bedroom cool (60-67\\u00b0F)"]	["Use screens right before bed", "Consume caffeine after 2pm", "Exercise vigorously close to bedtime"]	t	2025-10-09 04:27:19.541285	2025-10-09 23:15:20.04488
5	5	Managing PCOS Skin & Hair Symptoms	1	Visible symptoms like acne and hair changes affect confidence. Understanding your options helps you advocate for effective treatment.	https://www.youtube.com/watch?v=YSZ-4cpcDwA	11	Which skin or hair symptom affects you most? What support do you need from your care team?	Common treatments include topical medications, hormonal therapy, and lifestyle changes. Work with your dermatologist and endocrinologist for a comprehensive approach.	["Document symptoms with photos", "Ask about all treatment options", "Be patient - changes take 3-6 months"]	["Try multiple new products at once", "Skip sunscreen", "Expect overnight results"]	t	2025-10-09 04:27:19.716318	2025-10-09 23:15:20.159578
8	8	PCOS 101 for Supporters	1	Understanding PCOS helps you provide meaningful support without judgment or unwanted advice.	https://www.youtube.com/watch?v=dXood4rNhyI	15	What's one thing you can do this week to show support? Ask your loved one what would be most helpful.	PCOS is a complex hormonal condition affecting millions of women. Your role as a supporter is to listen, learn, and help when asked - not to fix or give unsolicited advice.	["Listen without judgment", "Ask 'how can I help?'", "Learn about PCOS", "Celebrate small wins"]	["Give unsolicited diet advice", "Compare to other people's experiences", "Minimize symptoms", "Make it about you"]	t	2025-10-09 04:27:20.244003	2025-10-09 23:15:20.504013
13	3	Strength Training for PCOS	2	Building muscle improves insulin sensitivity more than any other exercise type.	https://www.youtube.com/watch?v=OFAqheA0nB0	18	What's holding you back from strength training? Let's problem-solve together.	You don't need a gym! Bodyweight exercises, resistance bands, or household items work great. Aim for 2-3 sessions per week.	["Start with bodyweight exercises", "Focus on form over weight", "Rest 48 hours between sessions"]	["Lift too heavy too soon", "Skip warm-up", "Train the same muscles daily"]	t	2025-10-09 05:26:01.185986	2025-10-10 16:55:45.725376
6	6	PCOS and Fertility: What You Need to Know	1	PCOS is a leading cause of infertility, but most women with PCOS can conceive with proper support and treatment.	https://www.youtube.com/watch?v=_L24xoG5EVw	13	If fertility is a goal, who are your support people? What questions do you have for a fertility specialist?	Most women with PCOS can conceive naturally or with treatment. Start preconception health 3-6 months before trying. See a specialist if no pregnancy after 6 months of trying.	["Start prenatal vitamins early", "Track ovulation", "Optimize health before conceiving"]	["Wait too long to seek help", "Stress about timelines", "Skip preconception health"]	t	2025-10-09 04:27:19.893026	2025-10-10 16:57:21.463329
1	1	Understanding PCOS: What It Really Means	1	PCOS affects 1 in 10 women, but understanding your diagnosis empowers you to take control of your health journey.	https://www.youtube.com/watch?v=IvbjjJdKWTg	8	What surprised you most about PCOS? Share one thing you learned with a family member or friend.	PCOS is a hormonal condition that affects how your ovaries work. It's one of the most common causes of irregular periods and can affect fertility, but with the right approach, you can manage symptoms effectively.	["Track your symptoms regularly", "Focus on small, sustainable changes", "Ask questions to your healthcare team"]	["Compare your journey to others", "Try extreme diets or quick fixes", "Ignore symptoms or skip check-ups"]	t	2025-10-09 04:27:18.620103	2025-10-10 18:01:35.047819
9	1	Myths about PCOD	2	Understanding your hormone levels and test results empowers you to have informed conversations with your doctor.	https://www.youtube.com/watch?v=Zs32zCT90Nc	10	Which lab result surprised you most? Discuss with your healthcare provider what it means.	Key PCOS tests include testosterone, LH/FSH ratio, insulin levels, and thyroid function. Each tells a story about your hormones.	["Keep copies of all lab results", "Track trends over time", "Ask for explanations of abnormal values"]	["Self-diagnose based on one test", "Compare your values to others", "Ignore borderline results"]	t	2025-10-09 05:26:00.106061	2025-10-10 17:02:18.082241
7	7	PCOD Top 5 Supplements	1	While medications have their place, certain supplements can naturally support PCOS management by addressing insulin resistance, inflammation, and hormonal balance. Understanding these evidence-based supplements helps you make informed decisions about your health.	https://www.youtube.com/watch?v=tB2TgKbC0PM	15	What questions do you have about your current medications? Who can help you understand them better?	Common PCOS medications include birth control pills (COCs) for regulating cycles, metformin for insulin resistance, and spironolactone for androgen symptoms. Each has benefits and considerations.	["Take medications consistently", "Report side effects to your doctor", "Ask about long-term effects"]	["Stop medications without consulting your doctor", "Skip doses", "Compare your medications to others'"]	t	2025-10-09 04:27:20.068807	2025-10-10 17:26:35.411149
10	1	Your First Two Habits	3	Small, sustainable habits create the foundation for long-term PCOS management success.	https://www.youtube.com/watch?v=trNXpv3-JbI	12	Share your two chosen habits with a supporter and ask for their encouragement.	Start with just two habits: one for nutrition and one for movement. Master these before adding more.	["Start small and specific", "Track your habits daily", "Celebrate consistency over perfection"]	["Try to change everything at once", "Beat yourself up for missing a day", "Choose habits you hate"]	t	2025-10-09 05:26:00.303194	2025-10-09 23:15:20.733649
12	2	Meal Timing & Frequency	3	When you eat matters as much as what you eat for managing insulin levels.	\N	\N	What's your current eating schedule? Discuss potential improvements.	\n<h4>Why Meal Timing Matters for PCOS</h4>\n\n<p>When you eat can be just as important as what you eat when managing PCOS. Strategic meal timing helps regulate insulin levels, reduce inflammation, and support hormonal balance.</p>\n\n<h5>Key Principles:</h5>\n\n<p><strong>1. Eat Within 1 Hour of Waking</strong><br>\nStarting your day with a balanced breakfast kickstarts your metabolism and helps regulate blood sugar throughout the day. Skipping breakfast can lead to insulin spikes and increased cravings later.</p>\n\n<p><strong>2. The 3-4 Hour Rule</strong><br>\nSpace meals 3-4 hours apart to allow insulin levels to normalize between meals. This prevents constant insulin spikes that contribute to insulin resistance.</p>\n\n<p><strong>3. Don't Skip Meals</strong><br>\nIrregular eating patterns disrupt hormone regulation. Consistent meal timing helps your body anticipate and manage glucose more effectively.</p>\n\n<p><strong>4. Front-Load Your Calories</strong><br>\nResearch shows eating larger meals earlier in the day (breakfast and lunch) and a lighter dinner supports better insulin sensitivity and weight management for women with PCOS.</p>\n\n<p><strong>5. The Overnight Fast (12-14 Hours)</strong><br>\nAllow 12-14 hours between dinner and breakfast. This overnight fasting period helps improve insulin sensitivity and supports natural hormone rhythms. For example: dinner at 7 PM, breakfast at 7-9 AM.</p>\n\n<h5>Sample Meal Timing Schedule:</h5>\n<ul>\n<li><strong>7:30 AM</strong> - Balanced breakfast (protein + complex carbs + healthy fats)</li>\n<li><strong>10:30 AM</strong> - Optional small snack if needed</li>\n<li><strong>12:30 PM</strong> - Nutritious lunch (your largest meal)</li>\n<li><strong>3:30 PM</strong> - Balanced snack</li>\n<li><strong>6:30 PM</strong> - Lighter dinner</li>\n<li><strong>7:30 PM</strong> - Stop eating (12-hour fast until breakfast)</li>\n</ul>\n\n<p><strong>Important:</strong> This is a general guideline. Listen to your body and work with your healthcare provider to find the timing that works best for your lifestyle and PCOS symptoms.</p>\n	["Eat within 1 hour of waking", "Space meals 3-4 hours apart", "Have a consistent eating window"]	["Skip breakfast", "Graze constantly", "Eat late-night meals regularly"]	t	2025-10-09 05:26:00.836276	2025-10-10 17:29:25.614918
14	8	Real Stories: Living with PCOS	2	Hearing real experiences from people living with PCOS helps you understand the daily challenges, emotional journey, and resilience required. This deepens your empathy and equips you to be a better supporter.	https://www.youtube.com/watch?v=8Q2pB_tlzK4	5	After watching this story, what aspects of PCOS do you now understand better? How can you show more empathy and support?	\N	\N	\N	t	2025-10-10 18:23:11.057662	2025-10-10 18:23:11.057667
15	8	How to Cope with PCOS	3	Understanding effective coping strategies helps you support your loved one through difficult times. Learning how people successfully manage PCOS gives you practical ways to help and encourage.	https://www.youtube.com/watch?v=1rvTbDNfDyQ	6	What coping strategies from the video resonated most with you? How can you help implement these in your loved one's daily life?	\N	\N	\N	t	2025-10-10 18:24:50.491407	2025-10-10 18:24:50.491413
\.


--
-- Data for Name: menstrual_cycles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.menstrual_cycles (id, user_id, start_date, end_date, cycle_length, flow_intensity, cramps_severity, mood_changes, other_symptoms, created_at) FROM stdin;
1	1244bd18-1888-4419-808c-c50c5f3dea38	2025-09-25	\N	\N	\N	3	\N	\N	2025-09-25 19:13:19.951158
2	1244bd18-1888-4419-808c-c50c5f3dea38	2025-09-24	2025-09-30	\N	medium	1	emotional	\N	2025-09-25 19:41:06.028966
3	1244bd18-1888-4419-808c-c50c5f3dea38	2025-10-02	2025-10-16	\N	medium	2	\N	\N	2025-10-02 03:25:20.223486
4	9652f9ec-49ea-4c83-bfba-fc1e3b2cdd31	2025-10-09	\N	\N	\N	\N	\N	\N	2025-10-09 22:55:53.301584
5	57443a2f-9a90-481c-8872-d69ad93a2eef	2025-10-01	2025-10-06	\N	medium	2	\N	\N	2025-10-10 17:49:45.790323
8	e1a97a68-65b4-4cbb-a8df-fb484ee205f6	2025-09-01	2025-09-07	\N	medium	\N	\N	\N	2025-10-10 19:42:11.979986
10	e1a97a68-65b4-4cbb-a8df-fb484ee205f6	2025-10-01	2025-10-07	7	medium	\N	\N	\N	2025-10-11 04:32:03.028852
11	86a7716f-9ab3-47c5-acc1-ca44391ed79b	2025-10-01	2025-10-06	6	medium	2	\N	\N	2025-10-11 18:54:00.821625
12	4d9796a7-2dad-4ad2-8a2d-ae02046c867d	2025-10-12	2025-10-17	6	medium	2	\N	\N	2025-10-12 14:07:15.190477
13	31cb937d-a657-4703-8522-aec17fb5c2eb	2025-10-10	2025-10-14	5	medium	1	Irritable	Backpain	2025-10-13 03:31:26.231042
14	c435b83e-41fb-405f-b1e7-0811c56f89b4	2025-10-14	\N	\N	\N	2	\N	\N	2025-10-14 20:16:20.895535
15	c435b83e-41fb-405f-b1e7-0811c56f89b4	2025-10-14	2025-10-19	6	\N	\N	\N	\N	2025-10-14 20:16:54.808002
16	24b303b9-0b38-48c4-90d4-3531afb72e3e	2025-10-15	2025-10-19	5	medium	1	\N	\N	2025-10-15 04:56:13.225188
17	4a797d4a-42e4-455b-ab30-d7b96d72e751	2025-10-15	2025-10-19	5	medium	\N	\N	\N	2025-10-15 05:07:31.589597
18	4c327dc2-679d-46ec-8e66-4212767b6c35	2025-11-18	2025-11-22	5	medium	\N	\N	\N	2025-11-20 14:24:27.988534
19	45e24578-7a60-43ca-b356-072cba779da1	2025-12-29	\N	\N	medium	1	\N	\N	2025-12-29 23:38:20.935768
\.


--
-- Data for Name: message_reactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.message_reactions (id, message_id, user_id, reaction_type, created_at) FROM stdin;
\.


--
-- Data for Name: nudges; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nudges (id, nudge_type, title, message, goal_type, is_template, created_at) FROM stdin;
1	encouragement	You're doing great!	I see all the effort you're putting in. Your dedication is inspiring! 💪	\N	t	2025-10-09 04:27:20.478611
2	encouragement	Proud of you	Small steps add up to big changes. I'm proud of the progress you're making! 🌟	\N	t	2025-10-09 04:27:20.478618
3	encouragement	Keep going	Even on tough days, you're moving forward. That takes real strength! 💙	\N	t	2025-10-09 04:27:20.478619
4	recipe_swap	Tried a new recipe!	I made this delicious PCOS-friendly recipe and thought you might enjoy it too! Want to try it together this week? 🥗	diet	t	2025-10-09 04:27:20.47862
5	recipe_swap	Meal prep idea	Found a great meal prep idea that could make weeknights easier. Want to prep together this Sunday? 🍱	diet	t	2025-10-09 04:27:20.478621
6	walk_invite	Walk together?	Beautiful weather today! Want to go for a walk together? No pressure, just some fresh air and company 🚶‍♀️	exercise	t	2025-10-09 04:27:20.478622
7	walk_invite	Morning stroll	I'm going for a morning walk tomorrow. Would love your company if you're up for it! ☀️	exercise	t	2025-10-09 04:27:20.478623
8	reminder	Medication reminder	Just a gentle reminder about your evening medication 💊	medication	t	2025-10-09 04:27:20.478624
9	reminder	Hydration check	Have you had enough water today? Let's both grab a glass! 💧	\N	t	2025-10-09 04:27:20.478625
10	celebration	Milestone achieved!	You've stuck with your routine for a whole week! That's worth celebrating! 🎉	\N	t	2025-10-09 04:27:20.478626
11	celebration	Progress spotted!	I noticed you've been so consistent with your goals lately. Amazing work! ⭐	\N	t	2025-10-09 04:27:20.478627
\.


--
-- Data for Name: quiz_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quiz_questions (id, quiz_id, question_text, question_type, options, correct_answer, explanation, order_index, created_at) FROM stdin;
1	1	PCOS is a condition that affects:	multiple_choice	["Only fertility", "Hormone levels and ovarian function", "Only weight", "Only skin"]	Hormone levels and ovarian function	PCOS is a hormonal condition that affects multiple body systems, not just one aspect.	1	2025-10-09 04:27:18.94952
2	1	True or False: Everyone with PCOS experiences the exact same symptoms	true_false	["True", "False"]	False	PCOS symptoms vary widely between individuals. Your experience is unique to you.	2	2025-10-09 04:27:19.013948
3	2	What portion of your plate should be non-starchy vegetables?	multiple_choice	["1/4", "1/2", "1/3", "All of it"]	1/2	Half your plate should be filled with non-starchy vegetables for optimal nutrition and blood sugar control.	1	2025-10-09 04:27:19.307747
4	3	The best way to support someone with PCOS is to:	multiple_choice	["Give them diet advice", "Ask how you can help", "Tell them what worked for someone else", "Minimize their symptoms"]	Ask how you can help	Everyone's PCOS journey is different. Asking how you can help puts them in control.	1	2025-10-09 04:27:20.546675
5	3	True or False: You should celebrate small wins with your loved one	true_false	["True", "False"]	True	PCOS management involves many small steps. Celebrating progress, no matter how small, provides important encouragement.	2	2025-10-09 04:27:20.604309
6	4	What does a high LH/FSH ratio indicate in PCOS?	multiple_choice	["Low estrogen", "Hormonal imbalance typical of PCOS", "Thyroid issues", "Normal ovulation"]	Hormonal imbalance typical of PCOS	In PCOS, LH is often elevated relative to FSH, creating a high ratio that indicates hormonal imbalance.	1	2025-10-09 05:26:00.36183
7	4	Why is insulin testing important in PCOS?	multiple_choice	["It's not important", "Many women with PCOS have insulin resistance", "To check for diabetes only", "To measure weight loss"]	Many women with PCOS have insulin resistance	Up to 70% of women with PCOS have insulin resistance, which can worsen symptoms.	2	2025-10-09 05:26:00.361834
8	5	What's the best way to start new habits for PCOS?	multiple_choice	["Change everything at once", "Start with 1-2 small habits", "Wait until you feel motivated", "Copy someone else's routine"]	Start with 1-2 small habits	Starting small increases success rates and builds confidence before adding more changes.	1	2025-10-09 05:26:00.542883
9	6	What should fill half your PCOS plate?	multiple_choice	["Protein", "Vegetables", "Carbohydrates", "Fruits"]	Vegetables	Vegetables provide fiber, nutrients, and help balance blood sugar without spiking insulin.	1	2025-10-09 05:26:00.896221
10	6	Why is protein important at every meal?	multiple_choice	["It tastes good", "It stabilizes blood sugar and reduces cravings", "It's low calorie", "It speeds up metabolism"]	It stabilizes blood sugar and reduces cravings	Protein slows digestion and prevents blood sugar spikes, reducing insulin resistance.	2	2025-10-09 05:26:00.896226
11	7	How long should you wait between meals?	multiple_choice	["1-2 hours", "3-4 hours", "6-8 hours", "Only eat when hungry"]	3-4 hours	3-4 hour spacing helps maintain stable blood sugar without triggering insulin spikes.	1	2025-10-09 05:26:01.070237
12	8	Why is strength training especially beneficial for PCOS?	multiple_choice	["It burns the most calories", "It improves insulin sensitivity", "It's the easiest exercise", "It reduces stress only"]	It improves insulin sensitivity	Building muscle tissue helps your body use insulin more effectively, addressing a root cause of PCOS.	1	2025-10-09 05:26:01.416473
13	8	How many rest days should you have between strength sessions?	multiple_choice	["None - train daily", "At least 48 hours", "One week", "Only if sore"]	At least 48 hours	Muscles need 48 hours to recover and grow stronger.	2	2025-10-09 05:26:01.416477
14	9	Why is it important for supporters to hear real PCOS stories?	multiple_choice	["To understand medical terminology better", "To build empathy and understand emotional challenges", "To learn about treatment costs", "To compare different cases"]	To build empathy and understand emotional challenges	Real stories help you understand the emotional and daily life challenges, building deeper empathy.	1	2025-10-10 18:23:11.269647
15	9	PCOS affects only physical health.	true_false	["True", "False"]	False	PCOS significantly impacts mental health, emotions, self-esteem, and daily life beyond physical symptoms.	2	2025-10-10 18:23:11.269652
16	9	What's the most important thing a supporter can do after learning about real PCOS experiences?	multiple_choice	["Give medical advice", "Compare their loved one to others", "Listen without judgment and offer emotional support", "Focus only on visible symptoms"]	Listen without judgment and offer emotional support	The best support comes from empathetic listening and emotional validation, not comparisons or unsolicited advice.	3	2025-10-10 18:23:11.269653
17	10	What is the most important factor in successfully coping with PCOS?	multiple_choice	["Having expensive treatments", "A strong support system and consistent self-care", "Avoiding all social situations", "Ignoring symptoms"]	A strong support system and consistent self-care	Research shows that having support and practicing consistent self-care are key to managing PCOS effectively.	1	2025-10-10 18:24:50.674973
18	10	As a supporter, you should fix all of your loved one's PCOS problems.	true_false	["True", "False"]	False	Your role is to support, not fix. Empowering them to manage their condition with your support is more effective than trying to solve everything.	2	2025-10-10 18:24:50.674979
19	10	Which approach is most helpful when supporting someone coping with PCOS?	multiple_choice	["Constantly remind them about their symptoms", "Listen actively and offer encouragement without judgment", "Tell them what worked for someone else", "Minimize their struggles"]	Listen actively and offer encouragement without judgment	Active listening and non-judgmental support creates a safe space for them to share and cope effectively.	3	2025-10-10 18:24:50.67498
20	11	What type of exercise is most beneficial for PCOS?	multiple_choice	["A mix of cardio and strength training", "Only intense cardio", "Only yoga", "No exercise needed"]	A mix of cardio and strength training	Combining cardio and strength training helps manage insulin resistance and hormonal balance.	0	2025-10-10 22:09:12.220773
21	11	How often should you exercise if you have PCOS?	multiple_choice	["Most days of the week (4-5 days)", "Once a week", "Every day without rest", "Only when you feel like it"]	Most days of the week (4-5 days)	Consistent exercise 4-5 days per week helps regulate hormones and insulin.	1	2025-10-10 22:09:12.220777
22	11	Rest days are important even with PCOS.	true_false	["True", "False"]	True	Rest allows your body to recover and prevents stress hormone spikes.	2	2025-10-10 22:09:12.220779
23	12	How many hours of sleep should you aim for with PCOS?	multiple_choice	["7-9 hours", "4-5 hours", "10-12 hours", "Sleep doesn't matter"]	7-9 hours	Quality sleep of 7-9 hours helps regulate hormones and insulin sensitivity.	0	2025-10-10 22:09:12.397752
24	12	Poor sleep can worsen PCOS symptoms.	true_false	["True", "False"]	True	Lack of sleep increases insulin resistance and disrupts hormone balance.	1	2025-10-10 22:09:12.397756
25	12	What helps improve sleep quality for PCOS?	multiple_choice	["Consistent bedtime routine", "Late-night eating", "Screen time before bed", "Irregular sleep schedule"]	Consistent bedtime routine	A regular sleep routine helps regulate circadian rhythm and hormone production.	2	2025-10-10 22:09:12.397757
26	13	What causes acne in PCOS?	multiple_choice	["Excess androgens (male hormones)", "Not washing face enough", "Eating chocolate", "Drinking water"]	Excess androgens (male hormones)	High androgen levels in PCOS trigger oil production and acne.	0	2025-10-10 22:09:12.572559
27	13	Hair loss in PCOS can be managed with proper treatment.	true_false	["True", "False"]	True	Hormonal balance and proper care can significantly improve hair health.	1	2025-10-10 22:09:12.572563
28	13	Which approach helps manage PCOS skin issues?	multiple_choice	["Hormonal balance through diet and lifestyle", "Only topical products", "Ignoring the problem", "Using harsh scrubs daily"]	Hormonal balance through diet and lifestyle	Internal hormonal balance is key to managing external PCOS symptoms.	2	2025-10-10 22:09:12.572564
29	14	Can women with PCOS get pregnant?	true_false	["True", "False"]	True	Many women with PCOS can conceive with proper management and treatment.	0	2025-10-10 22:09:12.749105
30	14	What helps improve fertility in PCOS?	multiple_choice	["Weight management and lifestyle changes", "Only medication", "Ignoring symptoms", "High sugar diet"]	Weight management and lifestyle changes	Even a 5-10% weight loss can improve ovulation and fertility.	1	2025-10-10 22:09:12.749111
31	14	When should you consult a fertility specialist?	multiple_choice	["After trying for 6-12 months without success", "Immediately", "Never needed", "Only after 5 years"]	After trying for 6-12 months without success	Earlier consultation is recommended for women with PCOS and fertility concerns.	2	2025-10-10 22:09:12.749112
32	15	Which supplement is commonly recommended for PCOS?	multiple_choice	["Inositol", "Vitamin C for weight loss", "Random herbal pills", "Energy drinks"]	Inositol	Inositol helps improve insulin sensitivity and ovulation in PCOS.	0	2025-10-10 22:09:12.923873
33	15	You should take supplements without consulting a doctor.	true_false	["True", "False"]	False	Always consult healthcare providers before starting supplements.	1	2025-10-10 22:09:12.923878
34	15	What role does Vitamin D play in PCOS?	multiple_choice	["Supports hormone regulation and insulin sensitivity", "Only for bone health", "No role in PCOS", "Causes weight gain"]	Supports hormone regulation and insulin sensitivity	Vitamin D deficiency is common in PCOS and supplementation can help.	2	2025-10-10 22:09:12.923878
\.


--
-- Data for Name: quiz_results; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quiz_results (id, user_id, quiz_type, score, total_questions, answers, recommendations, created_at) FROM stdin;
1	1244bd18-1888-4419-808c-c50c5f3dea38	knowledge	3	3	{"q1": "a", "q2": "a", "q3": "a"}	Excellent! You have a good understanding of PCOD. Continue learning and stay informed.	2025-09-25 19:28:30.053295
\.


--
-- Data for Name: reminders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reminders (id, user_id, title, description, reminder_type, reminder_time, is_recurring, recurrence_pattern, is_completed, created_at) FROM stdin;
1	1244bd18-1888-4419-808c-c50c5f3dea38	Take Metformin	Take 500mg with breakfast for PCOD management	medication	2025-09-26 08:00:00	t	daily	f	2025-09-25 19:25:55.6953
2	1244bd18-1888-4419-808c-c50c5f3dea38	Morning Exercise	30-minute walk or yoga for hormonal balance	exercise	2025-09-26 07:00:00	t	daily	f	2025-09-25 19:25:55.6953
3	1244bd18-1888-4419-808c-c50c5f3dea38	Track Symptoms	Log daily symptoms in PCOD Care app	tracking	2025-09-26 21:00:00	t	daily	f	2025-09-25 19:25:55.6953
4	1244bd18-1888-4419-808c-c50c5f3dea38	Dr. Priya Appointment	Gynecology consultation at Women's Health Center	appointment	2025-09-28 10:30:00	f	\N	f	2025-09-25 19:25:55.6953
5	1244bd18-1888-4419-808c-c50c5f3dea38	Drink Water	Stay hydrated - aim for 2-3 liters daily	hydration	2025-09-26 14:00:00	t	daily	f	2025-09-25 19:25:55.6953
6	1244bd18-1888-4419-808c-c50c5f3dea38	PCOD-Friendly Lunch	Low-GI meal with protein and fiber	diet	2025-09-26 13:00:00	t	daily	f	2025-09-25 19:25:55.6953
7	9652f9ec-49ea-4c83-bfba-fc1e3b2cdd31	Exercise Session		exercise	2025-10-10 00:00:00	f	daily	f	2025-10-09 23:01:05.905843
8	57443a2f-9a90-481c-8872-d69ad93a2eef	Take Medication		medication	2025-10-10 18:00:00	f	daily	f	2025-10-10 17:56:27.757778
9	57443a2f-9a90-481c-8872-d69ad93a2eef	Exercise Session		exercise	2025-10-10 18:00:00	f	daily	f	2025-10-10 17:56:36.303628
10	006a9f87-7749-4c21-9c1e-ee28a6fe55fd	Take Medication		medication	2025-10-10 21:00:00	f	daily	f	2025-10-10 20:32:02.11411
12	86a7716f-9ab3-47c5-acc1-ca44391ed79b	Drink Water		hydration	2025-10-11 19:00:00	t	daily	f	2025-10-11 18:54:45.691438
11	86a7716f-9ab3-47c5-acc1-ca44391ed79b	Take Medication		medication	2025-10-11 19:00:00	f	daily	t	2025-10-11 18:54:31.660469
13	4d9796a7-2dad-4ad2-8a2d-ae02046c867d	Exercise Session		exercise	2025-10-12 15:00:00	f	daily	f	2025-10-12 14:37:34.985264
14	4c327dc2-679d-46ec-8e66-4212767b6c35	Exercise Session		exercise	2025-11-21 06:00:00	t	daily	t	2025-11-21 02:43:02.927412
16	03f94b21-d8ba-46ce-8244-13e34eaa24c4	App		appointment	2025-12-29 18:06:00	f	daily	f	2025-12-30 00:03:56.051482
\.


--
-- Data for Name: sent_nudges; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sent_nudges (id, connection_id, nudge_id, sender_id, recipient_id, message, nudge_type, is_read, sent_at, read_at) FROM stdin;
\.


--
-- Data for Name: shared_goals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shared_goals (id, connection_id, goal_text, goal_type, target_frequency, is_active, created_at, completed_at) FROM stdin;
\.


--
-- Data for Name: symptom_tracker; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.symptom_tracker (id, user_id, date, acne_severity, fatigue_level, mood_swings, anxiety_level, depression_level, notes, created_at, hair_loss_level, weight_gain_level, bloating_level) FROM stdin;
1	1244bd18-1888-4419-808c-c50c5f3dea38	2025-09-25	3	3	3	3	\N		2025-09-25 19:13:15.090065	0	0	0
2	1244bd18-1888-4419-808c-c50c5f3dea38	2025-09-24	1	1	\N	\N	\N		2025-09-25 19:40:29.197194	3	3	0
3	1244bd18-1888-4419-808c-c50c5f3dea38	2025-10-02	\N	\N	3	\N	\N	Quick log: Mood swings	2025-10-02 03:22:45.64126	0	0	0
4	1244bd18-1888-4419-808c-c50c5f3dea38	2025-10-02	\N	\N	3	\N	\N	Quick log: Mood swings	2025-10-02 03:22:46.568962	0	0	0
5	1244bd18-1888-4419-808c-c50c5f3dea38	2025-10-02	\N	\N	3	\N	\N	Quick log: Mood swings	2025-10-02 03:22:54.281584	0	0	0
6	1244bd18-1888-4419-808c-c50c5f3dea38	2025-10-02	\N	\N	\N	\N	\N		2025-10-02 03:22:59.942874	3	0	0
7	1244bd18-1888-4419-808c-c50c5f3dea38	2025-10-02	\N	5	\N	\N	\N		2025-10-02 03:23:30.408187	0	0	0
8	1244bd18-1888-4419-808c-c50c5f3dea38	2025-10-02	\N	\N	\N	5	\N		2025-10-02 03:23:42.910662	0	0	0
9	1244bd18-1888-4419-808c-c50c5f3dea38	2025-10-02	\N	\N	5	\N	\N		2025-10-02 03:23:51.262791	0	0	0
10	9652f9ec-49ea-4c83-bfba-fc1e3b2cdd31	2025-10-09	\N	\N	3	\N	\N	Quick log: Mood swings	2025-10-09 22:55:16.805816	0	0	0
11	9652f9ec-49ea-4c83-bfba-fc1e3b2cdd31	2025-10-09	1	1	2	1	\N		2025-10-09 22:55:36.157736	3	0	0
12	57443a2f-9a90-481c-8872-d69ad93a2eef	2025-10-10	2	2	1	1	\N		2025-10-10 17:49:16.694917	0	0	3
13	e1a97a68-65b4-4cbb-a8df-fb484ee205f6	2025-10-10	5	5	\N	5	\N		2025-10-10 19:38:19.019346	0	3	0
14	e1a97a68-65b4-4cbb-a8df-fb484ee205f6	2025-10-10	\N	\N	3	\N	\N	Quick log: Mood swings	2025-10-10 19:46:12.377242	0	0	0
15	e1a97a68-65b4-4cbb-a8df-fb484ee205f6	2025-10-10	\N	\N	\N	\N	\N		2025-10-10 19:46:23.288523	3	0	0
16	006a9f87-7749-4c21-9c1e-ee28a6fe55fd	2025-10-10	\N	\N	3	\N	\N	Quick log: Mood swings	2025-10-10 20:24:53.159228	0	0	0
17	006a9f87-7749-4c21-9c1e-ee28a6fe55fd	2025-10-10	\N	\N	\N	5	\N		2025-10-10 20:28:24.333575	0	0	0
18	7d378161-2361-473d-9dea-0bc9c7d88eda	2025-10-10	\N	\N	\N	\N	\N		2025-10-10 22:58:10.919346	0	0	0
19	7d378161-2361-473d-9dea-0bc9c7d88eda	2025-10-10	\N	\N	3	\N	\N	Quick log: Mood swings	2025-10-10 23:24:16.757435	0	0	0
20	e1a97a68-65b4-4cbb-a8df-fb484ee205f6	2025-10-11	\N	\N	\N	\N	\N	feels good	2025-10-11 04:49:37.955437	\N	\N	\N
21	e1a97a68-65b4-4cbb-a8df-fb484ee205f6	2025-10-11	\N	\N	2	\N	\N	feeling good	2025-10-11 04:50:31.367066	2	1	1
22	e1a97a68-65b4-4cbb-a8df-fb484ee205f6	2025-10-11	\N	\N	\N	\N	\N	all good	2025-10-11 04:56:42.211605	\N	\N	\N
23	1244bd18-1888-4419-808c-c50c5f3dea38	2025-10-11	0	0	0	0	\N	Custom Symptom: Headache (Moderate)	\N	0	0	0
24	e1a97a68-65b4-4cbb-a8df-fb484ee205f6	2025-10-11	\N	\N	\N	\N	\N	Custom Symptom: joint pain (Mild)	2025-10-11 05:04:59.217721	\N	\N	\N
25	e1a97a68-65b4-4cbb-a8df-fb484ee205f6	2025-10-11	\N	3	\N	\N	\N	Quick log: Feeling fatigued	2025-10-11 05:09:28.517877	\N	\N	\N
26	86a7716f-9ab3-47c5-acc1-ca44391ed79b	2025-10-11	\N	\N	\N	\N	\N	Quick log: Headache	2025-10-11 18:52:31.948942	\N	\N	\N
27	86a7716f-9ab3-47c5-acc1-ca44391ed79b	2025-10-11	\N	\N	3	\N	\N	Feels tried\n\nCustom Symptom: joint pain (Mild)	2025-10-11 18:53:21.346945	3	2	2
28	4d9796a7-2dad-4ad2-8a2d-ae02046c867d	2025-10-12	\N	\N	\N	\N	\N	Quick log: Headache	2025-10-12 14:06:28.217731	\N	\N	\N
29	4d9796a7-2dad-4ad2-8a2d-ae02046c867d	2025-10-12	1	1	1	1	\N		2025-10-12 14:06:49.613008	1	1	1
30	31cb937d-a657-4703-8522-aec17fb5c2eb	2025-10-13	\N	\N	\N	\N	\N	Quick log: Headache	2025-10-13 03:18:18.596728	\N	\N	\N
31	31cb937d-a657-4703-8522-aec17fb5c2eb	2025-10-13	1	1	1	1	\N	Had abdominal pain,took painkiller\n\nCustom Symptom: joint pain (Very Mild)	2025-10-13 03:29:14.564636	1	1	1
32	c435b83e-41fb-405f-b1e7-0811c56f89b4	2025-10-14	\N	\N	\N	\N	\N	Quick log: Headache	2025-10-14 20:14:05.128136	\N	\N	\N
33	c435b83e-41fb-405f-b1e7-0811c56f89b4	2025-10-14	1	5	\N	4	\N	Custom Symptom: he (Very Mild)	2025-10-14 20:15:26.201582	\N	\N	\N
34	24b303b9-0b38-48c4-90d4-3531afb72e3e	2025-10-15	\N	\N	3	\N	\N	Quick log: Mood swings	2025-10-15 04:55:26.354769	\N	\N	\N
35	24b303b9-0b38-48c4-90d4-3531afb72e3e	2025-10-15	\N	\N	\N	1	\N		2025-10-15 04:55:46.467814	1	\N	\N
36	4a797d4a-42e4-455b-ab30-d7b96d72e751	2025-10-15	\N	\N	\N	\N	\N	Quick log: Headache	2025-10-15 05:05:09.289824	\N	\N	\N
37	4a797d4a-42e4-455b-ab30-d7b96d72e751	2025-10-15	3	2	1	1	\N	Custom Symptom: joint pain (Very Mild)	2025-10-15 05:05:31.433746	1	1	1
38	4a797d4a-42e4-455b-ab30-d7b96d72e751	2025-10-15	\N	\N	\N	\N	\N	Quick log: Bloating	2025-10-15 05:06:04.209659	\N	\N	3
39	4a797d4a-42e4-455b-ab30-d7b96d72e751	2025-10-15	\N	\N	\N	\N	\N		2025-10-15 05:06:08.735757	\N	\N	\N
40	4a797d4a-42e4-455b-ab30-d7b96d72e751	2025-10-15	\N	3	\N	\N	\N	Quick log: Feeling fatigued	2025-10-15 05:06:31.571993	\N	\N	\N
41	4a797d4a-42e4-455b-ab30-d7b96d72e751	2025-10-15	1	1	1	1	\N		2025-10-15 05:06:54.387179	1	1	1
42	4a797d4a-42e4-455b-ab30-d7b96d72e751	2025-10-15	\N	\N	\N	\N	\N	Quick log: Headache	2025-10-15 05:11:04.637094	\N	\N	\N
43	4a797d4a-42e4-455b-ab30-d7b96d72e751	2025-10-15	1	1	\N	\N	\N		2025-10-15 05:11:20.541779	1	\N	\N
44	46685628-4d9f-477a-acc8-c89d5fd25fac	2025-11-17	\N	\N	\N	\N	\N		2025-11-17 04:42:38.880247	\N	2	\N
45	4c327dc2-679d-46ec-8e66-4212767b6c35	2025-11-20	\N	\N	\N	\N	\N	Quick log: Headache	2025-11-20 14:23:42.271811	\N	\N	\N
46	4c327dc2-679d-46ec-8e66-4212767b6c35	2025-11-20	1	1	1	1	\N		2025-11-20 14:23:57.335823	1	1	1
47	df37b342-6042-4094-a77e-6b5cb452e272	2025-11-20	\N	3	\N	\N	\N	Quick log: Feeling fatigued	2025-11-20 15:47:34.173654	\N	\N	\N
48	df37b342-6042-4094-a77e-6b5cb452e272	2025-11-20	\N	\N	3	\N	\N	Quick log: Mood swings	2025-11-20 15:47:35.072666	\N	\N	\N
49	df37b342-6042-4094-a77e-6b5cb452e272	2025-11-20	\N	\N	\N	\N	\N	Quick log: Headache	2025-11-20 15:47:38.498872	\N	\N	\N
50	df37b342-6042-4094-a77e-6b5cb452e272	2025-11-20	1	\N	\N	\N	\N		2025-11-20 15:48:08.107697	\N	\N	\N
51	4c327dc2-679d-46ec-8e66-4212767b6c35	2025-11-21	1	\N	\N	\N	\N		2025-11-21 17:30:08.431761	\N	1	2
52	45e24578-7a60-43ca-b356-072cba779da1	2025-12-29	1	1	\N	\N	\N		2025-12-29 23:37:55.321271	\N	\N	\N
53	4c327dc2-679d-46ec-8e66-4212767b6c35	2026-01-28	\N	\N	\N	\N	\N	Quick log: Headache	2026-01-28 02:23:03.033212	\N	\N	\N
\.


--
-- Data for Name: user_badges; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_badges (id, user_id, badge_id, lesson_id, earned_at, quiz_score) FROM stdin;
\.


--
-- Data for Name: user_lesson_progress; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_lesson_progress (id, user_id, lesson_id, started_at, completed_at, quiz_score, quiz_attempts, completed_actions, created_at, updated_at) FROM stdin;
1	1244bd18-1888-4419-808c-c50c5f3dea38	8	2025-10-09 04:35:51.728777	2025-10-11 19:02:02.592897	100	2	["23"]	2025-10-09 04:35:51.730545	2025-10-11 19:02:02.593369
38	e1a97a68-65b4-4cbb-a8df-fb484ee205f6	9	2025-10-10 19:31:03.394673	2025-10-10 19:31:55.493394	100	8	\N	2025-10-10 19:31:03.395292	2025-10-11 05:12:51.133627
41	006a9f87-7749-4c21-9c1e-ee28a6fe55fd	9	2025-10-10 20:15:32.029668	\N	\N	0	\N	2025-10-10 20:15:32.030186	2025-10-10 20:15:32.030189
2	32a032f9-f67c-42d8-a324-23d019157bbf	8	2025-10-09 04:58:37.661804	2025-10-09 04:59:51.7559	100	3	\N	2025-10-09 04:58:37.663276	2025-10-09 04:59:51.756536
3	9652f9ec-49ea-4c83-bfba-fc1e3b2cdd31	1	2025-10-09 05:48:31.481568	2025-10-09 05:49:08.34888	100	1	\N	2025-10-09 05:48:31.484559	2025-10-09 05:49:08.350064
40	006a9f87-7749-4c21-9c1e-ee28a6fe55fd	1	2025-10-10 20:14:33.514633	2025-10-10 20:15:14.075301	100	2	\N	2025-10-10 20:14:33.515157	2025-10-10 20:16:18.66181
4	9652f9ec-49ea-4c83-bfba-fc1e3b2cdd31	9	2025-10-09 05:50:49.439953	2025-10-09 05:51:42.252583	100	2	\N	2025-10-09 05:50:49.44053	2025-10-09 05:51:42.254309
5	9652f9ec-49ea-4c83-bfba-fc1e3b2cdd31	2	2025-10-09 05:54:52.552691	\N	\N	0	\N	2025-10-09 05:54:52.55443	2025-10-09 05:54:52.554433
42	006a9f87-7749-4c21-9c1e-ee28a6fe55fd	11	2025-10-10 20:18:51.730424	\N	\N	0	\N	2025-10-10 20:18:51.730865	2025-10-10 20:18:51.730867
43	6450b076-615f-4c4d-b3f9-cc549c615048	8	2025-10-10 20:51:03.162207	\N	\N	0	\N	2025-10-10 20:51:03.162705	2025-10-10 20:51:03.162707
7	9652f9ec-49ea-4c83-bfba-fc1e3b2cdd31	11	2025-10-09 21:28:16.687187	\N	\N	0	\N	2025-10-09 21:28:16.687633	2025-10-09 21:28:16.687634
8	9652f9ec-49ea-4c83-bfba-fc1e3b2cdd31	3	2025-10-09 21:44:24.543701	\N	\N	0	\N	2025-10-09 21:44:24.544099	2025-10-09 21:44:24.5441
6	9652f9ec-49ea-4c83-bfba-fc1e3b2cdd31	10	2025-10-09 21:17:04.279863	\N	\N	0	["29", "30", "31"]	2025-10-09 21:17:04.281306	2025-10-09 23:18:55.313619
44	6450b076-615f-4c4d-b3f9-cc549c615048	14	2025-10-10 20:51:20.840488	\N	\N	0	\N	2025-10-10 20:51:20.840841	2025-10-10 20:51:20.840843
45	6450b076-615f-4c4d-b3f9-cc549c615048	15	2025-10-10 20:51:32.434328	\N	\N	0	\N	2025-10-10 20:51:32.434749	2025-10-10 20:51:32.434752
9	9652f9ec-49ea-4c83-bfba-fc1e3b2cdd31	7	2025-10-09 23:19:47.813027	\N	\N	0	["20", "21", "22"]	2025-10-09 23:19:47.815301	2025-10-09 23:20:13.751112
10	937d3978-a5a4-42ff-aaab-8fdf32e3235c	1	2025-10-10 15:20:34.927843	\N	\N	0	\N	2025-10-10 15:20:34.929268	2025-10-10 15:20:34.929271
11	937d3978-a5a4-42ff-aaab-8fdf32e3235c	6	2025-10-10 15:31:02.518963	\N	\N	0	\N	2025-10-10 15:31:02.519481	2025-10-10 15:31:02.519483
12	937d3978-a5a4-42ff-aaab-8fdf32e3235c	9	2025-10-10 15:32:40.927324	\N	\N	0	\N	2025-10-10 15:32:40.927905	2025-10-10 15:32:40.927909
13	937d3978-a5a4-42ff-aaab-8fdf32e3235c	10	2025-10-10 15:33:07.93696	\N	\N	0	\N	2025-10-10 15:33:07.937466	2025-10-10 15:33:07.937469
14	937d3978-a5a4-42ff-aaab-8fdf32e3235c	11	2025-10-10 15:33:24.533228	\N	\N	0	\N	2025-10-10 15:33:24.533802	2025-10-10 15:33:24.533806
15	937d3978-a5a4-42ff-aaab-8fdf32e3235c	13	2025-10-10 15:34:45.326472	\N	\N	0	\N	2025-10-10 15:34:45.326863	2025-10-10 15:34:45.326865
16	937d3978-a5a4-42ff-aaab-8fdf32e3235c	3	2025-10-10 15:35:00.205835	\N	\N	0	\N	2025-10-10 15:35:00.206276	2025-10-10 15:35:00.206278
17	937d3978-a5a4-42ff-aaab-8fdf32e3235c	7	2025-10-10 16:46:29.531042	\N	\N	0	\N	2025-10-10 16:46:29.534061	2025-10-10 16:46:29.534064
18	937d3978-a5a4-42ff-aaab-8fdf32e3235c	2	2025-10-10 16:49:27.439461	\N	\N	0	\N	2025-10-10 16:49:27.440071	2025-10-10 16:49:27.440075
46	e1a97a68-65b4-4cbb-a8df-fb484ee205f6	7	2025-10-10 21:34:24.595991	\N	\N	0	\N	2025-10-10 21:34:24.596483	2025-10-10 21:34:24.596485
19	937d3978-a5a4-42ff-aaab-8fdf32e3235c	12	2025-10-10 16:49:37.798941	2025-10-10 16:52:56.267653	100	2	\N	2025-10-10 16:49:37.799747	2025-10-10 16:52:56.268379
20	937d3978-a5a4-42ff-aaab-8fdf32e3235c	4	2025-10-10 16:55:33.839255	\N	\N	0	\N	2025-10-10 16:55:33.839939	2025-10-10 16:55:33.839942
21	937d3978-a5a4-42ff-aaab-8fdf32e3235c	5	2025-10-10 16:55:46.25216	\N	\N	0	\N	2025-10-10 16:55:46.252721	2025-10-10 16:55:46.252723
22	57443a2f-9a90-481c-8872-d69ad93a2eef	1	2025-10-10 17:50:38.251766	\N	\N	0	\N	2025-10-10 17:50:38.253599	2025-10-10 17:50:38.253603
23	57443a2f-9a90-481c-8872-d69ad93a2eef	9	2025-10-10 17:50:54.608212	\N	\N	0	\N	2025-10-10 17:50:54.608684	2025-10-10 17:50:54.608686
24	57443a2f-9a90-481c-8872-d69ad93a2eef	10	2025-10-10 17:51:04.782536	\N	\N	0	\N	2025-10-10 17:51:04.783019	2025-10-10 17:51:04.783021
25	57443a2f-9a90-481c-8872-d69ad93a2eef	11	2025-10-10 17:51:14.392631	\N	\N	0	\N	2025-10-10 17:51:14.393044	2025-10-10 17:51:14.393046
26	57443a2f-9a90-481c-8872-d69ad93a2eef	2	2025-10-10 17:51:24.760566	\N	\N	0	\N	2025-10-10 17:51:24.760993	2025-10-10 17:51:24.760994
27	57443a2f-9a90-481c-8872-d69ad93a2eef	12	2025-10-10 17:51:34.361574	\N	\N	0	\N	2025-10-10 17:51:34.362093	2025-10-10 17:51:34.362096
28	57443a2f-9a90-481c-8872-d69ad93a2eef	3	2025-10-10 17:51:50.510293	\N	\N	0	\N	2025-10-10 17:51:50.510883	2025-10-10 17:51:50.510886
29	57443a2f-9a90-481c-8872-d69ad93a2eef	13	2025-10-10 17:51:59.682864	\N	\N	0	\N	2025-10-10 17:51:59.683394	2025-10-10 17:51:59.683396
30	57443a2f-9a90-481c-8872-d69ad93a2eef	4	2025-10-10 17:52:08.916529	\N	\N	0	\N	2025-10-10 17:52:08.917038	2025-10-10 17:52:08.917041
31	57443a2f-9a90-481c-8872-d69ad93a2eef	5	2025-10-10 17:52:19.067522	\N	\N	0	\N	2025-10-10 17:52:19.067986	2025-10-10 17:52:19.067988
32	57443a2f-9a90-481c-8872-d69ad93a2eef	6	2025-10-10 17:52:30.340799	\N	\N	0	\N	2025-10-10 17:52:30.341211	2025-10-10 17:52:30.341212
33	57443a2f-9a90-481c-8872-d69ad93a2eef	7	2025-10-10 17:52:43.522838	\N	\N	0	\N	2025-10-10 17:52:43.523469	2025-10-10 17:52:43.523473
34	49af2635-2893-47b6-aafe-d5927c5a20c5	8	2025-10-10 18:14:53.663664	2025-10-10 18:38:03.71608	100	1	\N	2025-10-10 18:14:53.666092	2025-10-10 18:38:03.717554
35	49af2635-2893-47b6-aafe-d5927c5a20c5	14	2025-10-10 18:26:53.114683	2025-10-10 18:38:49.477284	100	1	\N	2025-10-10 18:26:53.116497	2025-10-10 18:38:49.47765
36	49af2635-2893-47b6-aafe-d5927c5a20c5	15	2025-10-10 18:38:53.567902	2025-10-10 18:41:21.960321	100	2	\N	2025-10-10 18:38:53.568504	2025-10-10 18:41:21.961226
39	e1a97a68-65b4-4cbb-a8df-fb484ee205f6	10	2025-10-10 19:32:03.847401	2025-10-10 19:32:19.124391	100	3	\N	2025-10-10 19:32:03.847841	2025-10-11 05:13:04.383994
48	e1a97a68-65b4-4cbb-a8df-fb484ee205f6	5	2025-10-10 22:06:46.243402	\N	\N	0	\N	2025-10-10 22:06:46.245128	2025-10-10 22:06:46.245132
47	e1a97a68-65b4-4cbb-a8df-fb484ee205f6	11	2025-10-10 21:42:48.322838	2025-10-10 21:43:09.669501	100	1	\N	2025-10-10 21:42:48.325018	2025-10-10 21:43:09.671003
52	86a7716f-9ab3-47c5-acc1-ca44391ed79b	1	2025-10-11 18:49:37.738837	2025-10-11 18:49:57.046309	100	1	\N	2025-10-11 18:49:37.740775	2025-10-11 18:49:57.047193
49	e1a97a68-65b4-4cbb-a8df-fb484ee205f6	3	2025-10-10 22:08:56.213908	\N	33	1	\N	2025-10-10 22:08:56.214545	2025-10-10 22:11:24.962078
50	e1a97a68-65b4-4cbb-a8df-fb484ee205f6	13	2025-10-10 22:10:14.763838	\N	50	3	\N	2025-10-10 22:10:14.766677	2025-10-10 22:11:41.834604
53	86a7716f-9ab3-47c5-acc1-ca44391ed79b	9	2025-10-11 18:50:00.475845	2025-10-11 18:50:56.053846	100	1	\N	2025-10-11 18:50:00.476331	2025-10-11 18:50:56.054213
54	86a7716f-9ab3-47c5-acc1-ca44391ed79b	10	2025-10-11 18:50:59.141577	2025-10-11 18:51:21.342439	100	1	\N	2025-10-11 18:50:59.142014	2025-10-11 18:51:21.342774
51	e1a97a68-65b4-4cbb-a8df-fb484ee205f6	2	2025-10-10 22:11:58.414756	\N	0	2	\N	2025-10-10 22:11:58.417253	2025-10-10 22:12:25.096068
37	e1a97a68-65b4-4cbb-a8df-fb484ee205f6	1	2025-10-10 19:30:09.58563	2025-10-10 19:30:57.939666	100	9	["4"]	2025-10-10 19:30:09.587244	2025-10-11 05:12:26.726623
55	1244bd18-1888-4419-808c-c50c5f3dea38	14	2025-10-11 19:00:37.064964	2025-10-11 19:01:22.492488	100	1	\N	2025-10-11 19:00:37.065436	2025-10-11 19:01:22.492834
58	4d9796a7-2dad-4ad2-8a2d-ae02046c867d	9	2025-10-12 14:05:33.573776	2025-10-12 14:05:44.668564	100	1	\N	2025-10-12 14:05:33.574314	2025-10-12 14:05:44.668943
56	1244bd18-1888-4419-808c-c50c5f3dea38	15	2025-10-11 19:02:21.281714	2025-10-11 19:03:26.883717	100	2	\N	2025-10-11 19:02:21.282097	2025-10-11 19:03:26.884013
57	4d9796a7-2dad-4ad2-8a2d-ae02046c867d	1	2025-10-12 14:05:14.435647	2025-10-12 14:05:29.854852	100	1	\N	2025-10-12 14:05:14.436834	2025-10-12 14:05:29.855913
59	4d9796a7-2dad-4ad2-8a2d-ae02046c867d	10	2025-10-12 14:05:47.59769	2025-10-12 14:05:55.842774	100	1	\N	2025-10-12 14:05:47.598195	2025-10-12 14:05:55.843203
60	31cb937d-a657-4703-8522-aec17fb5c2eb	1	2025-10-13 03:13:04.576634	2025-10-13 03:15:19.415953	100	1	\N	2025-10-13 03:13:04.577898	2025-10-13 03:15:19.416833
61	31cb937d-a657-4703-8522-aec17fb5c2eb	9	2025-10-13 03:15:31.107523	2025-10-13 03:16:09.216289	100	1	\N	2025-10-13 03:15:31.108026	2025-10-13 03:16:09.216815
62	31cb937d-a657-4703-8522-aec17fb5c2eb	10	2025-10-13 03:16:18.331705	2025-10-13 03:16:46.655503	100	1	\N	2025-10-13 03:16:18.332291	2025-10-13 03:16:46.655822
63	31cb937d-a657-4703-8522-aec17fb5c2eb	8	2025-10-13 03:41:14.489805	2025-10-13 03:41:44.203878	100	1	\N	2025-10-13 03:41:14.490374	2025-10-13 03:41:44.204226
64	31cb937d-a657-4703-8522-aec17fb5c2eb	14	2025-10-13 03:41:54.048705	2025-10-13 03:42:36.243871	100	1	\N	2025-10-13 03:41:54.049161	2025-10-13 03:42:36.244369
65	31cb937d-a657-4703-8522-aec17fb5c2eb	15	2025-10-13 03:42:46.014581	2025-10-13 03:43:28.496092	100	1	\N	2025-10-13 03:42:46.015137	2025-10-13 03:43:28.496415
66	578dc22b-1920-4d79-93cc-7318c91064e6	8	2025-10-14 19:40:10.645363	\N	50	1	["23", "24"]	2025-10-14 19:40:10.647228	2025-10-14 19:40:41.533455
67	578dc22b-1920-4d79-93cc-7318c91064e6	14	2025-10-14 19:40:47.777025	\N	\N	0	\N	2025-10-14 19:40:47.777702	2025-10-14 19:40:47.777706
68	1f44891f-dc47-49ee-8397-c4b144a2b25c	8	2025-11-18 05:47:16.32987	\N	\N	0	\N	2025-11-18 05:47:16.330968	2025-11-18 05:47:16.33097
69	90d204fc-2ac3-4ce5-9818-21dd1a74e518	1	2025-11-18 18:40:44.916227	\N	\N	0	\N	2025-11-18 18:40:44.917623	2025-11-18 18:40:44.917627
70	90d204fc-2ac3-4ce5-9818-21dd1a74e518	9	2025-11-18 18:42:22.379157	\N	\N	0	\N	2025-11-18 18:42:22.37987	2025-11-18 18:42:22.379874
71	90d204fc-2ac3-4ce5-9818-21dd1a74e518	10	2025-11-18 18:42:36.343701	\N	\N	0	\N	2025-11-18 18:42:36.344194	2025-11-18 18:42:36.344196
72	90d204fc-2ac3-4ce5-9818-21dd1a74e518	11	2025-11-18 18:43:20.439527	\N	\N	0	\N	2025-11-18 18:43:20.440077	2025-11-18 18:43:20.44008
73	90d204fc-2ac3-4ce5-9818-21dd1a74e518	2	2025-11-18 18:43:48.172118	\N	\N	0	\N	2025-11-18 18:43:48.17264	2025-11-18 18:43:48.172642
74	90d204fc-2ac3-4ce5-9818-21dd1a74e518	12	2025-11-18 18:44:14.945112	\N	\N	0	\N	2025-11-18 18:44:14.945637	2025-11-18 18:44:14.945639
75	90d204fc-2ac3-4ce5-9818-21dd1a74e518	3	2025-11-18 18:44:58.434147	\N	\N	0	\N	2025-11-18 18:44:58.435089	2025-11-18 18:44:58.435094
77	4c327dc2-679d-46ec-8e66-4212767b6c35	2	2025-11-20 01:46:05.631899	\N	\N	0	\N	2025-11-20 01:46:05.632742	2025-11-20 01:46:05.632746
78	8778494d-3e52-43f0-be5f-9c415cb68a99	10	2025-11-20 01:54:27.233744	\N	\N	0	\N	2025-11-20 01:54:27.234227	2025-11-20 01:54:27.234229
79	8778494d-3e52-43f0-be5f-9c415cb68a99	1	2025-11-20 01:54:42.858159	\N	\N	0	\N	2025-11-20 01:54:42.858807	2025-11-20 01:54:42.858811
80	8778494d-3e52-43f0-be5f-9c415cb68a99	9	2025-11-20 01:54:57.009569	\N	\N	0	\N	2025-11-20 01:54:57.010233	2025-11-20 01:54:57.010237
81	8778494d-3e52-43f0-be5f-9c415cb68a99	11	2025-11-20 01:55:18.03297	\N	\N	0	\N	2025-11-20 01:55:18.033489	2025-11-20 01:55:18.033491
82	8778494d-3e52-43f0-be5f-9c415cb68a99	4	2025-11-20 01:55:30.864492	\N	\N	0	\N	2025-11-20 01:55:30.865358	2025-11-20 01:55:30.865368
83	8778494d-3e52-43f0-be5f-9c415cb68a99	5	2025-11-20 01:55:52.287613	\N	\N	0	\N	2025-11-20 01:55:52.288128	2025-11-20 01:55:52.28813
84	5574664e-3aae-4f58-87e0-4998ec83ef81	8	2025-11-20 02:48:06.64214	\N	\N	0	\N	2025-11-20 02:48:06.645559	2025-11-20 02:48:06.645564
85	4c327dc2-679d-46ec-8e66-4212767b6c35	13	2025-11-20 04:17:50.59965	\N	\N	0	\N	2025-11-20 04:17:50.601571	2025-11-20 04:17:50.601574
86	df37b342-6042-4094-a77e-6b5cb452e272	1	2025-11-20 15:43:48.422332	\N	\N	0	\N	2025-11-20 15:43:48.423861	2025-11-20 15:43:48.423866
87	df37b342-6042-4094-a77e-6b5cb452e272	9	2025-11-20 15:44:16.198122	\N	\N	0	\N	2025-11-20 15:44:16.198657	2025-11-20 15:44:16.19866
88	4c327dc2-679d-46ec-8e66-4212767b6c35	9	2025-11-21 04:25:30.33836	2025-11-21 04:26:31.139839	100	1	\N	2025-11-21 04:25:30.340158	2025-11-21 04:26:31.140273
89	4c327dc2-679d-46ec-8e66-4212767b6c35	10	2025-11-21 04:26:34.045592	\N	\N	0	\N	2025-11-21 04:26:34.046108	2025-11-21 04:26:34.04611
90	4c327dc2-679d-46ec-8e66-4212767b6c35	11	2025-11-21 04:27:20.869644	\N	\N	0	\N	2025-11-21 04:27:20.870181	2025-11-21 04:27:20.870183
91	4c327dc2-679d-46ec-8e66-4212767b6c35	5	2025-11-21 04:27:36.646166	\N	\N	0	\N	2025-11-21 04:27:36.646729	2025-11-21 04:27:36.646732
92	4c327dc2-679d-46ec-8e66-4212767b6c35	7	2025-11-21 04:28:01.341259	\N	\N	0	\N	2025-11-21 04:28:01.341773	2025-11-21 04:28:01.341775
93	d33b031f-277d-45af-839d-f371a33d5d5a	14	2025-11-21 16:24:25.437175	\N	\N	0	\N	2025-11-21 16:24:25.438762	2025-11-21 16:24:25.438765
76	4c327dc2-679d-46ec-8e66-4212767b6c35	1	2025-11-20 01:45:11.798552	2025-11-21 04:25:27.07325	100	2	\N	2025-11-20 01:45:11.800437	2025-11-21 17:23:21.252658
94	45e24578-7a60-43ca-b356-072cba779da1	1	2025-12-29 23:23:58.716246	2025-12-29 23:24:32.000072	100	1	\N	2025-12-29 23:23:58.717413	2025-12-29 23:24:32.000996
95	45e24578-7a60-43ca-b356-072cba779da1	9	2025-12-29 23:24:35.703943	\N	\N	0	\N	2025-12-29 23:24:35.704584	2025-12-29 23:24:35.704589
96	45e24578-7a60-43ca-b356-072cba779da1	8	2025-12-29 23:50:14.064046	\N	\N	0	\N	2025-12-29 23:50:14.064803	2025-12-29 23:50:14.064808
97	45e24578-7a60-43ca-b356-072cba779da1	15	2025-12-29 23:50:34.089542	\N	\N	0	\N	2025-12-29 23:50:34.09015	2025-12-29 23:50:34.090154
98	7eb560f8-fd1e-48e2-bdbc-e331d0b7c049	1	2026-01-01 17:35:49.239336	\N	\N	0	\N	2026-01-01 17:35:49.241845	2026-01-01 17:35:49.241849
99	7eb560f8-fd1e-48e2-bdbc-e331d0b7c049	9	2026-01-01 18:18:18.852599	\N	\N	0	\N	2026-01-01 18:18:18.85361	2026-01-01 18:18:18.853615
100	7eb560f8-fd1e-48e2-bdbc-e331d0b7c049	10	2026-01-01 18:18:33.749027	\N	\N	0	\N	2026-01-01 18:18:33.749602	2026-01-01 18:18:33.749605
101	7eb560f8-fd1e-48e2-bdbc-e331d0b7c049	11	2026-01-01 18:18:53.902058	\N	\N	0	\N	2026-01-01 18:18:53.902603	2026-01-01 18:18:53.902605
102	7eb560f8-fd1e-48e2-bdbc-e331d0b7c049	2	2026-01-01 18:18:59.804708	\N	\N	0	\N	2026-01-01 18:18:59.805281	2026-01-01 18:18:59.805284
103	7eb560f8-fd1e-48e2-bdbc-e331d0b7c049	12	2026-01-01 18:19:28.891672	\N	\N	0	\N	2026-01-01 18:19:28.892136	2026-01-01 18:19:28.892138
104	7eb560f8-fd1e-48e2-bdbc-e331d0b7c049	7	2026-01-01 18:20:20.421468	\N	\N	0	\N	2026-01-01 18:20:20.422054	2026-01-01 18:20:20.422057
105	ef951063-e7ce-4ede-aab1-8b78f5297249	1	2026-03-05 05:06:55.348824	\N	\N	0	\N	2026-03-05 05:06:55.349669	2026-03-05 05:06:55.349671
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, first_name, last_name, profile_image_url, age, height, weight, contact_number, emergency_contact, medical_history, created_at, updated_at, password_hash, is_active, last_login, user_role, onboarding_completed, data_consent, research_consent, consent_timestamp, goals, menstrual_status, current_medications, constraints, devices_available, family_relation, family_involvement, font_size, high_contrast, captions_enabled, text_to_speech, reminder_enabled, reminder_time, reminder_timezone, last_reminder_shown) FROM stdin;
doc-001	dr.priya@example.com	Priya	Sharma	\N	\N	\N	\N	\N	\N	\N	2025-09-25 19:19:47.494103	2025-09-25 19:19:47.494103	\N	t	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	medium	f	f	f	f	\N	\N	\N
doc-002	dr.anita@example.com	Anita	Reddy	\N	\N	\N	\N	\N	\N	\N	2025-09-25 19:19:47.494103	2025-09-25 19:19:47.494103	\N	t	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	medium	f	f	f	f	\N	\N	\N
doc-003	dr.kavya@example.com	Kavya	Nair	\N	\N	\N	\N	\N	\N	\N	2025-09-25 19:19:47.494103	2025-09-25 19:19:47.494103	\N	t	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	medium	f	f	f	f	\N	\N	\N
doc-004	dr.meera@example.com	Meera	Patel	\N	\N	\N	\N	\N	\N	\N	2025-09-25 19:19:47.494103	2025-09-25 19:19:47.494103	\N	t	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	medium	f	f	f	f	\N	\N	\N
doc-005	dr.sunitha@example.com	Sunitha	Kumar	\N	\N	\N	\N	\N	\N	\N	2025-09-25 19:19:47.494103	2025-09-25 19:19:47.494103	\N	t	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	medium	f	f	f	f	\N	\N	\N
7d378161-2361-473d-9dea-0bc9c7d88eda	chinniv@gmail.com	chinni	v	\N	\N	\N	\N	\N	\N	\N	2025-10-10 22:17:20.26136	2025-10-12 14:56:42.83302	scrypt:32768:8:1$QdM79yTaoKvduQ8Z$137c1a6dabdfd8d5ccc3ad8f59e9ef2661119ca417c3baa5d62afce76ff0429b03de0cb1b3079a9bbcf22af51893df98bcb1c25feaff1e8ba1d9abe996ea75e6	t	2025-10-12 14:56:42.832064	family_member	t	t	f	2025-10-10 22:17:32.900816	\N	\N	\N	\N	\N	sibling	["coach"]	medium	f	f	f	f	\N	\N	\N
9652f9ec-49ea-4c83-bfba-fc1e3b2cdd31	tilothamanunna@gmail.com	k	t	\N	27	\N	\N	\N	\N	\N	2025-10-09 05:45:50.84863	2025-10-09 20:12:29.537369	scrypt:32768:8:1$bX9BGml3ZI5CGHD6$6c35f617696d3525e6b9be8d8180f80bf08a35fc0d3ad37ae4dd6d678d92c3a3b596325b97bc9f373855cd0b07e8088d3a4eee3fae77a526f6686a1640be55db	t	2025-10-09 20:12:29.535075	pcos_user	t	t	f	2025-10-09 05:47:52.597914	[]	regular		{"time": "", "equipment": "", "culture_diet": ""}	[]	\N	\N	medium	f	f	t	f	\N	\N	\N
006a9f87-7749-4c21-9c1e-ee28a6fe55fd	Ammala@gmail.com	Ammala	k	\N	20	\N	\N	\N	\N	\N	2025-10-10 20:07:52.643507	2025-10-10 20:12:41.896378	scrypt:32768:8:1$CHtMD88LsE3NpTsh$aa19f194bea5f95b003456a9c1dcf07c13067ad389fabdefe48d2e0b95e53263ba875371cdea443f6921c28b385b404d76f4b6d1351669724bb5f0ab7f3e1e6b	t	\N	pcos_user	t	t	f	2025-10-10 20:09:05.483779	["symptom_control", "weight"]	regular		{"time": "", "equipment": "", "culture_diet": ""}	[]	\N	\N	large	f	f	f	f	\N	\N	\N
49af2635-2893-47b6-aafe-d5927c5a20c5	aca@gmail.com	ac	a	\N	\N	\N	\N	\N	\N	\N	2025-10-10 18:13:31.776355	2025-10-10 18:14:38.554241	scrypt:32768:8:1$AU72NfgPdKjjikkw$99c4f3b0664c7f4153d697189c2a0b35180d8f0b6e2fdf85f9d1cb6fc635f63095181b1b44c84fe09aaba9da7ce44c5bb70b8518cbe7cd0ef02b7c340bc05b47	t	\N	family_member	t	t	f	2025-10-10 18:14:11.299001	\N	\N	\N	\N	\N	sibling	["learn", "coach", "plan_meals", "encourage_activity"]	large	f	t	t	f	\N	\N	\N
32a032f9-f67c-42d8-a324-23d019157bbf	tilothamanunna7@gmail.com	T	T	\N	\N	\N	\N	\N	\N	\N	2025-10-09 04:51:46.775132	2025-10-09 04:54:03.94116	scrypt:32768:8:1$vJOGUKvzsyTekHul$3b863dfeaaa009489604fc0ef9c425cef96d22f78caf53316963ef6c241841bca27c1be37a1531cd4edf71a61867dc3fac84c47397a93069d9f52b371b3b4049	t	\N	family_member	t	t	f	2025-10-09 04:53:14.143802	\N	\N	\N	\N	\N	sibling	[]	medium	f	f	t	f	\N	\N	\N
937d3978-a5a4-42ff-aaab-8fdf32e3235c	Mahi@gmail.com	Mahi	M	\N	20	\N	\N	\N	\N	\N	2025-10-10 15:16:45.112825	2025-10-10 15:19:15.310113	scrypt:32768:8:1$db1xSkVqvTlVm9CO$5a554df3406312518dc6658f8a57c04f306c4db0dbe60ffd8d6d064f443b5b7e9853f5e5f0e6714297d96c82430bec58b55e3c8eb143927c57c8f3ccb1df910c	t	\N	pcos_user	t	t	f	2025-10-10 15:17:47.040247	["symptom_control", "weight"]	regular	Nothing	{"time": "30min", "equipment": "No", "culture_diet": "veg"}	["fitness_tracker"]	\N	\N	large	f	t	t	f	\N	\N	\N
31cb937d-a657-4703-8522-aec17fb5c2eb	Siri@gmail.com	Siri	A	\N	25	160	48	\N	\N	\N	2025-10-13 03:08:37.367321	2025-10-13 03:40:27.180905	scrypt:32768:8:1$XWFFYlbPbQxO2sta$0ab9939d42767e03aa0bda5f72a5f6fbe151928ebff8b8ae96d7569a70c09211162ffec1a2ac6d1dd2bd984f2dc11bee202869bf74dcdcf75d4c656f79282804	t	\N	family_member	t	t	f	2025-10-13 03:11:27.239883	["symptom_control", "weight", "mood"]	regular		{"time": "", "equipment": "", "culture_diet": ""}	[]	\N	\N	medium	f	f	f	f	\N	\N	\N
1244bd18-1888-4419-808c-c50c5f3dea38	tilothamanunna70@gmail.com	T	N	\N	23	160	48	1234567890	9123443216	no	2025-09-25 19:11:55.191412	2025-10-11 19:44:31.189794	scrypt:32768:8:1$flq6IQUkrCo1zsSA$c843270658646a7c18120a8813c0db9493dc19b3ce45f7c065a0f2fa96e94cbd9c537df988d0b921d78a90dca3474993568e069a1cd1789537ddffe1c5a1e93a	t	2025-10-11 19:28:27.131893	pcos_user	t	t	f	2025-10-09 04:20:37.498612	["weight"]	regular		{"time": "", "equipment": "", "culture_diet": ""}	[]	sibling	["learn"]	medium	f	f	f	f	\N	\N	\N
e1a97a68-65b4-4cbb-a8df-fb484ee205f6	amala@gmail.com	amala	a	\N	27	170	48	\N	\N	\N	2025-10-10 19:28:32.516655	2025-10-13 16:15:17.385242	scrypt:32768:8:1$c1ru6sBPrN9uzEH5$bca70075d9bfdb8e95691e3224e022105f9466b82ce1b350f9f2170dbfa19d18ccfe3ec5068d315a8c75b56307cfa04b04f6369f72d754d3d7d0760dac7d64f7	t	2025-10-13 16:14:49.326662	family_member	t	t	f	2025-10-10 19:28:49.248765	["fertility"]	absent	NA	{"time": "", "equipment": "", "culture_diet": ""}	["smart_scale"]	\N	\N	large	f	f	f	f	\N	\N	\N
57443a2f-9a90-481c-8872-d69ad93a2eef	akki@gmail.com	akki	c	\N	40	\N	\N	\N	\N	\N	2025-10-10 17:47:37.616518	2025-10-10 17:48:33.079081	scrypt:32768:8:1$a9NV44eochJZl85L$e5e4cd459fc0930afacd0ff2cfcb1447e31df86739dfb1d3bc46d44d2d404289aff7cca0db5ce64998600d7b908e470157a551ecb068263df570138765c26d6f	t	\N	pcos_user	t	t	f	2025-10-10 17:48:00.473149	["weight"]	irregular		{"time": "", "equipment": "", "culture_diet": ""}	["smart_scale"]	\N	\N	extra_large	f	t	t	f	\N	\N	\N
eed33b0c-db0f-41f7-b12c-d720eb90e3ea	amala1@gmai.com	Amala	a	\N	\N	\N	\N	\N	\N	\N	2025-10-12 15:18:02.908209	2025-10-12 15:19:11.982578	scrypt:32768:8:1$mBPsp1XM10pRKwkH$7633b5f2e95f9d792bb3cdc8c0df15ac417a9a841d0d91f3eab98d381d978ccae23f6c1644d30bb88daf5323d2175ff8744dfbe6e73da5b2ebdc871b0e4109f8	t	\N	family_member	t	t	f	2025-10-12 15:18:46.751422	\N	\N	\N	\N	\N	sibling	[]	medium	f	f	f	f	\N	\N	\N
6450b076-615f-4c4d-b3f9-cc549c615048	Chinni@gmail.com	Chinni	c	\N	\N	\N	\N	\N	\N	\N	2025-10-10 20:49:10.443904	2025-10-10 20:50:40.846278	scrypt:32768:8:1$iAIANveIgoo6oEZj$2cc414550f473ea8abc2cade409fb11055aeec89f6740e89f7514413a5b0fdbdd41e7285b1420a5edc13e207000badfa8f52e27d92e2b7302deaf1ccf61da4b1	t	\N	family_member	t	t	f	2025-10-10 20:50:02.71159	\N	\N	\N	\N	\N	sibling	[]	medium	f	f	f	f	\N	\N	\N
86a7716f-9ab3-47c5-acc1-ca44391ed79b	Tilun123@gmail.com	Tilu	N	\N	20	162	40	\N	\N	\N	2025-10-11 18:48:22.517594	2025-10-11 18:59:17.109037	scrypt:32768:8:1$UW0ft5M3YTIWHUIt$5b4edd33f0ed7485e1899ea5875ce5bdf06ca34662a81240822180f3c7c4ba008d441bf18ed15a49d84d0e58f40906977c35ebff367438576558e51975e20a03	t	\N	pcos_user	t	t	f	2025-10-11 18:48:41.93568	["symptom_control", "weight", "mood"]	regular		{"time": "", "equipment": "", "culture_diet": ""}	[]	\N	\N	large	f	f	f	f	\N	\N	\N
4d9796a7-2dad-4ad2-8a2d-ae02046c867d	Mahima@gmail.com	Mahima	M	\N	29	\N	\N	\N	\N	\N	2025-10-12 14:02:25.650199	2025-10-12 14:38:43.141609	scrypt:32768:8:1$WBjL8DAXvD6qVbbr$8d3b41136b6cee0dd79a68f873202197a58249c6d8a4ce69388c88110fe469ed1f2066ad581dc025c564b3f771c851aacf5a31b5f180066dc8c9dd09cfabdd13	t	\N	family_member	t	t	t	2025-10-12 14:03:59.085031	["symptom_control"]	irregular		{"time": "", "equipment": "", "culture_diet": ""}	[]	\N	\N	large	f	f	f	f	\N	\N	\N
e8e9bab0-676f-419e-95b3-f60f6b1fa78b	chinniv1@gmail.com	chinni	v	\N	27	\N	\N	\N	\N	\N	2025-10-13 16:20:43.991025	2025-10-13 16:21:31.718696	scrypt:32768:8:1$zCigmGLMMzhMubca$8cff21ea7e276a1b8ed0ee0153f6afe1f0ab934d0061da5ca960fb1b1cc0a40645bb4b5a0690bfa81315825f31146c737254034397ddbd4c09bd6a0d7635ca7a	t	\N	pcos_user	t	t	f	2025-10-13 16:21:15.947065	[]	regular		{"time": "", "equipment": "", "culture_diet": ""}	[]	\N	\N	medium	f	f	f	f	\N	\N	\N
bfbdcc3a-bf5a-411d-b72c-e87d0a623b1b	mahi1@gmail.com	Mahi	m	\N	\N	\N	\N	\N	\N	\N	2025-10-12 14:41:34.364399	2025-10-12 14:44:41.525052	scrypt:32768:8:1$H0JBon3WAbsgkAYa$97c4c357a8d460e0b3216744c4a4a8148e3f0e0c18309b79fb309ec9645a68f69314660debdbb29537b4bfb048e385651b1c0f5fc4ecf706421c873ad89596be	t	\N	family_member	t	t	f	2025-10-12 14:41:45.274286	\N	\N	\N	\N	\N	sibling	[]	medium	f	f	f	f	\N	\N	\N
4a797d4a-42e4-455b-ab30-d7b96d72e751	nk@gmail.com	n	k	\N	\N	\N	\N	\N	\N	\N	2025-10-13 18:07:55.688548	2025-10-15 05:29:20.365823	scrypt:32768:8:1$k7CaBl9ATkNVhA6J$027d583a6a89441f3fd754f7122e08187cd624d6cc9f5be9ed9d64f33236812872c8e896f8a54dfb4a4b8cab033b219f2e2a3307016098a56e266c5cf2fb2fd8	t	2025-10-15 05:18:18.479712	pcos_user	t	t	f	2025-10-13 18:08:35.908187	\N	\N	\N	\N	\N	sibling	[]	medium	f	f	f	f	\N	\N	\N
24b303b9-0b38-48c4-90d4-3531afb72e3e	km@gmail.com	k	m	\N	20	170	48	\N	\N	\N	2025-10-13 18:06:40.668274	2025-10-17 14:49:36.877956	scrypt:32768:8:1$oF9VN80UWg7M7LGe$597def508f5c0b97089bd5671ff87b51b4a2c044acf5937d0519362794330879e1e741cf28b6ffb024b2da77ed230385ab5c524859bcb4a0c70d7487accfaf39	t	2025-10-17 14:49:36.876066	family_member	t	t	f	2025-10-13 18:11:07.137415	[]	irregular		{"time": "", "equipment": "", "culture_diet": ""}	[]	\N	\N	medium	f	f	f	f	\N	\N	\N
578dc22b-1920-4d79-93cc-7318c91064e6	thrinathrt@gmail.com	Thrinath	R	\N	\N	\N	\N	\N	\N	\N	2025-10-14 19:39:05.913562	2025-10-14 19:39:59.476508	scrypt:32768:8:1$DZoMg0wP2IqNCx7h$895aac019e01cb230a9cef2c44b5ed26394762b237925358af532a9e1abd4ab89933ea5e9a9d0bdee71a07ccecaf9631b3277b5638ae9770e4d63c09a6e26a4e	t	\N	family_member	t	t	t	2025-10-14 19:39:36.461759	\N	\N	\N	\N	\N	sibling	["learn", "coach"]	medium	f	f	f	f	\N	\N	\N
d1acd91c-cc3e-4564-81a9-b6876a6511ee	n123@gmail.com	T	N	\N	\N	\N	\N	\N	\N	\N	2025-11-20 01:53:11.816434	2025-11-20 01:53:11.816444	scrypt:32768:8:1$ZLNs19R14xH2AXqB$f69a160dcb6267fc6051749a875266ea176ae8696a43b00e61ec6d23e655ddda228196525e5b281ec91baf03aabcc72edd2c88110a5c78e1a23710da6e098144	t	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	medium	f	f	f	f	\N	\N	\N
90d204fc-2ac3-4ce5-9818-21dd1a74e518	pmulgund@mmemphis.edu	Pavankumar	Mulgund	\N	21	\N	\N	\N	\N	\N	2025-11-18 18:38:12.130377	2025-11-18 18:39:55.829157	scrypt:32768:8:1$bxc1alQboUZKTg8U$b7939f30d8ae606454d6ff27cabeb9ade82a319609af3cb6db1606d780916e9a4eddb757b7236dfbfddec65c690dc777f0e506fbbbc7bdc6dd948ec7b7397541	t	\N	pcos_user	t	t	f	2025-11-18 18:38:49.581404	["symptom_control", "fertility", "weight", "mood"]	not_tracking		{"time": "", "equipment": "", "culture_diet": ""}	[]	\N	\N	medium	f	f	f	f	\N	\N	\N
c435b83e-41fb-405f-b1e7-0811c56f89b4	ch@gmail.com	ch	c	\N	28	160	40	\N	\N	\N	2025-10-14 20:06:00.047101	2025-10-14 20:13:14.189086	scrypt:32768:8:1$SjEsoKscNBjwD1iO$3637a15ffe7955c8de1aff1c7edcdfbf5f8c63599f027215d29860fec2fdb4f59d8115f143cca94e2b8be71bcabe3253326560423888b7f7876e8d2c3cb924b3	t	\N	pcos_user	t	t	f	2025-10-14 20:11:28.424408	[]	regular		{"time": "", "equipment": "", "culture_diet": ""}	[]	\N	\N	extra_large	f	f	f	f	\N	\N	\N
46685628-4d9f-477a-acc8-c89d5fd25fac	tilu@123	Tilu	N	\N	\N	\N	\N	\N	\N	\N	2025-11-17 04:36:26.69052	2025-11-17 04:36:52.817002	scrypt:32768:8:1$lUupAMi4Ky73EbzV$f2e9bba28cfd450a1ebb31f1a08fb37079eea6e2aed433cbe7636acd632d7a74c66e9260230760513111116d181f19fcbc001bd2d937790a0176deedcb53ff81	t	\N	pcos_user	f	t	t	2025-11-17 04:36:52.813912	\N	\N	\N	\N	\N	\N	\N	medium	f	f	f	f	\N	\N	\N
9e7fcc5a-636e-4364-99d4-7d2b8852d973	yasasreeyasu@gmail.com	R Yasasree	Rayal cheruvu	\N	\N	\N	\N	\N	\N	\N	2025-11-20 05:31:03.943637	2025-11-20 05:31:03.943648	scrypt:32768:8:1$WIqfhPC25fopEaZJ$7892109a3679f99464a9868c635ac5bed639c4c571c18ac35ee72527396cf9c35e2498d2450d3ae559c717c6c049dda1bb2d720bf72f41a3f9206a94af26ccf7	t	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	medium	f	f	f	f	\N	\N	\N
58e72b9c-1cae-46a5-bb35-08ab34bdc12c	sarah.demo@example.com	Sarah	Community	\N	\N	\N	\N	\N	\N	\N	2025-11-20 23:35:41.090401	2025-11-20 23:35:41.090401	scrypt:32768:8:1$4udsmfyc2V2k3ltI$ee0ed809a623950edc0cd418edb861bd129541e7d16698ff428a8788588bec8a99bb0d4c85c2559a56e113f36214a3122565009b43779e15aa5a90b1c056387f	t	\N	pcos_user	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	medium	f	f	f	f	\N	\N	\N
e716a9bb-4444-48f7-bf73-fd34d8edc984	vasundharakadiyala123@gmail.com	Vasundhara	Kadiyala	\N	25	152	42	9390952459	\N	\N	2025-11-18 05:22:38.892955	2025-11-18 05:27:19.650175	scrypt:32768:8:1$2vze6NWTcQScDusJ$a0ca19fcc45a6d87fc616e221640a7f6712c57bb365fd716ea7d19b6d7cd84aa6ba771402b48fbe1ce70802eda3218a18b71976bdcf1745be2fd624b77ecacc6	t	\N	pcos_user	t	t	t	2025-11-18 05:23:13.412045	["weight"]	regular		{"time": "", "equipment": "", "culture_diet": ""}	[]	\N	\N	medium	f	f	f	f	\N	\N	\N
46cea6ca-b492-425a-bf9e-639621b429e0	rekha123@gmail.com	Rekha	Vaitla	\N	30	\N	\N	\N	\N	\N	2025-11-18 05:07:41.709694	2025-11-18 05:09:45.270937	scrypt:32768:8:1$7EXcb3fYTc7jLFOY$4731b1eb42ac92cac056c30115a855bf03af8fe357d74f0fd9e9e43a4c93290f8ac494e6fae17557f2b0d3b566d3351f32549e5a866886299ddb2b310d855e3a	t	\N	pcos_user	t	t	t	2025-11-18 05:08:19.108755	["weight", "mood"]	irregular	Other	{"time": "30mins", "equipment": "Home workouts ", "culture_diet": "Vegetarian "}	["smart_scale", "apple_health"]	\N	\N	medium	f	f	f	f	\N	\N	\N
5574664e-3aae-4f58-87e0-4998ec83ef81	thrinathsachin10@gmail.com	Thrinath	RT	\N	\N	\N	\N	\N	\N	\N	2025-11-20 02:45:34.514126	2025-11-20 02:47:57.182315	scrypt:32768:8:1$4QCO3PX1CcenZDCB$6732df1450b99427a9e6881685a65a08a69ad4d084a112fabfee56a97c12f2218364e23d546b9bed17394d8c75bd8b539ae3d6b1ed55c1a1aa7e060e388b4ea2	t	\N	family_member	t	t	t	2025-11-20 02:47:32.927404	\N	\N	\N	\N	\N	sibling	["learn", "coach", "plan_meals", "encourage_activity"]	medium	f	f	f	f	\N	\N	\N
017876ef-d67a-4120-a14e-21aba11a30f8	n@123	T	N	\N	24	\N	\N	\N	\N	\N	2025-11-19 02:22:51.225638	2025-11-19 02:26:50.677377	scrypt:32768:8:1$rrA0nQ81hFMyByQ1$c8955ad5d181d25acd2a056593ae89d7b63504c82936f61a7827c0727b5053efdabfd7c206f6fbbd97542ce6454e46a80ac3658d8e6b5d4622c6cfedcd9b0ea2	t	\N	pcos_user	t	t	t	2025-11-19 02:26:18.705915	[]	not_tracking		{"time": "", "equipment": "", "culture_diet": ""}	[]	\N	\N	medium	f	f	f	f	\N	\N	\N
1f44891f-dc47-49ee-8397-c4b144a2b25c	shivanivudugula2000@gmail.com	Shivani 	Vudugula 	\N	\N	\N	\N	\N	\N	\N	2025-11-18 05:17:08.014979	2025-11-18 05:47:04.61468	scrypt:32768:8:1$eowpZlYt3OYixSTF$62afd3d57e63b12bb28a95f2fe4510e084b52ccb11fbf1e2a6d32043e23c8f46cccd309d47fd90eea8a8f7b6f6892bf9f20b48a0ee5dee3c37b7b7b65e94c6ee	t	\N	family_member	t	t	f	2025-11-18 05:20:45.420947	\N	\N	\N	\N	\N	friend	["learn", "coach", "plan_meals", "encourage_activity"]	medium	f	f	f	f	\N	\N	\N
63154ff3-80ed-4704-bbfa-3fbcb8a9430f	t@123	Tilu	N	\N	27	\N	\N	\N	\N	\N	2025-11-18 05:12:23.25427	2025-11-18 05:58:10.702426	scrypt:32768:8:1$OkWrirt7gMiEa463$c6ce3d341208d96e6311e71caec21714266f3004ef6b1cf137786f3ecaa63280d29340b2137f2585e6820815a064c586102c0fb9c628be499f36c2df5313f1ce	t	2025-11-18 05:55:34.84204	family_member	t	t	t	2025-11-18 05:12:34.656669	[]	regular		{"time": "", "equipment": "", "culture_diet": ""}	[]	\N	\N	medium	f	f	f	f	\N	\N	\N
8778494d-3e52-43f0-be5f-9c415cb68a99	t123@mail.com	T	N	\N	28	\N	\N	\N	\N	\N	2025-11-20 01:53:55.647314	2025-11-20 01:54:19.25312	scrypt:32768:8:1$ft1abVajZomtWOps$4309d06cdc106ab1bcf0e7ccf3e7814bb7837b19e25e3cc4946726fbbd1ae218e69bd77191d4477a6a0f32af43b8880f604ad977db308bd04d97bb2ad6aeed61	t	\N	pcos_user	t	t	t	2025-11-20 01:54:07.141345	[]	not_tracking		{"time": "", "equipment": "", "culture_diet": ""}	[]	\N	\N	medium	f	f	f	f	\N	\N	\N
7035b183-33d4-44d6-b1f9-38cbb7dd0e36	test@cystasense.com	Test	User	\N	\N	\N	\N	\N	\N	\N	2025-11-20 03:17:07.206971	2025-11-20 03:17:07.206977	scrypt:32768:8:1$klInxtbr2QA076yd$91477bc2595953c7da195c57887ae9e5e53b3e7c33fc40b6bc2c6d36d4d891ceccff52b923c2ce17293863a5f857b304270e5a0b195da69f23f6d7c077dbc4c4	t	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	medium	f	f	f	f	\N	\N	\N
133a8a18-eed8-4025-a1e7-91d4edb12bc2	mw48@gmail.com	maria	smith	\N	\N	\N	\N	\N	\N	\N	2025-11-20 15:12:56.907366	2025-11-20 15:12:56.907376	scrypt:32768:8:1$JNvWDhmmgwFL9eUz$93ed1defb79ff6d18a7a2744705bc6f5976281426ab44aa532197686a6c51b89ac6034a7ec7d8cdb3efefb6b1db28ac179a0c8737a7395be369c06eca9336447	t	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N	\N	\N	medium	f	f	f	f	\N	\N	\N
df37b342-6042-4094-a77e-6b5cb452e272	mw484$@gmail.com	maria	smith	\N	45	\N	\N	\N	\N	\N	2025-11-20 15:14:09.628832	2025-11-20 15:59:56.877641	scrypt:32768:8:1$bfvP1l70k2jQwGE1$7dd6858b82c611d55f1a2f3437405a63c9a7fd6c531945c84cc44dd028de6b4169f9b053000f607f00bc6cf57e4721734169370478b4cdf7336278c9f743ea48	t	\N	family_member	t	t	t	2025-11-20 15:15:08.740717	[]	regular		{"time": "", "equipment": "", "culture_diet": ""}	[]	\N	\N	medium	f	f	f	t	09:00	America/Chicago	\N
d33b031f-277d-45af-839d-f371a33d5d5a	ntfam123@gmail.com	n	t	\N	\N	\N	\N	\N	\N	\N	2025-11-20 21:43:41.514847	2025-11-21 16:24:00.443979	scrypt:32768:8:1$EGnHqLHxEgMpoTNs$225b52269b9f30086078df751219d0f5e10d0774926709b8058e643974bb5a7a1301715740b48292be99a397a63c20c33537b5a5feec8c7149750cf608d9dbbb	t	2025-11-21 16:24:00.441416	family_member	t	t	t	2025-11-20 21:43:55.817219	\N	\N	\N	\N	\N	parent	[]	medium	f	f	f	f	\N	\N	\N
d92802b5-d322-40ca-bfd0-4a66eeca7534	priya.demo@example.com	Priya	Community	\N	\N	\N	\N	\N	\N	\N	2025-11-20 23:35:41.50427	2025-11-20 23:35:41.50427	scrypt:32768:8:1$Vl2WdJvXKP5YZvt0$abfe161bfdaf2dfe21a612967f7c3623db32d429eba25609af46c4916f9639361d6266a4de8f8c0c4b247635ff4d92ad0a6105af7343f8b79f5e7314587ee839	t	\N	pcos_user	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	medium	f	f	f	f	\N	\N	\N
9446cc89-0de1-48b1-acb6-2db877d79eec	maya.demo@example.com	Maya	Community	\N	\N	\N	\N	\N	\N	\N	2025-11-20 23:35:41.973936	2025-11-20 23:35:41.973936	scrypt:32768:8:1$MVriG4jpyWYihJPr$96682c62a380c587e9d6061dbeb41462cb199efb8286b2de9829363a72fb656ebb3e7d3229b91d627f38ef50ca9a8af301a197b3038450aeeb440e2d4efe818b	t	\N	pcos_user	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	medium	f	f	f	f	\N	\N	\N
4d2f858e-092c-46d5-be3d-43477ea1e723	emma.demo@example.com	Emma	Community	\N	\N	\N	\N	\N	\N	\N	2025-11-20 23:35:42.432742	2025-11-20 23:35:42.432742	scrypt:32768:8:1$fSoRExkZn3rgOo06$97f0127667f2274f219660c44575e33ba43e49d26b8d9475749a12fa2049eee374953f33c3029cdce650783c9076f7a8fee4cb83e1c18f55f10059183c113741	t	\N	pcos_user	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	medium	f	f	f	f	\N	\N	\N
41fd03f2-f23a-4e31-bb82-790cdd5fbe70	jasmine.demo@example.com	Jasmine	Community	\N	\N	\N	\N	\N	\N	\N	2025-11-20 23:35:42.89586	2025-11-20 23:35:42.89586	scrypt:32768:8:1$TJyPCeoyGJIqTzlM$59db8fe2780e4870f4da87e8c81e448216db931518f34e3fa77be66b2a80fa5f27d384aaaad0b4f271415492da6dd75c3dfb62950cd2482a0970764a081e995d	t	\N	pcos_user	t	f	f	\N	\N	\N	\N	\N	\N	\N	\N	medium	f	f	f	f	\N	\N	\N
45e24578-7a60-43ca-b356-072cba779da1	tnunna@gmail.com	tnunna	nunna	\N	27	\N	\N	\N	\N	\N	2025-12-29 23:22:25.143427	2025-12-29 23:49:35.772838	scrypt:32768:8:1$l67psvNMYlLieYm9$64fae123fb2e19731d7b654c8168963b3ed295fb699ab26c1dfd419dd94a216a4f729e96cf9c435ea42a24bfa8562cc2d5055421d07722dde673f1d8aa5b5643	t	\N	family_member	t	t	f	2025-12-29 23:22:51.095014	[]	not_tracking		{"time": "", "equipment": "", "culture_diet": ""}	[]	\N	\N	medium	f	f	f	f	\N	\N	\N
709dac6b-ade7-4e42-bd33-8dad433131e4	tilu12@gmail.com	tnunna	nunna	\N	27	\N	\N	\N	\N	\N	2025-12-29 23:56:23.641086	2025-12-30 00:01:22.669113	scrypt:32768:8:1$kBUUdNbNuD6XsRM2$a611d8708dc871e68725da5560858b6b2b6d43704ad682f497359bc6709805d7fc99e91763894fb6c74625758b185a1b78bcd0e6c778d2e7f6414cf8ed30b754	t	2025-12-30 00:01:22.668406	pcos_user	t	t	f	2025-12-29 23:56:38.24354	[]	irregular		{"time": "", "equipment": "", "culture_diet": ""}	[]	\N	\N	medium	f	f	f	f	\N	\N	\N
03f94b21-d8ba-46ce-8244-13e34eaa24c4	tilu123@gmail.com	tilu	nunna	\N	\N	\N	\N	\N	\N	\N	2025-12-29 23:53:17.059599	2025-12-30 00:02:02.144491	scrypt:32768:8:1$3Jvc4PlHzQypQJwn$2145fafaef3e7902c1d8a9acfc58e08c79d40958089e371072251831079bbaec1bf1ee53813b13aa186d4abf5ed9a9d760e7f291742fd9736b7a83de02967197	t	2025-12-30 00:02:02.143812	pcos_user	t	t	f	2025-12-29 23:53:32.812906	\N	\N	\N	\N	\N	sibling	[]	medium	f	f	f	f	\N	\N	\N
dd592cff-ce60-4992-aa23-7995ae1014ce	TilothamaM@gmail.com	tilothama	Nunna	\N	\N	\N	\N	\N	\N	\N	2025-11-21 17:15:45.525079	2025-11-21 17:59:59.805312	scrypt:32768:8:1$yhfjxYF1SGB8yIm9$c8b101a225a46d2e73557640c0264c4e02527d096e3c8eaa323c610d6d797ba27f65c3e573fcba82d1efb34ca7077954953d19be6554d94f249bbdbcb780d10a	t	2025-11-21 17:59:59.804569	family_member	t	t	t	2025-11-21 17:16:42.516448	\N	\N	\N	\N	\N	parent	[]	medium	f	f	f	f	\N	\N	\N
7eb560f8-fd1e-48e2-bdbc-e331d0b7c049	priyaragh22@gmail.com	Priya	Ragh	\N	28	\N	\N	\N	\N	\N	2025-12-30 00:09:49.637049	2026-01-27 20:14:06.810782	scrypt:32768:8:1$UHwE0jSoHnB9rWbr$357168068c113529002edb47703d03aa97685ca683db73c6c813502d4742082dd9b6c02c939be52296f6dfd05911012e1649a9917782d768e1c5d7890d5baf85	t	2026-01-27 20:14:06.80876	pcos_user	t	t	f	2026-01-01 17:34:18.169707	["weight", "mood"]	regular		{"time": "45 mins a day", "equipment": "", "culture_diet": ""}	["fitness_tracker"]	\N	\N	extra_large	t	f	f	f	\N	\N	\N
ef951063-e7ce-4ede-aab1-8b78f5297249	t1@gmail.com	t	tilu	\N	22	\N	\N	\N	\N	\N	2026-03-05 05:05:50.240065	2026-03-05 05:06:31.981941	scrypt:32768:8:1$ORcYR6hAVFUUXDT8$58eaadffaca059c9152b7aa92f1382053ffa57acb379022bd0e8bc43756399c077a9614c38abe90c020e65877b0fcd817999b6063470954117935b97221ad406	t	\N	pcos_user	t	t	t	2026-03-05 05:06:12.042733	[]	regular		{"time": "", "equipment": "", "culture_diet": ""}	[]	\N	\N	medium	f	f	f	f	\N	\N	\N
4c327dc2-679d-46ec-8e66-4212767b6c35	t123@gmail.com	n	t	\N	29	164.6	50	\N	\N	\N	2025-11-20 01:44:21.448378	2026-03-13 18:17:15.943685	scrypt:32768:8:1$9hNbXyTgjIF6gLMx$1a5694b920077025dc25eee738a800e41f62c07656255201ce3ace6ccc60a61cc341d092af3a370cc58cf44c081b88e5e99d8352e5c663d9ad8a702dc4e4e805	t	2026-03-13 18:17:15.941893	pcos_user	t	t	t	2025-11-20 01:44:35.210505	[]	not_tracking		{"time": "", "equipment": "", "culture_diet": ""}	[]	\N	\N	medium	f	f	f	t	00:57	Europe/London	\N
\.


--
-- Name: appointments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appointments_id_seq', 1, true);


--
-- Name: badges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.badges_id_seq', 12, true);


--
-- Name: contact_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contact_messages_id_seq', 2, true);


--
-- Name: daily_motivations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.daily_motivations_id_seq', 30, true);


--
-- Name: diet_plans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.diet_plans_id_seq', 14, true);


--
-- Name: doctor_profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.doctor_profiles_id_seq', 5, true);


--
-- Name: educational_content_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.educational_content_id_seq', 3, true);


--
-- Name: educational_tracks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.educational_tracks_id_seq', 8, true);


--
-- Name: exercise_plans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.exercise_plans_id_seq', 9, true);


--
-- Name: family_connections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.family_connections_id_seq', 11, true);


--
-- Name: flask_dance_oauth_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.flask_dance_oauth_id_seq', 1, false);


--
-- Name: forum_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.forum_categories_id_seq', 9, true);


--
-- Name: forum_post_views_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.forum_post_views_id_seq', 41, true);


--
-- Name: forum_posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.forum_posts_id_seq', 46, true);


--
-- Name: forum_reactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.forum_reactions_id_seq', 12, true);


--
-- Name: forum_replies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.forum_replies_id_seq', 59, true);


--
-- Name: lesson_actions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lesson_actions_id_seq', 56, true);


--
-- Name: lesson_quizzes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lesson_quizzes_id_seq', 15, true);


--
-- Name: lessons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lessons_id_seq', 15, true);


--
-- Name: menstrual_cycles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.menstrual_cycles_id_seq', 19, true);


--
-- Name: message_reactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.message_reactions_id_seq', 3, true);


--
-- Name: nudges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nudges_id_seq', 11, true);


--
-- Name: quiz_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quiz_questions_id_seq', 34, true);


--
-- Name: quiz_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quiz_results_id_seq', 1, true);


--
-- Name: reminders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reminders_id_seq', 16, true);


--
-- Name: sent_nudges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sent_nudges_id_seq', 18, true);


--
-- Name: shared_goals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shared_goals_id_seq', 1, false);


--
-- Name: symptom_tracker_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.symptom_tracker_id_seq', 53, true);


--
-- Name: user_badges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_badges_id_seq', 1, false);


--
-- Name: user_lesson_progress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_lesson_progress_id_seq', 105, true);


--
-- Name: appointments appointments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (id);


--
-- Name: badges badges_badge_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.badges
    ADD CONSTRAINT badges_badge_name_key UNIQUE (badge_name);


--
-- Name: badges badges_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.badges
    ADD CONSTRAINT badges_pkey PRIMARY KEY (id);


--
-- Name: contact_messages contact_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_messages
    ADD CONSTRAINT contact_messages_pkey PRIMARY KEY (id);


--
-- Name: daily_motivations daily_motivations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.daily_motivations
    ADD CONSTRAINT daily_motivations_pkey PRIMARY KEY (id);


--
-- Name: diet_plans diet_plans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diet_plans
    ADD CONSTRAINT diet_plans_pkey PRIMARY KEY (id);


--
-- Name: doctor_profiles doctor_profiles_medical_license_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor_profiles
    ADD CONSTRAINT doctor_profiles_medical_license_number_key UNIQUE (medical_license_number);


--
-- Name: doctor_profiles doctor_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor_profiles
    ADD CONSTRAINT doctor_profiles_pkey PRIMARY KEY (id);


--
-- Name: educational_content educational_content_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educational_content
    ADD CONSTRAINT educational_content_pkey PRIMARY KEY (id);


--
-- Name: educational_tracks educational_tracks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educational_tracks
    ADD CONSTRAINT educational_tracks_pkey PRIMARY KEY (id);


--
-- Name: exercise_plans exercise_plans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercise_plans
    ADD CONSTRAINT exercise_plans_pkey PRIMARY KEY (id);


--
-- Name: family_connections family_connections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_connections
    ADD CONSTRAINT family_connections_pkey PRIMARY KEY (id);


--
-- Name: flask_dance_oauth flask_dance_oauth_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flask_dance_oauth
    ADD CONSTRAINT flask_dance_oauth_pkey PRIMARY KEY (id);


--
-- Name: forum_categories forum_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_categories
    ADD CONSTRAINT forum_categories_pkey PRIMARY KEY (id);


--
-- Name: forum_post_views forum_post_views_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_post_views
    ADD CONSTRAINT forum_post_views_pkey PRIMARY KEY (id);


--
-- Name: forum_posts forum_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_posts
    ADD CONSTRAINT forum_posts_pkey PRIMARY KEY (id);


--
-- Name: forum_reactions forum_reactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_reactions
    ADD CONSTRAINT forum_reactions_pkey PRIMARY KEY (id);


--
-- Name: forum_replies forum_replies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_replies
    ADD CONSTRAINT forum_replies_pkey PRIMARY KEY (id);


--
-- Name: lesson_actions lesson_actions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_actions
    ADD CONSTRAINT lesson_actions_pkey PRIMARY KEY (id);


--
-- Name: lesson_quizzes lesson_quizzes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_quizzes
    ADD CONSTRAINT lesson_quizzes_pkey PRIMARY KEY (id);


--
-- Name: lessons lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);


--
-- Name: menstrual_cycles menstrual_cycles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menstrual_cycles
    ADD CONSTRAINT menstrual_cycles_pkey PRIMARY KEY (id);


--
-- Name: message_reactions message_reactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message_reactions
    ADD CONSTRAINT message_reactions_pkey PRIMARY KEY (id);


--
-- Name: nudges nudges_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nudges
    ADD CONSTRAINT nudges_pkey PRIMARY KEY (id);


--
-- Name: quiz_questions quiz_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_questions
    ADD CONSTRAINT quiz_questions_pkey PRIMARY KEY (id);


--
-- Name: quiz_results quiz_results_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_results
    ADD CONSTRAINT quiz_results_pkey PRIMARY KEY (id);


--
-- Name: reminders reminders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reminders
    ADD CONSTRAINT reminders_pkey PRIMARY KEY (id);


--
-- Name: sent_nudges sent_nudges_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sent_nudges
    ADD CONSTRAINT sent_nudges_pkey PRIMARY KEY (id);


--
-- Name: shared_goals shared_goals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shared_goals
    ADD CONSTRAINT shared_goals_pkey PRIMARY KEY (id);


--
-- Name: symptom_tracker symptom_tracker_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.symptom_tracker
    ADD CONSTRAINT symptom_tracker_pkey PRIMARY KEY (id);


--
-- Name: forum_post_views unique_session_post_view; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_post_views
    ADD CONSTRAINT unique_session_post_view UNIQUE (post_id, session_id);


--
-- Name: message_reactions unique_user_message_reaction; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message_reactions
    ADD CONSTRAINT unique_user_message_reaction UNIQUE (message_id, user_id);


--
-- Name: forum_reactions unique_user_post_reaction; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_reactions
    ADD CONSTRAINT unique_user_post_reaction UNIQUE (post_id, user_id);


--
-- Name: forum_post_views unique_user_post_view; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_post_views
    ADD CONSTRAINT unique_user_post_view UNIQUE (post_id, user_id);


--
-- Name: forum_reactions unique_user_reply_reaction; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_reactions
    ADD CONSTRAINT unique_user_reply_reaction UNIQUE (reply_id, user_id);


--
-- Name: flask_dance_oauth uq_user_browser_session_key_provider; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flask_dance_oauth
    ADD CONSTRAINT uq_user_browser_session_key_provider UNIQUE (user_id, browser_session_key, provider);


--
-- Name: user_badges user_badges_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_badges
    ADD CONSTRAINT user_badges_pkey PRIMARY KEY (id);


--
-- Name: user_lesson_progress user_lesson_progress_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_lesson_progress
    ADD CONSTRAINT user_lesson_progress_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_family_connections_member; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_family_connections_member ON public.family_connections USING btree (family_member_id, connection_status);


--
-- Name: idx_family_connections_primary; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_family_connections_primary ON public.family_connections USING btree (primary_user_id, connection_status);


--
-- Name: idx_forum_posts_category; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_forum_posts_category ON public.forum_posts USING btree (category_id, created_at DESC);


--
-- Name: idx_forum_posts_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_forum_posts_user ON public.forum_posts USING btree (user_id);


--
-- Name: idx_forum_replies_post; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_forum_replies_post ON public.forum_replies USING btree (post_id, created_at DESC);


--
-- Name: idx_lesson_progress_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_lesson_progress_user ON public.user_lesson_progress USING btree (user_id, lesson_id);


--
-- Name: idx_menstrual_cycle_user_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_menstrual_cycle_user_date ON public.menstrual_cycles USING btree (user_id, start_date DESC);


--
-- Name: idx_reminders_user_completed; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reminders_user_completed ON public.reminders USING btree (user_id, is_completed);


--
-- Name: idx_sent_nudges_recipient_read; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sent_nudges_recipient_read ON public.sent_nudges USING btree (recipient_id, is_read);


--
-- Name: idx_symptom_tracker_user_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_symptom_tracker_user_date ON public.symptom_tracker USING btree (user_id, date DESC);


--
-- Name: idx_users_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_email ON public.users USING btree (lower((email)::text));


--
-- Name: appointments appointments_doctor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES public.users(id);


--
-- Name: appointments appointments_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.users(id);


--
-- Name: badges badges_track_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.badges
    ADD CONSTRAINT badges_track_id_fkey FOREIGN KEY (track_id) REFERENCES public.educational_tracks(id);


--
-- Name: diet_plans diet_plans_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diet_plans
    ADD CONSTRAINT diet_plans_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: doctor_profiles doctor_profiles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor_profiles
    ADD CONSTRAINT doctor_profiles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: exercise_plans exercise_plans_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercise_plans
    ADD CONSTRAINT exercise_plans_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: family_connections family_connections_family_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_connections
    ADD CONSTRAINT family_connections_family_member_id_fkey FOREIGN KEY (family_member_id) REFERENCES public.users(id);


--
-- Name: family_connections family_connections_primary_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_connections
    ADD CONSTRAINT family_connections_primary_user_id_fkey FOREIGN KEY (primary_user_id) REFERENCES public.users(id);


--
-- Name: flask_dance_oauth flask_dance_oauth_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flask_dance_oauth
    ADD CONSTRAINT flask_dance_oauth_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: forum_post_views forum_post_views_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_post_views
    ADD CONSTRAINT forum_post_views_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.forum_posts(id);


--
-- Name: forum_post_views forum_post_views_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_post_views
    ADD CONSTRAINT forum_post_views_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: forum_posts forum_posts_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_posts
    ADD CONSTRAINT forum_posts_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.forum_categories(id);


--
-- Name: forum_posts forum_posts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_posts
    ADD CONSTRAINT forum_posts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: forum_reactions forum_reactions_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_reactions
    ADD CONSTRAINT forum_reactions_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.forum_posts(id);


--
-- Name: forum_reactions forum_reactions_reply_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_reactions
    ADD CONSTRAINT forum_reactions_reply_id_fkey FOREIGN KEY (reply_id) REFERENCES public.forum_replies(id);


--
-- Name: forum_reactions forum_reactions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_reactions
    ADD CONSTRAINT forum_reactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: forum_replies forum_replies_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_replies
    ADD CONSTRAINT forum_replies_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.forum_posts(id);


--
-- Name: forum_replies forum_replies_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_replies
    ADD CONSTRAINT forum_replies_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: lesson_actions lesson_actions_lesson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_actions
    ADD CONSTRAINT lesson_actions_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lessons(id);


--
-- Name: lesson_quizzes lesson_quizzes_lesson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lesson_quizzes
    ADD CONSTRAINT lesson_quizzes_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lessons(id);


--
-- Name: lessons lessons_track_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_track_id_fkey FOREIGN KEY (track_id) REFERENCES public.educational_tracks(id);


--
-- Name: menstrual_cycles menstrual_cycles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menstrual_cycles
    ADD CONSTRAINT menstrual_cycles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: message_reactions message_reactions_message_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message_reactions
    ADD CONSTRAINT message_reactions_message_id_fkey FOREIGN KEY (message_id) REFERENCES public.sent_nudges(id);


--
-- Name: message_reactions message_reactions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message_reactions
    ADD CONSTRAINT message_reactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: quiz_questions quiz_questions_quiz_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_questions
    ADD CONSTRAINT quiz_questions_quiz_id_fkey FOREIGN KEY (quiz_id) REFERENCES public.lesson_quizzes(id);


--
-- Name: quiz_results quiz_results_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_results
    ADD CONSTRAINT quiz_results_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: reminders reminders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reminders
    ADD CONSTRAINT reminders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: sent_nudges sent_nudges_connection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sent_nudges
    ADD CONSTRAINT sent_nudges_connection_id_fkey FOREIGN KEY (connection_id) REFERENCES public.family_connections(id);


--
-- Name: sent_nudges sent_nudges_nudge_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sent_nudges
    ADD CONSTRAINT sent_nudges_nudge_id_fkey FOREIGN KEY (nudge_id) REFERENCES public.nudges(id);


--
-- Name: sent_nudges sent_nudges_recipient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sent_nudges
    ADD CONSTRAINT sent_nudges_recipient_id_fkey FOREIGN KEY (recipient_id) REFERENCES public.users(id);


--
-- Name: sent_nudges sent_nudges_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sent_nudges
    ADD CONSTRAINT sent_nudges_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(id);


--
-- Name: shared_goals shared_goals_connection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shared_goals
    ADD CONSTRAINT shared_goals_connection_id_fkey FOREIGN KEY (connection_id) REFERENCES public.family_connections(id);


--
-- Name: symptom_tracker symptom_tracker_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.symptom_tracker
    ADD CONSTRAINT symptom_tracker_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: user_badges user_badges_badge_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_badges
    ADD CONSTRAINT user_badges_badge_id_fkey FOREIGN KEY (badge_id) REFERENCES public.badges(id);


--
-- Name: user_badges user_badges_lesson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_badges
    ADD CONSTRAINT user_badges_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lessons(id);


--
-- Name: user_badges user_badges_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_badges
    ADD CONSTRAINT user_badges_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: user_lesson_progress user_lesson_progress_lesson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_lesson_progress
    ADD CONSTRAINT user_lesson_progress_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lessons(id);


--
-- Name: user_lesson_progress user_lesson_progress_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_lesson_progress
    ADD CONSTRAINT user_lesson_progress_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

\unrestrict hwaIKiwb3DRTKPaofOacuEFqTim3BmTusDhH0frM2mBymgCRNkN2UmxeSTeDm7n

