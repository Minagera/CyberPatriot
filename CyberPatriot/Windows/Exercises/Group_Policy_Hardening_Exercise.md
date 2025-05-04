# Group Policy Hardening Exercise

## Overview

Practice using Local Group Policy to implement security settings on a Windows system, as required in CyberPatriot competitions.

## Objectives

- Configure password and account lockout policies
- Restrict user rights assignments
- Set security options for system hardening
- Apply and verify Group Policy changes

## Tasks

1. **Open Local Group Policy Editor**
   - Run: `gpedit.msc`

2. **Configure password policy**
   - Minimum password length: 12
   - Maximum password age: 90 days
   - Password complexity: enabled

3. **Configure account lockout policy**
   - Lockout threshold: 5 attempts
   - Lockout duration: 30 minutes

4. **Restrict user rights assignments**
   - Limit "Allow log on locally" and "Access this computer from the network" to authorized users/groups

5. **Set security options**
   - Rename administrator and guest accounts
   - Disable display of last username at logon
   - Set legal notice banner

6. **Apply changes**
   - Run: `gpupdate /force`

7. **Verify settings**
   - Run: `gpresult /r`
   - Check effective policies

8. **Document all changes**
   - List settings applied and verification steps

## Reflection

- Why is Group Policy a powerful tool for system hardening?
- What risks exist if policies are misconfigured?

---
