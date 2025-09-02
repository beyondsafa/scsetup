Write-Host "========================================"
Write-Host "   Scoop Setup Menu"
Write-Host "========================================"
Write-Host "1) Initialize (install apps + browser setup)"
Write-Host "2) Self-destruct (remove Scoop and data)"
Write-Host "Q) Quit"
Write-Host "========================================"

$choice = Read-Host "Enter your choice"

switch ($choice) {
    "1" {
        Write-Host "Fetching install script from repo..."
        irm "https://raw.githubusercontent.com/beyondsafa/scsetup/main/install.ps1" | iex

        Write-Host "Fetching browser setup script from repo..."
        irm "https://raw.githubusercontent.com/beyondsafa/scsetup/main/browsersetup.ps1" | iex
    }
    "2" {
        Write-Host "Fetching self-destruct script from repo..."
        irm "https://raw.githubusercontent.com/beyondsafa/scsetup/main/self-destruct.ps1" | iex
    }
    "Q" { Write-Host "Exiting menu." }
    "q" { Write-Host "Exiting menu." }
    default { Write-Host "Invalid choice. Exiting." }
}
