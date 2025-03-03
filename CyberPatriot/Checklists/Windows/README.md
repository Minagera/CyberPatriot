# Windows Security Checklist

This comprehensive checklist covers essential security configurations for Windows systems. Use it during CyberPatriot competitions to ensure you address all critical security aspects systematically.

## User Account Security

### User Management
- [ ] Review all user accounts
  ```
  Computer Management > System Tools > Local Users and Groups > Users
  ```
- [ ] Remove unauthorized or unnecessary users
- [ ] Rename Administrator account
  ```
  Computer Management > System Tools > Local Users and Groups > Users > Administrator > Rename
  ```
- [ ] Disable Guest account
  ```
  Computer Management > System Tools > Local Users and Groups > Users > Guest > Right-click > Properties > Check "Account is disabled"
  ```
- [ ] Set appropriate account descriptions

### Password Policies
- [ ] Configure strong password policy
  ```
  Local Security Policy > Security Settings > Account Policies > Password Policy
  ```
  - [ ] Enforce password history: 5 or more passwords remembered
  - [ ] Maximum password age: 90 days or less
  - [ ] Minimum password age: 1 day or more
  - [ ] Minimum password length: 12 characters or more
  - [ ] Password must meet complexity requirements: Enabled
  - [ ] Store passwords using reversible encryption: Disabled

### Account Lockout Policy
- [ ] Configure account lockout policy
  ```
  Local Security Policy > Security Settings > Account Policies > Account Lockout Policy
  ```
  - [ ] Account lockout duration: 30 minutes or more
  - [ ] Account lockout threshold: 5 or fewer invalid logon attempts
  - [ ] Reset account lockout counter after: 30 minutes or more

### User Rights Assignment
- [ ] Review and configure user rights
  ```
  Local Security Policy > Security Settings > Local Policies > User Rights Assignment
  ```
  - [ ] Access this computer from the network: Remove Everyone, limit to necessary groups
  - [ ] Allow log on locally: Limit to necessary users
  - [ ] Allow log on through Remote Desktop Services: Limit to necessary users
  - [ ] Deny access to this computer from the network: Add Guest
  - [ ] Deny log on locally: Add Guest
  - [ ] Shut down the system: Limit to necessary users

## Group Policy and Security Settings

### Audit Policy
- [ ] Configure auditing
  ```
  Local Security Policy > Security Settings > Local Policies > Audit Policy
  ```
  - [ ] Audit account logon events: Success, Failure
  - [ ] Audit account management: Success, Failure
  - [ ] Audit logon events: Success, Failure
  - [ ] Audit object access: Failure
  - [ ] Audit policy change: Success, Failure
  - [ ] Audit privilege use: Failure
  - [ ] Audit system events: Success, Failure

### Security Options
- [ ] Configure security options
  ```
  Local Security Policy > Security Settings > Local Policies > Security Options
  ```
  - [ ] Accounts: Limit local account use of blank passwords to console logon only: Enabled
  - [ ] Interactive logon: Do not display last user name: Enabled
  - [ ] Interactive logon: Message text for users attempting to log on: Configure legal notice
  - [ ] Interactive logon: Message title for users attempting to log on: Configure legal notice title
  - [ ] Network security: Do not store LAN Manager hash value on next password change: Enabled
  - [ ] Network security: LAN Manager authentication level: Send NTLMv2 response only. Refuse LM & NTLM
  - [ ] User Account Control: Run all administrators in Admin Approval Mode: Enabled
  - [ ] User Account Control: Behavior of the elevation prompt for administrators in Admin Approval Mode: Prompt for consent
  - [ ] User Account Control: Behavior of the elevation prompt for standard users: Prompt for credentials

## Windows Defender Security

### Windows Defender Antivirus
- [ ] Enable real-time protection
  ```
  Windows Security > Virus & threat protection > Manage settings > Real-time protection: On
  ```
- [ ] Enable cloud-delivered protection
  ```
  Windows Security > Virus & threat protection > Manage settings > Cloud-delivered protection: On
  ```
