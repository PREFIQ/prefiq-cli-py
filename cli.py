#!/usr/bin/env python3

import argparse
import subprocess
import os

def run_setup(version):
    setup_filename = f"setup-v{version}.sh"
    github_url = f"https://raw.githubusercontent.com/PREFIQ/prefiq-cli-py/main/{setup_filename}"

    print(f"Downloading setup script from: {github_url}")
    subprocess.run(["curl", "-O", github_url], check=True)

    print(f"Running setup script: {setup_filename}")
    subprocess.run(["chmod", "+x", setup_filename], check=True)
    subprocess.run(["./" + setup_filename], check=True)

def create_app(app_name):
    print(f"Creating app: {app_name}")
    subprocess.run(["python", "manage.py", "startapp", app_name], check=True)

def run_dev_server():
    print("Starting development server...")
    subprocess.run(["python", "manage.py", "runserver"], check=True)

def main():
    parser = argparse.ArgumentParser(prog="prefiq", description="Prefiq CLI for scaffolding")
    subparsers = parser.add_subparsers(dest="command", required=True)

    # install
    install_parser = subparsers.add_parser("install", help="Install  project using shell setup")
    install_parser.add_argument("--version", default="1", help="Setup script version (default: 1)")

    # new-app
    new_app_parser = subparsers.add_parser("new-app", help="Create a new app")
    new_app_parser.add_argument("name", help="App name")

    # run
    run_parser = subparsers.add_parser("run", help="Run development server")

    args = parser.parse_args()

    if args.command == "install":
        run_setup(args.version)
    elif args.command == "new-app":
        create_app(args.name)
    elif args.command == "run":
        run_dev_server()

if __name__ == "__main__":
    main()
