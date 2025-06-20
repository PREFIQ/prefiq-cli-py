#!/bin/bash

# Ask for project name
read -p "📦 Enter your project name: " PROJECT_NAME

if [ -z "$PROJECT_NAME" ]; then
  echo "❌ Project name cannot be empty."
  exit 1
fi

# Create the project directory and move into it
mkdir "$PROJECT_NAME" || { echo "❌ Folder '$PROJECT_NAME' already exists."; exit 1; }
cd "$PROJECT_NAME" || exit

echo "🚀 Creating virtual environment..."
python -m venv venv
source venv/Scripts/activate 2>/dev/null || source venv/bin/activate

echo "📦 Installing Django..."
pip install --upgrade pip setuptools
pip install django

echo "⚙️ Creating Django project..."
django-admin startproject config .

echo "🔧 Running migrations..."
python manage.py migrate

echo "👤 Creating Django superuser with default credentials..."
python src/prefiq/create_superuser.py

