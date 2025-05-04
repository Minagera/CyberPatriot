# Disable-UnnecessaryServices.ps1
# Disables common unnecessary services for CyberPatriot

$services = @(
    "Telnet",
    "RemoteRegistry",
    "SNMP",
    "Fax",
    "XblGameSave",
    "WMPNetworkSvc"
)

foreach ($svc in $services) {
    $service = Get-Service -Name $svc -ErrorAction SilentlyContinue
    if ($service) {
        Set-Service -Name $svc -StartupType Disabled
        Stop-Service -Name $svc -Force
        Write-Host "$svc disabled."
    }
}
