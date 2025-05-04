# Configure-WindowsFirewall.ps1
# Applies recommended firewall rules for CyberPatriot

# Block all inbound connections except allowed apps
Set-NetFirewallProfile -Profile Domain,Public,Private -DefaultInboundAction Block -DefaultOutboundAction Allow

# Allow RDP if needed
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Allow file/printer sharing if required
Enable-NetFirewallRule -DisplayGroup "File and Printer Sharing"

Write-Host "Firewall rules applied. Verify with Windows Security Center."
