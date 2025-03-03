# Windows Security Fundamentals Quiz - SOLUTION KEY

## MENTOR ACCESS ONLY - Do Not Share With Cadets

## Multiple Choice Questions (2 points each)

### 1. Which Windows feature provides a central location to view security status and manage security settings?

**Answer: D. Windows Security**

Explanation: Windows Security (previously called Windows Defender Security Center in earlier versions) is the central dashboard for managing security settings in Windows 10/11. It includes sections for virus protection, account protection, firewall, and other security features.

### 2. Which of the following user account types has the most privileges on a Windows system?

**Answer: B. Administrator**

Explanation: Administrator accounts have full control over the system, including the ability to install software, change system settings, and modify other user accounts. They have the highest level of privileges among standard account types.

### 3. What is the minimum recommended password length according to CyberPatriot guidelines?

**Answer: C. 12 characters**

Explanation: CyberPatriot recommends a minimum of 12 characters for passwords, which aligns with many modern security standards. Longer passwords provide better protection against brute force attacks.

### 4. Which Windows service should be disabled to prevent remote management of the registry?

**Answer: A. Remote Registry**

Explanation: The Remote Registry service allows remote users to modify registry settings on the computer. Disabling this service prevents remote manipulation of the registry, which is a security best practice when remote registry management is not needed.

### 5. What is the recommended account lockout threshold for failed login attempts?

**Answer: B. 5 attempts**

Explanation: A threshold of 5 failed login attempts is generally recommended as it balances security (preventing brute force attacks) with usability (not locking out legitimate users who occasionally mistype passwords).

### 6. Which of the following is NOT a common location for malware persistence in Windows?

**Answer: D. System32 folder (itself)**

Explanation: While malware may place files in the System32 folder, the folder itself is not a persistence mechanism. The other options (Run keys, Startup folder, and Scheduled Tasks) are all common methods for malware to ensure it runs again after system restart.

### 7. What Windows feature helps prevent unauthorized changes to the system by prompting for permission?

**Answer: B. User Account Control (UAC)**

Explanation: User Account Control (UAC) displays prompts when programs attempt to make changes to the system. It helps prevent unauthorized software from making changes without the user's knowledge.

### 8. Which built-in Windows account should typically be disabled?

**Answer: B. Guest**

Explanation: The Guest account provides limited access to the system and is disabled by default in modern Windows versions. It should remain disabled as it can be a security risk if enabled.

### 9. What Windows tool is used to view and monitor security-related events?

**Answer: C. Event Viewer**

Explanation: Event Viewer is the Windows tool used to view and analyze event logs, including security events. It allows administrators to monitor login attempts, security policy changes, and other security-related activities.

### 10. Which Windows component is responsible for enforcing password policies?

**Answer: A. Local Security Authority (LSA)**

Explanation: The Local Security Authority (LSA) is responsible for enforcing security policies, including password policies. It validates users logging on to the system and enforces password requirements.

### 11. What is the default location of the Windows user account database (SAM)?

**Answer: B. C:\Windows\System32\config\SAM**

Explanation: The Security Account Manager (SAM) database is stored in the C:\Windows\System32\config directory. This database contains the hashed passwords and security information for local user accounts.

### 12. Which of the following registry keys contains startup programs that run when a user logs in?

**Answer: A. HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run**

Explanation: This registry key contains entries for programs that start automatically when any user logs in. Programs listed here run for all users on the system. The HKCU version runs only for the current user.

### 13. What Windows feature can encrypt the entire operating system drive to protect data?

**Answer: B. BitLocker**

Explanation: BitLocker is Microsoft's full-disk encryption feature that can encrypt entire volumes, including the operating system drive. EFS only encrypts individual files and folders, not the entire drive.

### 14. Which tool can be used to manage local security policy on Windows systems?

**Answer: A. secpol.msc**

