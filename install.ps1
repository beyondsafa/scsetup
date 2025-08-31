# install.ps1 (TEST BRANCH)
# Installs Scoop in sandbox location and apps from apps.txt

Write-Host "⚠️ TEST MODE: Scoop will be installed in a sandbox at $env:USERPROFILE\scoop-test" -ForegroundColor Yellow

# Force Scoop environment
$env:SCOOP = "$env:USERPROFILE\scoop-test"
$env:SCOOP_GLOBAL = "$env:ProgramData\scoop-test"

# Install Scoop if not already in test location
if (-not (Test-Path $env:SCOOP)) {
    Write-Host "Installing Scoop (TEST MODE)..." -ForegroundColor Green
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    irm get.scoop.sh | iex
} else {
    Write-Host "Test Scoop already exists at $env:SCOOP" -ForegroundColor Yellow
}

# Ensure Git (inside test scoop)
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Git (TEST MODE)..." -ForegroundColor Green
    scoop install git
} else {
    Write-Host "Git already installed (system or Scoop)." -ForegroundColor Yellow
}

# Add extras bucket (sandbox)
Write-Host "Adding extras bucket (TEST MODE)..." -ForegroundColor Green
scoop bucket add extras

# Get app list from test branch
$appListUrl = "https://raw.githubusercontent.com/beyondsafa/scsetup/test/apps.txt"
$apps = (irm $appListUrl) -split "`n" | ForEach-Object { $_.Trim() } | Where-Object {$_ -ne ""}

foreach ($app in $apps) {
    if (-not (scoop list | Select-String $app)) {
        Write-Host "Installing $app ..." -ForegroundColor Green
        scoop install $app
    } else {
        Write-Host "$app already installed." -ForegroundColor Yellow
    }
}

Write-Host "✅ Test installation complete." -ForegroundColor Cyan
