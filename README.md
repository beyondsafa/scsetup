# scsetup

> PS scripts to get me running and leaving.

A modular, bloat-free Windows bootstrapping toolset. It sets up a portable development environment using the Scoop package manager on a custom drive, installs your preferred utilities, and features a complete "self-destruct" mechanism to wipe all traces when you are done. 

Perfect for temporary workstations or keeping your host machine's C:\ drive clean.

## 🚀 Features

* **Interactive Menu:** Run everything from a single, clean router script.
* **Batch Processing:** Reads directly from text files to install apps and browser extensions concurrently for maximum speed.
* **Custom Drive Support:** Forces Scoop to install on a designated drive (defaults to `D:\scoop`) instead of cluttering your user profile.
* **Zero Trace Teardown:** Aggressively uninstalls Scoop, deletes the directories, and sanitizes your Windows Environment variables.

## 📂 Repository Structure

* `menu.ps1` - The main entry point. Run this to access the other scripts.
* `install.ps1` - Installs Scoop, adds the `extras` bucket, and batch-installs everything listed in `apps.txt`.
* `browsersetup.ps1` - Automatically opens the Chrome Web Store pages for the IDs/URLs listed in `extensions.txt`.
* `self-destruct.ps1` - The teardown script. Uninstalls packages, deletes the Scoop root folder, and removes Scoop from your `PATH`.
* `apps.txt` - Your untouched manifest of Scoop packages.
* `extensions.txt` - Your untouched manifest of browser extension IDs/URLs.

## 🛠️ Usage

1. Clone or download the repository to your target machine.
2. Open PowerShell as Administrator (if system-level path changes are needed, though User-level is the default).
3. Ensure you have the proper execution policy to run scripts:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
