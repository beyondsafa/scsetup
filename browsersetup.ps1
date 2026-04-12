# Script for Browser Setup

# This script sets up browsers for use with custom Scoop directory locations.

# Define environment variable for custom Scoop directory if set
if ($env:SCOOP_ROOT -ne $null) {
    $scoopRoot = $env:SCOOP_ROOT
} else {
    $scoopRoot = "$HOME\scoop"
}

# Path to the browsers installation in the Scoop directory
$browsersPath = "$scoopRoot\shims"

# Install or set up browsers with Scoop
scoop install firefox
scoop install chrome
scoop install edge

Write-Host "Browsers have been set up in: $browsersPath"