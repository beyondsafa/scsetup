# install.ps1
# Installs Scoop and applications listed in apps.txt

Write-Host "Starting installation..." -ForegroundColor Cyan

# Install Scoop if not present
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

# Add extras bucket
Write-Host "Adding extras bucket..." -ForegroundColor Green
scoop bucket add extras

# Add beeper bucket
Write-Host "Adding beeper bucket..." -ForegroundColor Blue
scoop bucket add beeper https://github.com/beyondsafa/scoop-beeper.git


# Fetch app list from GitHub (always up-to-date)
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

Write-Host "Installation complete!" -ForegroundColor Cyan
