# Meld Auto-Installer for Windows (unique for CyberPatriot)

$meldUrl = "https://download.gnome.org/binaries/win32/meld/3.22/Meld-3.22.0-win64.exe"
$installer = "$env:TEMP\MeldInstaller.exe"

Write-Host "Downloading Meld installer..."
Invoke-WebRequest -Uri $meldUrl -OutFile $installer

Write-Host "Running Meld installer silently..."
Start-Process -FilePath $installer -ArgumentList "/SILENT" -Wait

Write-Host "Meld installation complete. You can now use Meld from the Start menu or command line."
Remove-Item $installer -Force
