# install.ps1
# Installs Scoop and applications listed in apps.txt
# Now with support for custom drive letter installation

Write-Host "================================" -ForegroundColor Cyan
Write-Host "   Scoop Setup with Drive Selection" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan

# Prompt for drive letter
$driveLetter = Read-Host "Which drive would you like to install Scoop on? (e.g., D, E, F)"
$driveLetter = $driveLetter.ToUpper().TrimEnd(':')

# Validate drive
if ($driveLetter -notmatch '^[A-Z]$') {
    Write-Host "Invalid drive letter. Please use a single letter (A-Z)." -ForegroundColor Red
    exit 1
}

$scoopPath = "$($driveLetter):\scoop"
$scoopGlobalPath = "$($driveLetter):\scoop-global"

Write-Host "Scoop will be installed to: $scoopPath" -ForegroundColor Yellow
Write-Host "Global apps will be installed to: $scoopGlobalPath" -ForegroundColor Yellow

# Verify drive exists
if (-not (Test-Path "$($driveLetter):\")) {
    Write-Host "Drive $driveLetter does not exist or is not accessible." -ForegroundColor Red
    exit 1
}

# Set environment variables permanently
[Environment]::SetEnvironmentVariable("SCOOP", $scoopPath, "User")
[Environment]::SetEnvironmentVariable("SCOOP_GLOBAL", $scoopGlobalPath, "User")
$env:SCOOP = $scoopPath
$env:SCOOP_GLOBAL = $scoopGlobalPath

Write-Host "Environment variables set:" -ForegroundColor Green
Write-Host "  SCOOP = $env:SCOOP" -ForegroundColor Green
Write-Host "  SCOOP_GLOBAL = $env:SCOOP_GLOBAL" -ForegroundColor Green

# Create directories
if (-not (Test-Path $scoopPath)) {
    New-Item -ItemType Directory -Path $scoopPath -Force | Out-Null
    Write-Host "Created directory: $scoopPath" -ForegroundColor Green
}

if (-not (Test-Path $scoopGlobalPath)) {
    New-Item -ItemType Directory -Path $scoopGlobalPath -Force | Out-Null
    Write-Host "Created directory: $scoopGlobalPath" -ForegroundColor Green
}

Write-Host "Starting installation..." -ForegroundColor Cyan

# Install Scoop
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Scoop..." -ForegroundColor Green
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    irm get.scoop.sh | iex
} else {
    Write-Host "Scoop already installed." -ForegroundColor Yellow
}

# Ensure Git is installed
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Git..." -ForegroundColor Green
    scoop install git
} else {
    Write-Host "Git already installed." -ForegroundColor Yellow
}

# Add buckets
Write-Host "Adding extras bucket..." -ForegroundColor Green
scoop bucket add extras

Write-Host "Adding beeper bucket..." -ForegroundColor Blue
scoop bucket add beeper https://github.com/beyondsafa/scoop-beeper.git

# Fetch and install apps
$appListUrl = "https://raw.githubusercontent.com/beyondsafa/scsetup/main/apps.txt"
$apps = (irm $appListUrl) -split "`n" | ForEach-Object { $_.Trim() } | Where-Object {$_ -ne ""}

foreach ($app in $apps) {
    if (-not (scoop list | Select-String $app)) {
        Write-Host "Installing $app ..." -ForegroundColor Green
        scoop install $app
    } else {
        Write-Host "$app already installed." -ForegroundColor Yellow
    }
}

Write-Host "================================" -ForegroundColor Cyan
Write-Host "Installation complete!" -ForegroundColor Cyan
Write-Host "All Scoop data is stored on: $driveLetter" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Cyan
