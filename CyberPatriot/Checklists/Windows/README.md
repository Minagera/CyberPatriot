# Windows Security Checklist for CyberPatriot

## CRITICAL FIRST STEP: Read the Competition README File!
Before making any changes, thoroughly read the README file provided with the competition image. It contains:
- Required services that must remain operational
- User accounts that must be maintained
- Prohibited actions that could cause penalties
- Answers to forensics questions (worth points!)
- Competition-specific requirements that override general security practices

This checklist covers essential Windows security settings commonly tested in CyberPatriot competitions. Focus on these items to quickly secure your Windows system and gain points, but always follow README instructions when they conflict with general security practices.

## User Account Management

### Critical User Settings
- [ ] Change all user passwords to strong passwords (12+ characters, complex)
- [ ] Remove unauthorized user accounts
- [ ] Disable the Guest account
- [ ] Ensure Administrator account is secured with a strong password
- [ ] Remove unauthorized users from Administrator group
  ```
  Computer Management > System Tools > Local Users and Groups > Groups > Administrators
  ```
- [ ] Check for hidden administrator accounts
  ```
  Computer Management > Local Users and Groups > Users
  Look for accounts with Administrator privileges
  ```

### Password Policy
- [ ] Set minimum password length to 10+ characters
  ```
  Local Security Policy > Account Policies > Password Policy > Minimum password length
  ```
- [ ] Enable password complexity requirements
  ```
  Local Security Policy > Account Policies > Password Policy > Password must meet complexity requirements
  ```
- [ ] Set maximum password age (90 days or competition requirement)
  ```
  Local Security Policy > Account Policies > Password Policy > Maximum password age
  ```

### Account Lockout
- [ ] Enable account lockout after 5 failed attempts
  ```
  Local Security Policy > Account Policies > Account Lockout Policy > Account lockout threshold
  ```
- [ ] Set account lockout duration to 30 minutes
  ```
  Local Security Policy > Account Policies > Account Lockout Policy > Account lockout duration
  ```

## Windows Security Features

### Windows Defender
- [ ] Ensure Windows Defender is enabled
  ```
  Windows Security > Virus & threat protection
  ```
- [ ] Run a full virus scan
  ```
  Windows Security > Virus & threat protection > Scan options > Full scan
  ```
- [ ] Update virus definitions
  ```
  Windows Security > Virus & threat protection > Virus & threat protection updates
  ```

### Windows Firewall
- [ ] Enable Windows Firewall for all network profiles
  ```
  Windows Security > Firewall & network protection
  ```
- [ ] Block inbound connections by default
  ```
  Windows Defender Firewall with Advanced Security > Windows Defender Firewall Properties > Domain/Private/Public Profile > Inbound connections: Block
  ```

### Windows Updates
- [ ] Check for and install Windows updates
  ```
  Settings > Update & Security > Windows Update
  ```
- [ ] Configure automatic updates
  ```
  Settings > Update & Security > Windows Update > Advanced options
  ```

## Services and Applications

### Disable Unnecessary Services
- [ ] Remote Registry (if not needed)
  ```
  Services > Remote Registry > Startup Type: Disabled
  ```
- [ ] Telnet (if not needed)
  ```
  Services > Telnet > Startup Type: Disabled
  ```
- [ ] FTP Service (if not needed)
  ```
  Services > FTP Service > Startup Type: Disabled
  ```
- [ ] SNMP Service (if not needed)
  ```
  Services > SNMP Service > Startup Type: Disabled
  ```
- [ ] Print Spooler (if not needed)
  ```
  Services > Print Spooler > Startup Type: Disabled
  ```

### Application Security
- [ ] Uninstall unauthorized software
  ```
  Settings > Apps > Apps & features
  ```
- [ ] Check for prohibited software (games, hacking tools)
  ```
  Settings > Apps > Apps & features
  ```
- [ ] Remove unauthorized browser extensions/plugins
  - Internet Explorer: Tools > Manage Add-ons
  - Chrome: Menu > More Tools > Extensions
  - Firefox: Menu > Add-ons

### Remote Access
- [ ] Disable or secure Remote Desktop
  ```
  System Properties > Remote tab > Remote Desktop
  ```
- [ ] Disable Remote Assistance if not needed
  ```
  System Properties > Remote tab > Remote Assistance
  ```

## File System Security

### Sharing and Access
- [ ] Disable unnecessary file shares
  ```
  Computer Management > System Tools > Shared Folders > Shares
  ```
- [ ] Remove Everyone permissions from shared folders
  ```
  Computer Management > Shared Folders > Shares > [share] > Properties > Share Permissions
  ```
- [ ] Disable administrative shares if not needed (C$, ADMIN$)
  - **Note**: This may be required for the competition, check rules first

### File Permissions
- [ ] Check for unauthorized access to sensitive files
  ```
  Right-click folder > Properties > Security tab
  ```

## Security Policies

### Audit Policy
- [ ] Enable success/failure auditing for account logon events
  ```
  Local Security Policy > Local Policies > Audit Policy > Audit account logon events
  ```
- [ ] Enable success/failure auditing for account management
  ```
  Local Security Policy > Local Policies > Audit Policy > Audit account management
  ```
- [ ] Enable success/failure auditing for logon events
  ```
  Local Security Policy > Local Policies > Audit Policy > Audit logon events
  ```

### User Rights
- [ ] Restrict "Access this computer from the network"
  ```
  Local Security Policy > Local Policies > User Rights Assignment
  ```
- [ ] Restrict "Allow log on locally"
  ```
  Local Security Policy > Local Policies > User Rights Assignment
  ```

### Security Options
- [ ] Set legal notice banner text and title
  ```
  Local Security Policy > Local Policies > Security Options > Interactive logon: Message text/title...
  ```
- [ ] Disable "Interactive logon: Display last username"
  ```
  Local Security Policy > Local Policies > Security Options > Interactive logon: Do not display last user name
  ```

## Network Security

### Network Settings
- [ ] Disable SMBv1 protocol (commonly exploited)
  ```
  PowerShell (as administrator):
  Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol
  ```
- [ ] Enable UAC (User Account Control)
  ```
  Control Panel > System and Security > Security and Maintenance > Change User Account Control settings
  ```

## Search for Forensics Questions

- [ ] Check Desktop for README files
- [ ] Check Documents folder for competition files
- [ ] Look for files with "read me" or "answer" in the name
- [ ] Check Recent Files for suspicious activity

## Common CyberPatriot Scoring Items

- [ ] Unauthorized users removed
- [ ] Administrator account secured
- [ ] Password policy configured
- [ ] Account lockout policy configured
- [ ] Windows Defender enabled and updated
- [ ] Windows Firewall enabled
- [ ] Windows Updates installed
- [ ] Unnecessary services disabled
- [ ] Malware removed
- [ ] Unauthorized software removed
- [ ] File sharing secured
- [ ] Audit policies enabled
- [ ] Security banners configured
- [ ] Secure remote access configured

## Quick PowerShell Commands

Check Users and Group Memberships:
```powershell
Get-LocalUser | Where-Object {$_.Enabled -eq $true} | Format-Table Name, Description
Get-LocalGroupMember -Group "Administrators"
```

Check Running Services:
```powershell
Get-Service | Where-Object {$_.Status -eq "Running"} | Format-Table Name, DisplayName
```

Check Firewall Status:
```powershell
Get-NetFirewallProfile | Format-Table Name, Enabled
```

Check Shared Folders:
```powershell
Get-SmbShare
```

Check Startup Programs:
```powershell
Get-CimInstance Win32_StartupCommand | Select-Object Name, Command, User
```
