@echo off
echo 🚀 Creating virtual environment...
python -m venv venv
call venv\Scripts\activate

echo 📦 Installing Django...
pip install --upgrade pip setuptools
pip install django
pip install -e .

echo ⚙️ Creating Django project...
django-admin startproject config .

echo 🔧 Running migrations...
python manage.py migrate

echo 👤 Creating Django superuser...
python setup\create_superuser.py
