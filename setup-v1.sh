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

echo "👤 Creating Django superuser with default cr

