# Windows Firewall Exercise

## Overview

Practice configuring Windows Firewall to protect the system from unauthorized access, as required in CyberPatriot competitions.

## Objectives

- Enable Windows Firewall for all profiles
- Block inbound connections by default
- Allow only required exceptions
- Document your configuration

## Tasks

1. **Enable Windows Firewall**
   - PowerShell: `Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True`

2. **Block all inbound connections by default**
   - PowerShell: `Set-NetFirewallProfile -Profile Domain,Public,Private -DefaultInboundAction Block`

3. **Allow all outbound connections by default**
   - PowerShell: `Set-NetFirewallProfile -Profile Domain,Public,Private -DefaultOutboundAction Allow`

4. **Add exceptions for required services (e.g., RDP, HTTP)**
   - PowerShell: `New-NetFirewallRule -DisplayName "Allow RDP" -Direction Inbound -Protocol TCP -LocalPort 3389 -Action Allow`

5. **Review and remove unnecessary rules**
   - PowerShell: `Get-NetFirewallRule | Format-Table Name, Enabled, Direction, Action`

6. **Document all changes**
   - List enabled rules and exceptions

## Verification

- Confirm firewall is enabled and configured as required
- Test access to allowed and blocked services

## Reflection

- Why is it important to block inbound connections by default?
- How do you decide which exceptions to allow?

---
