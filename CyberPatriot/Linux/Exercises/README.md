# Linux Security Challenge

## Overview

This exercise simulates a CyberPatriot competition scenario where you need to secure an Ubuntu/Linux Mint system. It includes various security vulnerabilities that must be identified and remediated. This exercise will test your skills in user management, service configuration, firewall setup, and system hardening.

## Difficulty Level: Intermediate

## Estimated Time: 90-120 minutes

## Learning Objectives

By completing this exercise, you will be able to:
- Identify and fix common security vulnerabilities in Linux systems
- Implement proper user and group management
- Secure system services and network configurations
- Apply system hardening techniques
- Practice searching for specific security issues

## Prerequisites

- Ubuntu 22.04 or Linux Mint VM set up according to the instructions in the VM-Setup directory
- Basic understanding of Linux commands and system administration
- Familiarity with security concepts from the basic guides

## Setup Instructions

1. Download the [Linux_Security_Challenge.zip](../VM-Setup/Linux_Security_Challenge.zip) file
2. Extract the contents and follow the instructions in the README.txt to prepare your VM
3. **Do not** look at the solution until you have completed the exercise
4. Take note of your starting time to track how long the exercise takes

## Scenario

You are a system administrator for a small organization. The previous IT person left unexpectedly, and you've discovered that one of the Linux servers hasn't been properly maintained. Your task is to secure this system according to best practices and organization requirements.

The organization's security policy requires:
- Only authorized users should have access to the system
- All services should be properly secured or disabled if not needed
- The system should be hardened against common attacks
- All security vulnerabilities should be patched

## Exercise Tasks

### Part 1: Initial Assessment

Begin by assessing the current state of the system before making any changes:

1. Document the current state of the system
   - List all users and their privileges
   - List all running services
   - Check network configuration and open ports
   - Review installed software

2. Identify security issues
   - Look for unauthorized users
   - Check for insecure services
   - Identify misconfigured security settings
   - Look for unusual files or processes

3. Create a security plan
   - Prioritize issues by severity
   - Plan your approach to fixing each issue
   - Document intended changes

### Part 2: User and Group Management

1. Check for unauthorized users
   - Look for accounts that shouldn't be on the system
   - Review user privileges and group memberships
   - Check for users with dangerous permissions

2. Implement proper user security
   - Remove or disable unauthorized accounts
   - Fix improper group memberships (especially sudoers)
   - Set appropriate password policies
   - Secure the root account

3. Configure sudo access
   - Review and fix the sudoers configuration
   - Implement the principle of least privilege
   - Enable sudo logging

### Part 3: Service Security

1. Audit running services
   - Identify all running services
   - Determine which services are necessary
   - Look for insecurely configured services

2. Secure necessary services
   - Properly configure SSH
   - Secure web server if installed
   - Ensure database security if applicable
   - Check for proper service permissions

3. Disable or remove unnecessary services
   - Stop and disable unneeded services
   - Remove unnecessary packages
   - Prevent services from starting at boot

### Part 4: System Updates and Software Management

1. Update the system
   - Update package repositories
   - Install all security updates
   - Configure automatic updates

2. Review installed software
   - Remove unauthorized or suspicious software
   - Verify package integrity
   - Install required security tools

### Part 5: Network Security

1. Configure the firewall
   - Install and enable UFW
   - Set default policies
   - Configure appropriate rules
   - Test the firewall configuration

2. Secure network settings
   - Review network interfaces
   - Apply network hardening via sysctl
   - Disable unnecessary protocols

### Part 6: System Hardening

1. Implement kernel hardening
   - Configure sysctl security settings
   - Secure boot configuration if applicable
   - Enable security modules

2. Implement filesystem security
   - Set appropriate permissions on sensitive files
   - Check for unauthorized SUID/SGID binaries
   - Secure temporary file storage

3. Configure logging and monitoring
   - Set up proper system logging
   - Configure log rotation
   - Enable auditd for key files and commands

