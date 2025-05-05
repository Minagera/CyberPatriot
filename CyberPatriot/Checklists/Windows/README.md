# Windows Security Checklist for CyberPatriot

## CRITICAL FIRST STEP: Read the Competition README File!
Before making any changes, thoroughly read the README file provided with the competition image. It contains:
- Required services that must remain operational
- User accounts that must be maintained
- Prohibited actions that could cause penalties
- Answers to forensics questions (worth points!)
- Competition-specific requirements that override general security practices

**README INSTRUCTIONS TRUMP THIS CHECKLIST!**

---

## User Account Management (`lusrmgr.msc` or `Computer Management`)

### Critical User Settings
- [ ] **Read README:** Identify authorized/required users.
- [ ] Change all user passwords to strong passwords (12+ chars, complex). Document them!
- [ ] Remove unauthorized user accounts (check README first!).
- [ ] Disable the Guest account (if not required by README).
- [ ] Ensure Administrator account is secured (strong password, consider renaming if allowed).
- [ ] Remove unauthorized users from `Administrators` group.
- [ ] Remove unauthorized users from `Remote Desktop Users` group.
- [ ] Check for hidden/unusual user accounts.

### Password Policy (`secpol.msc` > Account Policies > Password Policy)
- [ ] Enforce password history: `5` passwords remembered (or higher)
- [ ] Maximum password age: `90` days (or lower)
- [ ] Minimum password age: `1` day (or higher)
- [ ] Minimum password length: `12` characters (or higher)
- [ ] Password must meet complexity requirements: `Enabled`
- [ ] Store passwords using reversible encryption: `Disabled`

### Account Lockout Policy (`secpol.msc` > Account Policies > Account Lockout Policy)
- [ ] Account lockout threshold: `5` invalid logon attempts (or lower)
- [ ] Account lockout duration: `30` minutes (or higher)
- [ ] Reset account lockout counter after: `30` minutes (or higher)

---

## Windows Security Features

### Windows Defender Antivirus (`Windows Security` App)
- [ ] Ensure Real-time protection is `On`.
- [ ] Check Virus & threat protection updates are recent. Run update if possible.
- [ ] Run a Quick Scan (or Full Scan if time permits).
- [ ] Review Protection history for quarantined items or threats.

### Windows Defender Firewall (`wf.msc` or `Windows Security` App)
- [ ] **Read README:** Identify required ports/services (e.g., HTTP, RDP if needed).
- [ ] Ensure Firewall is `On` for Domain, Private, and Public profiles.
- [ ] Block inbound connections by default for all profiles.
- [ ] Review inbound rules: Disable or remove rules for unauthorized applications/ports. Allow only necessary ones (check README).
- [ ] Review outbound rules: Less critical, but check for suspicious entries if time allows.

### Windows Updates (`Settings` > `Update & Security`)
- [ ] **Read README:** Check if updates are allowed/prohibited/required.
- [ ] If allowed and network available, check for and install critical updates (time permitting).

---

## Services and Applications

### Disable Unnecessary Services (`services.msc`)
- [ ] **Read README:** Identify required services. **DO NOT DISABLE REQUIRED SERVICES.**
- [ ] Disable commonly unnecessary/risky services (if not required):
    - [ ] Remote Registry
    - [ ] Telnet
    - [ ] SNMP Service / SNMP Trap
    - [ ] FTP Service (if installed)
    - [ ] Print Spooler (if no printing needed)
    - [ ] Server (if no file sharing needed)
    - [ ] Workstation (needed for network access, usually leave enabled)
    - [ ] Remote Desktop Services (if RDP not required by README)

### Application Security (`Settings` > `Apps` > `Apps & features`)
- [ ] **Read README:** Identify authorized/required applications.
- [ ] Uninstall unauthorized software (check README first!).
- [ ] Check for prohibited software (games, hacking tools, P2P clients, unauthorized remote access).
- [ ] Remove unauthorized browser extensions/plugins (Chrome, Firefox, Edge).

### Remote Access (`System Properties` > `Remote`)
- [ ] Disable or secure Remote Desktop (Allow connections only from computers running RDP with NLA) - Check README first!
- [ ] Disable Remote Assistance if not needed.

---

## File System Security

### Sharing and Access (`compmgmt.msc` > `Shared Folders` > `Shares`)
- [ ] **Read README:** Identify required shares.
- [ ] Disable unnecessary file shares (especially default admin shares like C$, ADMIN$ if allowed).
- [ ] Review Share Permissions: Remove `Everyone` group access. Grant access only to necessary users/groups (e.g., Authenticated Users, specific groups). Use least privilege.
- [ ] Review NTFS Permissions (Security tab): Ensure file/folder permissions are not overly permissive (check critical folders like `C:\Windows`, `C:\Program Files`, user profiles).

---

## Security Policies (`secpol.msc`)

### Audit Policy (`Local Policies` > `Audit Policy`)
- [ ] Audit account logon events: `Success, Failure`
- [ ] Audit account management: `Success, Failure`
- [ ] Audit logon events: `Success, Failure`
- [ ] Audit object access: `Failure` (Enable Success if specific object auditing is needed)
- [ ] Audit policy change: `Success, Failure`
- [ ] Audit privilege use: `Failure`
- [ ] Audit system events: `Success, Failure`
- *Note: Excessive auditing can fill logs quickly.*

