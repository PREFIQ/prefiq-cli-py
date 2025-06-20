import argparse, subprocess, sys
from prefiq.add_to_path import add_to_user_path
import os

VERSION = "Prefiq CLI v0.1.0"

import platform

def run_setup(version):
    setup_filename = f"setup-v{version}.sh"
    github_url = f"https://raw.githubusercontent.com/PREFIQ/prefiq-cli-py/main/{setup_filename}"

    print(f"📥 Downloading setup from: {github_url}")
    subprocess.run(["curl", "-fLo", setup_filename, github_url], check=True)
    subprocess.run(["chmod", "+x", setup_filename], check=True)

    # ✅ Run with bash on Windows
    if platform.system() == "Windows":
        subprocess.run([setup_filename.replace(".sh", ".bat")], shell=True, check=True)
    else:
        subprocess.run(["bash", setup_filename], check=True)


def create_app(app_name):
    print(f"📦 Creating app: {app_name}")
    subprocess.run(["python", "manage.py", "startapp", app_name], check=True)

def run_dev_server():
    print("🚀 Starting dev server...")
    subprocess.run(["python", "manage.py", "runserver"], check=True)

def main():
    if len(sys.argv) > 1 and sys.argv[1] in ["--version", "--v", "-v"]:
        print(VERSION)
        return

    parser = argparse.ArgumentParser(prog="prefiq", description="Prefiq CLI – Simple Setup Tool")
    subparsers = parser.add_subparsers(dest="command", help="Available commands")

    install_parser = subparsers.add_parser("install", help="Run setup script from GitHub")
    install_parser.add_argument("--version", default="1", help="Setup script version")

    new_app_parser = subparsers.add_parser("new-app", help="Create a new app folder")
    new_app_parser.add_argument("name", help="App name")

    run_parser = subparsers.add_parser("run", help="Run the development server")

    args = parser.parse_args()

    if args.command == "install":
        run_setup(args.version)
    elif args.command == "new-app":
        create_app(args.name)
    elif args.command == "run":
        run_dev_server()
    else:
        parser.print_help()

if __name__ == "__main__":
    main()
