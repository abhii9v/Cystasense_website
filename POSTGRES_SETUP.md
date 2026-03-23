# PostgreSQL Database Setup Guide

This guide will help you set up PostgreSQL and use your SQL dump file as the database for CystaSense.

## Prerequisites

- PostgreSQL 12 or higher installed
- Python 3.11+ with all project dependencies
- The `dump.sql` file (included in the repository)

## Quick Setup Steps

### 1. Install PostgreSQL

#### On Ubuntu/Debian:
```bash
sudo apt update
sudo apt install postgresql postgresql-contrib
```

#### On macOS (using Homebrew):
```bash
brew install postgresql@16
brew services start postgresql@16
```

#### On Windows:
Download and install from [PostgreSQL.org](https://www.postgresql.org/download/windows/)

### 2. Create Database and User

Open PostgreSQL command line:
```bash
sudo -u postgres psql
```

Or on macOS/Windows:
```bash
psql postgres
```

Run the following SQL commands:
```sql
-- Create a new database
CREATE DATABASE cystasense;

-- Create a user (optional, you can use the default postgres user)
CREATE USER cystasense_user WITH PASSWORD 'your_secure_password';

-- Grant privileges
GRANT ALL PRIVILEGES ON DATABASE cystasense TO cystasense_user;

-- Exit psql
\q
```

### 3. Load Your SQL Dump

Use the provided script to load your database:

```bash
# Make the script executable
chmod +x load_database.sh

# Run the script
./load_database.sh
```

Or load it manually:

```bash
# Using default postgres user
psql -U postgres -d cystasense -f dump.sql

# Or using custom user
psql -U cystasense_user -d cystasense -f dump.sql
```

If you encounter password prompts, you can also use:
```bash
PGPASSWORD=your_password psql -U cystasense_user -d cystasense -f dump.sql
```

### 4. Configure Environment Variables

Create a `.env` file in the project root (or copy from `.env.example`):

```bash
cp .env.example .env
```

Edit the `.env` file and set your database connection:

```env
# Required session secret
SESSION_SECRET=your_generated_secret_key_here

# PostgreSQL connection string
# Format: postgresql://username:password@host:port/database
DATABASE_URL=postgresql://cystasense_user:your_secure_password@localhost:5432/cystasense

# Optional: OpenAI API key for AI features
OPENAI_API_KEY=your_openai_api_key

# Flask environment
FLASK_ENV=development
```

**Generate a secure SESSION_SECRET:**
```bash
python -c "import secrets; print(secrets.token_hex(32))"
```

### 5. Verify the Setup

Test the database connection:
```bash
python verify_db.py
```

Or run the application:
```bash
python main.py
```

Visit `http://localhost:5000` in your browser.

## Troubleshooting

### Connection Refused
**Problem:** `psql: error: connection to server on socket ... failed`

**Solution:**
- Ensure PostgreSQL service is running:
  ```bash
  # On Ubuntu/Debian
  sudo systemctl status postgresql
  sudo systemctl start postgresql

  # On macOS
  brew services list
  brew services start postgresql@16
  ```

### Authentication Failed
**Problem:** `FATAL: password authentication failed for user`

**Solution:**
- Verify your credentials in the DATABASE_URL
- Check PostgreSQL's `pg_hba.conf` file for authentication settings
- Reset password if needed:
  ```sql
  ALTER USER cystasense_user WITH PASSWORD 'new_password';
  ```

### Database Already Exists
**Problem:** `ERROR: database "cystasense" already exists`

**Solution:** This is fine! Skip database creation and proceed to load the dump.

### Permission Denied on Tables
**Problem:** `ERROR: permission denied for table`

**Solution:**
```bash
psql -U postgres -d cystasense
```
Then run:
```sql
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO cystasense_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO cystasense_user;
```

### SQL Dump Load Errors
**Problem:** Errors while loading dump.sql

**Solution:**
1. Check if the dump file is for the correct PostgreSQL version
2. Try loading with more verbose output:
   ```bash
   psql -U postgres -d cystasense -f dump.sql -v ON_ERROR_STOP=1
   ```
3. If tables already exist, drop and recreate:
   ```sql
   DROP DATABASE cystasense;
   CREATE DATABASE cystasense;
   ```

### Flask App Can't Connect
**Problem:** Application starts but shows database errors

**Solution:**
1. Verify DATABASE_URL in .env is correct
2. Test connection string:
   ```python
   python -c "from sqlalchemy import create_engine; engine = create_engine('your_database_url'); print(engine.connect())"
   ```
3. Ensure psycopg2-binary is installed:
   ```bash
   pip install psycopg2-binary
   ```

## Advanced Configuration

### Using Environment Variables (no .env file)

Set variables directly in your shell:

**Linux/macOS:**
```bash
export SESSION_SECRET="your_secret_key"
export DATABASE_URL="postgresql://user:pass@localhost:5432/cystasense"
export OPENAI_API_KEY="your_api_key"
python main.py
```

**Windows (Command Prompt):**
```cmd
set SESSION_SECRET=your_secret_key
set DATABASE_URL=postgresql://user:pass@localhost:5432/cystasense
set OPENAI_API_KEY=your_api_key
python main.py
```

### Remote PostgreSQL Server

If your PostgreSQL is on a remote server:

```env
DATABASE_URL=postgresql://username:password@remote-host.com:5432/cystasense
```

Ensure:
- PostgreSQL accepts remote connections (`listen_addresses` in postgresql.conf)
- Firewall allows connections on port 5432
- `pg_hba.conf` allows your IP address

### Connection Pooling

For production deployments, you can adjust connection pool settings:

```env
SQLALCHEMY_POOL_SIZE=10
SQLALCHEMY_MAX_OVERFLOW=20
SQLALCHEMY_POOL_TIMEOUT=30
```

### SSL/TLS Connection

For secure connections (recommended for remote databases):

```env
DATABASE_URL=postgresql://user:pass@host:5432/cystasense?sslmode=require
```

## Database Backup

To backup your database later:

```bash
# Backup to file
pg_dump -U cystasense_user -d cystasense > backup_$(date +%Y%m%d).sql

# Or with postgres user
pg_dump -U postgres -d cystasense > backup_$(date +%Y%m%d).sql
```

## Migration from SQLite

If you're currently using SQLite and want to migrate to PostgreSQL:

1. Export your current SQLite data (if any)
2. Set up PostgreSQL as described above
3. Load the dump.sql file
4. Update your DATABASE_URL in .env
5. Restart the application

## Support

For more information:
- PostgreSQL Documentation: https://www.postgresql.org/docs/
- SQLAlchemy Documentation: https://docs.sqlalchemy.org/
- Flask-SQLAlchemy: https://flask-sqlalchemy.palletsprojects.com/

If you encounter issues not covered here, please check the main [README.md](README.md) or open an issue on GitHub.
