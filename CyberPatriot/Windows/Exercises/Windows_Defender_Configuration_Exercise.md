# Windows Defender Configuration Exercise

## Overview

Practice configuring Windows Defender to protect against malware and threats, as required in CyberPatriot competitions.

## Objectives

- Enable and configure Windows Defender
- Run a full system scan
- Update virus definitions
- Configure real-time protection and exclusions
- Document your actions

## Tasks

1. **Verify Windows Defender is enabled**
   - PowerShell: `Get-MpPreference | Select-Object DisableRealtimeMonitoring`
   - Enable if needed: `Set-MpPreference -DisableRealtimeMonitoring $false`

2. **Update virus definitions**
   - PowerShell: `Update-MpSignature`

3. **Run a full system scan**
   - PowerShell: `Start-MpScan -ScanType FullScan`

4. **Enable real-time protection**
   - PowerShell: `Set-MpPreference -DisableRealtimeMonitoring $false`

5. **Configure controlled folder access (optional)**
   - PowerShell: `Set-MpPreference -EnableControlledFolderAccess Enabled`

6. **Add or review exclusions (if required by scenario)**
   - PowerShell: `Add-MpPreference -ExclusionPath "C:\Path\To\Exclude"`

7. **Document all changes**
   - List Defender settings and scan results

## Verification

- Confirm Defender is running and up to date
- Review scan results for threats

## Reflection

- Why is real-time protection important?
- When might you need to add exclusions?

---
