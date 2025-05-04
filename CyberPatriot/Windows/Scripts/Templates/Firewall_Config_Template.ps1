# Firewall Configuration Template for CyberPatriot

Write-Host "=== Windows Firewall Configuration ==="

# Enable firewall for all profiles
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True

# Block all inbound connections by default
Set-NetFirewallProfile -Profile Domain,Public,Private -DefaultInboundAction Block

# Allow all outbound connections by default
Set-NetFirewallProfile -Profile Domain,Public,Private -DefaultOutboundAction Allow

# Allow inbound RDP (if needed)
# Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Add custom rule example (allow HTTP)
# New-NetFirewallRule -DisplayName "Allow HTTP" -Direction Inbound -Protocol TCP -LocalPort 80 -Action Allow

# Show firewall status
Get-NetFirewallProfile | Format-Table Name, Enabled

Write-Host "=== End of Firewall Configuration ==="