Explanation: The secpol.msc tool opens the Local Security Policy editor, which is used to configure security settings on Windows systems. Gpedit.msc is the Group Policy editor, lusrmgr.msc manages local users and groups, and services.msc manages services.

### 15. What command line tool can be used to view all user accounts on a Windows system?

**Answer: A. net users**

Explanation: The "net users" command lists all local user accounts on a Windows system. It can also be used to add, remove, or modify user accounts when used with additional parameters.

## True/False Questions (1 point each)

### 16. The built-in Administrator account cannot be deleted, only disabled.

**Answer: True**

Explanation: The built-in Administrator account is a system account that cannot be deleted. It can only be disabled, renamed, or have its password changed. This ensures there is always a way to administer the system.

### 17. Windows 11 Home edition includes the Local Group Policy Editor (gpedit.msc).

**Answer: False**

Explanation: Windows 11 Home edition does not include the Local Group Policy Editor (gpedit.msc). This tool is only available in Pro, Enterprise, and Education editions of Windows.

### 18. Password complexity requirements enforce the use of uppercase letters, lowercase letters, numbers, and special characters.

**Answer: True**

Explanation: When enabled, password complexity requirements in Windows typically require that passwords contain characters from at least three of the following four categories: uppercase letters, lowercase letters, numbers, and special characters.

### 19. Windows Update can be safely disabled in a competition environment to prevent unexpected changes.

**Answer: False**

Explanation: Disabling Windows Update is generally not recommended, even in competition environments. Updates often include critical security patches. In CyberPatriot specifically, configuring updates properly is often part of the scoring criteria.

### 20. User Account Control (UAC) only affects accounts in the Administrators group.

**Answer: True**

Explanation: UAC primarily affects users in the Administrators group. When an administrator performs an action that requires elevation, UAC prompts for confirmation. Standard users simply receive an authentication prompt asking for administrator credentials.

### 21. Files encrypted with EFS (Encrypting File System) can be accessed by any administrator on the system by default.

**Answer: False**

Explanation: By default, files encrypted with EFS can only be accessed by the user who encrypted them. Administrators cannot access these files unless they're designated as recovery agents or have access to the user's encryption key.

### 22. System Restore can be used to recover from malware infections with no data loss.

**Answer: False**

Explanation: While System Restore can help recover from some malware infections, it is not guaranteed to remove all malware and may not restore all files. It also does not protect user data files, so data loss is still possible.

### 23. In Windows, the Guest account is enabled by default.

**Answer: False**

Explanation: In modern Windows versions (Windows 10/11), the Guest account is disabled by default for security reasons. It must be explicitly enabled if needed.

### 24. Windows Firewall can block both inbound and outbound traffic.

**Answer: True**

Explanation: Windows Firewall can control both inbound connections (connections initiated from external sources to the local computer) and outbound connections (connections initiated from the local computer to external destinations).

### 25. Windows Defender is automatically disabled if a third-party antivirus is installed.

**Answer: True**

Explanation: When a third-party antivirus is installed, Windows Defender typically disables its real-time protection feature to avoid conflicts. However, Windows Defender Periodic Scanning may still be available as a secondary scanner.

## Short Answer Questions (3 points each)

### 26. List three methods for adding a user to the Administrators group in Windows.

**Sample Answer:**
1. Using Computer Management (lusrmgr.msc): 
   - Open Computer Management > System Tools > Local Users and Groups > Groups
   - Double-click the Administrators group > Add > Enter the username > Check Names > OK

2. Using Command Prompt or PowerShell:
   - `net localgroup Administrators [username] /add` (Command Prompt)
   - `Add-LocalGroupMember -Group "Administrators" -Member "[username]"` (PowerShell)

3. Using User Accounts in Control Panel:
   - Control Panel > User Accounts > Manage another account
   - Select the user > Change account type > Select Administrator > Change Account Type

**Grading Notes:** Award 1 point for each valid method. Other valid methods include using Local Security Policy, Active Directory Users and Computers (in domain environments), or using Group Policy.

