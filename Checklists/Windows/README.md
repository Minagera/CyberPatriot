# Windows Security Checklist for CyberPatriot

**Reminder: This checklist is a guide for general hardening. Always prioritize the specific instructions, requirements, authorized users/services, and forensic questions found in the official Competition README file provided with the image.**

## CRITICAL FIRST STEP: Read the Competition README File!
Before making any changes, thoroughly read the README file provided with the competition image. It contains:
- Required services/applications that must remain operational.
- User accounts that must be maintained or have specific roles.
- Prohibited actions that could cause penalties.
- Answers to forensics questions (worth points!).
- Competition-specific requirements that override general security practices.

**README INSTRUCTIONS TRUMP THIS CHECKLIST!**

---

## User Account Management (`lusrmgr.msc` or `Computer Management` or PowerShell)

### Critical User Settings
- [ ] **README Check:** Identify authorized users and required group memberships (Administrators, Remote Desktop Users, etc.).
- [ ] Change all user passwords to strong, unique passwords (unless README prohibits).
  ```powershell
  # Example: Set password, force change at next logon
  $user = Get-LocalUser -Name "username"
  $user | Set-LocalUser -Password (Read-Host -AsSecureString "Enter new password for $user") -PasswordNeverExpires $false -UserMayNotChangePassword $false
  # Or use net user username *
  ```
- [ ] Remove unauthorized user accounts (verify against README first!).
  ```powershell
  Remove-LocalUser -Name "unauthorized_user"
  # Or use net user unauthorized_user /delete
  ```
