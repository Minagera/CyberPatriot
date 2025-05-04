# Registry Hardening Exercise

## Overview

Practice securing critical Windows Registry keys and removing registry-based persistence, as required in CyberPatriot competitions.

## Objectives

- Identify and secure critical registry keys
- Remove unauthorized autorun and persistence entries
- Implement registry monitoring

## Tasks

1. **Identify critical registry keys**
   - Review: `HKLM\SYSTEM\CurrentControlSet\Control\Lsa`
   - Review: `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon`
   - Review: `HKLM\SYSTEM\CurrentControlSet\Services`
   - Review: `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run`

2. **Check for unauthorized autorun entries**
   - Use PowerShell: `Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"`

3. **Remove suspicious or unauthorized entries**
   - Use PowerShell: `Remove-ItemProperty -Path ... -Name ...`

4. **Secure registry permissions**
   - Open `regedit`, right-click key > Permissions, restrict to Administrators

5. **Implement registry auditing**
   - Enable "Audit object access" in Local Security Policy
   - Configure auditing on critical keys

6. **Document all changes**
   - List keys checked, entries removed, permissions set

## Verification

- Confirm only authorized entries remain
- Test system functionality after changes

## Reflection

- Why is registry security important in Windows hardening?
- What are the risks of improper registry permissions?

---
