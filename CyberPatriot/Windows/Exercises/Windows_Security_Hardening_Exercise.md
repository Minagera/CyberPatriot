# Windows Security Hardening Exercise

## Overview

This exercise simulates a CyberPatriot competition scenario where you need to identify and remediate security issues on a Windows system. You'll practice implementing security configurations, managing user accounts, enabling security features, and cleaning up a potentially compromised system.

## Difficulty Level: Intermediate

## Estimated Time: 60-90 minutes

## Learning Objectives

After completing this exercise, you will be able to:
- Identify common Windows security vulnerabilities
- Implement proper user account security
- Configure essential Windows security settings
- Detect and remove unauthorized software
- Use built-in Windows security tools effectively
- Apply security best practices in a competition scenario

## Prerequisites

- Windows 10/11 VM set up according to the instructions in the VM-Setup directory
- Basic understanding of Windows system administration
- Familiarity with Windows security concepts
- Administrative access to the Windows VM

## Setup Instructions

1. Download the [Windows_Security_Exercise.zip](../VM-Setup/Windows_Security_Exercise.zip) file
2. Extract the contents to a folder on your system
3. Follow the instructions in the README.txt file to prepare your VM
4. **Do not** open any files in the 'Competition' folder until instructed to do so

## Scenario

You are a cybersecurity technician who has been called in to secure a Windows workstation at a small business. The previous IT administrator left suddenly, and there are concerns that the system may have security issues. The business owner has given you a list of requirements for securing the system and wants you to implement them as quickly as possible.

## Exercise Tasks

### Part 1: Initial Assessment and Documentation

1. Create a document to record your findings and actions
2. Take a system snapshot or backup before making changes
3. Document the initial state of the system:
   - List all user accounts
   - Note the security settings currently in place
   - Record installed applications
   - Document running services
   - Note any obvious security issues

### Part 2: User Account Security

1. Check for unauthorized or suspicious user accounts
   - List all local users and their properties
   - Verify Administrator group membership
   - Check for accounts with no password or passwords that never expire

2. Implement proper account security
   - Disable or remove unauthorized accounts (refer to the README for approved accounts)
   - Rename the built-in Administrator account
   - Ensure Guest account is disabled
   - Set appropriate passwords for all accounts
   - Remove any unauthorized accounts from the Administrators group

3. Configure proper password and account policies
   - Set minimum password length to 12 characters
   - Enable password complexity requirements
   - Configure account lockout threshold (5 attempts)
   - Set account lockout duration (30 minutes)

### Part 3: System Security Configuration

1. Configure Windows Update
   - Ensure Windows Update is enabled
   - Set updates to install automatically
   - Check for and install pending updates

2. Configure Windows Security (Defender)
   - Verify Windows Defender is enabled
   - Enable real-time protection
   - Run a full system scan
   - Enable controlled folder access
   - Configure appropriate exclusions based on the README

3. Configure Windows Firewall
   - Enable Windows Firewall for all profiles
   - Verify default inbound and outbound rules
   - Add any necessary exceptions based on the README
   - Block unauthorized applications from accessing the network

4. Disable unnecessary services and features
   - Review running services and disable those not needed
   - Disable unnecessary Windows features
   - Disable unnecessary startup items

### Part 4: Security Hardening

1. Implement AppLocker or Software Restriction Policies
   - Create basic rules to block execution from user directories
   - Allow execution of approved applications
   - Test policies to ensure they don't break needed functionality

2. Configure User Account Control (UAC)
   - Ensure UAC is enabled
   - Set appropriate notification level
   - Test UAC prompts

3. Configure Internet Explorer or Edge security
   - Set appropriate security zones
   - Disable password saving
   - Enable phishing and malware protection

4. Enable and configure audit policies
   - Enable successful and failed login attempts
   - Enable policy change auditing
   - Enable privilege use auditing
   - Review Event Viewer for security events

### Part 5: Finding and Removing Unauthorized Software

