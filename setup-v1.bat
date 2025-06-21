@echo off
setlocal enabledelayedexpansion

set "PROJECT_NAME=%1"

if "%PROJECT_NAME%"=="" (
    echo [ERROR] Project name not provided.
    exit /b 1
)

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
python -m pip install --upgrade pip >nul
pip install django >nul

echo [INFO] Creating Django project...
django-admin startproject config . >nul

echo [INFO] Running migrations...
python manage.py migrate

echo [INFO] Creating Django superuser with default credentials...
python manage.py shell -c ^
"from django.contrib.auth import get_user_model; ^
User = get_user_model(); ^
if not User.objects.filter(username='admin').exists(): ^
    User.objects.create_superuser('admin', 'admin@example.com', 'admin123'); ^
    print('Superuser created: admin / admin123'); ^
else: ^
    print('Superuser \"admin\" already exists.')"

echo [SUCCESS] Project '%PROJECT_NAME%' setup completed.