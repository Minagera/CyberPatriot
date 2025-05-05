# Windows Security Checklist for CyberPatriot (Unique & Actionable - 25-26 Season)

## CRITICAL FIRST STEP: Read the Competition README File!
Before ANY changes, dissect the README. Note: Required Services/Users, Prohibited Actions, Scored Tasks, Forensic Questions, Overrides to Best Practices. **README IS LAW!** Document constraints.

---

**Workflow Suggestion:** Recon/README -> Users -> Persistence -> Services/Apps -> Policies -> Network -> Forensics -> Verify Score

---

## User Account Management (`lusrmgr.msc`, `net user`, `Get-LocalUser`, `secpol.msc`)

### Account Review & Cleanup
- [ ] **Read README:** Identify ALL authorized users & groups. Document them.
- [ ] List local users: `Get-LocalUser | Format-Table Name, Enabled, LastLogon` or `lusrmgr.msc`.
- [ ] **Remove unauthorized user accounts** (`net user <user> /delete` or `Remove-LocalUser -Name <user>`). Verify against authorized list.
- [ ] **Disable unnecessary accounts** (e.g., unused app accounts - check README). `Disable-LocalUser -Name <user>` or `net user <user> /active:no`.
- [ ] **Disable built-in Guest account** (Verify SID S-1-5-32-546). `Disable-LocalUser -Name Guest` or `net user Guest /active:no`.
- [ ] **Rename Administrator account** (ONLY if allowed by README). `Rename-LocalUser -Name Administrator -NewName <NewAdminName>` or `secpol.msc`. Document new name.
- [ ] **Rename Guest account** (ONLY if allowed by README). `Rename-LocalUser -Name Guest -NewName <NewGuestName>` or `secpol.msc`. Document new name.

### Password Security
- [ ] **Change ALL passwords** for remaining users (including renamed Admin) to strong, unique passwords compliant with policy (`net user <user> *` or `Set-LocalUser`). Document securely!
- [ ] Check "Password never expires": `Get-LocalUser | Select Name,PasswordNeverExpires`. Uncheck (`Set-LocalUser -Name <user> -PasswordNeverExpires $false`) unless required by README.
- [ ] Check "User cannot change password": `Get-LocalUser | Select Name,UserMayNotChangePassword`. Uncheck (`Set-LocalUser -Name <user> -UserMayNotChangePassword $false`) unless required.

### Group Membership (`lusrmgr.msc`, `net localgroup`, `Get-LocalGroupMember`)
- [ ] Review **Administrators** group members: `Get-LocalGroupMember Administrators`. Remove ALL unauthorized users/groups (`Remove-LocalGroupMember Administrators -Member <user>`). Apply Least Privilege rigorously.
- [ ] Review **Remote Desktop Users** group members: `Get-LocalGroupMember 'Remote Desktop Users'`. Remove unauthorized. Check README for RDP allowance.
- [ ] Review other sensitive groups (Backup Operators, Power Users, etc.). Remove unauthorized members.

### User Rights (`secpol.msc` -> Local Policies -> User Rights Assignment)
- [ ] Review sensitive rights (Debug programs, Act as part of OS, Take ownership, Backup/Restore files). Remove unauthorized users/groups.
- [ ] Deny access to this computer from the network: Add `Guest` and potentially other non-admin groups.
- [ ] Deny log on locally: Add `Guest`.
- [ ] Deny log on through Remote Desktop Services: Add `Guest` and other unauthorized/non-admin groups if RDP is restricted/disabled per README.

---

## Windows Security Features

### Windows Defender Antivirus (`Windows Security` App, `Get-MpComputerStatus`, `Get-MpPreference`)
- [ ] Verify Real-time protection is **Enabled**: `(Get-MpComputerStatus).RealTimeProtectionEnabled` or `(Get-MpPreference).DisableRealtimeMonitoring -eq $false`. Enable if disabled (`Set-MpPreference -DisableRealtimeMonitoring $false`).
- [ ] Verify Virus & threat definitions are **Up to date** (if internet allowed/possible). Check `Windows Security` app or `(Get-MpComputerStatus).AntispywareSignatureVersion`.
- [ ] Run a **Quick Scan** (if time permits/allowed): `Start-MpScan -ScanType QuickScan`. Check history/quarantine in `Windows Security` app.

