from django.contrib.auth import get_user_model
import os
import django

# Set up Django environment
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings')
django.setup()

User = get_user_model()

if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'admin@example.com', 'admin123')
    print("✅ Superuser created: username=admin, password=admin123")
else:
    print("ℹ️ Superuser already exists.")

    # Create sundar superuser
    if not User.objects.filter(username='sundar').exists():
        User.objects.create_superuser('sundar', 'sundar@sundar.com', 'kalarani')
        print("✅ Superuser 'sundar' created (sundar@sundar.com / kalarani)")
    else:
        print("ℹ️ Superuser 'sundar' already exists.")
