# menu.ps1 (TEST BRANCH)
# Main entry point for sandboxed test environment
# All scripts and apps are fetched from the test branch

Write-Host "===== TEST SETUP MENU =====" -ForegroundColor Cyan
Write-Host "WARNING: This is SANDBOX MODE. Your real Scoop install will NOT be affected."
Write-Host ""
Write-Host "1. Install test environment"
Write-Host "2. Self-destruct test environment"
$choice = Read-Host "Enter 1 or 2"

switch ($choice) {
    "1" {
        Write-Host "Fetching test install script from test branch..." -ForegroundColor Green
        irm "https://raw.githubusercontent.com/beyondsafa/scsetup/test/install.ps1" | iex
    }
    "2" {
        Write-Host "Fetching test self-destruct script from test branch..." -ForegroundColor Red
        irm "https://raw.githubusercontent.com/beyondsafa/scsetup/test/self-destruct.ps1" | iex
    }
    Default {
        Write-Host "Invalid choice. Exiting..." -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Menu execution complete. Sandbox scripts ran from test branch." -ForegroundColor Cyan
