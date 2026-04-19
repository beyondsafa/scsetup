$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

# Renamed from $ScoopDir to avoid clashing with Scoop's internal installer variables
$TargetDir = "D:\scoop" 

# 1. Establish Environment Path
if (-not $env:SCOOP) {
    [Environment]::SetEnvironmentVariable('SCOOP', $TargetDir, 'User')
    $env:SCOOP = $TargetDir
}

# 2. Install Scoop if missing
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Scoop..."
    Invoke-RestMethod -Uri get.scoop.sh | Invoke-Expression
}

# 3. Add necessary buckets
$existingBuckets = scoop bucket list
if ($existingBuckets -notmatch "extras") {
    scoop bucket add extras
}
# 4. Read untouched apps.txt and install
$appsFile = ".\apps.txt"
if (Test-Path $appsFile) {
    # Reads the file, ignoring empty spaces
    $apps = Get-Content $appsFile | Where-Object { $_ -match '\S' -and -not $_.StartsWith('#') }
    if ($apps) {
        Write-Host "Installing packages from apps.txt..."
        
        # Temporarily relax error handling so buggy packages (like btop) don't crash the script
        $ErrorActionPreference = 'Continue' 
        
        scoop install @apps
        
        # Re-enable strict error handling just in case
        $ErrorActionPreference = 'Stop'
    }
} else {
    Write-Host "apps.txt not found. Skipping."
}
