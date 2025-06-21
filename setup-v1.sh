#!/bin/bash

# Check if project name is passed via env
if [ -z "$PROJECT_NAME" ]; then
    echo "[ERROR] Project name is not set. Use: prefiq install <project-name>"
    exit 1
fi

# Check for existing folder
if [ -d "$PROJECT_NAME" ]; then
    echo "[ERROR] Folder '$PROJECT_NAME' already exists."
    exit 1
fi

echo "[INFO] Creating project folder: $PROJECT_NAME"
mkdir "$PROJECT_NAME"
cd "$PROJECT_NAME" || exit 1

echo "[INFO] Creating virtual environment..."
python3 -m venv venv

echo "[INFO] Activating virtual environment..."
source venv/bin/activate

echo "[INFO] Installing Django..."
python3 -m pip install --upgrade pip setuptools >/dev/null
pip install django >/dev/null

echo "[INFO] Creating Django project..."
django-admin startproject config . >/dev/null

echo "[INFO] Running migrations..."
python3 manage.py migrate

echo "[INFO] Creating Django superuser with default credentials..."
if [ -f prefiq/create_superuser.py ]; then
    python3 prefiq/create_superuser.py
else
    echo "[WARN] Skipping superuser creation: 'prefiq/create_superuser.py' not found."
fi

echo "[SUCCESS] Project '$PROJECT_NAME' setup completed!"
