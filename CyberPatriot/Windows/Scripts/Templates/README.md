# PowerShell Script Templates

This directory contains template scripts for Windows security hardening and auditing. These templates are designed to help CyberPatriot competitors learn PowerShell scripting for security tasks and provide a foundation that can be customized for competition scenarios.

## Using These Templates

1. These templates are ready-to-use PowerShell scripts (.ps1 files)
2. Download the script files to your Windows system
3. Review and customize them according to your specific needs
4. Run them from PowerShell with administrator privileges
5. Use them as learning tools to understand PowerShell security automation

## Important Notes

- **Always review scripts before running them** - Understand what each script does before execution
- **Run as Administrator** - Most security scripts require elevated privileges
- **Test in a safe environment** - Practice on VMs before using in competition
- **Customize parameters** - Modify script variables to fit your specific scenario
- **Save outputs** - Scripts generate reports; save them for analysis

## Available Templates

### User_Audit_Template.ps1

This template provides a comprehensive audit of user accounts and security settings on a Windows system.

**Features:**
- Lists all local user accounts
- Identifies built-in Administrator and Guest account status
- Checks password policies
- Identifies accounts with no passwords or passwords that never expire
- Lists Administrator group membership
- Checks for suspicious accounts
- Verifies User Account Control (UAC) settings
- Provides security recommendations

**Usage:**
```powershell
# Run with administrator privileges
.\User_Audit_Template.ps1
```

**Output:**
- Generates a text report of findings
- Creates a CSV export of user account details
- Produces a log file of script operations

### Security_Baseline_Template.ps1

This template checks the current system against security best practices and identifies areas for improvement.

**Features:**
- Evaluates Windows security settings
- Checks Windows Defender status
- Verifies Windows Firewall configuration
- Audits service configurations
- Checks registry security settings
- Provides remediation suggestions

**Usage:**
```powershell
# Run with administrator privileges
.\Security_Baseline_Template.ps1
```

### Service_Hardening_Template.ps1

This template helps identify and disable unnecessary services to reduce the attack surface.

**Features:**
- Lists all running services
- Identifies unnecessary or potentially insecure services
- Suggests services to disable
- Provides options to modify service startup types

**Usage:**
```powershell
# Run with administrator privileges
.\Service_Hardening_Template.ps1
```

### Firewall_Configuration_Template.ps1

This template helps configure Windows Firewall for optimal security.

**Features:**
- Enables Windows Firewall on all profiles
- Sets default deny rules
- Creates appropriate inbound/outbound rules
- Configures logging settings

**Usage:**
```powershell
# Run with administrator privileges
.\Firewall_Configuration_Template.ps1
```

## Learning PowerShell Scripting for Security

When studying these templates:

1. **Read the comments** - Each script is documented to explain what each section does
2. **Understand the functions** - Look at how functions are structured for reusability
3. **Examine error handling** - Note how the scripts handle errors gracefully
4. **Study reporting techniques** - Learn how to generate useful security reports
5. **Identify customization points** - Find areas where you can modify the script for your needs

## Extending Templates

Feel free to extend these templates by:

1. Adding new security checks
2. Enhancing reporting capabilities
3. Automating remediation actions
4. Combining multiple templates into comprehensive solutions
5. Creating new templates for other security tasks

## Sharing Your Improvements

If you enhance any of these templates or create new ones:

1. Document your changes
2. Test thoroughly
3. Submit a pull request to share with the team
4. Explain what your improvements address

## Additional Resources

- [PowerShell Documentation](https://docs.microsoft.com/en-us/powershell/)
- [Microsoft Security Baselines](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-security-baselines)
- [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks/)
- [PowerShell for Security Professionals](https://www.sans.org/security-resources/powershell-cheat-sheet/)