### Windows Defender Firewall (`wf.msc`, `Get-NetFirewallProfile`, `Get-NetFirewallRule`)
- [ ] Verify Firewall is **Enabled** for ALL profiles: `Get-NetFirewallProfile | Select Name, Enabled`. Enable if needed (`Set-NetFirewallProfile -Profile Domain,Private,Public -Enabled True`).
- [ ] Set Default Inbound action to **Block**: `Get-NetFirewallProfile | Select Name, DefaultInboundAction`. Set if needed (`Set-NetFirewallProfile -Profile Domain,Private,Public -DefaultInboundAction Block`).
- [ ] Set Default Outbound action to **Allow** (Default). Verify: `Get-NetFirewallProfile | Select Name, DefaultOutboundAction`.
- [ ] Review **Inbound Rules**: `Get-NetFirewallRule -Direction Inbound -Action Allow -Enabled True | Sort-Object DisplayName | Format-Table Name, DisplayName, Profile, Enabled -AutoSize`. Disable/remove suspicious/unnecessary rules.
- [ ] Review **Outbound Rules** (less common focus): `Get-NetFirewallRule -Direction Outbound -Action Block -Enabled True`. Check for suspicious blocks.
- [ ] **Create necessary Allow rules** ONLY for required services/ports specified in the README. Be specific (Program/Port/Protocol/Scope). Use `wf.msc` or `New-NetFirewallRule`.

### User Account Control (UAC) (`secpol.msc` or `UserAccountControlSettings.exe`)
- [ ] Ensure UAC is **Enabled**: Check `secpol.msc` -> Security Options -> "Run all administrators in Admin Approval Mode" is `Enabled`. Verify prompt behavior is reasonable (Default level usually OK). Registry: `(Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System').EnableLUA -eq 1`.

### Windows Updates (`Settings` > `Update & Security`, `Get-HotFix`)
- [ ] Check for/Install updates **ONLY IF** required or explicitly allowed by README and time/network permits. Note status if required.

---

## Services and Applications

### Disable Unnecessary Services (`services.msc`, `Get-Service`, `Get-CimInstance Win32_Service`)
- [ ] **Read README:** Identify required services. Document them.
- [ ] List running/auto-start services: `Get-Service | Where-Object {$_.Status -eq 'Running' -or $_.StartType -eq 'Automatic'} | Sort-Object DisplayName`.
- [ ] Identify potentially unnecessary/risky services (Telnet, Remote Registry, Fax, Print Spooler (if no printing), Web Server (IIS/Apache if not required), Third-party updaters, SNMP Trap/Service).
- [ ] **Disable** unnecessary services (Verify against README first!): `Set-Service -Name <ServiceName> -StartupType Disabled; Stop-Service -Name <ServiceName> -Force`.
- [ ] Investigate suspicious services (Name, Description, `PathName` via `Get-CimInstance Win32_Service`). Check path for legitimacy.

### Application Security (`Settings` > `Apps`, `Get-Package`, `Get-CimInstance Win32_Product`)
- [ ] **Read README:** Identify authorized/required applications.
- [ ] **Uninstall unauthorized software** (Check README!). Look for games, hacking tools (Wireshark, Nmap unless allowed), P2P, unauthorized remote access (VNC, TeamViewer), unknown programs. Use Settings > Apps or `Uninstall-Package`.
- [ ] Remove unauthorized browser extensions/plugins (Manual check per browser).

### Remote Access (`SystemPropertiesRemote.exe`, `Settings`, `Get-LocalGroupMember 'Remote Desktop Users'`)
- [ ] **Disable or secure Remote Desktop** (Allow connections with NLA) - **Check README FIRST!** If allowed, ensure ONLY authorized users are in `Remote Desktop Users` group. Disable via System Properties > Remote if not allowed.
- [ ] Disable Remote Assistance if not needed/allowed (System Properties > Remote).

---

## Security Policies (`secpol.msc`)

*(Verify settings via `secpol.msc` GUI)*

### Password Policy (`Account Policies` > `Password Policy`)
- [ ] Enforce password history: `5-24` passwords remembered.
- [ ] Maximum password age: `60-90` days (per README).
- [ ] Minimum password age: `1` day (per README).
- [ ] Minimum password length: `12-14` characters (per README).
- [ ] Password must meet complexity requirements: `Enabled`.
- [ ] Store passwords using reversible encryption: `Disabled`.

### Account Lockout Policy (`Account Policies` > `Account Lockout Policy`)
- [ ] Account lockout threshold: `3-5` invalid logon attempts.
- [ ] Account lockout duration: `15-30` minutes.
- [ ] Reset account lockout counter after: `15-30` minutes.

