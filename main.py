import os
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

from app import app
import routes  # noqa: F401

if __name__ == "__main__":
    # Only enable debug in development
    debug_mode = os.environ.get('FLASK_ENV') == 'development'
    # Use port 5001 if 5000 is in use (e.g., by AirPlay on macOS)
    port = int(os.environ.get('FLASK_PORT', 5001))
    app.run(host="0.0.0.0", port=port, debug=debug_mode)