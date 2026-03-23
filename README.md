# CystaSense - Women's Health Management Platform

CystaSense is a comprehensive web application designed to help women manage Polycystic Ovary Syndrome (PCOS/PCOD). The platform provides symptom tracking, educational learning tracks, diet planning, community forums, AI health assistance, and family support tools.

---

## Features

- Symptom & cycle tracking with 5-level health score analytics
- Educational learning tracks (7 PCOS tracks + Family Support course)
- AI-powered PCOS health assistant (OpenAI)
- Community forum with categories, reactions, and replies
- Family support system with permission-based data sharing
- Doctor directory and appointment booking
- Diet, exercise, and medication reminders
- Role-based access (PCOS user / Family supporter)

---

## Prerequisites

Make sure the following are installed on your machine before starting:

- **Python 3.11 or higher** — [Download Python](https://www.python.org/downloads/)
- **pip** — usually comes bundled with Python
- **Git** — [Download Git](https://git-scm.com/downloads/)
- **PostgreSQL** *(optional)* — only needed if you prefer PostgreSQL over the default SQLite database

---

## Quick Start Options

Choose your preferred database:

- **🚀 Quick Start (SQLite)** - Continue with steps below for instant setup
- **💾 PostgreSQL Setup** - See [POSTGRES_SETUP.md](POSTGRES_SETUP.md) for detailed PostgreSQL configuration and how to use your SQL dump file

---

## Step-by-Step Local Setup

### Step 1: Clone the Repository

```bash
git clone <your-repository-url>
cd cystasense
```

Replace `<your-repository-url>` with the actual URL of this repository.

---

### Step 2: Create a Virtual Environment

Creating a virtual environment keeps dependencies isolated from your system Python.

```bash
python -m venv venv
```

Activate it:

- **On macOS/Linux:**
  ```bash
  source venv/bin/activate
  ```

- **On Windows:**
  ```bash
  venv\Scripts\activate
  ```

You should now see `(venv)` at the start of your terminal prompt.

---

### Step 3: Install Dependencies

```bash
pip install -r requirements.txt
```

This installs Flask, SQLAlchemy, OpenAI, and all other required packages.

---

### Step 4: Set Up Environment Variables

Copy the example environment file and configure it:

```bash
cp .env.example .env
```

Edit the `.env` file and set your configuration:

```env
# Required — used to sign sessions and cookies. Use any long random string.
SESSION_SECRET=your_super_secret_key_here

# Optional — defaults to SQLite if not set (recommended for local development)
# For PostgreSQL use: postgresql://username:password@localhost:5432/cystasense
DATABASE_URL=

# Optional — required only for the AI Health Assistant feature
OPENAI_API_KEY=your_openai_api_key_here

# Optional — set to 'development' to enable debug mode and verbose logging
FLASK_ENV=development
```

> **Tip:** To generate a strong `SESSION_SECRET`, run this in your terminal:
> ```bash
> python -c "import secrets; print(secrets.token_hex(32))"
> ```
> Copy the output and paste it as the value for `SESSION_SECRET`.

> **PostgreSQL Users:** See [POSTGRES_SETUP.md](POSTGRES_SETUP.md) for detailed instructions on using your SQL dump file with PostgreSQL.

---

### Step 5: Load Environment Variables

Install `python-dotenv` to automatically load the `.env` file:

```bash
pip install python-dotenv
```

Then, before running the app, export the variables:

- **On macOS/Linux:**
  ```bash
  export $(cat .env | xargs)
  ```

- **On Windows (Command Prompt):**
  ```cmd
  for /f "tokens=*" %i in (.env) do set %i
  ```

- **On Windows (PowerShell):**
  ```powershell
  Get-Content .env | ForEach-Object { $name, $value = $_ -split '=', 2; [System.Environment]::SetEnvironmentVariable($name, $value) }
  ```

---

### Step 6: Set Up the Database

The application creates all database tables automatically on first launch. No manual migration step is needed.

**Using SQLite (default — recommended for local development):**

No setup required. A file called `pcod_app.db` will be created automatically in the project root when you first run the app.

**Using PostgreSQL with your SQL dump file:**

For detailed instructions on setting up PostgreSQL and loading your `dump.sql` file, see **[POSTGRES_SETUP.md](POSTGRES_SETUP.md)**.

Quick summary:
1. Install PostgreSQL
2. Create a database: `CREATE DATABASE cystasense;`
3. Load your dump file: `./load_database.sh` or `psql -U postgres -d cystasense -f dump.sql`
4. Set your `DATABASE_URL` in `.env`:
   ```env
   DATABASE_URL=postgresql://your_username:your_password@localhost:5432/cystasense
   ```
5. Verify connection: `python verify_db.py`

---

### Step 7: Run the Application

```bash
python main.py
```

You should see output similar to:

```
 * Running on http://0.0.0.0:5000
 * Debug mode: on
```

Open your browser and go to:

```
http://localhost:5000
```

---

## Project Structure

```
cystasense/
├── app.py                  # Flask app setup, DB config, security headers
├── main.py                 # Entry point — runs the Flask development server
├── models.py               # SQLAlchemy database models
├── routes.py               # All URL routes and view logic
├── replit_auth.py          # Replit OAuth integration (Replit platform only)
├── chatbot.py              # AI Health Assistant logic (OpenAI)
├── pcos_knowledge_base.py  # Curated PCOS knowledge for the AI assistant
├── content_moderation.py   # Forum content moderation
├── seed_forum_posts.py     # Script to seed sample forum data
├── seed_motivations.py     # Script to seed motivation messages
├── requirements.txt        # Python dependencies
├── pyproject.toml          # Project metadata and dependency specs
├── assets/                 # Static files (images, CSS, JS)
└── templates/              # Jinja2 HTML templates
```

---

## Optional: Seed Sample Data

To pre-populate the forum with sample posts, run:

```bash
python seed_forum_posts.py
```

To add daily motivation messages:

```bash
python seed_motivations.py
```

---

## Environment Variables Reference

| Variable | Required | Description |
|---|---|---|
| `SESSION_SECRET` | Yes | Secret key for signing Flask sessions |
| `DATABASE_URL` | No | Database connection string. Defaults to SQLite |
| `OPENAI_API_KEY` | No | Enables the AI Health Assistant feature |
| `FLASK_ENV` | No | Set to `development` for debug mode |

---

## Notes

- The **Replit OAuth login** feature only works when the app is deployed on the Replit platform. On local, use the standard email/password registration and login instead.
- The **AI Health Assistant** requires a valid `OPENAI_API_KEY`. Without it, the chatbot feature will not work.
- SQLite is perfectly fine for local development. Switch to PostgreSQL for production deployments.
- The app binds to `0.0.0.0:5000` by default, making it accessible from all network interfaces.

---

## Troubleshooting

**`ValueError: SESSION_SECRET environment variable must be set`**
- You have not set the `SESSION_SECRET` variable. Follow Step 4 above.

**`ModuleNotFoundError`**
- Make sure your virtual environment is activated and you have run `pip install -r requirements.txt`.

**Database errors on first run**
- This is usually because tables have not been created yet. The app creates them automatically — simply restart and visit any page other than the homepage.

**Port 5000 already in use**
- Kill the process using port 5000 or change the port in `main.py` from `5000` to another number like `5001`.