### 27. What is "least privilege" and why is it important for Windows security?

**Sample Answer:**
Least privilege is a security principle that states that users and processes should be granted only the minimum levels of access—or permissions—needed to perform their job functions. In Windows, this means users should operate with standard user accounts for daily tasks and only use administrator privileges when absolutely necessary.

This principle is important for Windows security because:
1. It limits the potential damage from security breaches or malware infections
2. It reduces the attack surface by preventing unauthorized access to sensitive areas
3. It minimizes the risk of accidental system changes or corruption
4. It helps contain lateral movement in case one account is compromised

By implementing least privilege, a compromise of one user account or application doesn't necessarily mean a compromise of the entire system.

**Grading Notes:** Award 1 point for correctly defining least privilege, and 2 points for explaining at least two reasons why it's important.

### 28. Name three Windows services that are commonly disabled for security purposes.

**Sample Answer:**
1. Remote Registry - Allows remote users to modify registry settings
2. Telnet - Provides unsecured remote access to the system
3. Print Spooler - When not needed, can be exploited (as in PrintNightmare)
4. Remote Desktop Services - If remote access isn't needed
5. Server - File and printer sharing service (if not needed)
6. Xbox Live services - Not needed in business environments
7. Windows Media Player Network Sharing Service - Not needed in business environments
8. UPnP Device Host - Can expose the system to network risks
9. SNMP Service - Often unnecessary and can leak system information
10. Web Management Service (WMSvc) - Unnecessary on non-web servers

**Grading Notes:** Award 1 point for each valid service named. The list above contains more than three options, but cadets only need to name three valid services.

### 29. Explain the difference between NTFS permissions and share permissions.

**Sample Answer:**
NTFS permissions and share permissions are two different security layers in Windows:

NTFS permissions:
- Apply to files and folders on NTFS-formatted drives
- Apply regardless of how the files are accessed (locally or over the network)
- Are more granular, offering specific permissions like Read, Write, Modify, Full Control, etc.
- Follow files when they're moved within the same volume
- Can be inherited from parent folders
- Can be applied to specific users and groups

Share permissions:
- Only apply when accessing files/folders over the network
- Only have three permission levels: Read, Change, and Full Control
- Apply to everyone accessing the share, regardless of which files they access
- Don't affect local users accessing the files directly on the computer
- Are set on the share itself, not on individual files or folders

When accessing files over the network, both permission sets apply, and the most restrictive permission wins.

**Grading Notes:** Award 1.5 points for correctly describing NTFS permissions and 1.5 points for correctly describing share permissions. Focus on key differences between the two.

### 30. Describe three ways malware can maintain persistence on a Windows system.

**Sample Answer:**
1. Registry Run Keys: Malware can add entries to registry keys like HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run or HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run to automatically start when Windows boots or a user logs in.

2. Scheduled Tasks: Malware can create scheduled tasks using the Task Scheduler to execute malicious code at specific times or after certain events.

3. Windows Services: Malware can install itself as a Windows service, which automatically starts when the system boots and often runs with SYSTEM privileges.

Other valid methods include:
- Startup folder entries
- DLL hijacking or search order hijacking
- WMI event subscriptions
- Boot or logon autostart execution via Group Policy
- Registry modification for file associations
- COM hijacking
- Bootkit or rootkit techniques
- Modifying the Winlogon registry keys
- Browser extensions or helpers

**Grading Notes:** Award 1 point for each valid persistence method, including a brief explanation of how it works. There are many valid answers beyond those listed here.

## Scenario Questions (5 points each)

### 31. You suspect unauthorized access to a Windows system. Which three Event Viewer logs would you check, and what event IDs would be most relevant?

