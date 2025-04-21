# Linux Security Track

This track covers Linux security concepts, tools, and techniques relevant to the CyberPatriot competition. The materials focus on Ubuntu and Linux Mint distributions, which are commonly used in the competition.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Learning Path](#learning-path)
- [Module 1: Linux Fundamentals](#module-1-linux-fundamentals)
- [Module 2: Intermediate Linux Security](#module-2-intermediate-linux-security)
- [Module 3: Advanced Linux Security](#module-3-advanced-linux-security)
- [Practice Exercises](#practice-exercises)
- [Security Scripts](#security-scripts)
- [References](#references)

## Prerequisites

- Ubuntu/Linux Mint virtual machine
- Root/sudo access
- Basic understanding of the Linux command line

## Learning Path

### Beginner Path
Start with the fundamentals modules to understand the Linux operating system structure, basic commands, and security features.

### Advanced Path
If you're already familiar with Linux basics, you can start with the intermediate modules and advanced exercises.

## Module 1: Linux Fundamentals

### 1.1 Linux Architecture
- [Linux File System Hierarchy](./fundamentals/file_system_hierarchy.md)
- [Linux Boot Process](./fundamentals/boot_process.md)
- [System Initialization](./fundamentals/system_initialization.md)

### 1.2 Command Line Basics
- [Essential Commands](./fundamentals/essential_commands.md)
- [File and Directory Operations](./fundamentals/file_operations.md)
- [Text Processing](./fundamentals/text_processing.md)

### 1.3 User and Group Management
- [User Accounts](./fundamentals/user_accounts.md)
- [Group Management](./fundamentals/group_management.md)
- [File Permissions](./fundamentals/file_permissions.md)

### 1.4 Package Management
- [APT Package Management](./fundamentals/apt_package_management.md)
- [Software Repositories](./fundamentals/software_repositories.md)
- [System Updates](./fundamentals/system_updates.md)

## Module 2: Intermediate Linux Security

### 2.1 File System Security
- [Advanced Permissions](./intermediate/advanced_permissions.md)
- [ACLs](./intermediate/access_control_lists.md)
- [File Integrity](./intermediate/file_integrity.md)

### 2.2 Service Management
- [Systemd Services](./intermediate/systemd_services.md)
- [Service Hardening](./intermediate/service_hardening.md)
- [Service Monitoring](./intermediate/service_monitoring.md)

### 2.3 Network Security
- [Firewall Configuration (UFW)](./intermediate/ufw_configuration.md)
- [Firewall Configuration (iptables)](./intermediate/iptables_configuration.md)
- [Network Services Security](./intermediate/network_services.md)

### 2.4 Authentication Security
- [PAM Configuration](./intermediate/pam_configuration.md)
- [Password Policies](./intermediate/password_policies.md)
- [Sudo Configuration](./intermediate/sudo_configuration.md)

## Module 3: Advanced Linux Security

### 3.1 Advanced Hardening
- [AppArmor Configuration](./advanced/apparmor.md)
- [SELinux Basics](./advanced/selinux_basics.md)
- [Kernel Security Parameters](./advanced/kernel_security.md)

### 3.2 Logging and Auditing
- [System Logging](./advanced/system_logging.md)
- [Audit Framework](./advanced/audit_framework.md)
- [Log Analysis](./advanced/log_analysis.md)

### 3.3 Intrusion Detection
- [Rootkit Detection](./advanced/rootkit_detection.md)
- [File Integrity Monitoring](./advanced/file_integrity_monitoring.md)
- [Intrusion Detection Systems](./advanced/ids.md)

### 3.4 Incident Response
- [Malware Detection](./advanced/malware_detection.md)
- [Security Incident Handling](./advanced/incident_handling.md)
- [System Recovery](./advanced/system_recovery.md)

## Practice Exercises

- [Basic Exercises](./exercises/basic/)
- [Intermediate Exercises](./exercises/intermediate/)
- [Advanced Exercises](./exercises/advanced/)
- [Mock Competition Scenarios](./exercises/competition/)

## Security Scripts

- [System Hardening Script](./scripts/system_hardening.sh)
- [User Management Script](./scripts/user_management.sh)
- [Service Security Script](./scripts/service_security.sh)
- [Firewall Configuration Script](./scripts/firewall_config.sh)
- [Security Audit Script](./scripts/security_audit.sh)

## References

- [Linux Security Checklists](./references/checklists.md)
- [Common Vulnerabilities](./references/common_vulnerabilities.md)
- [Command Reference](./references/command_reference.md)
- [Additional Resources](./references/additional_resources.md)
