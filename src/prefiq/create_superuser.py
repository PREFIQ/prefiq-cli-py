# prefiq/create_superuser.py
from django.contrib.auth import get_user_model
from django.core.management import call_command

User = get_user_model()

if not User.objects.filter(username="admin").exists():
    call_command("createsuperuser", interactive=False, username="admin", email="admin@example.com", password="admin123")
    print("Superuser 'admin' created.")
else:
    print("Superuser already exists.")
