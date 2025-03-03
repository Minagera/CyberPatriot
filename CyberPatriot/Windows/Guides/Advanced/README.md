# Windows Registry Security Hardening

This advanced guide covers techniques for securing the Windows Registry, a critical database of settings that controls the behavior of the Windows operating system. Registry security is an important aspect of advanced Windows hardening that is often overlooked in standard security procedures.

## Table of Contents

- [Understanding the Windows Registry](#understanding-the-windows-registry)
- [Registry Security Risks](#registry-security-risks)
- [Registry Structure and Key Security Components](#registry-structure-and-key-security-components)
- [Registry Permissions and Access Control](#registry-permissions-and-access-control)
- [Registry Security Best Practices](#registry-security-best-practices)
- [Critical Registry Keys to Secure](#critical-registry-keys-to-secure)
- [Securing Login and Authentication](#securing-login-and-authentication)
- [Securing Windows Services in the Registry](#securing-windows-services-in-the-registry)
- [Mitigating Autorun Vulnerabilities](#mitigating-autorun-vulnerabilities)
- [Detecting and Removing Registry-Based Malware](#detecting-and-removing-registry-based-malware)
- [Registry Security Monitoring](#registry-security-monitoring)
- [Registry Security for CyberPatriot Competitions](#registry-security-for-cyberpatriot-competitions)

## Understanding the Windows Registry

The Windows Registry is a hierarchical database that stores configuration settings and options for Windows operating systems. It contains information and settings for hardware, operating system software, most non-operating system software, and per-user settings.

### Why the Registry Matters for Security

- It controls critical operating system behavior
- Malware often uses the Registry for persistence
- Security settings can be modified through Registry keys
- Sensitive data might be stored in Registry values
- Unauthorized changes can compromise system security
- Many security hardening steps require Registry modifications

## Registry Security Risks

Common security threats related to the Windows Registry include:

1. **Persistence mechanisms** - Malware adding startup entries to maintain presence after reboots
2. **Privilege escalation** - Exploiting misconfigured Registry permissions to gain elevated rights
3. **Information disclosure** - Sensitive data stored in the Registry in cleartext
4. **Security control bypasses** - Disabling security features by modifying Registry settings
5. **Configuration tampering** - Changing system behavior by modifying Registry settings
6. **Denial of service** - Corrupting critical Registry keys causing system instability

## Registry Structure and Key Security Components

The Registry is organized into logical sections called hives:

| Hive | Description | Security Significance |
|------|-------------|----------------------|
| HKEY_LOCAL_MACHINE (HKLM) | System-wide settings | Contains critical security settings that affect all users |
| HKEY_CURRENT_USER (HKCU) | Current user settings | Contains user-specific security settings and application configurations |
| HKEY_USERS (HKU) | All users' profiles | Contains security settings for all user profiles on the system |
| HKEY_CLASSES_ROOT (HKCR) | File association and COM data | Can contain vulnerabilities in file type handling or COM objects |
| HKEY_CURRENT_CONFIG (HKCC) | Current hardware profile | Contains hardware-specific settings |

## Registry Permissions and Access Control

### Viewing and Modifying Registry Permissions

1. Open **Registry Editor**:
   - Press **Win+R**, type `regedit`, and press **Enter**
   - Accept the UAC prompt

2. Navigate to the key you want to secure

3. Right-click on the key and select **Permissions**

4. Click **Advanced** for detailed permissions settings

5. You can configure:
   - Owner of the key
   - Permission entries
   - Inheritance settings
   - Auditing (when configured)

### Types of Registry Permissions

- **Full Control** - Complete access to the key and subkeys
- **Read** - Ability to view key contents
- **Special Permissions** - Customized permissions including:
  - **Query Value** - Read values
  - **Set Value** - Create or modify values
  - **Create Subkey** - Create new keys under this key
  - **Enumerate Subkeys** - List subkeys
  - **Notify** - Receive change notifications
  - **Create Link** - Create symbolic links
  - **Delete** - Remove the key
  - **Write DAC** - Change permissions
  - **Write Owner** - Change ownership
  - **Read Control** - Read security information

## Registry Security Best Practices

### Use Least Privilege Principle

1. Review default permissions on sensitive Registry keys
2. Remove unnecessary permissions, especially from the Everyone and Users groups
3. Ensure only authorized administrators can modify security-related keys

### Implement Registry Access Auditing

1. Open **Local Security Policy** (`secpol.msc`)
2. Navigate to **Security Settings** → **Local Policies** → **Audit Policy**
3. Enable **Audit object access** for success and failure events
4. Use Advanced Security Settings in Registry Editor to configure auditing on critical keys

### Backup Critical Registry Keys

Before making changes:
1. Select the key in Registry Editor
2. Go to **File** → **Export**
3. Save the .reg file with a descriptive name
4. Store backups securely

### Restrict Remote Registry Access

1. Disable the Remote Registry service when not needed:
   - Open **Services** (`services.msc`)
   - Find **Remote Registry**
   - Stop the service and set Startup type to **Disabled**

2. Use Windows Firewall to block remote Registry access:
   - Block TCP port 135 (RPC Endpoint Mapper) on public networks
   - Create a restricted inbound rule for private networks if needed

## Critical Registry Keys to Secure

### System Security Settings

```
HKLM\SYSTEM\CurrentControlSet\Control\Lsa
```
Contains Local Security Authority settings including authentication packages and security providers.

Important values to secure:
- `LmCompatibilityLevel`: Set to `5` to use NTLMv2 only
- `RestrictAnonymous`: Set to `1` to restrict anonymous access
- `RestrictAnonymousSAM`: Set to `1` to prevent anonymous enumeration of accounts
- `NoLMHash`: Set to `1` to prevent storing LM hash in SAM

### Windows Services

```
HKLM\SYSTEM\CurrentControlSet\Services
```
Contains configuration for all Windows services. Malware often creates services here.

Security measures:
- Restrict write access to administrators only
- Regularly audit new or modified services
- Monitor for suspicious service configurations

### System Startup

```
HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce
HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce
```

These keys control programs that start automatically. They are common targets for malware persistence.

Security measures:
- Restrict write access to administrators
- Regularly review startup entries
- Remove unauthorized entries

### Winlogon Process

```
HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon
```

Controls Windows logon process, including custom notification packages and automatic logon.

Important values to secure:
- `AutoAdminLogon`: Ensure set to `0` unless auto-login is required
- `DefaultPassword`: Should not contain a plaintext password
- `Shell`: Should be set to `explorer.exe`

## Securing Login and Authentication

### Disable Cached Logons

When users log on to a domain, Windows caches credentials to allow logon when the domain controller isn't available. This can be a security risk.

Registry path:
```
HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon
```

Set value:
- `CachedLogonsCount` to `0` (disables caching)
- Or to a low number like `1` or `2` if caching is required

### Prevent Windows from Storing LM Hashes

LM hashes are weak and can be easily cracked. Prevent Windows from storing them.

Registry path:
```
HKLM\SYSTEM\CurrentControlSet\Control\Lsa
```

Set value:
- `NoLMHash` to `1`

### Require Ctrl+Alt+Del for Login

Enforce Ctrl+Alt+Del before login to prevent keyloggers from capturing credentials.

Registry path:
```
HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
```

Set value:
- `DisableCAD` to `0`

## Securing Windows Services in the Registry

Malware often creates or modifies services to maintain persistence. Secure service-related Registry keys:

### Monitor for Suspicious Services

Check for unauthorized services in:
```
HKLM\SYSTEM\CurrentControlSet\Services
```

Look for:
- Services with unusual names or descriptions
- Services with executable paths in temporary directories
- Services running as SYSTEM that don't need elevated privileges
- Recently created services that don't match installed software

### Secure Service Permissions

For critical services:
1. Navigate to the service key
2. Right-click and select **Permissions**
3. Restrict write access to Administrators only
4. Consider enabling auditing for changes

## Mitigating Autorun Vulnerabilities

Autorun functionality can be exploited to automatically execute malware when removable media is connected.

### Disable AutoRun

Registry path:
```
HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer
```

Set values:
- `NoDriveTypeAutoRun` to `0xFF` (disables for all drive types)
- `NoAutorun` to `1`

### Disable AutoPlay

Registry path:
```
HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer
```

Set value:
- `NoAutoplayfornonVolume` to `1`

Registry path:
```
HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer
```

Set value:
- `NoAutoplayfornonVolume` to `1`

## Detecting and Removing Registry-Based Malware

### Common Malware Registry Locations

Look for suspicious entries in these locations:

1. **Run keys** (persistence):
   ```
   HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
   HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce
   HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
   HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce
   ```

2. **Startup folder entries**:
   ```
   HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders
   HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders
   HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders
   HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders
   ```

3. **Service entries**:
   ```
   HKLM\SYSTEM\CurrentControlSet\Services
   ```

4. **Browser helper objects and extensions**:
   ```
   HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects
   HKLM\SOFTWARE\Microsoft\Internet Explorer\Extensions
   ```

5. **Winlogon entries**:
   ```
   HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\Notify
   HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\Shell
   HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\Userinit
   ```

### Registry Analysis Process

1. Export the Run key:
   ```
   reg export "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" run_keys.txt
   ```

2. Export the Services key:
   ```
   reg export "HKLM\SYSTEM\CurrentControlSet\Services" services.txt
   ```

3. Review the exports for:
   - Unfamiliar entries
   - Paths to unusual locations
   - Obfuscated command lines
   - Misspelled names that look like legitimate programs

4. For suspicious entries, search online for the exact name to determine if it's known malware

## Registry Security Monitoring

### Enable Registry Auditing

1. Open **Local Security Policy** (`secpol.msc`)
2. Navigate to **Security Settings** → **Local Policies** → **Audit Policy**
3. Set **Audit object access** to **Success and Failure**

4. In **Registry Editor**:
   - Navigate to the key you want to audit
   - Right-click and select **Permissions**
   - Click **Advanced**
   - Go to the **Auditing** tab
   - Add auditing entries for appropriate users and groups

### Using PowerShell for Registry Monitoring

Create a script to monitor critical Registry keys:

```powershell
# Define keys to monitor
$keysToMonitor = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run",
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce",
    "HKLM:\SYSTEM\CurrentControlSet\Services"
)

# Create baseline
$baseline = @{}
foreach ($key in $keysToMonitor) {
    $baseline[$key] = Get-ItemProperty -Path $key
}

# Monitor for changes
while ($true) {
    foreach ($key in $keysToMonitor) {
        $current = Get-ItemProperty -Path $key
        $diff = Compare-Object -ReferenceObject $baseline[$key].PSObject.Properties -DifferenceObject $current.PSObject.Properties
        
        if ($diff) {
            Write-Host "ALERT: Changes detected in $key" -ForegroundColor Red
            foreach ($change in $diff) {
                Write-Host "  Changed: $($change.InputObject.Name)" -ForegroundColor Yellow
            }
            
            # Update baseline
            $baseline[$key] = $current
        }
    }
    
    # Wait before next check
    Start-Sleep -Seconds 300
}
```

## Registry Security for CyberPatriot Competitions

During CyberPatriot competitions, focus on these Registry security areas:

### Competition Registry Checklist

1. **Check Startup Items**:
   - Examine all Run keys for unauthorized programs
   - Remove any suspicious entries

2. **Verify Service Configurations**:
   - Check for unusual services
   - Verify service permissions

3. **Secure Authentication Settings**:
   - Enforce strong authentication policies in the LSA key
   - Disable LM hash storage

4. **Disable Risky Features**:
   - Disable AutoRun/AutoPlay
   - Disable clear-text password storage

5. **Check User Account Settings**:
   - Verify password policies are properly configured
   - Check for unauthorized auto-login settings

### PowerShell Script for Competition Registry Check

```powershell
# CyberPatriot Registry Security Checker

Write-Host "CyberPatriot Registry Security Checker" -ForegroundColor Cyan
Write-Host "===================================" -ForegroundColor Cyan

# Check startup items
Write-Host "`nChecking Startup Items..." -ForegroundColor Yellow
$runKeys = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run",
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce",
    "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run",
    "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce"
)

foreach ($key in $runKeys) {
    if (Test-Path $key) {
        Write-Host "Items in $key:" -ForegroundColor Green
        Get-ItemProperty -Path $key | Format-Table -AutoSize
    }
}

# Check LSA settings
Write-Host "`nChecking LSA Security Settings..." -ForegroundColor Yellow
$lsaKey = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$lsaSettings = Get-ItemProperty -Path $lsaKey

Write-Host "LmCompatibilityLevel: $($lsaSettings.LmCompatibilityLevel)"
Write-Host "NoLMHash: $($lsaSettings.NoLMHash)"
Write-Host "RestrictAnonymous: $($lsaSettings.RestrictAnonymous)"
Write-Host "RestrictAnonymousSAM: $($lsaSettings.RestrictAnonymousSAM)"

# Check AutoRun settings
Write-Host "`nChecking AutoRun Settings..." -ForegroundColor Yellow
$explorerKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
if (Test-Path $explorerKey) {
    $autorunSettings = Get-ItemProperty -Path $explorerKey
    Write-Host "NoDriveTypeAutoRun: $($autorunSettings.NoDriveTypeAutoRun)"
    Write-Host "NoAutorun: $($autorunSettings.NoAutorun)"
}

# Check Winlogon settings
Write-Host "`nChecking Winlogon Settings..." -ForegroundColor Yellow
$winlogonKey = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
$winlogonSettings = Get-ItemProperty -Path $winlogonKey

Write-Host "AutoAdminLogon: $($winlogonSettings.AutoAdminLogon)"
if ($winlogonSettings.DefaultPassword) {
    Write-Host "DefaultPassword is set! This is a security risk." -ForegroundColor Red
}
Write-Host "Shell: $($winlogonSettings.Shell)"
Write-Host "Userinit: $($winlogonSettings.Userinit)"
```

## Practical Exercise: Registry Security Hardening

1. Export Registry keys before making changes
2. Create a new security baseline for your competition system:
   - Disable AutoRun functionality
   - Ensure LM hashes aren't stored
   - Configure proper LSA security settings
   - Restrict anonymous access to system information
   - Enable UAC through Registry settings
3. Verify changes with `reg query` commands
4. Test system functionality after changes

## Additional Resources

- [Microsoft Registry Documentation](https://docs.microsoft.com/en-us/windows/win32/sysinfo/registry)
- [SANS Windows Registry Forensics](https://www.sans.org/security-resources/posters/windows-forensics-evidence-of/75/download)
- [CIS Windows Registry Security Recommendations](https://www.cisecurity.org/benchmark/microsoft_windows_desktop/)
- [Microsoft Security Compliance Toolkit](https://www.microsoft.com/en-us/download/details.aspx?id=55319)

## Next Steps

After mastering Registry security, consider exploring:
- [Windows Kernel Security](./Windows_Kernel_Security.md)
- [Advanced Threat Hunting](./Windows_Threat_Hunting.md)
- Try the [Registry Hardening Exercise](../../Exercises/Registry_Hardening_Exercise.md)
