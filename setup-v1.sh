#!/bin/bash

# Move to root (parent of setup/)
cd "$(dirname "$0")"/..

echo "🚀 Creating virtual environment..."
python -m venv venv
source venv/Scripts/activate

echo "📦 Installing Django..."
pip install django

echo "⚙️ Creating Django project..."
django-admin startproject config .

echo "🔧 Running migrations..."
python manage.py migrate

echo "👤 Creating Django superuser with default credentials..."
python src\prefiq\create_superuser.py

