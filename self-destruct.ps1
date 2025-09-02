Write-Host "Self-destruct initialized..."

# Fetch app list
$appListUrl = "https://raw.githubusercontent.com/beyondsafa/scsetup/main/apps.txt"
$appList = irm $appListUrl

# Map Scoop app names to process names
$processMap = @{
    "brave"                = "brave"
    "mullvad-browser"      = "mullvad-browser"
    "qbittorrent-enhanced" = "qbittorrent"   # exe name is qbittorrent.exe
    "aria2"                = "aria2c"
    "speedtest-cli"        = "speedtest"     # python script, may not run as a process
    "fastfetch"            = "fastfetch"
    "cpufetch"             = "cpufetch"
}

# Kill running processes that match installed apps
foreach ($app in $appList) {
    $appTrimmed = $app.Trim()
    if ($appTrimmed -ne "" -and $processMap.ContainsKey($appTrimmed)) {
        $procName = $processMap[$appTrimmed]
        $procs = Get-Process -Name $procName -ErrorAction SilentlyContinue
        if ($procs) {
            Write-Host "Terminating process: $procName"
            $procs | ForEach-Object { Stop-Process -Id $_.Id -Force }
        }
    }
}

# Define Scoop directory
$scoopDir = "$env:USERPROFILE\scoop"

# Remove Scoop directory permanently
if (Test-Path $scoopDir) {
    Write-Host "Removing Scoop directory: $scoopDir"
    Remove-Item -Recurse -Force $scoopDir
} else {
    Write-Host "No Scoop directory found. Nothing to remove."
}

Write-Host "Self-destruct complete."