### Part 7: Find Hidden Security Issues

Several specific security issues have been hidden on the system. Your task is to find and fix them:

1. Find the hidden backdoor account
2. Locate and remove the unauthorized SSH key
3. Find the suspicious cron job
4. Identify and remove the hidden startup script
5. Find the flag file (contains text "FLAG: [code]")

## Scoring

Track your progress using the following scoring criteria (1 point per item):

### User Security (10 points)
- [ ] Unauthorized users removed or disabled
- [ ] Proper group memberships configured
- [ ] Root account secured
- [ ] Password policies implemented
- [ ] Guest account disabled
- [ ] Sudo access properly configured
- [ ] User permissions corrected
- [ ] Hidden backdoor user found and removed
- [ ] User home directories secured
- [ ] Password aging configured

### Service Security (10 points)
- [ ] SSH properly configured
- [ ] Telnet disabled/removed
- [ ] FTP disabled/removed
- [ ] Web server secured (if applicable)
- [ ] Database secured (if applicable)
- [ ] All unnecessary services disabled
- [ ] Services running with appropriate privileges
- [ ] Service-specific security settings applied
- [ ] Startup scripts checked and secured
- [ ] inetd/xinetd services checked and secured

### System Security (10 points)
- [ ] System fully updated
- [ ] Automatic updates configured
- [ ] Firewall properly configured
- [ ] Network settings hardened
- [ ] Kernel parameters hardened
- [ ] Suspicious cron job found and removed
- [ ] Logging properly configured
- [ ] Unauthorized SUID/SGID binaries fixed
- [ ] Hidden startup script found and removed
- [ ] Flag file found

### Bonus Tasks (5 points)
- [ ] Configure fail2ban
- [ ] Set up intrusion detection (AIDE)
- [ ] Implement advanced auditing
- [ ] Configure AppArmor profiles
- [ ] Create a system security report

**Total Possible Score: 35 points**

## Hints

If you get stuck, here are some hints to help (try to solve without hints first):

<details>
  <summary>Hint 1: User Security</summary>
  
  Check all users in /etc/passwd and compare with authorized users. Don't forget to check for users in sudo or admin groups with: `grep -Po '^sudo:.*:\K.*$' /etc/group`
</details>

<details>
  <summary>Hint 2: Service Security</summary>
  
  Check running services with `systemctl list-units --type=service --state=active` and ports with `ss -tulpn`. Pay special attention to SSH configuration in /etc/ssh/sshd_config.
</details>

<details>
  <summary>Hint 3: Hidden Issues</summary>
  
  Look for files with unusual timestamps, check all startup locations, and use commands like `find / -type f -name ".*" 2>/dev/null` to find hidden files.
</details>

<details>
  <summary>Hint 4: Backdoor Location</summary>
  
  Check for unusual entries in /etc/passwd and /etc/shadow. Also look for hidden shells and unusual login scripts in user home directories.
</details>

<details>
  <summary>Hint 5: Cron Jobs</summary>
  
  Look in /etc/cron.d, /etc/crontab, and run `for user in $(cut -f1 -d: /etc/passwd); do echo $user; crontab -u $user -l 2>/dev/null; done`
</details>

## Documenting Your Work

As you work, document all issues found and changes made. This helps for:
1. Learning from your experience
2. Verifying all issues have been addressed
3. Providing evidence of your work
4. Preparing for future security audits

## Solution

After completing the exercise, you can check your work against the [solution guide](./Solutions/Linux_Security_Challenge_Solution.md).

## Conclusion

Upon completing this exercise, you will have experienced a realistic security hardening scenario similar to what you might encounter in the CyberPatriot competition. The skills practiced here—identifying security issues, prioritizing fixes, and implementing security best practices—are directly applicable to competition scenarios.

## Next Steps

After completing this exercise:
1. Review the solution to identify any issues you missed
2. Try the exercise again with a different focus or time constraint
3. Move on to the advanced Linux security exercises
4. Practice with the provided scripts to automate security checks# Linux Security Challenge