**Sample Answer:**
1. Security Log:
   - Event ID 4624: Successful logon events
   - Event ID 4625: Failed logon attempts
   - Event ID 4634/4647: Account logoff events
   - Event ID 4648: Logon using explicit credentials (potential lateral movement)
   - Event ID 4672: Special privileges assigned to new logon (admin access)
   - Event ID 4720: User account created
   - Event ID 4738: User account changed
   - Event ID 4732: User added to security-enabled local group

2. System Log:
   - Event ID 7045: A new service was installed
   - Event ID 7040: Service state change (start/stop)
   - Event ID 1074: System shutdown/restart initiated
   - Event ID 6005/6006: Event log service started/stopped

3. Application Log:
   - Application crashes that might indicate exploitation attempts
   - Event ID 1000/1001: Application errors/hangs
   - Software installation events
   - Antivirus or security software alerts

Other logs worth checking:
- PowerShell logs (Event ID 4103, 4104): Script execution
- Task Scheduler logs: Creation of scheduled tasks
- RDP logs (Event ID 1149): Remote connections

**Grading Notes:** Award 1.5 points for each appropriate log category with relevant event IDs and a brief explanation of what to look for. There are multiple valid combinations of logs to check.

### 32. During a CyberPatriot competition, you discover multiple unauthorized user accounts on a Windows system. Describe your step-by-step approach to address this issue, including the commands or tools you would use and how you would verify your changes.

**Sample Answer:**
Step 1: Identify all user accounts and determine which are unauthorized
- Open Computer Management via right-click on Start > Computer Management
- Navigate to Local Users and Groups > Users
- Or use Command Prompt/PowerShell: `net user` or `Get-LocalUser`
- Compare user list with the authorized accounts in the competition README file

Step 2: Document the unauthorized accounts before removing them
- Note their names, group memberships, and any relevant properties
- Check if they're part of the Administrators group: `net localgroup Administrators`
- Check when they were created and last logged in

Step 3: Check for any running processes or scheduled tasks owned by these accounts
- Use Task Manager to look for running processes
- Check Task Scheduler for tasks created by or running as these users
- Check services running as these accounts

Step 4: Remove unauthorized accounts from privileged groups first
- Use Computer Management or command line:
- `net localgroup Administrators [username] /delete`
- Or `Remove-LocalGroupMember -Group "Administrators" -Member "[username]"`

Step 5: Disable the accounts before deleting them (optional safety step)
- `net user [username] /active:no`
- Or right-click the account > Properties > check "Account is disabled"

Step 6: Delete the unauthorized accounts
- `net user [username] /delete`
- Or right-click the account > Delete
- Or `Remove-LocalUser -Name "[username]"`

Step 7: Verify the changes
- Run `net user` again to confirm accounts are removed
- Check `net localgroup Administrators` to verify they're not in admin group
- Check for any remaining files owned by those accounts
- Verify points are awarded in the CyberPatriot scoring engine

Step 8: Implement preventive measures
- Review password policies
- Check audit policies to monitor for new account creation
- Consider enabling UAC if not already enabled

**Grading Notes:** Award up to 5 points based on the completeness and accuracy of the approach. Look for logical flow, appropriate tools/commands, and verification steps. Deduct points for steps that could cause system issues or miss critical elements.

### 33. You need to secure a Windows workstation that will be accessed by multiple users. Outline five specific security measures you would implement, explaining why each is important.

**Sample Answer:**
1. Implement User Account Control (UAC) and Standard User Accounts
   - Configure all regular users as Standard Users, not Administrators
   - Ensure UAC is set to the appropriate notification level
   - Why it's important: Follows the principle of least privilege, reducing the risk of malware installation and unauthorized system changes. UAC provides an additional barrier against unauthorized elevation.

2. Configure Strong Password and Account Policies
   - Set minimum password length to 12+ characters
   - Enable password complexity requirements
   - Configure account lockout after 5 failed attempts
   - Why it's important: Prevents weak passwords and brute force attacks, which are common entry points for attackers.

