# menu.ps1
# Main entry point: dynamically fetches scripts from GitHub

Write-Host "===== Setup Menu =====" -ForegroundColor Cyan
Write-Host "1. Install environment"
Write-Host "2. Self-destruct (remove Scoop & apps)"
$choice = Read-Host "Enter 1 or 2"

switch ($choice) {
    "1" {
        Write-Host "Fetching install script..." -ForegroundColor Green
        irm https://raw.githubusercontent.com/beyondsafa/scsetup/main/install.ps1 | iex
    }
    "2" {
        Write-Host "Fetching self-destruct script..." -ForegroundColor Red
        irm https://raw.githubusercontent.com/beyondsafa/scsetup/main/self-destruct.ps1 | iex
    }
    Default {
        Write-Host "Invalid choice. Exiting..." -ForegroundColor Red
    }
}
