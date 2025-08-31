# install.ps1 (TEST BRANCH)
# Installs Scoop and apps in a sandboxed test environment

Write-Host "WARNING: TEST MODE. Scoop will be installed in a sandbox at $env:USERPROFILE\scoop-test" -ForegroundColor Yellow

# --- Force Sandbox Environment ---
$env:SCOOP = "$env:USERPROFILE\scoop-test"
$env:SCOOP_GLOBAL = "$env:ProgramData\scoop-test"

# Create sandbox directories if they don't exist
if (-not (Test-Path $env:SCOOP)) {
    New-Item -ItemType Directory -Path $env:SCOOP | Out-Null
}
if (-not (Test-Path $env:SCOOP_GLOBAL)) {
    New-Item -ItemType Directory -Path $env:SCOOP_GLOBAL | Out-Null
}

Write-Host "Scoop sandbox location: $env:SCOOP" -ForegroundColor Yellow

# --- Install Scoop in sandbox ---
if (-not (Test-Path "$env:SCOOP\shims\scoop.ps1")) {
    Write-Host "Installing Scoop (sandbox)..." -ForegroundColor Green
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    irm get.scoop.sh | iex
} else {
    Write-Host "Scoop sandbox already exists." -ForegroundColor Yellow
}

# --- Ensure Git is available in sandbox ---
if (-not (scoop list | Select-String "git")) {
    Write-Host "Installing Git in sandbox..." -ForegroundColor Green
    scoop install git
} else {
    Write-Host "Git already installed in sandbox." -ForegroundColor Yellow
}

# --- Add extras bucket (sandbox) ---
if (-not (scoop bucket list | Select-String "extras")) {
    Write-Host "Adding extras bucket in sandbox..." -ForegroundColor Green
    scoop bucket add extras
} else {
    Write-Host "Extras bucket already added." -ForegroundColor Yellow
}

# --- Install apps from test branch apps.txt ---
$appListUrl = "https://raw.githubusercontent.com/beyondsafa/scsetup/test/apps.txt"
$apps = (irm $appListUrl) -split "`n" | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne "" }

foreach ($app in $apps) {
    if (-not (scoop list | Select-String $app)) {
        Write-Host "Installing $app..." -ForegroundColor Green
        scoop install $app
    } else {
        Write-Host "$app already insta
