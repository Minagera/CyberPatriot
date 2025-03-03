# Windows Group Policy Security Hardening

This guide covers intermediate-level techniques for securing Windows systems using Group Policy. Group Policy is a powerful tool for implementing security controls across Windows systems and is an essential component of Windows security hardening.

## Table of Contents

- [Introduction to Group Policy](#introduction-to-group-policy)
- [Accessing and Using Group Policy Editor](#accessing-and-using-group-policy-editor)
- [Essential Security Policies](#essential-security-policies)
- [Account Policies](#account-policies)
- [Local Policies](#local-policies)
- [Windows Defender Security Policies](#windows-defender-security-policies)
- [Advanced Audit Policy Configuration](#advanced-audit-policy-configuration)
- [Windows Firewall Policy](#windows-firewall-policy)
- [Application Control Policies](#application-control-policies)
- [Creating Security Templates](#creating-security-templates)
- [Troubleshooting Group Policy Issues](#troubleshooting-group-policy-issues)
- [Group Policy for CyberPatriot Competitions](#group-policy-for-cyberpatriot-competitions)

## Introduction to Group Policy

Group Policy provides a centralized way to implement and manage configuration settings for Windows operating systems. In the context of security hardening, Group Policy allows you to:

- Enforce password policies and account restrictions
- Control user rights and permissions
- Manage security settings across the system
- Configure Windows Defender settings
- Control application execution
- Set up audit policies for monitoring
- And much more

While Group Policy is most powerful in domain environments (with Active Directory), you can also use the Local Group Policy Editor on standalone Windows systems, which is what we'll focus on for CyberPatriot competitions.

## Accessing and Using Group Policy Editor

### Local Group Policy Editor

To access the Local Group Policy Editor on Windows:

1. Press **Win+R** to open the Run dialog
2. Type `gpedit.msc` and press **Enter**

> **Note**: The Local Group Policy Editor (gpedit.msc) is available in Windows Pro, Enterprise, and Education editions. If you're using Windows Home edition, you won't have access to this tool.

### Group Policy Editor Interface

The Group Policy Editor has two main sections:

1. **Computer Configuration** - Settings that apply to the computer, regardless of who logs in
2. **User Configuration** - Settings that apply to specific users when they log in

For security hardening, you'll primarily work with the Computer Configuration section, particularly:

- **Windows Settings** → **Security Settings**
- **Administrative Templates** → **Windows Components**

## Essential Security Policies

When hardening Windows systems using Group Policy, focus on these critical areas:

### Account Policies

Located at: **Computer Configuration** → **Windows Settings** → **Security Settings** → **Account Policies**

Key policies to configure:

#### Password Policy

- **Enforce password history**: Set to 5-24 passwords remembered
- **Maximum password age**: Set to 60-90 days
- **Minimum password age**: Set to at least 1 day
- **Minimum password length**: Set to 12 or more characters
- **Password must meet complexity requirements**: Enable
- **Store passwords using reversible encryption**: Disable

#### Account Lockout Policy

- **Account lockout duration**: Set to 15-30 minutes
- **Account lockout threshold**: Set to 3-5 invalid attempts
- **Reset account lockout counter after**: Set to 15-30 minutes

### Local Policies

Located at: **Computer Configuration** → **Windows Settings** → **Security Settings** → **Local Policies**

Key policies to configure:

#### Audit Policy

- **Audit account logon events**: Success and Failure
- **Audit account management**: Success and Failure
- **Audit logon events**: Success and Failure
- **Audit object access**: Failure
- **Audit policy change**: Success and Failure
- **Audit privilege use**: Failure
- **Audit system events**: Success and Failure

#### User Rights Assignment

- **Access this computer from the network**: Limit to necessary users/groups
- **Allow log on locally**: Limit to authorized users
- **Allow log on through Remote Desktop Services**: Restrict to specific users
- **Back up files and directories**: Administrators only
- **Change the system time**: Administrators only
- **Debug programs**: No one (remove all)
- **Deny access to this computer from the network**: Add anonymous users, guests
- **Deny log on locally**: Add guests and other unauthorized accounts
- **Deny log on through Remote Desktop Services**: Add guests and unauthorized accounts
- **Log on as a batch job**: Restrict to necessary service accounts
- **Shut down the system**: Administrators and authorized users only

#### Security Options

- **Accounts: Administrator account status**: Disabled
- **Accounts: Guest account status**: Disabled
- **Accounts: Limit local account use of blank passwords to console logon only**: Enabled
- **Accounts: Rename administrator account**: Use a non-standard name
- **Accounts: Rename guest account**: Use a non-standard name
- **Interactive logon: Do not display last user name**: Enabled
- **Interactive logon: Message text for users attempting to log on**: Configure a legal notice
- **Interactive logon: Number of previous logons to cache**: Set to 0-4
- **Microsoft network client: Digitally sign communications (always)**: Enabled
- **Network security: Do not store LAN Manager hash value on next password change**: Enabled
- **Network security: LAN Manager authentication level**: Send NTLMv2 response only
- **Network security: Minimum session security for NTLM SSP**: Require 128-bit encryption
- **User Account Control**: Configure all UAC settings to their secure defaults

## Windows Defender Security Policies

Located at: **Computer Configuration** → **Administrative Templates** → **Windows Components** → **Windows Defender Antivirus**

Key policies to configure:

- **Turn off Windows Defender Antivirus**: Disabled (keep Defender on)
- **Real-time Protection** → **Turn off real-time protection**: Disabled
- **Scan** → **Specify the scan type to use for a scheduled scan**: Quick Scan or Full Scan
- **Scan** → **Specify the day of the week to run a scheduled scan**: Pick a day
- **Scan** → **Specify the time of day to run a scheduled scan**: Set an appropriate time
- **MpEngine** → **Configure extended cloud check**: Enabled (set to 50 seconds or more)

## Advanced Audit Policy Configuration

Located at: **Computer Configuration** → **Windows Settings** → **Security Settings** → **Advanced Audit Policy Configuration**

For more detailed auditing, configure these policy areas:

- **Account Logon**
- **Account Management**
- **Detailed Tracking**
- **DS Access**
- **Logon/Logoff**
- **Object Access**
- **Policy Change**
- **Privilege Use**
- **System**

Enable auditing for both success and failure events in critical categories to track security incidents.

## Windows Firewall Policy

Located at: **Computer Configuration** → **Windows Settings** → **Security Settings** → **Windows Defender Firewall with Advanced Security**

Configure:

- **Firewall State**: On (all profiles)
- **Inbound connections**: Block (all profiles)
- **Outbound connections**: Allow (all profiles)
- Create specific inbound rules only for required services
- Configure logging settings for each profile

## Application Control Policies

Located at: **Computer Configuration** → **Windows Settings** → **Security Settings** → **Application Control Policies**

#### AppLocker

AppLocker lets you control which applications and files users can run. Configure:

- Executable rules
- Windows Installer rules
- Script rules
- Packaged app rules

> **Note**: AppLocker is available only on Windows Enterprise and Education editions.

## Creating Security Templates

Security templates allow you to save a collection of security settings that can be applied to multiple systems.

To create a security template:

1. Open the Local Security Policy editor (`secpol.msc`)
2. Right-click on **Security Templates** and select **New Template**
3. Name your template and click **OK**
4. Configure the settings in your template
5. Right-click on your template and select **Save**

To apply a security template:

1. Open the Local Security Policy editor
2. Right-click on **Security Configuration and Analysis**
3. Select **Import Template**
4. Select your saved template file
5. Right-click on **Security Configuration and Analysis**
6. Select **Configure Computer Now**

## Troubleshooting Group Policy Issues

When applying Group Policy settings for security hardening, you might encounter issues. Here are some troubleshooting steps:

### Verify Policy Application

To check if policies are applied:

1. Open Command Prompt as Administrator
2. Run: `gpresult /r` to see a summary of applied policies
3. For more detail, run: `gpresult /h C:\GPReport.html` and open the HTML file

### Update Group Policy

To force Group Policy update:

1. Open Command Prompt as Administrator
2. Run: `gpupdate /force`

### Check for Policy Conflicts

If policies aren't applying as expected:

1. Look for conflicting policies (domain policies override local policies)
2. Check security filtering and WMI filtering (in domain environments)
3. Verify that the user has permission to apply the policy

## Group Policy for CyberPatriot Competitions

During CyberPatriot competitions, focus on these Group Policy areas:

1. **Password and Account Lockout Policies**: Always configure these first
2. **User Rights Assignments**: Restrict access and privileges
3. **Security Options**: Configure system security settings
4. **Audit Policies**: Enable appropriate audit settings
5. **Windows Defender Settings**: Ensure antivirus is properly configured
6. **Windows Firewall**: Configure firewall settings

### Tips for Competition Success

- **Read the competition documentation** thoroughly to understand required services
- Keep a list of **changes you make** for troubleshooting
- Test functionality after applying Group Policy changes
- Be careful with restrictive policies that might break required services
- Use `gpresult` to verify policy application

## Practical Exercise: Implement Security Hardening via Group Policy

1. Open the Local Group Policy Editor (`gpedit.msc`)
2. Navigate to **Computer Configuration** → **Windows Settings** → **Security Settings** → **Account Policies** → **Password Policy**
3. Configure:
   - Set **Minimum password length** to 12 characters
   - Enable **Password must meet complexity requirements**
   - Set **Maximum password age** to 90 days
4. Navigate to **Account Lockout Policy**
5. Configure:
   - Set **Account lockout threshold** to 5 invalid attempts
   - Set **Account lockout duration** to 30 minutes
6. Navigate to **Local Policies** → **Security Options**
7. Find and configure:
   - Set **Accounts: Rename administrator account** to a non-obvious name
   - Enable **Interactive logon: Do not display last user name**
8. Navigate to **Administrative Templates** → **Windows Components** → **Windows Defender Antivirus**
9. Ensure:
   - **Turn off Windows Defender Antivirus** is set to Disabled
   - **Turn off real-time protection** is set to Disabled
10. Run `gpupdate /force` from an administrative Command Prompt
11. Verify settings applied with `gpresult /r`

## Additional Resources

- [Microsoft Security Compliance Toolkit](https://www.microsoft.com/en-us/download/details.aspx?id=55319)
- [CIS Windows Benchmarks](https://www.cisecurity.org/benchmark/microsoft_windows_desktop/)
- [Microsoft Security Baselines](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-security-configuration-framework/windows-security-baselines)
- [Group Policy Planning and Deployment Guide](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754948(v=ws.10))

## Next Steps

After implementing Group Policy security measures, proceed to:
- [Advanced Windows Registry Security](../Advanced/Windows_Registry_Security.md)
- [Advanced Windows Event Log Analysis](../Advanced/Windows_Event_Log_Analysis.md)
- Try the [Group Policy Hardening Exercise](../../Exercises/Group_Policy_Hardening_Exercise.md)
