# PowerShell Script Templates

This directory contains template scripts for Windows security hardening and auditing. These templates are designed to help CyberPatriot competitors learn PowerShell scripting for security tasks and provide a foundation that can be customized for competition scenarios.

## Using These Templates

1. Download the `.ps1` script files to your Windows VM.
2. Review the comments and logic in each script before running.
3. Modify variables and logic to fit your specific scenario.
4. Test scripts in a safe environment before using in competition.

## Important Notes

- Always run PowerShell as Administrator for system-level changes.
- Understand what each script does before executing.
- Document any changes made by scripts for competition reporting.

## Available Templates

- `User_Audit_Template.ps1`: List users, check group memberships, find unauthorized accounts.
- `Password_Policy_Template.ps1`: Audit and set password policies.
- `Service_Audit_Template.ps1`: List running services, check for insecure services.
- `Firewall_Config_Template.ps1`: Configure Windows Firewall rules.
- `Defender_Config_Template.ps1`: Enable/disable Defender, run scans, set exclusions.
- `Registry_Security_Check_Template.ps1`: Audit critical registry keys for security settings.

## Learning PowerShell Scripting for Security

- Start with basic commands (`Get-LocalUser`, `Get-Service`, `Set-LocalUser`, etc.).
- Learn to use `if`, `foreach`, and error handling.
- Practice modifying templates to add new checks or automate more tasks.

## Extending Templates

- Add logging and reporting features.
- Combine multiple templates into a master script.
- Share improvements with your team.

## Sharing Your Improvements

- Contribute improved templates back to your team repository.

## Additional Resources

- [PowerShell Documentation](https://docs.microsoft.com/en-us/powershell/)
- [CyberPatriot Windows Checklists](../../../Checklists/Windows/README.md)
