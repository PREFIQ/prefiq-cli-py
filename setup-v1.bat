@echo off
setlocal enabledelayedexpansion

:: Use provided project name from environment variable
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

>prefiq\create_superuser.py echo from django.contrib.auth import get_user_model
>>prefiq\create_superuser.py echo User = get_user_model()
>>prefiq\create_superuser.py echo if not User.objects.filter(username='admin').exists():
>>prefiq\create_superuser.py echo.    User.objects.create_superuser('admin', 'admin@example.com', 'admin123')
>>prefiq\create_superuser.py echo print('Superuser created with username: admin and password: admin123')

python prefiq\create_superuser.py

echo [SUCCESS] Project '%PROJECT_NAME%' setup completed!