### User Rights Assignment (`Local Policies` > `User Rights Assignment`)
- [ ] Review users/groups assigned to sensitive rights (e.g., "Act as part of the operating system", "Debug programs", "Take ownership of files"). Remove unauthorized entries.
- [ ] Deny access to this computer from the network: Add `Guest` account.
- [ ] Deny log on locally: Add `Guest` account.
- [ ] Deny log on through Remote Desktop Services: Add `Guest` and potentially other non-admin groups if RDP is restricted.

### Security Options (`Local Policies` > `Security Options`)
- [ ] Interactive logon: Message text/title for logon attempts: Set appropriate warning banner.
- [ ] Interactive logon: Do not display last user name: `Enabled`
- [ ] Network access: Do not allow anonymous enumeration of SAM accounts: `Enabled`
- [ ] Network access: Do not allow anonymous enumeration of SAM accounts and shares: `Enabled`
- [ ] Accounts: Rename administrator account: Consider renaming if allowed by README.
- [ ] Accounts: Rename guest account: Consider renaming if allowed by README.
- [ ] User Account Control: Run all administrators in Admin Approval Mode: `Enabled` (Default, ensure it wasn't disabled). Check other UAC settings.

---

## Network Security

### Network Settings
- [ ] Disable SMBv1 protocol (commonly exploited):
    ```powershell
    # Run PowerShell as Administrator
    Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart
    ```
- [ ] Check Network Discovery and File Sharing settings (Network and Sharing Center > Change advanced sharing settings). Disable if not needed for the required profile.

---

## Search for Forensics Questions / Persistence

- [ ] **Read README:** Note specific forensic questions.
- [ ] Check Desktop, Documents, Downloads, `C:\`, `C:\Users`, `C:\Windows\Temp` for README files, answer files, suspicious scripts, or unusual files.
- [ ] Check Registry Run Keys:
    - `HKLM\Software\Microsoft\Windows\CurrentVersion\Run`
    - `HKCU\Software\Microsoft\Windows\CurrentVersion\Run`
    - `HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce`
    - `HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce`
    - (WoW6432Node equivalents on 64-bit)
- [ ] Check Scheduled Tasks (`taskschd.msc`): Look for unusual tasks, tasks running with high privileges, or tasks executing suspicious commands/scripts.
- [ ] Check Startup Folders:
    - `C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp`
    - `C:\Users\<user>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`
- [ ] Check Services (`services.msc`): Look for unusual services, services with suspicious paths/commands, or services configured to run malicious executables.
- [ ] Check Event Logs (`eventvwr.msc`): Look for relevant events based on forensic questions (e.g., Security log for logons - 4624/4625, System log for service errors/installs, Application log). Filter by time or event ID.
- [ ] Check Browser History/Extensions.
- [ ] Check `hosts` file (`C:\Windows\System32\drivers\etc\hosts`) for malicious redirects.

---

## Common CyberPatriot Scoring Items (Verify based on README)

- [ ] Unauthorized users removed / Passwords changed
- [ ] Administrator account secured / Guest disabled
- [ ] Password policy configured
- [ ] Account lockout policy configured
- [ ] Windows Defender enabled and updated
- [ ] Windows Firewall enabled and configured correctly
- [ ] Windows Updates installed (if allowed/required)
- [ ] Unnecessary/Insecure services disabled
- [ ] Malware/Persistence removed (Tasks, Run Keys, Services)
- [ ] Unauthorized software removed
- [ ] File sharing secured (Share/NTFS Permissions)
- [ ] Audit policies enabled
- [ ] Security banners configured
- [ ] Secure remote access configured (RDP disabled or secured)
- [ ] Answering Forensics Questions correctly

---

## Quick PowerShell Commands (Run as Administrator)

Check Users and Group Memberships:
```powershell
Get-LocalUser | Where-Object {$_.Enabled -eq $true} | Format-Table Name, Description, Enabled
Get-LocalGroupMember -Group "Administrators"
Get-LocalGroupMember -Group "Remote Desktop Users"
```

Check Running Services:
```powershell
Get-Service | Where-Object {$_.Status -eq "Running"} | Sort-Object DisplayName | Format-Table Name, DisplayName, Status
```

Check Firewall Status:
```powershell
Get-NetFirewallProfile | Format-Table Name, Enabled
Get-NetFirewallRule -Direction Inbound -Action Allow -Enabled True | Where-Object {$_.DisplayName -notlike "Core Networking*"} | Sort-Object DisplayName | Format-Table Name, DisplayName, Description, Profile, Enabled
```

Check Shared Folders:
```powershell
Get-SmbShare | Format-Table Name, Path, ScopeName
Get-SmbShareAccess -Name * | Format-Table Name, AccountName, AccessControlType, AccessRight
```

Check Startup Programs (Registry Run Keys):
```powershell
Get-CimInstance -ClassName Win32_StartupCommand | Select-Object Name, Command, Location, User | Format-List
# Check specific keys directly
Get-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run"
Get-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
# Add WoW6432Node paths if needed
```

Check Scheduled Tasks (Basic List):
```powershell
Get-ScheduledTask | Where-Object {$_.State -ne "Disabled"} | Select TaskName, TaskPath, State, Author | Format-Table -AutoSize
```
