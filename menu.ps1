do {
    Write-Host "`n1. Install Environment"
    Write-Host "2. Configure Browser"
    Write-Host "3. Teardown (Self-Destruct)"
    Write-Host "4. Exit"
    
    $choice = Read-Host "`nSelect option"

    switch ($choice) {
        '1' { .\install.ps1 }
        '2' { 
            if (Test-Path ".\browsersetup.ps1") { .\browsersetup.ps1 } 
            else { Write-Host "browsersetup.ps1 not found." }
        }
        '3' { .\self-destruct.ps1; exit }
        '4' { exit }
        Default { Write-Host "Invalid selection." }
    }
} while ($true)
