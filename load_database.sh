#!/bin/bash
# Database setup script for CystaSense PostgreSQL database

set -e

echo "=========================================="
echo "CystaSense PostgreSQL Database Setup"
echo "=========================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default values
DB_NAME="cystasense"
DB_USER="postgres"
DB_HOST="localhost"
DB_PORT="5432"
DUMP_FILE="dump.sql"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -d|--database)
      DB_NAME="$2"
      shift 2
      ;;
    -u|--user)
      DB_USER="$2"
      shift 2
      ;;
    -h|--host)
      DB_HOST="$2"
      shift 2
      ;;
    -p|--port)
      DB_PORT="$2"
      shift 2
      ;;
    -f|--file)
      DUMP_FILE="$2"
      shift 2
      ;;
    --help)
      echo "Usage: $0 [OPTIONS]"
      echo ""
      echo "Options:"
      echo "  -d, --database NAME    Database name (default: cystasense)"
      echo "  -u, --user USER        PostgreSQL user (default: postgres)"
      echo "  -h, --host HOST        Database host (default: localhost)"
      echo "  -p, --port PORT        Database port (default: 5432)"
      echo "  -f, --file FILE        SQL dump file (default: dump.sql)"
      echo "      --help             Show this help message"
      echo ""
      echo "Example:"
      echo "  $0 -d cystasense -u myuser -f dump.sql"
      exit 0
      ;;
    *)
      echo -e "${RED}Unknown option: $1${NC}"
      echo "Use --help for usage information"
      exit 1
      ;;
  esac
done

# Check if dump file exists
if [ ! -f "$DUMP_FILE" ]; then
    echo -e "${RED}Error: SQL dump file '$DUMP_FILE' not found!${NC}"
    echo "Please ensure the dump file exists in the current directory."
    exit 1
fi

echo -e "${GREEN}Configuration:${NC}"
echo "  Database: $DB_NAME"
echo "  User: $DB_USER"
echo "  Host: $DB_HOST"
echo "  Port: $DB_PORT"
echo "  Dump file: $DUMP_FILE"
echo ""

# Check if PostgreSQL is installed
if ! command -v psql &> /dev/null; then
    echo -e "${RED}Error: PostgreSQL client (psql) is not installed!${NC}"
    echo "Please install PostgreSQL first."
    echo ""
    echo "Ubuntu/Debian: sudo apt install postgresql-client"
    echo "macOS: brew install postgresql"
    exit 1
fi

# Check if database exists
echo -e "${YELLOW}Checking if database exists...${NC}"
DB_EXISTS=$(psql -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" -lqt | cut -d \| -f 1 | grep -w "$DB_NAME" | wc -l)

if [ "$DB_EXISTS" -eq 0 ]; then
    echo -e "${YELLOW}Database '$DB_NAME' does not exist. Creating...${NC}"
    createdb -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" "$DB_NAME"
    echo -e "${GREEN}✓ Database created successfully!${NC}"
else
    echo -e "${YELLOW}⚠ Database '$DB_NAME' already exists.${NC}"
    read -p "Do you want to drop and recreate it? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Dropping database...${NC}"
        dropdb -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" "$DB_NAME"
        echo -e "${YELLOW}Creating database...${NC}"
        createdb -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" "$DB_NAME"
        echo -e "${GREEN}✓ Database recreated successfully!${NC}"
    else
        echo -e "${YELLOW}Keeping existing database. Data will be loaded on top of existing tables.${NC}"
    fi
fi

echo ""
echo -e "${YELLOW}Loading SQL dump file...${NC}"
echo "This may take a few minutes depending on the size of your data."
echo ""

# Load the dump file
if psql -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" -d "$DB_NAME" -f "$DUMP_FILE"; then
    echo ""
    echo -e "${GREEN}=========================================="
    echo "✓ Database setup completed successfully!"
    echo "==========================================${NC}"
    echo ""
    echo "Your database connection string:"
    echo -e "${GREEN}postgresql://$DB_USER:YOUR_PASSWORD@$DB_HOST:$DB_PORT/$DB_NAME${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Create/update your .env file with the DATABASE_URL"
    echo "2. Set your SESSION_SECRET in .env"
    echo "3. Run 'python main.py' to start the application"
    echo ""
    echo "See POSTGRES_SETUP.md for detailed configuration instructions."
else
    echo ""
    echo -e "${RED}=========================================="
    echo "✗ Error loading database dump!"
    echo "==========================================${NC}"
    echo ""
    echo "Common issues:"
    echo "- Check your PostgreSQL credentials"
    echo "- Verify the dump file format is correct"
    echo "- Ensure PostgreSQL service is running"
    echo ""
    echo "For troubleshooting, see POSTGRES_SETUP.md"
    exit 1
fi
