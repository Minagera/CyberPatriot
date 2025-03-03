# Windows User Management Security Guide

This guide covers the fundamental concepts and techniques for securing user accounts on Windows systems. User account management is a critical component of Windows security and is frequently a focus area in CyberPatriot competitions.

## Table of Contents

- [User Account Types](#user-account-types)
- [Identifying and Auditing User Accounts](#identifying-and-auditing-user-accounts)
- [Managing Local User Accounts](#managing-local-user-accounts)
- [Password Policies](#password-policies)
- [User Rights and Permissions](#user-rights-and-permissions)
- [Administrator Accounts](#administrator-accounts)
- [User Account Control (UAC)](#user-account-control-uac)
- [Group Management](#group-management)
- [Monitoring User Account Activity](#monitoring-user-account-activity)
- [Common CyberPatriot Scenarios](#common-cyberpatriot-scenarios)

## User Account Types

Windows systems have several types of user accounts:

1. **Administrator Accounts**
   - Full control over the system
   - Can install software, change system settings, and modify other user accounts
   - The built-in Administrator account is the most powerful account on local systems

2. **Standard User Accounts**
   - Limited privileges
   - Can use most software and change system settings that don't affect other users
   - Cannot install most software or make system-wide changes

3. **Guest Account**
   - Limited temporary access
   - Highly restricted privileges
   - Disabled by default in modern Windows versions
   - Should remain disabled unless specifically needed

4. **Service Accounts**
   - Used by system services rather than people
   - Should have only the permissions needed for their specific functions
   - Different from human user accounts

Understanding these account types is essential for proper security implementation.

## Identifying and Auditing User Accounts

Before making changes, you should identify all existing accounts on the system.

### Using the GUI:

1. Open **Computer Management**
   - Right-click on **Start** → select **Computer Management**
   - Or press **Win+X** → select **Computer Management**

2. Navigate to **System Tools** → **Local Users and Groups** → **Users**

3. Review all user accounts listed
   - Note their names, descriptions, and status (enabled/disabled)
   - Identify any suspicious or unauthorized accounts

### Using Command Line:

1. Open **Command Prompt** as Administrator
   - Right-click on **Start** → select **Command Prompt (Admin)**

2. Run the following command to list all local user accounts:
   ```cmd
   net user
   ```

3. For detailed information about a specific user:
   ```cmd
   net user [username]
   ```

4. Check which users are in the Administrators group:
   ```cmd
   net localgroup Administrators
   ```

### Using PowerShell:

1. Open **PowerShell** as Administrator
   - Right-click on **Start** → select **Windows PowerShell (Admin)**

2. Run the following commands:
   ```powershell
   # List all local users
   Get-LocalUser
   
   # Get detailed information about users
   Get-LocalUser | Select-Object Name, Enabled, PasswordExpires, LastLogon
   
   # List members of the Administrators group
   Get-LocalGroupMember -Group "Administrators"
   ```

## Managing Local User Accounts

### Adding a New User Account

**GUI Method:**
1. In **Computer Management** → **Local Users and Groups** → **Users**
2. Right-click in the right pane → select **New User**
3. Fill in the required information:
   - User name
   - Full name (optional)
   - Description (optional)
   - Password
   - Password options (user must change password at next logon, etc.)
4. Click **Create**

**Command Line Method:**
```cmd
net user [username] [password] /add /fullname:"[Full Name]" /comment:"[Description]"
```

**PowerShell Method:**
```powershell
New-LocalUser -Name "[username]" -Password (ConvertTo-SecureString "[password]" -AsPlainText -Force) -FullName "[Full Name]" -Description "[Description]"
```

### Removing a User Account

**GUI Method:**
1. In **Computer Management** → **Local Users and Groups** → **Users**
2. Right-click on the user → select **Delete**
3. Confirm the deletion

**Command Line Method:**
```cmd
net user [username] /delete
```

**PowerShell Method:**
```powershell
Remove-LocalUser -Name "[username]"
```

### Enabling or Disabling User Accounts

**GUI Method:**
1. In **Computer Management** → **Local Users and Groups** → **Users**
2. Right-click on the user → select **Properties**
3. Check or uncheck **Account is disabled**
4. Click **OK**

**Command Line Method:**
```cmd
# To disable a user account
net user [username] /active:no

# To enable a user account
net user [username] /active:yes
```

**PowerShell Method:**
```powershell
# To disable a user account
Disable-LocalUser -Name "[username]"

# To enable a user account
Enable-LocalUser -Name "[username]"
```

## Password Policies

Strong password policies are essential for security. Here's how to configure them:

### Setting Password Policy Using Local Security Policy

1. Open **Local Security Policy**
   - Press **Win+R** → type `secpol.msc` → press **Enter**

2. Navigate to **Account Policies** → **Password Policy**

3. Configure the following settings (recommended values for CyberPatriot):
   - **Enforce password history**: 5 passwords remembered
   - **Maximum password age**: 90 days
   - **Minimum password age**: 1 day
   - **Minimum password length**: 12 characters
   - **Password must meet complexity requirements**: Enabled
   - **Store passwords using reversible encryption**: Disabled

### Setting Account Lockout Policy

1. In **Local Security Policy**, navigate to **Account Policies** → **Account Lockout Policy**

2. Configure the following settings:
   - **Account lockout duration**: 30 minutes
   - **Account lockout threshold**: 5 invalid login attempts
   - **Reset account lockout counter after**: 30 minutes

### Using Command Line:

```cmd
# Set minimum password length to 12 characters
net accounts /minpwlen:12

# Set maximum password age to 90 days
net accounts /maxpwage:90

# Set minimum password age to 1 day
net accounts /minpwage:1

# Set account lockout threshold to 5 attempts
net accounts /lockoutthreshold:5

# Set lockout duration to 30 minutes
net accounts /lockoutduration:30

# Set lockout observation window to 30 minutes
net accounts /lockoutwindow:30
```

### Using PowerShell:

```powershell
# View current password policy
net accounts

# Set password policy (requires secpol.msc/Group Policy)
# For Windows 10/11 Pro or higher
```

## User Rights and Permissions

User rights determine what actions users can perform on a system level, while permissions control access to specific resources.

### Configuring User Rights

1. Open **Local Security Policy**
   - Press **Win+R** → type `secpol.msc` → press **Enter**

2. Navigate to **Local Policies** → **User Rights Assignment**

3. Review and configure important settings:
   - **Access this computer from the network**: Should only include necessary groups
   - **Allow log on locally**: Should only include necessary users
   - **Allow log on through Remote Desktop Services**: Only for users needing remote access
   - **Back up files and directories**: Only for backup operators/administrators
   - **Change the system time**: Only administrators
   - **Load and unload device drivers**: Only administrators
   - **Shut down the system**: Typically users and administrators

### File and Folder Permissions

1. Right-click on a file or folder → select **Properties**
2. Go to the **Security** tab
3. Click **Edit** to modify permissions
4. Add or remove users and groups, assigning appropriate permissions:
   - Full control
   - Modify
   - Read & execute
   - List folder contents
   - Read
   - Write

## Administrator Accounts

### Built-in Administrator Account

The built-in Administrator account has complete system access. For security:

1. **Rename the Administrator account**:
   - In **Computer Management** → **Local Users and Groups** → **Users**
   - Right-click on **Administrator** → select **Rename**
   - Choose a non-obvious name

2. **Set a strong password**:
   - Right-click on the Administrator account → select **Set Password**
   - Set a complex password

3. **Disable when not needed**:
   - Right-click on the Administrator account → select **Properties**
   - Check **Account is disabled**

### Using Command Line:

```cmd
# Rename the Administrator account
wmic useraccount where name='Administrator' rename NewAdminName

# Set Administrator password
net user Administrator [NewPassword]

# Disable the Administrator account
net user Administrator /active:no
```

### Creating a Secondary Admin Account

For CyberPatriot, you should create a secondary admin account:

1. Create a new user with a strong password
2. Add the user to the Administrators group:
   - In **Computer Management** → **Local Users and Groups** → **Groups**
   - Double-click **Administrators**
   - Click **Add** → type the username → click **OK**

## User Account Control (UAC)

User Account Control provides a barrier against unwanted system changes. To configure UAC:

1. Open **User Account Control Settings**:
   - Press **Win+R** → type `UserAccountControlSettings` → press **Enter**

2. Set the notification level:
   - Recommended: "Notify me only when apps try to make changes to my computer (default)"
   - For maximum security: "Always notify me"

3. Click **OK**

### Using Command Line:

```cmd
# View UAC settings
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA

# Enable UAC
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 1 /f

# Set UAC to always notify
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 2 /f
```

## Group Management

Groups allow you to assign permissions to multiple users at once.

### Built-in Groups

Important built-in groups to review:
- **Administrators**: Full control over the computer
- **Backup Operators**: Can backup and restore files
- **Power Users**: More privileges than standard users (legacy group)
- **Remote Desktop Users**: Can connect via Remote Desktop
- **Users**: Standard users with limited privileges

### Managing Group Membership

**GUI Method:**
1. In **Computer Management** → **Local Users and Groups** → **Groups**
2. Double-click on a group
3. Click **Add** to add users or **Remove** to remove users

**Command Line Method:**
```cmd
# Add a user to a group
net localgroup [GroupName] [UserName] /add

# Remove a user from a group
net localgroup [GroupName] [UserName] /delete

# List members of a group
net localgroup [GroupName]
```

**PowerShell Method:**
```powershell
# Add a user to a group
Add-LocalGroupMember -Group "[GroupName]" -Member "[UserName]"

# Remove a user from a group
Remove-LocalGroupMember -Group "[GroupName]" -Member "[UserName]"

# List members of a group
Get-LocalGroupMember -Group "[GroupName]"
```

## Monitoring User Account Activity

### Enabling Audit Policies

1. Open **Local Security Policy**
   - Press **Win+R** → type `secpol.msc` → press **Enter**

2. Navigate to **Local Policies** → **Audit Policy**

3. Configure the following settings:
   - **Audit account logon events**: Success and Failure
   - **Audit account management**: Success and Failure
   - **Audit logon events**: Success and Failure

### Viewing Security Logs

1. Open **Event Viewer**
   - Press **Win+R** → type `eventvwr.msc` → press **Enter**

2. Navigate to **Windows Logs** → **Security**

3. Look for events related to:
   - Account logons (Event IDs 4624, 4625)
   - Account modifications (Event IDs 4720-4738)
   - Group modifications (Event IDs 4731-4737)

## Common CyberPatriot Scenarios

### Scenario 1: Unauthorized User Accounts

**Challenge:** You find unknown user accounts on the system.

**Solution:**
1. Check if the account is required (read the CyberPatriot README file)
2. If not required, document the account name and then remove it:
   ```cmd
   net user [UnauthorizedUser] /delete
   ```

### Scenario 2: Administrator Group Membership

**Challenge:** Too many users have administrator privileges.

**Solution:**
1. List administrators: `net localgroup Administrators`
2. Remove unauthorized users (keep required admins):
   ```cmd
   net localgroup Administrators [UnauthorizedUser] /delete
   ```

### Scenario 3: Weak Password Policy

**Challenge:** The password policy does not meet security requirements.

**Solution:**
1. Set a strong password policy as described in the [Password Policies](#password-policies) section
2. Force password resets for existing accounts if necessary:
   ```cmd
   net user [UserName] /logonpasswordchg:yes
   ```

### Scenario 4: Guest Account Enabled

**Challenge:** The Guest account is enabled.

**Solution:**
1. Disable the Guest account:
   ```cmd
   net user Guest /active:no
   ```

### Scenario 5: Finding Hidden User Accounts

**Challenge:** There may be hidden or misnamed administrator accounts.

**Solution:**
1. Check account privileges and properties:
   ```powershell
   Get-LocalUser | Select-Object Name, Enabled, SID | Where-Object {$_.SID -like "S-1-5-*-500"}
   ```
2. Check for accounts with administrator privileges:
   ```powershell
   Get-LocalGroupMember -Group "Administrators"
   ```

## Best Practices Summary

1. **Inventory all accounts** regularly and remove unnecessary ones
2. **Implement strong password policies** (length, complexity, expiration)
3. **Limit administrator privileges** to only necessary accounts
4. **Disable the Guest account** and any other built-in accounts not in use
5. **Rename the Administrator account** to something non-obvious
6. **Use standard user accounts** for daily activities
7. **Enable account lockout** to prevent brute force attacks
8. **Monitor user activity** through audit policies and log review
9. **Regularly review group memberships**, especially administrative groups
10. **Document all user accounts** and their purpose

## Additional Resources

- [Microsoft Documentation: Local Users and Groups](https://docs.microsoft.com/en-us/windows/security/identity-protection/access-control/local-accounts)
- [CIS Benchmark for Windows](https://www.cisecurity.org/benchmark/microsoft_windows_desktop/)
- [PowerShell Commands for User Management](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.localaccounts/)
- [Windows Security Log Events](https://www.ultimatewindowssecurity.com/securitylog/encyclopedia/)
