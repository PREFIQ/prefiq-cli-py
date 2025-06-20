Absolutely! Here's a clear, step-by-step **documentation** for how to set up and use the **`PREFIQ` Python CLI** — following the modern `src/` layout, editable install, and OS compatibility.

---

# 📘 PREFIQ CLI – Setup & Usage Guide

A lightweight CLI tool to scaffold and manage Django projects the smart way.

---

## 📁 Project Structure

```
prefiq-cli-py/
├── pyproject.toml
├── README.md
├── setup.cfg (optional)
├── src/
│   └── prefiq/
│       ├── __init__.py
│       ├── main.py
│       └── add_to_path.py
```

---

## ⚙️ Requirements

* Python ≥ 3.7
* `pip`
* Git Bash or any terminal that supports `bash`
* Internet connection for downloading setup scripts

---

## 🚀 1. Clone the Repo

```bash
git clone https://github.com/PREFIQ/prefiq-cli-py.git
cd prefiq-cli-py
```

---

## 🛠 2. Editable Install (Modern Way)

> ✅ Uses `pyproject.toml` with `--use-pep517`

```bash
pip install -e . --use-pep517
```

If successful, you’ll see:

```
Successfully installed prefiq-cli-py-0.1.0
```

> If you see a warning about `prefiq.exe` not in PATH — follow the next step.

---

## 🧩 3. Add CLI to PATH (Windows)

Add this to your system `PATH`:

```plaintext
C:\Users\<yourname>\AppData\Roaming\Python\Python313\Scripts
```

### Or use this PowerShell script:

```powershell
$envName = "PATH"
$userScope = "User"
$pythonScripts = "$env:APPDATA\Python\Python313\Scripts"
$current = [Environment]::GetEnvironmentVariable($envName, $userScope)
if ($current -notlike "*$pythonScripts*") {
    [Environment]::SetEnvironmentVariable($envName, "$current;$pythonScripts", $userScope)
    "✅ PATH updated. Restart your terminal."
} else {
    "✅ Already in PATH."
}
```
Or do it manually via:

>> System Properties > Environment Variables > User > Path > New
>  file name and browse to path


Then restart the terminal.

---

## ✅ 4. Available Commands

### 🔹 Version

```bash
prefiq --version
```

### 🔹 Install Django Setup (From GitHub Script)

```bash
prefiq install --version 1
```

Runs `setup-v1.sh` from GitHub and installs Django in a virtual environment.

### 🔹 Create a New App

```bash
prefiq new-app blog
```

Creates a Django app called `blog`.

### 🔹 Run Local Server

```bash
prefiq run
```

Runs the Django dev server.

---

## 🧪 Troubleshooting

### ❌ `ModuleNotFoundError: No module named 'main'`

✅ Fix: Use `src/prefiq/main.py` and update `pyproject.toml` to:

```toml
[project.scripts]
prefiq = "prefiq.main:main"

[tool.setuptools.packages.find]
where = ["src"]
```

---

### ❌ Bash error on Windows: `WinError 193`

✅ Fix: On Windows, run `.sh` scripts using:

```python
subprocess.run(["bash", setup_filename], check=True)
```

---

## 📄 Example `pyproject.toml`

```toml
[build-system]
requires = ["setuptools>=64"]
build-backend = "setuptools.build_meta"

[project]
name = "prefiq-cli-py"
version = "0.1.0"
description = "Prefiq CLI – A simple Django setup tool"
authors = [{ name = "Sundar" }]
readme = "README.md"

[project.scripts]
prefiq = "prefiq.main:main"

[tool.setuptools.packages.find]
where = ["src"]
```

---

## 🧰 Future Commands (Planned)

* `prefiq init` – initialize a new modular project
* `prefiq generate module` – create scaffolded apps
* `prefiq clean` – remove conflicting npm/Python binaries
* `prefiq deploy` – setup production configs
* `prefiq test` – run unit tests

---

## 🧼 Clean Conflicts (Optional)

If an old Node.js CLI was installed:

```bash
npm uninstall -g prefiq
del "%APPDATA%\npm\prefiq"
del "%APPDATA%\npm\prefiq.cmd"
```

Then:

```bash
hash -r  # if using bash
```

---

## ✅ That’s It!

You’re ready to use the `prefiq` CLI globally on any project.

---

You're 100% right — earlier, `npm` installed a conflicting `prefiq` binary globally, and **it's still in your `PATH`**, possibly shadowing the Python one.

Let’s clean it properly.

---

## ✅ Step-by-Step: Remove `npm`'s CLI Conflict

### 🔍 1. Check what's currently running for `prefiq`

Run in **Git Bash** or **CMD**:

```bash
where prefiq
```

You’ll likely see something like:

```
C:\Users\SUNDAR\AppData\Roaming\npm\prefiq
```

This is the **old Node.js CLI** path.

---

### 🧼 2. Uninstall the npm version (if you haven’t already)

```bash
npm uninstall -g prefiq
```

---

### 🔁 3. Manually delete leftover files (important)

Even after uninstall, `npm` sometimes leaves behind stub files.

Manually **delete**:

```bash
C:\Users\SUNDAR\AppData\Roaming\npm\prefiq
C:\Users\SUNDAR\AppData\Roaming\npm\prefiq.cmd
```

You can do this via File Explorer or run:

```bash
del "%APPDATA%\npm\prefiq"
del "%APPDATA%\npm\prefiq.cmd"
```

---

### 🔃 4. Clear shell cache (if using Git Bash)

```bash
hash -r
```

Or just **restart your terminal**.

---

### ✅ 5. Verify the correct Python CLI is used

Now run again:

```bash
where prefiq
```

You should now see:

```
C:\Users\SUNDAR\AppData\Roaming\Python\Python313\Scripts\prefiq.exe
```

That’s the correct Python CLI!

Then try:

```bash
prefiq --version
```

✅ It should output:

```
Prefiq CLI v0.1.0
```

```
prefiq-cli-py/
├── src/
│   ├── prefiq/
│   │   ├── __init__.py
│   │   ├── main.py
│   │   └── add_to_path.py
├── pyproject.toml
```


Now reinstall:

```bash
pip install -e . --use-pep517
```

python -m main install --version 1

4. Available Commands
🔹 Version
bash
Copy
Edit
prefiq --version
🔹 Install Django Setup (From GitHub Script)
bash
Copy
Edit
prefiq install --version 1
Runs setup-v1.sh from GitHub and installs Django in a virtual environment.

🔹 Create a New App
bash
Copy
Edit
prefiq new-app blog
Creates a Django app called blog.

🔹 Run Local Server
bash
Copy
Edit
prefiq run
Runs the Django dev server.

git clone https://github.com/PREFIQ/prefiq-cli-py.git
cd prefiq-cli-py


pip uninstall prefiq-cli-py -y
pip install -e . --use-pep517



