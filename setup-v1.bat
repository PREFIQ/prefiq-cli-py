@echo off
setlocal enabledelayedexpansion

echo 📦 Enter your project name:
set /p PROJECT_NAME=

if "%PROJECT_NAME%"=="" (
    echo ❌ Project name cannot be empty.
    exit /b 1
)

REM Create folder and change directory
if exist "%PROJECT_NAME%" (
    echo ❌ Folder "%PROJECT_NAME%" already exists.
    exit /b 1
)

mkdir "%PROJECT_NAME%"
cd "%PROJECT_NAME%"

echo 🚀 Creating virtual environment...
python -m venv venv

echo 🟢 Activating virtual environment...
call venv\Scripts\activate.bat

echo 📦 Installing Django...
python -m pip install --upgrade pip setuptools
pip install django

echo ⚙️ Creating Django project...
django-admin startproject config .

echo 🔧 Running migrations...
python manage.py migrate

echo 👤 Creating Django superuser with default credentials...
python src\prefiq\create_superuser.py

endlocal
