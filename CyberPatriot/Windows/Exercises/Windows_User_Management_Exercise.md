# Windows User Management Exercise

## Overview

This exercise will help you practice managing user accounts and groups on a Windows system, as required in CyberPatriot competitions.

## Objectives

- Identify all user accounts on the system
- Remove unauthorized or unnecessary accounts
- Secure administrator and guest accounts
- Implement strong password policies
- Document all changes

## Tasks

1. **List all local user accounts**
   - Use PowerShell: `Get-LocalUser`
   - Use Command Prompt: `net user`

2. **Identify unauthorized or suspicious accounts**
   - Compare against the list of required users in the scenario README

3. **Remove or disable unauthorized accounts**
   - Remove: `Remove-LocalUser -Name "username"` or `net user username /delete`
   - Disable: `Disable-LocalUser -Name "username"` or `net user username /active:no`

4. **Check administrator group membership**
   - PowerShell: `Get-LocalGroupMember -Group "Administrators"`
   - Remove unauthorized users from Administrators group

5. **Secure the Guest account**
   - Disable Guest: `Disable-LocalUser -Name "Guest"` or `net user Guest /active:no`

6. **Set strong password policies**
   - Minimum length: 12+ characters
   - Complexity: enabled
   - Maximum age: 90 days

7. **Document all changes**
   - List accounts removed/disabled and password policy settings

## Verification

- List all users and groups after changes
- Confirm only authorized users remain
- Check password policy with `net accounts`

## Reflection

- Why is it important to remove unauthorized accounts?
- What risks are associated with weak password policies?

---
