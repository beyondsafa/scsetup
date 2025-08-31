# self-destruct.ps1 (TEST BRANCH)
# Nukes only sandbox Scoop install

Write-Host "💀 TEST MODE: Self-destruct initialized (sandbox only)..." -ForegroundColor Red

# Test Scoop directories
$scoopDir    = "$env:USERPROFILE\scoop-test"
$scoopGlobal = "$env:ProgramData\scoop-test"

# Remove Scoop dirs
try {
    if (Test-Path $scoopDir) {
        Write-Host "Removing $scoopDir ..." -ForegroundColor Yellow
        Remove-Item -Recurse -Force $scoopDir
    }
    if (Test-Path $scoopGlobal) {
        Write-Host "Removing $scoopGlobal ..." -ForegroundColor Yellow
        Remove-Item -Recurse -Force $scoopGlobal
    }
} catch {
    # Suppress errors
}

# Clear env vars for test scoop
[Environment]::SetEnvironmentVariable('SCOOP', $null, 'User')
[Environment]::SetEnvironmentVariable('SCOOP_GLOBAL', $null, 'Machine')

Write-Host "🔥 Sandbox Scoop obliterated (TEST MODE)." -ForegroundColor Cyan