- [ ] Enable automatic sample submission
  ```
  Windows Security > Virus & threat protection > Manage settings > Automatic sample submission: On
  ```
- [ ] Run a full scan
  ```
  Windows Security > Virus & threat protection > Scan options > Full scan > Scan now
  ```
- [ ] Update virus definitions
  ```
  Windows Security > Virus & threat protection > Virus & threat protection updates > Check for updates
  ```

### Windows Defender Firewall
- [ ] Enable Windows Defender Firewall for all profiles
  ```
  Windows Security > Firewall & network protection > [Domain/Private/Public] network > Turn on
  ```
- [ ] Review and remove unnecessary inbound rules
  ```
  Windows Defender Firewall with Advanced Security > Inbound Rules
  ```
- [ ] Review and remove unnecessary outbound rules
  ```
  Windows Defender Firewall with Advanced Security > Outbound Rules
  ```
- [ ] Block all inbound connections by default
  ```
  Windows Defender Firewall with Advanced Security > Windows Defender Firewall Properties > [Profile] tab > Inbound connections: Block
  ```

## System Services

### Service Management
- [ ] Review all running services
  ```
  Services > Sort by Status
  ```
- [ ] Disable unnecessary services (examples below)
  - [ ] Remote Registry
  - [ ] Print Spooler (if not needed)
  - [ ] FTP Service (if not needed)
  - [ ] Telnet (if not needed)
  - [ ] SNMP Service (if not needed)
  - [ ] Web Management Service (if not needed)
- [ ] Configure services to start with least privilege

### Secure Remote Access
- [ ] Configure Remote Desktop (if needed)
  ```
  System Properties > Remote tab > Remote Desktop
  ```
  - [ ] Allow remote connections only from computers running Remote Desktop with Network Level Authentication
  - [ ] Limit users allowed to connect via Remote Desktop
- [ ] Disable Remote Desktop if not needed
  ```
  System Properties > Remote tab > Remote Desktop > Don't allow remote connections to this computer
  ```
- [ ] Disable Remote Assistance if not needed
  ```
  System Properties > Remote tab > Remote Assistance > Don't allow Remote Assistance connections to this computer
  ```

## Software Security

### Windows Updates
- [ ] Check for and install all available updates
  ```
  Settings > Update & Security > Windows Update > Check for updates
  ```
- [ ] Configure automatic updates
  ```
  Settings > Update & Security > Windows Update > Advanced options > Automatic (recommended)
  ```
- [ ] Verify update history for failed updates
  ```
  Settings > Update & Security > Windows Update > View update history
  ```

### Software Management
- [ ] Uninstall unauthorized or unnecessary software
  ```
  Settings > Apps > Apps & features
  ```
- [ ] Update installed software to latest versions
- [ ] Disable or remove vulnerable plugins (Flash, Java, etc.)
- [ ] Check for unauthorized software in startup
  ```
  Task Manager > Startup tab
  ```

## File System Security

### NTFS Permissions
- [ ] Review and secure permissions on sensitive folders
  ```
  Right-click folder > Properties > Security tab
  ```
- [ ] Remove Everyone and anonymous access from sensitive directories
- [ ] Ensure proper ownership of system files and directories
- [ ] Apply appropriate permissions to program directories

### File Sharing
- [ ] Review all shared folders
  ```
  Computer Management > System Tools > Shared Folders > Shares
  ```
- [ ] Remove unnecessary shares
- [ ] Configure appropriate permissions on necessary shares
- [ ] Disable administrative shares if not needed
  ```
  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters\AutoShareServer = 0
  ```

## Registry Security

### Registry Settings
- [ ] Disable autorun/autoplay
  ```
  HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\NoDriveTypeAutoRun = 0xFF
  ```
- [ ] Show file extensions
  ```
  HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt = 0
  ```
- [ ] Disable remote registry access if not needed
  ```
  Services > Remote Registry > Startup type: Disabled
  ```

## Network Security

### Network Configuration
- [ ] Disable unnecessary network protocols and components
  ```
  Network and Sharing Center > Change adapter settings > Right-click adapter > Properties
  ```
