# Week 6: Linux System Hardening

## Learning Objectives
By the end of this session, cadets will be able to:
- Implement comprehensive Linux security configurations
- Secure critical Linux system files and directories
- Configure and manage system services securely
- Implement advanced file permissions and access controls
- Configure Linux firewall (iptables/ufw/firewalld)
- Use SELinux/AppArmor for enhanced security
- Apply security auditing and monitoring
- Recognize and remediate common Linux vulnerabilities

## Pre-class Preparation
- Review [Linux System Hardening Guide](../../Linux/Guides/Intermediate/Linux_System_Hardening.md)
- Complete the [Linux Services Overview](../../Linux/Guides/Basic/Linux_Services_Overview.md)
- Watch [Linux Security Hardening video](https://www.youtube.com/watch?v=example) (placeholder link)
- Read [Linux Security Baseline documentation](https://example.com/linux-baseline) (placeholder link)

## Lesson Plan

### 1. Linux Security Architecture (20 minutes)
- Linux security model overview
- Linux kernel security features
- Security-Enhanced Linux (SELinux) and AppArmor
- Discretionary Access Control (DAC) vs. Mandatory Access Control (MAC)
- Linux security modules
- Linux distribution security differences
- Security compliance and benchmarking

### 2. Securing System Files and Directories (35 minutes)
- Critical system files and directories
- File permissions revisited (advanced concepts)
- Special permissions (SUID, SGID, sticky bit)
- Access Control Lists (ACLs)
- Immutable flags and attributes
- Finding world-writable and SUID files
- Securing log files
- Filesystem security best practices

### 3. Service Hardening (35 minutes)
- Understanding Linux services and daemons
- systemd security features
- Managing services securely
- Identifying unnecessary services
- Securing common services:
  - SSH
  - FTP
  - Web servers
  - Database servers
- Service isolation techniques
- Service configuration security auditing

### 4. Linux Firewall Configuration (35 minutes)
- Linux firewall architecture
- iptables fundamentals
- UFW (Uncomplicated Firewall)
- firewalld (for RHEL-based systems)
- Creating secure firewall rules
- Default deny policies
- Implementing network access controls
- Validating firewall configurations
- Logging and monitoring firewall activities

### 5. Advanced Access Controls (25 minutes)
- SELinux/AppArmor configuration
- SELinux modes and policies
- AppArmor profiles
- Context security
- Mandatory Access Control implementation
- Troubleshooting access control issues
- Balancing security and usability
- Detecting and resolving policy violations

### 6. Hands-on Exercise (60 minutes)
- Harden a Linux VM using provided checklists and scripts
- Document all changes and verify system security

### 7. Assessment (20 minutes)
- Quiz on Linux hardening concepts
- [Linux System Hardening Quiz](../../Linux/Quizzes/Quiz-Files/Linux_System_Hardening_Quiz.md)
- Group discussion of key hardening techniques
- Review of common mistakes and misconceptions

### 8. Wrap-up and Preview (10 minutes)
- Recap Linux hardening techniques
- Assign homework (see below)
- Preview next week (Network Security & Firewall Configuration)
- Q&A session

## Homework Assignment
1. Complete the [Advanced Linux System Hardening Guide](../../Linux/Guides/Intermediate/Advanced_System_Hardening.md)
2. Create a custom security audit script for Linux systems
3. Research and document three advanced Linux security features
4. Practice implementing security settings from the CyberPatriot Linux checklist

## Additional Resources
- [CIS Linux Benchmarks](https://www.cisecurity.org/benchmark/distribution_independent_linux/)
- [Linux Security Hardening Guide](https://static.open-scap.org/ssg-guides/ssg-rhel7-guide-stig.html)
- [SELinux User Guide](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/selinux_users_and_administrators_guide/index)
- [AppArmor Documentation](https://gitlab.com/apparmor/apparmor/-/wikis/Documentation)
- [Linux Hardening Scripts](../../Linux/Scripts/Examples/)

## Materials Needed
- Ubuntu 22.04/Linux Mint VM for each cadet
- Linux security templates and examples
- SELinux/AppArmor configuration examples
- Firewall rule examples
- Projection system for demonstrations
- Linux hardening checklist
- Access to repository materials

## Instructor Notes
- Ensure all VMs are properly configured before class
- This session is technically challenging - prepare additional examples
- SELinux/AppArmor concepts can be difficult - have simplified explanations ready
- Allow extra time for troubleshooting permission and access control issues
- Emphasize documentation of changes made during hardening
- Highlight specific configurations commonly tested in competition
- Consider demonstrating a before/after security scan to show hardening effectiveness
- Be prepared with common CyberPatriot Linux vulnerabilities and their remediation
- If possible, include both Ubuntu and CentOS examples (as CyberPatriot uses both)
