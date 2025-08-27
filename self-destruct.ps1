# self-destruct.ps1
# Removes Scoop and all traces

Write-Host "Self-destruct initiated..." -ForegroundColor Red

# Try to uninstall apps and remove bucket
try {
    scoop uninstall *
    scoop bucket rm extras
} catch {
    Write-Host "Cleanup continuing..." -ForegroundColor Yellow
}

# Remove Scoop directories
$scoopDir = "$env:USERPROFILE\scoop"
$scoopGlobal = "$env:ProgramData\scoop"

if (Test-Path $scoopDir) {
    Remove-Item -Recurse -Force $scoopDir
}
if (Test-Path $scoopGlobal) {
    Remove-Item -Recurse -Force $scoopGlobal
}

# Remove environment variables
[Environment]::SetEnvironmentVariable('SCOOP', $null, 'User')
[Environment]::SetEnvironmentVariable('SCOOP_GLOBAL', $null, 'Machine')

Write-Host "Scoop and all installed applications removed." -ForegroundColor Cyan