- [ ] Disable NetBIOS over TCP/IP if not needed
  ```
  Network adapter properties > TCP/IPv4 > Advanced > WINS tab > Disable NetBIOS over TCP/IP
  ```
- [ ] Disable IPv6 if not needed
  ```
  Network adapter properties > Uncheck Internet Protocol Version 6 (TCP/IPv6)
  ```
- [ ] Configure host-based intrusion detection (Windows Defender Advanced Threat Protection if available)

### SMB Security
- [ ] Disable SMBv1
  ```
  PowerShell (as administrator):
  Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol
  ```
- [ ] Enable SMB signing
  ```
  Local Security Policy > Security Settings > Local Policies > Security Options:
  - Microsoft network client: Digitally sign communications (always): Enabled
  - Microsoft network server: Digitally sign communications (always): Enabled
  ```

## Browser Security

### Internet Explorer/Edge Security
- [ ] Configure enhanced security configuration for IE (if installed)
  ```
  Server Manager > Local Server > IE Enhanced Security Configuration
  ```
- [ ] Configure secure browser settings
  ```
  Internet Explorer > Internet Options > Security tab > Set all zones to High
  ```
- [ ] Disable unnecessary browser add-ons and extensions
  ```
  Internet Explorer > Internet Options > Programs tab > Manage add-ons
  ```

## Logging and Monitoring

### Event Logs
- [ ] Configure maximum log sizes
  ```
  Event Viewer > Windows Logs > Right-click Security > Properties > Maximum log size: 4096000 KB or more
  ```
- [ ] Configure log retention
  ```
  Event Viewer > Windows Logs > Right-click Security > Properties > "Overwrite events as needed" or "Archive the log when full"
  ```
- [ ] Enable PowerShell script block logging
  ```
  PowerShell (as administrator):
  Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" -Name EnableScriptBlockLogging -Value 1 -Type DWORD -Force
  ```

## Common CyberPatriot Windows Findings

These are commonly tested vulnerabilities in CyberPatriot competitions:

1. **User Account Issues**
   - Default/blank/weak passwords
   - Unauthorized accounts
   - Guest account enabled
   - Unauthorized users in Administrators group

2. **Policy Issues**
   - Weak password policies
   - Missing account lockout policies
   - Incomplete audit settings
   - Missing security banners

3. **System Service Issues**
   - Unnecessary services running
   - Remote Desktop enabled when not needed
   - Print Spooler enabled when not needed
   - Telnet or FTP services enabled

4. **Software Issues**
   - Missing Windows updates
   - Unauthorized software (games, hacking tools)
   - Outdated browsers or plugins
   - Prohibited media files

5. **Sharing and Permissions**
   - Excessive sharing permissions
   - Unnecessary shared folders
   - World-writable directories
   - Incorrect file system permissions

## Verification Commands

Use these PowerShell commands to verify your security configurations:

- View all local users:
  ```powershell
  Get-LocalUser | Format-Table Name, Enabled, Description
  ```

- View members of the Administrators group:
  ```powershell
  Get-LocalGroupMember -Group "Administrators"
  ```

- View account lockout policy:
  ```powershell
  net accounts
  ```

- View all services:
  ```powershell
  Get-Service | Sort-Object Status | Format-Table Name, DisplayName, Status
  ```

- View running services:
  ```powershell
  Get-Service | Where-Object {$_.Status -eq "Running"} | Format-Table Name, DisplayName
  ```

- View Windows Firewall status:
  ```powershell
  Get-NetFirewallProfile | Format-Table Name, Enabled
  ```

- View shared folders:
  ```powershell
  Get-SmbShare
  ```

- View installed software:
  ```powershell
  Get-WmiObject -Class Win32_Product | Select-Object Name, Version
  ```

- View listening ports:
  ```powershell
  Get-NetTCPConnection -State Listen | Format-Table LocalPort, State, OwningProcess
  ```

- View startup programs:
  ```powershell
  Get-CimInstance -ClassName Win32_StartupCommand | Select-Object Name, Command, Location, User
  ```
