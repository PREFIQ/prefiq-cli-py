import os
import subprocess

def add_to_user_path(path):
    current_path = os.environ.get("PATH", "")
    if path.lower() in current_path.lower():
        print("✅ PATH already contains Scripts directory.")
        return

    print(f"📌 Adding to PATH: {path}")
    command = (
        f'[Environment]::SetEnvironmentVariable("PATH", '
        f'"{current_path};{path}", "User")'
    )
    try:
        subprocess.run(["powershell", "-Command", command], check=True)
        print("✅ PATH updated. Restart your terminal to apply changes.")
    except subprocess.CalledProcessError as e:
        print("❌ Failed to update PATH. Run as admin or do it manually.")
