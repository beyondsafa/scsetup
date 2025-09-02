Write-Host "Starting installation..."

# Check if Scoop is already installed
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "Scoop not found. Installing Scoop..."
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    irm get.scoop.sh | iex
} else {
    Write-Host "Scoop is already installed. Run 'scoop update' to get the latest version."
}

# Install Git (needed for buckets)
scoop install git

# Add extras bucket
scoop bucket add extras

# Install apps from apps.txt
$appListUrl = "https://raw.githubusercontent.com/beyondsafa/scsetup/main/apps.txt"
$appList = irm $appListUrl
foreach ($app in $appList) {
    if ($app.Trim() -ne "") {
        Write-Host "Installing $app..."
        scoop install $app
    }
}

Write-Host "Installation complete."

# Automatically run browser setup
Write-Host "Running browser setup..."
irm https://raw.githubusercontent.com/beyondsafa/scsetup/main/browsersetup.ps1 | iex

Write-Host "All setup scripts finished."
