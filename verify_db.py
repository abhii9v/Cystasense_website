"""
Database connection verification script for CystaSense
This script tests the PostgreSQL connection and displays database information.
"""

import os
import sys
from dotenv import load_dotenv

def verify_database():
    """Verify database connection and display information"""

    # Load environment variables
    load_dotenv()

    database_url = os.environ.get("DATABASE_URL")

    if not database_url:
        print("❌ ERROR: DATABASE_URL environment variable is not set!")
        print("\nPlease set your DATABASE_URL in the .env file:")
        print("DATABASE_URL=postgresql://user:password@localhost:5432/cystasense")
        return False

    print("=" * 60)
    print("CystaSense Database Connection Verification")
    print("=" * 60)
    print()

    # Hide password in output
    safe_url = database_url
    if '@' in database_url:
        parts = database_url.split('@')
        if '://' in parts[0]:
            protocol, creds = parts[0].split('://')
            if ':' in creds:
                user = creds.split(':')[0]
                safe_url = f"{protocol}://{user}:****@{parts[1]}"

    print(f"📊 Database URL: {safe_url}")
    print()

    # Try to connect
    try:
        from sqlalchemy import create_engine, text

        print("🔌 Attempting to connect to database...")
        engine = create_engine(database_url)

        with engine.connect() as connection:
            print("✅ Connection successful!")
            print()

            # Get database version
            result = connection.execute(text("SELECT version()"))
            version = result.fetchone()[0]
            print(f"📦 PostgreSQL Version:")
            print(f"   {version.split(',')[0]}")
            print()

            # Get database name
            result = connection.execute(text("SELECT current_database()"))
            db_name = result.fetchone()[0]
            print(f"🗄️  Current Database: {db_name}")
            print()

            # Check if tables exist
            result = connection.execute(text("""
                SELECT COUNT(*)
                FROM information_schema.tables
                WHERE table_schema = 'public'
            """))
            table_count = result.fetchone()[0]
            print(f"📋 Tables in database: {table_count}")

            if table_count > 0:
                print()
                print("📑 Sample tables:")
                result = connection.execute(text("""
                    SELECT table_name
                    FROM information_schema.tables
                    WHERE table_schema = 'public'
                    ORDER BY table_name
                    LIMIT 10
                """))
                for i, (table_name,) in enumerate(result, 1):
                    print(f"   {i}. {table_name}")

                if table_count > 10:
                    print(f"   ... and {table_count - 10} more")
            else:
                print("   ⚠️  No tables found. You may need to load your dump.sql file.")
                print("   Run: ./load_database.sh")

            print()
            print("=" * 60)
            print("✅ Database verification completed successfully!")
            print("=" * 60)
            print()
            print("Next steps:")
            if table_count == 0:
                print("1. Load your database dump: ./load_database.sh")
                print("2. Start the application: python main.py")
            else:
                print("1. Start the application: python main.py")
                print("2. Visit http://localhost:5000 in your browser")
            print()

            return True

    except ImportError as e:
        print("❌ ERROR: Required packages not installed!")
        print(f"   {str(e)}")
        print()
        print("Please install required packages:")
        print("   pip install -r requirements.txt")
        return False

    except Exception as e:
        print("❌ ERROR: Failed to connect to database!")
        print(f"   {str(e)}")
        print()
        print("Common issues:")
        print("1. PostgreSQL service is not running")
        print("   - Ubuntu/Debian: sudo systemctl start postgresql")
        print("   - macOS: brew services start postgresql")
        print()
        print("2. Incorrect credentials in DATABASE_URL")
        print("   - Check username and password")
        print("   - Verify database name exists")
        print()
        print("3. PostgreSQL not accepting connections")
        print("   - Check pg_hba.conf configuration")
        print("   - Verify host and port settings")
        print()
        print("See POSTGRES_SETUP.md for detailed troubleshooting.")
        return False

if __name__ == "__main__":
    success = verify_database()
    sys.exit(0 if success else 1)
