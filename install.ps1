# PowerShell Script for Environment Setup

# User selection for drive letter
$driveLetter = Read-Host 'Enter the drive letter (e.g., D, E, F)'

# Setting environment variable
$env:MY_ENV_VAR = 'C:\MyFolder'

Write-Output "Drive letter selected: $driveLetter"
Write-Output "Environment variable MY_ENV_VAR is set to: $env:MY_ENV_VAR"