## Overview

This exercise simulates a CyberPatriot competition scenario where you need to secure an Ubuntu/Linux Mint system. It includes various security vulnerabilities that must be identified and remediated. This exercise will test your skills in user management, service configuration, firewall setup, and system hardening.

## Difficulty Level: Intermediate

## Estimated Time: 90-120 minutes

## Learning Objectives

By completing this exercise, you will be able to:
- Identify and fix common security vulnerabilities in Linux systems
- Implement proper user and group management
- Secure system services and network configurations
- Apply system hardening techniques
- Practice searching for specific security issues

## Prerequisites

- Ubuntu 22.04 or Linux Mint VM set up according to the instructions in the VM-Setup directory
- Basic understanding of Linux commands and system administration
- Familiarity with security concepts from the basic guides

## Setup Instructions

1. Download the [Linux_Security_Challenge.zip](../VM-Setup/Linux_Security_Challenge.zip) file
2. Extract the contents and follow the instructions in the README.txt to prepare your VM
3. **Do not** look at the solution until you have completed the exercise
4. Take note of your starting time to track how long the exercise takes

## Scenario

You are a system administrator for a small organization. The previous IT person left unexpectedly, and you've discovered that one of the Linux servers hasn't been properly maintained. Your task is to secure this system according to best practices and organization requirements.

The organization's security policy requires:
- Only authorized users should have access to the system
- All services should be properly secured or disabled if not needed
- The system should be hardened against common attacks
- All security vulnerabilities should be patched

## Exercise Tasks

### Part 1: Initial Assessment

Begin by assessing the current state of the system before making any changes:

1. Document the current state of the system
   - List all users and their privileges
   - List all running services
   - Check network configuration and open ports
   - Review installed software

2. Identify security issues
   - Look for unauthorized users
   - Check for insecure services
   - Identify misconfigured security settings
   - Look for unusual files or processes

3. Create a security plan
   - Prioritize issues by severity
   - Plan your approach to fixing each issue
   - Document intended changes

### Part 2: User and Group Management

1. Check for unauthorized users
   - Look for accounts that shouldn't be on the system
   - Review user privileges and group memberships
   - Check for users with dangerous permissions

2. Implement proper user security
   - Remove or disable unauthorized accounts
   - Fix improper group memberships (especially sudoers)
   - Set appropriate password policies
   - Secure the root account

3. Configure sudo access
   - Review and fix the sudoers configuration
   - Implement the principle of least privilege
   - Enable sudo logging

### Part 3: Service Security

1. Audit running services
   - Identify all running services
   - Determine which services are necessary
   - Look for insecurely configured services

2. Secure necessary services
   - Properly configure SSH
   - Secure web server if installed
   - Ensure database security if applicable
   - Check for proper service permissions

3. Disable or remove unnecessary services
   - Stop and disable unneeded services
   - Remove unnecessary packages
   - Prevent services from starting at boot

### Part 4: System Updates and Software Management

1. Update the system
   - Update package repositories
   - Install all security updates
   - Configure automatic updates

2. Review installed software
   - Remove unauthorized or suspicious software
   - Verify package integrity
   - Install required security tools

### Part 5: Network Security

1. Configure the firewall
   - Install and enable UFW
   - Set default policies
   - Configure appropriate rules
   - Test the firewall configuration

2. Secure network settings
   - Review network interfaces
   - Apply network hardening via sysctl
   - Disable unnecessary protocols

### Part 6: System Hardening

1. Implement kernel hardening
   - Configure sysctl security settings
   - Secure boot configuration if applicable
   - Enable security modules

2. Implement filesystem security
   - Set appropriate permissions on sensitive files
   - Check for unauthorized SUID/SGID binaries
   - Secure temporary file storage

3. Configure logging and monitoring
   - Set up proper system logging
   - Configure log rotation
   - Enable auditd for key files and commands

### Part 7: Find Hidden Security Issues

