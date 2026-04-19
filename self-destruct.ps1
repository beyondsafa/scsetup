$ErrorActionPreference = 'SilentlyContinue'
Write-Host "Initiating teardown sequence..."

if (Get-Command scoop) {
    scoop uninstall scoop -p
}

$scoopPath = [Environment]::GetEnvironmentVariable('SCOOP', 'User')
if ($scoopPath -and (Test-Path $scoopPath)) {
    Remove-Item -Path $scoopPath -Recurse -Force
}

[Environment]::SetEnvironmentVariable('SCOOP', $null, 'User')

$userPath = [Environment]::GetEnvironmentVariable('PATH', 'User')
if ($userPath) {
    $cleanPath = ($userPath -split ';' | Where-Object { $_ -notmatch 'scoop' }) -join ';'
    [Environment]::SetEnvironmentVariable('PATH', $cleanPath, 'User')
}

Write-Host "Environment wiped. Safe to leave."
