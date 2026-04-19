$ErrorActionPreference = 'Stop'

$extensionsFile = ".\extensions.txt"

if (Test-Path $extensionsFile) {
    Write-Host "Loading extensions from extensions.txt..."
    $extensions = Get-Content $extensionsFile | Where-Object { $_ -match '\S' -and -not $_.StartsWith('#') }
    
    foreach ($ext in $extensions) {
        # If your text file has full URLs, it opens them. 
        # If they are just 32-character IDs, it appends the Chrome Web Store URL.
        if ($ext -match "^http") {
            Start-Process $ext
        } else {
            Start-Process "https://chrome.google.com/webstore/detail/$ext"
        }
        Start-Sleep -Seconds 1 # Brief pause to prevent browser tab crashing
    }
} else {
    Write-Host "extensions.txt not found. Skipping."
}