Several specific security issues have been hidden on the system. Your task is to find and fix them:

1. Find the hidden backdoor account
2. Locate and remove the unauthorized SSH key
3. Find the suspicious cron job
4. Identify and remove the hidden startup script
5. Find the flag file (contains text "FLAG: [code]")

## Scoring

Track your progress using the following scoring criteria (1 point per item):

### User Security (10 points)
- [ ] Unauthorized users removed or disabled
- [ ] Proper group memberships configured
- [ ] Root account secured
- [ ] Password policies implemented
- [ ] Guest account disabled
- [ ] Sudo access properly configured
- [ ] User permissions corrected
- [ ] Hidden backdoor user found and removed
- [ ] User home directories secured
- [ ] Password aging configured

### Service Security (10 points)
- [ ] SSH properly configured
- [ ] Telnet disabled/removed
- [ ] FTP disabled/removed
- [ ] Web server secured (if applicable)
- [ ] Database secured (if applicable)
- [ ] All unnecessary services disabled
- [ ] Services running with appropriate privileges
- [ ] Service-specific security settings applied
- [ ] Startup scripts checked and secured
- [ ] inetd/xinetd services checked and secured

### System Security (10 points)
- [ ] System fully updated
- [ ] Automatic updates configured
- [ ] Firewall properly configured
- [ ] Network settings hardened
- [ ] Kernel parameters hardened
- [ ] Suspicious cron job found and removed
- [ ] Logging properly configured
- [ ] Unauthorized SUID/SGID binaries fixed
- [ ] Hidden startup script found and removed
- [ ] Flag file found

### Bonus Tasks (5 points)
- [ ] Configure fail2ban
- [ ] Set up intrusion detection (AIDE)
- [ ] Implement advanced auditing
- [ ] Configure AppArmor profiles
- [ ] Create a system security report

**Total Possible Score: 35 points**

## Hints

If you get stuck, here are some hints to help (try to solve without hints first):

<details>
  <summary>Hint 1: User Security</summary>
  
  Check all users in /etc/passwd and compare with authorized users. Don't forget to check for users in sudo or admin groups with: `grep -Po '^sudo:.*:\K.*$' /etc/group`
</details>

<details>
  <summary>Hint 2: Service Security</summary>
  
  Check running services with `systemctl list-units --type=service --state=active` and ports with `ss -tulpn`. Pay special attention to SSH configuration in /etc/ssh/sshd_config.
</details>

<details>
  <summary>Hint 3: Hidden Issues</summary>
  
  Look for files with unusual timestamps, check all startup locations, and use commands like `find / -type f -name ".*" 2>/dev/null` to find hidden files.
</details>

<details>
  <summary>Hint 4: Backdoor Location</summary>
  
  Check for unusual entries in /etc/passwd and /etc/shadow. Also look for hidden shells and unusual login scripts in user home directories.
</details>

<details>
  <summary>Hint 5: Cron Jobs</summary>
  
  Look in /etc/cron.d, /etc/crontab, and run `for user in $(cut -f1 -d: /etc/passwd); do echo $user; crontab -u $user -l 2>/dev/null; done`
</details>

## Documenting Your Work

As you work, document all issues found and changes made. This helps for:
1. Learning from your experience
2. Verifying all issues have been addressed
3. Providing evidence of your work
4. Preparing for future security audits

## Solution

After completing the exercise, you can check your work against the [solution guide](./Solutions/Linux_Security_Challenge_Solution.md).

## Conclusion

Upon completing this exercise, you will have experienced a realistic security hardening scenario similar to what you might encounter in the CyberPatriot competition. The skills practiced here—identifying security issues, prioritizing fixes, and implementing security best practices—are directly applicable to competition scenarios.

## Next Steps

After completing this exercise:
1. Review the solution to identify any issues you missed
2. Try the exercise again with a different focus or time constraint
3. Move on to the advanced Linux security exercises
4. Practice with the provided scripts to automate security checks
