# Scoop-based Mullvad Browser Extension Setup

$ErrorActionPreference = "Stop"

# Paths
$scoopDir   = Join-Path $env:USERPROFILE "scoop"
$aria2Path  = Join-Path (Join-Path $scoopDir "shims") "aria2c.exe"
$extFile    = Join-Path $env:TEMP "extensions.txt"  # Download to temp
$extOutDir  = Join-Path $scoopDir "extensions"

# Download extensions.txt from GitHub
$extensionsUrl = "https://raw.githubusercontent.com/beyondsafa/scsetup/main/extensions.txt"
Invoke-WebRequest -Uri $extensionsUrl -OutFile $extFile

# Ensure aria2 exists
if (-not (Test-Path $aria2Path)) {
    Write-Error "aria2c.exe not found at $aria2Path. Make sure Scoop installed it."
    exit 1
}

# Ensure output directory
if (-not (Test-Path $extOutDir)) {
    New-Item -ItemType Directory -Path $extOutDir | Out-Null
}

# Read extensions.txt
if (-not (Test-Path $extFile)) {
    Write-Error "extensions.txt not found in $extFile"
    exit 1
}

$extensions = Get-Content $extFile | Where-Object { $_ -and ($_ -notmatch "^\s*#") }

foreach ($line in $extensions) {
    $parts = $line -split "\|"
    if ($parts.Count -lt 2) {
        Write-Warning "Skipping malformed line: $line"
        continue
    }

    $name  = $parts[0].Trim()
    $slug  = $parts[1].Trim()
    $url   = "https://addons.mozilla.org/firefox/downloads/latest/$slug/latest.xpi"
    $out   = Join-Path $extOutDir ("$slug.xpi")

    Write-Host "Downloading $name..."
    & $aria2Path --max-connection-per-server=5 --split=5 --min-split-size=1M --retry-wait=3 --max-tries=5 -o (Split-Path $out -Leaf) -d (Split-Path $out) $url

    if ($LASTEXITCODE -ne 0) {
        Write-Warning "aria2 failed to download $name. Exit code: $LASTEXITCODE"
    } else {
        Write-Host "$name downloaded to $out"
    }
}

Write-Host "All downloads attempted. You can install extensions manually by dragging them into Mullvad Browser."
