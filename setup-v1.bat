@echo off
setlocal enabledelayedexpansion

:: Get project name from argument
set "PROJECT_NAME=%1"

if "%PROJECT_NAME%"=="" (
    echo [ERROR] Project name not provided.
    exit /b 1
)

:: Check if folder already exists
if exist "%PROJECT_NAME%" (
    echo [ERROR] Folder "%PROJECT_NAME%" already exists.
    exit /b 1
)

echo [INFO] Creating project folder: %PROJECT_NAME%
mkdir "%PROJECT_NAME%"
cd "%PROJECT_NAME%"

echo [INFO] Creating virtual environment...
python -m venv venv

echo [INFO] Activating virtual environment...
call venv\Scripts\activate.bat

echo [INFO] Installing Django...
python -m pip install --upgrade pip setuptools >nul
pip install django >nul

echo [INFO] Creating Django project...
django-admin startproject config . >nul

echo [INFO] Running migrations...
python manage.py migrate

echo [INFO] Creating Django superuser with default credentials...
mkdir prefiq >nul 2>&1

:: Create Python script
> prefiq\create_superuser.py (
    echo import os
    echo os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings')
    echo import django
    echo django.setup()
    echo from django.contrib.auth import get_user_model
    echo User = get_user_model()
    echo if not User.objects.filter(username="admin").exists():
    echo.    User.objects.create_superuser("admin", "admin@example.com", "admin123")
    echo.    print("Superuser created: admin / admin123")
    echo else:
    echo.    print("Superuser 'admin' already exists.")
)

:: Run the script
python prefiq\create_superuser.py

echo [SUCCESS] Project '%PROJECT_NAME%' setup completed
