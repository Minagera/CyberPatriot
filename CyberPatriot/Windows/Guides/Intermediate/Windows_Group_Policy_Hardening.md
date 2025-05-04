# Windows Group Policy Hardening Guide

This guide provides step-by-step instructions for hardening Windows systems using Local Group Policy, tailored for CyberPatriot competition scenarios.

## Key Areas to Harden

1. **Password Policies**
   - Minimum length: 12+
   - Complexity: enabled
   - Maximum age: 90 days
   - Enforce password history: 5+

2. **Account Lockout Policies**
   - Lockout threshold: 5 attempts
   - Lockout duration: 30 minutes
   - Reset counter: 30 minutes

3. **Audit Policies**
   - Enable auditing for logon events, privilege use, object access, policy changes, and system events.

4. **User Rights Assignment**
   - Remove unnecessary privileges from users/groups.
   - Restrict "Log on locally" and "Log on through Remote Desktop Services" to authorized users only.

5. **Security Options**
   - Enable UAC (User Account Control)
   - Disable Guest account
   - Require Ctrl+Alt+Del for logon
   - Restrict anonymous access

6. **Windows Defender and Firewall**
   - Ensure Defender is enabled and updated
   - Configure firewall to block inbound by default, allow only required services

7. **Service Hardening**
   - Disable unnecessary services (e.g., Telnet, FTP, Remote Registry)
   - Set critical services to automatic, others to manual or disabled

## How to Apply Group Policy Settings

1. Open `gpedit.msc` (Local Group Policy Editor)
2. Navigate to the relevant policy section (e.g., Computer Configuration > Windows Settings > Security Settings)
3. Double-click the policy, configure as recommended, and apply
4. Use `gpupdate /force` to apply changes immediately

## Verification

- Use `gpresult /r` to view applied policies
- Check Event Viewer for audit logs
- Test password and lockout policies by attempting logins

## Documentation

- Record all changes in a change log for competition scoring and troubleshooting

*This guide is unique and designed for CyberPatriot training.*