### Audit Policy (`Local Policies` > `Audit Policy` OR Advanced Audit Policy Configuration) - Enable Success & Failure
- [ ] Audit account logon events: `Success, Failure`.
- [ ] Audit account management: `Success, Failure`. (Crucial for tracking user/group changes)
- [ ] Audit logon events: `Success, Failure`. (Crucial for tracking logins/logoffs)
- [ ] Audit object access: `Failure` (Enable Success only if specific object auditing is needed & configured).
- [ ] Audit policy change: `Success, Failure`. (Track changes to policies)
- [ ] Audit privilege use: `Failure` (Success can be very noisy).
- [ ] Audit process tracking: `Failure` (Enable Success for Process Creation ID 4688 if needed for forensics). **Enable Command Line Auditing via GPO/Registry if possible.**
- [ ] Audit system events: `Success, Failure`.
    *Advanced:* Use `auditpol.exe /get /category:*` to view. Use `auditpol.exe /set /subcategory:"User Account Management" /success:enable /failure:enable` etc. for granular control.

### User Rights Assignment (`Local Policies` > `User Rights Assignment`)
- *Covered partially in User Management.* Review others like "Allow log on through Remote Desktop Services", "Access this computer from the network".

### Security Options (`Local Policies` > `Security Options`)
- [ ] Interactive logon: Message text/title for logon attempts: Set appropriate warning banner.
- [ ] Interactive logon: Do not display last user name: `Enabled`.
- [ ] Network access: Do not allow anonymous enumeration of SAM accounts: `Enabled`.
- [ ] Network access: Do not allow anonymous enumeration of SAM accounts and shares: `Enabled`.
- [ ] Accounts: Rename administrator account: (See User Management).
- [ ] Accounts: Rename guest account: (See User Management).
- [ ] User Account Control: Run all administrators in Admin Approval Mode: `Enabled`. (See Security Features).
- [ ] Network security: LAN Manager authentication level: `Send NTLMv2 response only. Refuse LM & NTLM`.
- [ ] Shutdown: Allow system to be shut down without having to log on: `Disabled`.

---

## File System Security (`icacls`, `Get-Acl`)

- [ ] Check permissions on critical directories (`C:\Windows`, `C:\Program Files`, `C:\Users`). Ensure Administrators/SYSTEM have Full Control, Users have Read/Execute. Remove excessive permissions (e.g., `Everyone Full Control`, `Users Full Control`). Use `icacls <path>` to view, `icacls <path> /remove Everyone` etc.
- [ ] Search for world-writable directories/files (Advanced: Use PowerShell `Get-ChildItem -Recurse | Get-Acl | Where-Object {$_.Access | Where-Object {$_.IdentityReference -eq 'Everyone' -and $_.FileSystemRights -like '*Write*'}}`). Fix insecure permissions (`icacls <path> /remove Everyone` or `/inheritance:d`).
- [ ] Search for large media files (`.mp3`, `.mp4`, `.avi`, etc.) if prohibited by README. `Get-ChildItem C:\ -Recurse -Include *.mp3,*.mp4,*.avi -ErrorAction SilentlyContinue | Select FullName, Length`

---

## Network Security

### Network Shares (`fsmgmt.msc`, `Get-SmbShare`, `Get-SmbShareAccess`)
- [ ] **Read README:** Identify required shares.
- [ ] **Remove unnecessary shares:** `Remove-SmbShare -Name <ShareName> -Force`.
- [ ] Secure required shares:
    -   Review **Share Permissions**: `Get-SmbShareAccess -Name <ShareName>`. Apply Least Privilege (`Grant-SmbShareAccess` / `Revoke-SmbShareAccess`). Avoid `Everyone`. Use `Authenticated Users` or specific groups.
    -   Review **NTFS Permissions** on the shared folder (`icacls <FolderPath>`). Ensure they are also restrictive (most restrictive wins).
- [ ] Disable SMBv1 (if possible/allowed): `Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart`

### Hosts File (`C:\Windows\System32\drivers\etc\hosts`)
- [ ] Check `hosts` file: `Get-Content C:\Windows\System32\drivers\etc\hosts`. Remove malicious/unexpected entries (Edit manually or `Set-Content`).

---

## Search for Forensics Questions / Persistence

