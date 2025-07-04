#!/bin/bash

# Dify Sandbox Setup Script for ZimaOS
# This script creates necessary directories and files for Dify sandbox

echo "Setting up Dify directories and files..."

# Create necessary directories
mkdir -p /DATA/AppData/Dify/storage
mkdir -p /DATA/AppData/Dify/db
mkdir -p /DATA/AppData/Dify/redis
mkdir -p /DATA/AppData/Dify/weaviate
mkdir -p /DATA/AppData/Dify/sandbox
mkdir -p /DATA/AppData/Dify/plugin-daemon

# Create python-requirements.txt for sandbox
cat > /DATA/AppData/Dify/sandbox/python-requirements.txt << 'EOF'
# Dify Sandbox Python Requirements
# Basic packages for code execution
requests>=2.25.0
numpy>=1.21.0
pandas>=1.3.0
matplotlib>=3.4.0
seaborn>=0.11.0
scikit-learn>=1.0.0
plotly>=5.0.0
beautifulsoup4>=4.10.0
lxml>=4.6.0
openpyxl>=3.0.0
pillow>=8.0.0
python-dateutil>=2.8.0
pytz>=2021.1
scipy>=1.7.0
EOF

# Create nodejs package.json for sandbox
cat > /DATA/AppData/Dify/sandbox/package.json << 'EOF'
{
  "name": "dify-sandbox-nodejs",
  "version": "1.0.0",
  "description": "Node.js dependencies for Dify sandbox",
  "dependencies": {
    "axios": "^1.3.0",
    "lodash": "^4.17.21",
    "moment": "^2.29.0",
    "cheerio": "^1.0.0-rc.12",
    "csv-parser": "^3.0.0",
    "node-fetch": "^3.3.0"
  }
}
EOF

# Set proper permissions
chmod -R 755 /DATA/AppData/Dify/

echo "Dify sandbox setup completed!"
echo "Created directories:"
echo "  - /DATA/AppData/Dify/storage"
echo "  - /DATA/AppData/Dify/db"
echo "  - /DATA/AppData/Dify/redis"
echo "  - /DATA/AppData/Dify/weaviate"
echo "  - /DATA/AppData/Dify/sandbox"
echo "  - /DATA/AppData/Dify/plugin-daemon"
echo ""
echo "Created files:"
echo "  - /DATA/AppData/Dify/sandbox/python-requirements.txt"
echo "  - /DATA/AppData/Dify/sandbox/package.json"
echo ""
echo "You can now run: docker-compose -f docker-compose-dify.yml up -d" 