1. Identify potentially unwanted programs
   - Check installed programs list
   - Look for suspicious startup items
   - Scan for malware
   - Check browser extensions

2. Remove unauthorized software
   - Uninstall programs according to the README instructions
   - Remove malicious browser extensions
   - Clean up temporary files

3. Check for and remediate registry persistence
   - Check common autorun locations in the registry
   - Review scheduled tasks
   - Verify service configurations

### Part 6: Documentation and Reporting

1. Document all changes made
   - Account security changes
   - System configuration changes
   - Software removals
   - Security policy implementations

2. Create a report summarizing:
   - Security issues found
   - Actions taken to remediate
   - Recommendations for future maintenance
   - Potential security concerns that remain

## Forensic Questions

During the exercise, look for answers to these questions (write down your answers):

1. What is the name of the file located in the hidden folder on the Desktop?
2. Which local user has an extremely weak password?
3. What unauthorized program is set to run at startup?
4. What suspicious outbound network connection is occurring?
5. What registry setting was modified to disable Windows Defender?
6. When was the last unauthorized login attempt made?
7. What is the name of the service with a suspicious executable path?
8. Which user account has been added to the Administrators group without authorization?
9. What is the path to the batch file set to run with a scheduled task at 3 AM daily?
10. What is the path of the most recently installed backdoor application?

## Challenge Tasks (Optional)

If you complete the main exercise quickly, try these additional challenges:

1. Set up BitLocker drive encryption with a recovery key
2. Implement Windows Sandbox for testing suspicious files
3. Create a custom security baseline using Security Compliance Toolkit
4. Implement Advanced Threat Protection features
5. Set up and configure Windows Credential Guard

## Scorecard

Track your progress using the following scorecard (1 point per item):

### User Account Security (10 points)
- [ ] Unauthorized accounts removed/disabled
- [ ] Built-in Administrator account renamed 
- [ ] Guest account disabled
- [ ] Appropriate password policies implemented
- [ ] Account lockout policies implemented
- [ ] Unauthorized users removed from Administrator group
- [ ] All accounts have strong passwords
- [ ] User-specific permissions configured
- [ ] Account auditing enabled
- [ ] UAC configured properly

### System Security (10 points)
- [ ] Windows Update configured correctly
- [ ] All critical updates applied
- [ ] Windows Defender enabled and configured
- [ ] Firewall enabled on all profiles
- [ ] Appropriate firewall rules configured
- [ ] Unnecessary services disabled
- [ ] Unnecessary features removed
- [ ] Startup items secured
- [ ] Registry secured
- [ ] File system permissions reviewed

### Malware Removal (5 points)
- [ ] Unauthorized software removed
- [ ] Malicious startup items removed
- [ ] Suspicious scheduled tasks removed
- [ ] Browser cleaned of extensions
- [ ] Temporary files cleaned up

### Security Features (5 points)
- [ ] AppLocker/Software Restriction Policies implemented
- [ ] Audit policies configured
- [ ] Browser security settings configured
- [ ] Security event logging enabled
- [ ] Security reports generated

### Forensic Questions (10 points)
- [ ] One point for each correct answer

### Challenge Tasks (5 points)
- [ ] One point for each completed challenge task

**Total Possible Score: 45 points**

## Solution Reference

A solution guide is available for instructors in the [Solutions](./Solutions/Windows_Security_Exercise_Solution.md) directory. This should only be referenced after attempting the exercise.

## Additional Resources

- [Microsoft Security Baselines](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-security-baselines)
- [CIS Benchmarks for Windows](https://www.cisecurity.org/benchmark/microsoft_windows_desktop/)
- [NIST Windows Security Guide](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-123.pdf)

## Next Steps

After completing this exercise, consider:
1. Exploring more advanced Windows security topics
2. Participating in a practice competition
3. Setting up and securing a Windows Server environment
4. Learning about advanced threat hunting techniques
