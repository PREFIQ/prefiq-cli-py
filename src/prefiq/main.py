import argparse
import subprocess
import sys
import os
import platform
import requests

from prefiq.add_to_path import add_to_user_path

VERSION = "Prefiq CLI v0.1.0"


def download_with_progress(url, filename):
    print(f"Downloading setup from: {url}")
    response = requests.get(url, stream=True)

    if response.status_code != 200:
        print("Error: Could not download the setup script.")
        sys.exit(1)

    total_length = int(response.headers.get("content-length", 0))
    chunk_size = 1024
    downloaded = 0
    progress_bar = ""

    with open(filename, "wb") as f:
        for chunk in response.iter_content(chunk_size=chunk_size):
            if chunk:
                f.write(chunk)
                downloaded += len(chunk)
                done = int(50 * downloaded / total_length)
                progress_bar = "#" * done + "-" * (50 - done)
                print(f"\r[{progress_bar}] {downloaded * 100 // total_length}%", end="")

    print(f"\nSaved to: {filename}")


def run_setup(version):
    is_windows = platform.system() == "Windows"
    ext = ".bat" if is_windows else ".sh"
    setup_filename = f"setup-v{version}{ext}"
    github_url = f"https://raw.githubusercontent.com/PREFIQ/prefiq-cli-py/main/{setup_filename}"

    download_with_progress(github_url, setup_filename)

    print(f"Running setup script: {setup_filename}")
    try:
        if is_windows:
            subprocess.run([setup_filename], shell=True, check=True)
        else:
            subprocess.run(["chmod", "+x", setup_filename], check=True)
            subprocess.run(["bash", setup_filename], check=True)
    finally:
        if os.path.exists(setup_filename):
            os.remove(setup_filename)
            print("Cleaned up setup script.")


def create_app(app_name):
    print(f"Creating app: {app_name}")
    base_path = os.path.join(os.getcwd(), app_name)

    try:
        os.makedirs(base_path, exist_ok=False)
    except FileExistsError:
        print(f"App '{app_name}' already exists.")
        return

    open(os.path.join(base_path, "__init__.py"), "w").close()

    with open(os.path.join(base_path, "main.py"), "w") as f:
        f.write(f'''def main():
    print("Hello from {app_name}!")
''')

    print(f"App '{app_name}' created at: {base_path}")


def run_dev_server():
    print("Starting development server...")
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