- [ ] **Read README:** Note ALL forensic questions carefully.
- [ ] Search common locations for clues: Desktop, Documents, Downloads, Temp (`$env:TEMP`, `C:\Windows\Temp`), Recycle Bin (`$Recycle.Bin`), User Profiles (`C:\Users`). Use `findstr` or `Select-String -Path C:\Users\*.txt -Pattern 'password'` etc.
- [ ] Check **Registry Run/RunOnce Keys**: `Get-ItemProperty 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Run'`, `Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run'`, `...RunOnce`. Use `regedit` for GUI view. Remove malicious entries (`Remove-ItemProperty`).
- [ ] Check **Scheduled Tasks**: `Get-ScheduledTask | Where-Object {$_.State -ne 'Disabled'} | Format-Table TaskPath, TaskName, State, Author`. Use `taskschd.msc` for GUI. Look for suspicious names, triggers, actions (paths, arguments), authors. Disable/remove malicious tasks (`Unregister-ScheduledTask`).
- [ ] Check **Startup Folders**: User (`$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup`), All Users (`$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\Startup`). Remove malicious shortcuts/scripts.
- [ ] Check **Services**: `Get-CimInstance -ClassName Win32_Service | Select Name, State, StartMode, PathName`. Use `services.msc`. Look for unusual services, suspicious `PathName`, bad descriptions, weird dependencies, or malicious recovery options. Disable/fix malicious services (`Set-Service`, `Stop-Service`).
- [ ] Check **Event Logs** (`eventvwr.msc`): Filter Security/System/Application logs. Use `Get-WinEvent`. Filter by Time, Event ID (Logon 4624/4625, User Create 4720, Group Add 4732, Service Install 7045, Process Create 4688 - requires Command Line Auditing), Keywords from questions.
- [ ] Check Browser History/Extensions (Manual check per browser).
- [ ] Check `hosts` file (as above).
- [ ] Use `findstr /S /I /M "keyword" C:\*.*` or `Select-String` for broad file content searches if needed.

---

## Common CyberPatriot Scoring Items (Verify based on README)

- [ ] Unauthorized users removed / Passwords changed & strong
- [ ] Administrator account secured (Renamed if allowed) / Guest disabled
- [ ] Password policy configured (Length, Complexity, History, Age)
- [ ] Account lockout policy configured
- [ ] Windows Defender enabled & updated (if possible)
- [ ] Windows Firewall enabled & configured correctly (Profiles, Default Actions, Rules per README)
- [ ] Windows Updates installed (if allowed/required)
- [ ] Unnecessary/Insecure services disabled (per README)
- [ ] Malware/Persistence removed (Tasks, Run Keys, Services, Files, Startup)
- [ ] Unauthorized software removed
- [ ] File sharing secured (Share/NTFS Permissions, SMBv1 disabled if allowed)
- [ ] Audit policies enabled (Logon, Account Mgmt, Policy Change)
- [ ] Security banners configured (Interactive Logon Message)
- [ ] Secure remote access configured (RDP disabled or secured per README)
- [ ] Answering Forensics Questions correctly

---

## Quick PowerShell Commands (Run as Administrator - Verification/Recon)

Users & Groups:
```powershell
Get-LocalUser | Where-Object {$_.Enabled -eq $true} | Format-Table Name, Description, Enabled, LastLogon
Get-LocalGroupMember -Group "Administrators"
Get-LocalGroupMember -Group "Remote Desktop Users"
# Get-LocalGroup | ForEach-Object { $group = $_; Write-Host "`nGroup: $($group.Name)"; Get-LocalGroupMember -Group $group.Name | Select Name, PrincipalSource } # List all groups/members
```

Services:
```powershell
Get-Service | Where-Object {$_.Status -eq "Running"} | Sort-Object DisplayName | Format-Table Name, DisplayName, Status
Get-CimInstance -ClassName Win32_Service | Select-Object Name, DisplayName, State, StartMode, PathName | Sort-Object Name | Format-Table -Wrap
```

Firewall:
```powershell
Get-NetFirewallProfile | Format-Table Name, Enabled, DefaultInboundAction, DefaultOutboundAction
Get-NetFirewallRule -Direction Inbound -Action Allow -Enabled True | Where-Object {$_.DisplayName -notlike "Core Networking*"} | Sort-Object DisplayName | Format-Table Name, DisplayName, Description, Profile, Enabled -AutoSize
```

Shares:
```powershell
Get-SmbShare | Format-Table Name, Path, ScopeName
# Get-SmbShare | ForEach-Object { Write-Host "`nShare: $($_.Name)"; Get-SmbShareAccess -Name $_.Name } # Show Share Permissions
```

Persistence:
```powershell
Get-ItemProperty 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Run'
Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run'
Get-ScheduledTask | Where-Object {$_.State -ne 'Disabled'} | Format-Table TaskPath, TaskName, State, Author
Get-ChildItem "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
Get-ChildItem "$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\Startup"
```

System Info:
```powershell
Get-ComputerInfo | Select-Object OsName, OsVersion, CsName, CsUserName # Basic OS Info
(Get-MpComputerStatus).RealTimeProtectionEnabled # Defender Status
(Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System').EnableLUA # UAC Status
```

---
*Remember: Document changes meticulously, check scoring engine often, and always prioritize the README!*