- [ ] Disable (don't delete unless sure) user accounts that should not be active but might be needed later or are specified in README.
  ```powershell
  Disable-LocalUser -Name "temp_disabled_user"
  ```
- [ ] Verify and correct group memberships, especially `Administrators` and `Remote Desktop Users`. Remove unauthorized members.
  ```powershell
  Get-LocalGroupMember -Group "Administrators"
  Remove-LocalGroupMember -Group "Administrators" -Member "unauthorized_admin"
  Get-LocalGroupMember -Group "Remote Desktop Users"
  Remove-LocalGroupMember -Group "Remote Desktop Users" -Member "unauthorized_rdp_user"
  ```
- [ ] Disable or Rename Guest account (check README if renaming is allowed/required).
  ```powershell
  Disable-LocalUser -Name "Guest"
  # Rename: Rename-LocalUser -Name "Guest" -NewName "SomethingElse" (Requires specific PS version/module)
  # Or use GUI: lusrmgr.msc
  ```
- [ ] Check for hidden user accounts (e.g., ending with `$`). Use PowerShell `Get-LocalUser`.

### Password Policy (`secpol.msc` > Account Policies > Password Policy)
- [ ] Enforce password history: `5` or more passwords remembered.
- [ ] Maximum password age: `90` days or less (e.g., 60).
- [ ] Minimum password age: `1` day or more.
- [ ] Minimum password length: `12` characters or more (e.g., 14).
- [ ] Password must meet complexity requirements: `Enabled`.
- [ ] Store passwords using reversible encryption: `Disabled`.

### Account Lockout Policy (`secpol.msc` > Account Policies > Account Lockout Policy)
- [ ] Account lockout threshold: `5` invalid logon attempts or fewer.
- [ ] Account lockout duration: `15` minutes or more.
- [ ] Reset account lockout counter after: `15` minutes or more.

---

## Windows Security Features

### Windows Defender Antivirus (`Windows Security` App)
- [ ] Ensure Real-time protection is `On`.
- [ ] Check for recent definition updates (Update if internet allowed).
- [ ] Run a Quick Scan (or Full Scan if time permits and seems necessary).
- [ ] Review Protection history for detected threats.

### Windows Defender Firewall (`wf.msc` or `Windows Security` App)
- [ ] Ensure Firewall is `On` for Domain, Private, and Public profiles.
- [ ] Review inbound rules: Disable or remove rules allowing unnecessary traffic (check README for required services!). Pay attention to rules allowing `Any` protocol/port or applying to `All` profiles.
  ```powershell
  Get-NetFirewallRule -Direction Inbound -Action Allow -Enabled True | Where-Object {$_.DisplayName -notlike "Core Networking*"} | Sort-Object DisplayName | Format-Table Name, DisplayName, Description, Profile, Enabled
  # Disable-NetFirewallRule -Name "RuleNameToDisable"
  ```
- [ ] Review outbound rules (less common to change, but check for overly permissive rules if suspicious activity is noted).
- [ ] Block all inbound connections, except those on the list of allowed apps (for relevant profiles, if appropriate and doesn't break required services).

### Windows Updates (`Settings` > `Update & Security`)
- [ ] Check for and install updates if allowed by README and network/time permit. Prioritize security updates.

---

## Services and Applications

### Disable Unnecessary Services (`services.msc`)
- [ ] **README Check:** Identify required services that MUST be running.
- [ ] Disable unnecessary/insecure services (Examples: `Remote Registry`, `Telnet`, `SNMP Service`, `Routing and Remote Access` if not needed, `Server` if file sharing not needed). Set startup type to `Disabled`.
  ```powershell
  # Example: Stop and disable Remote Registry
  Stop-Service -Name "RemoteRegistry" -Force
  Set-Service -Name "RemoteRegistry" -StartupType Disabled
  ```
- [ ] Check service permissions and recovery options for suspicious modifications (less common focus).

### Application Security (`Settings` > `Apps` > `Apps & features`)
- [ ] **README Check:** Identify authorized/required applications.
- [ ] Uninstall unauthorized software (verify against README first!). Look for games, hacking tools (nmap, Wireshark - unless authorized), P2P clients, unauthorized remote access tools (VNC variants, TeamViewer unless authorized), unknown programs.
- [ ] Check for prohibited software categories mentioned in the README.
- [ ] Remove unauthorized browser extensions/plugins (Chrome, Firefox, Edge).

### Remote Access (`System Properties` > `Remote` or `Settings` > `System` > `Remote Desktop`)
- [ ] Disable Remote Desktop unless explicitly required by README. If required, ensure "Allow connections only from computers running Remote Desktop with Network Level Authentication (NLA)" is checked.
- [ ] Limit users allowed RDP access via `Select Users...` or the `Remote Desktop Users` group.
- [ ] Disable Remote Assistance if not needed.

---

## File System Security

- [ ] Check permissions on critical system folders (e.g., `C:\Windows`, `C:\Windows\System32`). Look for `Everyone` or `Users` having Full Control or Write access (generally bad). Use `icacls` or GUI (Properties > Security).
- [ ] Check permissions on user profile directories.
- [ ] Search for prohibited files (media files - `.mp3`, `.mp4`, `.avi`, `.mov`, etc.) if specified in README.
  ```powershell
  Get-ChildItem -Path C:\Users -Recurse -Include *.mp3, *.mp4, *.mov, *.avi -ErrorAction SilentlyContinue
  ```
- [ ] Check Network Shares (`compmgmt.msc` -> Shared Folders -> Shares). Remove unnecessary shares (especially default shares like `C$`, `ADMIN$` if policy allows - check README). Restrict permissions on required shares (remove `Everyone`, use specific users/groups with least privilege).
  ```powershell
  Get-SmbShare | Format-Table Name, Path, ScopeName
  # Remove-SmbShare -Name "ShareName" -Force
  ```
- [ ] Disable SMBv1 (if not already disabled).
  ```powershell
  # Check status
  Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol
  # Disable
  Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart
  ```

---

## Security Policies (`secpol.msc`)

### Audit Policy (`Local Policies` > `Audit Policy`) - Configure for Success and Failure
- [ ] Audit account logon events: `Success, Failure`
- [ ] Audit account management: `Success, Failure`
- [ ] Audit logon events: `Success, Failure` (Tracks local/network logons)
- [ ] Audit object access: `Failure` (Consider `Success` for specific objects if needed, but can be noisy)
- [ ] Audit policy change: `Success, Failure`
- [ ] Audit privilege use: `Failure` (Consider `Success` cautiously)
- [ ] Audit process tracking: `Off` (Usually too noisy unless investigating specific issue)
- [ ] Audit system events: `Success, Failure`

### User Rights Assignment (`Local Policies` > `User Rights Assignment`)
- [ ] Review users/groups assigned to sensitive rights (e.g., "Act as part of the operating system", "Debug programs", "Take ownership of files", "Log on as a service", "Log on as a batch job"). Remove unauthorized entries.
- [ ] Deny access to this computer from the network: Add `Guest` account, potentially other unauthorized groups.
- [ ] Deny log on locally: Add `Guest` account.
- [ ] Deny log on through Remote Desktop Services: Add `Guest` and potentially other non-admin groups if RDP is restricted by README.

### Security Options (`Local Policies` > `Security Options`)
- [ ] Interactive logon: Message text/title for logon attempts: Set appropriate warning banner (check README for specific text).
- [ ] Interactive logon: Do not display last user name: `Enabled`.
- [ ] Network access: Do not allow anonymous enumeration of SAM accounts: `Enabled`.
- [ ] Network access: Do not allow anonymous enumeration of SAM accounts and shares: `Enabled`.
- [ ] Accounts: Rename administrator account: Consider renaming if allowed/required by README.
- [ ] Accounts: Rename guest account: Consider renaming if allowed/required by README (and ensure it's disabled).
- [ ] User Account Control: Run all administrators in Admin Approval Mode: `Enabled` (Default, ensure it wasn't disabled). Review other UAC settings (e.g., behavior for standard users).

---

## Search for Forensics Questions / Persistence

- [ ] **README Check:** Re-read forensic questions. What specific information, files, users, or events are they asking about?
- [ ] Search common locations for flags/answers: Desktop, Documents, Downloads, Pictures, `C:\`, `C:\Users`, `C:\Windows\Temp`, Recycle Bin. Look for `.txt`, image files, or unusually named files.
- [ ] Check Registry Run Keys (Persistence):
    - `HKLM\Software\Microsoft\Windows\CurrentVersion\Run`
    - `HKCU\Software\Microsoft\Windows\CurrentVersion\Run`
    - `HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce`
    - `HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce`
    - (WoW64 nodes on 64-bit systems) `HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run`
    ```powershell
    Get-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run"
    Get-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
    # Add Wow6432Node path if applicable
    ```
- [ ] Check Scheduled Tasks (`taskschd.msc` or `schtasks` / `Get-ScheduledTask`): Look for suspicious tasks (unusual names, run locations, triggers, actions running strange executables/scripts). Disable or remove unauthorized tasks.
  ```powershell
  Get-ScheduledTask | Where-Object {$_.State -ne "Disabled"} | Format-Table TaskName, TaskPath, State, Actions
  # Disable-ScheduledTask -TaskName "SuspiciousTask"
  ```
- [ ] Check Startup Folders (Persistence):
    - `C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp` (All Users)
    - `C:\Users\<user>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup` (Specific User)
- [ ] Check Services (`services.msc` or `Get-Service`): Look for unusual services, services with suspicious paths/commands (ImagePath), or services configured to run malicious executables. Check service recovery options.
- [ ] Check Event Logs (`eventvwr.msc` or `Get-WinEvent`): Filter logs (Security, System, Application) based on forensic questions (e.g., Security log for logons - 4624/Success, 4625/Failure; System log for service errors/installs; Application log). Filter by time, Event ID, or keywords.
  ```powershell
  # Example: Find recent successful logons
  Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4624; StartTime=(Get-Date).AddDays(-1)} -MaxEvents 50
  ```
- [ ] Check Browser History/Extensions (if relevant to questions).
- [ ] Check `hosts` file (`C:\Windows\System32\drivers\etc\hosts`) for malicious redirects. Open with Notepad (as Admin).

---

## Common CyberPatriot Scoring Items (Verify based on README)

- [ ] Unauthorized users removed / Passwords changed for authorized users.
- [ ] Administrator account secured / Guest disabled (and possibly renamed).
- [ ] Password policy configured (Length, Complexity, History, Age).
- [ ] Account lockout policy configured.
- [ ] Windows Defender Antivirus enabled and updated (if possible).
- [ ] Windows Defender Firewall enabled and configured correctly (blocking unnecessary inbound, allowing required).
- [ ] Windows Updates installed (if allowed/required/possible).
- [ ] Unnecessary/Insecure services disabled (Remote Registry, Telnet, etc.).
- [ ] Malware/Persistence removed (Tasks, Run Keys, Services, Startup Folders).
- [ ] Unauthorized software removed.
- [ ] File sharing secured (Shares removed/permissions restricted). SMBv1 disabled.
- [ ] Audit policies enabled (Logon Success/Failure, Policy Change, etc.).
- [ ] Security banners configured (Interactive Logon message).
- [ ] Secure remote access configured (RDP disabled or secured with NLA and limited users).
- [ ] Answering Forensics Questions correctly and completely.

---

## Quick PowerShell Commands (Run as Administrator)

Check Users and Group Memberships:
```powershell
Get-LocalUser | Where-Object {$_.Enabled -eq $true} | Format-Table Name, Description, Enabled, PasswordLastSet
Get-LocalGroupMember -Group "Administrators"
Get-LocalGroupMember -Group "Remote Desktop Users"
```

Check Running Services (excluding Microsoft/common system services can help spot outliers):
```powershell
Get-Service | Where-Object {$_.Status -eq "Running"} | Sort-Object DisplayName | Format-Table Name, DisplayName, Status
# Try filtering common ones (may need refinement):
# Get-Service | Where-Object {$_.Status -eq "Running" -and $_.Name -notmatch "^CDP|BITS|Broker|Dcom|Dhcp|Dnscache|DoSvc|DPS|Event|gpsvc|IKE|iphlp|KeyIso|Lanman|lfsvc|lmhosts|Nca|Ncb|Nla|Plug|Power|Prof|Ras|Rpc|Sam|Schedule|SENS|SessionEnv|ShellHWDetection|Spooler|StateRepository|StorSvc|SysMain|SystemEventsBroker|Tablet|Task|Themes|Time|TrkWks|UmRdp|Uso|Vault|Wcmsvc|Wdi|WebClient|WinHttp|Winmgmt|Wlan|Wpn|wuauserv|Wwan"} | Sort-Object DisplayName | FT Name, DisplayName, Status
```

Check Firewall Status and Rules:
```powershell
Get-NetFirewallProfile | Format-Table Name, Enabled
# Review enabled inbound allow rules (excluding core networking)
Get-NetFirewallRule -Direction Inbound -Action Allow -Enabled True | Where-Object {$_.Group -notlike "@*" -and $_.DisplayName -notlike "Core Networking*"} | Sort-Object DisplayName | Format-Table Name, DisplayName, Description, Profile, Enabled
```

Check Scheduled Tasks (Enabled):
```powershell
Get-ScheduledTask | Where-Object {$_.State -eq 'Ready' -or $_.State -eq 'Running'} | Format-Table TaskPath, TaskName, State
```

Check Network Connections:
```powershell
Get-NetTCPConnection -State Listen | Format-Table LocalAddress, LocalPort, OwningProcess
Get-NetTCPConnection | Where-Object {$_.State -eq "Established"} | Format-Table LocalAddress, LocalPort, RemoteAddress, RemotePort, OwningProcess
```

Check Shared Folders:
```powershell
Get-SmbShare | Format-Table Name, Path, ScopeName
Get-SmbShareAccess -Name "*" # Check permissions on shares
```

Check Registry Run Keys:
```powershell
Get-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run"
Get-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
# Add Wow6432Node if needed: Get-ItemProperty "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run"
```

---
*Checklist Version X.Y - Last Updated YYYY-MM-DD*
*Remember to adapt based on the specific competition image and README.*
