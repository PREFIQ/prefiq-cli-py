@echo off
setlocal enabledelayedexpansion

echo Enter your project name:
set /p PROJECT_NAME=

if "%PROJECT_NAME%"=="" (
    echo Project name cannot be empty.
    exit /b 1
)

if exist "%PROJECT_NAME%" (
    echo Folder "%PROJECT_NAME%" already exists.
    exit /b 1
)

mkdir "%PROJECT_NAME%"
cd "%PROJECT_NAME%"

echo Creating virtual environment...
python -m venv venv

echo Activating virtual environment...
call venv\Scripts\activate.bat

echo Installing Django...
python -m pip install --upgrade pip setuptools >nul
pip install django >nul

echo Creating Django project...
django-admin startproject config . >nul

echo Running migrations...
python manage.py migrate

echo Creating Django superuser with default credentials...
if exist prefiq\setup\create_superuser.py (
    python prefiq\setup\create_superuser.py
) else (
    echo Skipping superuser creation: file 'prefiq\setup\create_superuser.py' not found.
)

echo Cleaning up setup script...
cd ..
del setup-v1.bat >nul 2>&1

echo Project '%PROJECT_NAME%' setup completed!