3. Enable and Configure Windows Defender
   - Ensure real-time protection is enabled
   - Configure regular scans
   - Enable controlled folder access to protect against ransomware
   - Why it's important: Provides baseline protection against malware, ransomware, and other threats that users might inadvertently introduce.

4. Restrict Application Execution
   - Implement AppLocker or Software Restriction Policies
   - Only allow execution from approved directories (Program Files, Windows)
   - Block execution from user-writable locations
   - Why it's important: Prevents users from running unauthorized or malicious software, even if it makes it onto the system.

5. Configure Proper Folder Permissions and File System Access
   - Implement NTFS permissions that restrict users to only the files they need
   - Use folder redirection for user documents
   - Create shared folders with appropriate permissions for collaborative work
   - Why it's important: Ensures data segregation between users and prevents unauthorized access to sensitive files.

Other valid measures include:
- Configuring Windows Firewall
- Implementing disk encryption (BitLocker)
- Setting up regular system backups
- Configuring automatic updates
- Disabling unnecessary services and features
- Implementing application whitelisting
- Setting up audit policies for monitoring
- Restricting removable media
- Configuring secure boot settings

**Grading Notes:** Award 1 point for each well-described security measure with a valid explanation of its importance. Looking for specific, actionable measures rather than vague recommendations.

## Bonus Question (5 points)

### 34. Explain how credential caching works in Windows and what security risks it presents. How can you mitigate these risks?

**Sample Answer:**
Credential caching in Windows refers to the system's ability to store user credentials (passwords or password hashes) in memory or on disk to facilitate authentication without requiring the user to repeatedly enter their password. There are several forms of credential caching in Windows:

1. Domain Cached Credentials (DCC): When a domain user logs into a Windows machine, the system caches their credentials locally. This allows users to log in even when the domain controller is unavailable. These cached credentials are stored in the registry (HKLM\SECURITY\Cache) as hashed values.

2. LSASS Memory Cache: The Local Security Authority Subsystem Service (LSASS) process caches credentials in memory to facilitate single sign-on and other authentication needs during a user's session.

3. Credential Manager: Windows stores passwords for websites, applications, and network resources in the Credential Manager to enable automatic login.

Security risks associated with credential caching include:

1. Credential Theft: Attackers with administrative access can extract cached credentials from disk or memory using tools like Mimikatz.

2. Pass-the-Hash Attacks: Cached password hashes can sometimes be used directly for authentication without knowing the actual password.

3. Offline Cracking: Domain cached credentials can be extracted and subjected to offline brute-force attacks.

4. Lateral Movement: Compromised cached credentials can enable attackers to move laterally across a network.

Mitigation strategies:

1. Limit Cached Credentials: Reduce the number of cached domain logons using Group Policy (Computer Configuration > Policies > Windows Settings > Security Settings > Local Policies > Security Options > "Interactive logon: Number of previous logons to cache"). Set to 0 for highest security or a low number like 1-2 if offline access is needed.

2. Use Credential Guard: Enable Windows Defender Credential Guard to protect LSASS and prevent credential theft from memory.

3. Implement LAPS: Use Local Administrator Password Solution (LAPS) to manage and rotate local administrator passwords.

4. Strong Authentication: Implement multi-factor authentication to reduce the impact of stolen password hashes.

5. Regular Password Changes: Implement password expiration policies to limit the usefulness of stolen credentials.

6. Protected Users Security Group: Add sensitive users to the Protected Users group, which prevents credentials from being cached.

7. Secure Boot and TPM: Use Secure Boot and TPM to protect the integrity of the boot process and prevent tampering.

8. Monitor for Credential Theft: Implement detection for tools like Mimikatz and suspicious LSASS access.

**Grading Notes:** Award up to 5 points based on the depth of understanding shown:
- 1-2 points for correctly explaining how credential caching works
- 1-2 points for identifying relevant security risks
- 1-2 points for proposing effective mitigation strategies
The most comprehensive answers will include technical details and cover multiple types of credential caching.
