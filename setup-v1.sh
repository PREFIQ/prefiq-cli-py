#!/bin/bash

echo "📦 Enter your project name:"
read PROJECT_NAME

if [ -z "$PROJECT_NAME" ]; then
    echo "❌ Project name cannot be empty."
    exit 1
fi

if [ -d "$PROJECT_NAME" ]; then
    echo "❌ Folder '$PROJECT_NAME' already exists."
    exit 1
fi

mkdir "$PROJECT_NAME"
cd "$PROJECT_NAME" || exit 1

echo "🚀 Creating virtual environment..."
python3 -m venv venv

echo "🟢 Activating virtual environment..."
source venv/bin/activate

echo "📦 Installing Django..."
python3 -m pip install --upgrade pip setuptools >/dev/null
pip install django >/dev/null

echo "⚙️ Creating Django project..."
django-admin startproject config . >/dev/null

echo "🔧 Running migrations..."
python3 manage.py migrate

echo "👤 Creating Django superuser with default credentials..."
if [ -f prefiq/create_superuser.py ]; then
    python3 prefiq/create_superuser.py
else
    echo "⚠️  Skipping superuser creation: 'prefiq/create_superuser.py' not found."
fi

echo "🧹 Cleaning up setup script..."
cd ..
rm -f setup-v1.sh

echo "✅ Project '$PROJECT_NAME' setup completed!"
