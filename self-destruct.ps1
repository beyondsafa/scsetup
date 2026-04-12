# self-destruct.ps1
# Removes Scoop and all data from the designated drive

Write-Host "Self-destruct initialized..." -ForegroundColor Red

# Get SCOOP directory from environment variable
$scoopDir = $env:SCOOP
if (-not $scoopDir) {
    $scoopDir = "$env:USERPROFILE\scoop"
}

Write-Host "Scoop directory detected: $scoopDir" -ForegroundColor Yellow

# Fetch app list
$appListUrl = "https://raw.githubusercontent.com/beyondsafa/scsetup/main/apps.txt"
$appList = irm $appListUrl

# Process termination map
$processMap = @{
    "brave"                = "brave"
    "mullvad-browser"      = "mullvad-browser"
    "qbittorrent-enhanced" = "qbittorrent"
    "aria2"                = "aria2c"
    "speedtest-cli"        = "speedtest"
    "fastfetch"            = "fastfetch"
    "cpufetch"             = "cpufetch"
    "alacritty"            = "alacritty"
    "warp-terminal"        = "warp-terminal"
}

# Kill running processes
foreach ($app in $appList) {
    $appTrimmed = $app.Trim()
    if ($appTrimmed -ne "" -and $processMap.ContainsKey($appTrimmed)) {
        $procName = $processMap[$appTrimmed]
        $procs = Get-Process -Name $procName -ErrorAction SilentlyContinue
        if ($procs) {
            Write-Host "Terminating process: $procName" -ForegroundColor Yellow
            $procs | ForEach-Object { Stop-Process -Id $_.Id -Force -ErrorAction SilentlyContinue }
        }
    }
}

# Remove Scoop directory
if (Test-Path $scoopDir) {
    Write-Host "Removing Scoop directory: $scoopDir" -ForegroundColor Red
    Remove-Item -Recurse -Force $scoopDir -ErrorAction SilentlyContinue
    Write-Host "Scoop directory removed." -ForegroundColor Green
} else {
    Write-Host "No Scoop directory found at $scoopDir" -ForegroundColor Yellow
}

# Remove global Scoop directory
$scoopGlobalDir = $env:SCOOP_GLOBAL
if (-not $scoopGlobalDir) {
    $scoopGlobalDir = "$env:USERPROFILE\scoop-global"
}

if (Test-Path $scoopGlobalDir) {
    Write-Host "Removing Scoop Global directory: $scoopGlobalDir" -ForegroundColor Red
    Remove-Item -Recurse -Force $scoopGlobalDir -ErrorAction SilentlyContinue
    Write-Host "Scoop Global directory removed." -ForegroundColor Green
}

# Clear environment variables
Write-Host "Clearing environment variables..." -ForegroundColor Yellow
[Environment]::SetEnvironmentVariable("SCOOP", "", "User")
[Environment]::SetEnvironmentVariable("SCOOP_GLOBAL", "", "User")

Write-Host "================================" -ForegroundColor Red
Write-Host "Self-destruct complete." -ForegroundColor Red
Write-Host "All Scoop data has been removed." -ForegroundColor Green
Write-Host "================================" -ForegroundColor Red
