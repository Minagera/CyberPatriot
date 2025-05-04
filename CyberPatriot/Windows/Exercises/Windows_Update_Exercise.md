# Windows Update Exercise

## Overview

Practice configuring and managing Windows Updates to ensure system security and compliance during CyberPatriot competitions.

## Objectives

- Enable and configure Windows Update
- Check for and install pending updates
- Set update policies for automatic installation
- Document your actions

## Tasks

1. **Check Windows Update status**
   - Settings > Update & Security > Windows Update
   - PowerShell: `Get-WindowsUpdateLog`

2. **Enable automatic updates**
   - Settings > Windows Update > Advanced options
   - Ensure updates are set to install automatically

3. **Check for and install all pending updates**
   - Click "Check for updates" in Settings
   - PowerShell: `Install-WindowsUpdate -AcceptAll -AutoReboot` (requires PSWindowsUpdate module)

4. **Verify update history**
   - Settings > Windows Update > View update history

5. **Document all actions**
   - List updates installed and update policy settings

## Verification

- Confirm system is up to date
- Review update history for recent installations

## Reflection

- Why is timely patching critical in a competition?
- What risks are associated with delaying updates?

---
