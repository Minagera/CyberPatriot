# Linux Security Training Materials

## Directory Structure

```
Linux/
├── Guides/                 # Educational guides for Linux security
│   ├── Basic/              # Fundamental Linux security concepts
│   ├── Intermediate/       # More advanced security configurations
│   └── Advanced/           # Complex security implementations
│
├── Exercises/              # Hands-on Linux security exercises
│
├── Scripts/                # Bash scripts for Linux hardening
│   ├── Templates/          # Script templates for cadets to modify
│   ├── Examples/           # Example scripts for reference
│   └── Solutions/          # Solution scripts (mentor access only)
│
├── Quizzes/                # Assessment materials
│   ├── Quiz-Files/         # Quiz questions in various formats
│   └── Solutions/          # Answer keys for quizzes
│
└── VM-Setup/               # Instructions for setting up Linux VMs
```

## Getting Started

1. Begin by setting up a Linux VM using the instructions in the [VM-Setup](./VM-Setup) directory
2. Review the basic security concepts in the [Guides/Basic](./Guides/Basic) directory
3. Try the introductory exercises
4. Explore the script examples to learn about automation

## Learning Path

For optimal learning, we recommend following this sequence:

1. Basic Linux commands and system administration
2. User account security and permissions
3. Service and application security
4. Network security and firewall configuration
5. Logging and monitoring
6. Advanced security hardening techniques

## CyberPatriot Competition Tips

- The Linux portion of CyberPatriot typically involves:
  - Securing user accounts (removing unauthorized users, setting appropriate permissions)
  - Configuring password policies
  - Securing system services
  - Configuring the firewall (UFW/iptables)
  - Removing malware and unauthorized software
  - Addressing specific vulnerabilities mentioned in the competition README

- Focus on completing the highest-value items first
- Always read the competition README file thoroughly
- Use checklists to ensure you don't miss critical steps
- Document your changes in case you need to troubleshoot
- Learn to use the `find` command to locate suspicious files

## Linux Security Fundamentals

The key areas of Linux security covered in these materials include:

1. **User Account Security**
   - User management and authentication
   - Password policies
   - Privilege management
   - Group configuration
   - Sudo access control

2. **File System Security**
   - File permissions
   - Special permissions (SUID, SGID, sticky bit)
   - File attributes
   - Access Control Lists (ACLs)
   - Disk encryption

3. **System Service Security**
   - Service configuration and hardening
   - Disabling unnecessary services
   - Running services with minimal privileges
   - Secure SSH configuration
   - Secure web server configuration

4. **Network Security**
   - Firewall configuration (UFW/iptables)
   - Network service hardening
   - Port management
   - Traffic filtering
   - Intrusion detection

5. **Auditing and Logging**
   - Log configuration
   - Log monitoring
   - Audit frameworks
   - Intrusion detection systems

## Scripting and Automation

The Scripts directory contains Bash scripts for:
- Automating security checks
- Hardening system components
- Auditing security settings
- Performing system inventory

Learning to use these scripts will help you work more efficiently during competitions.

## Additional Resources

- [Ubuntu Security Documentation](https://ubuntu.com/security)
- [CIS Benchmarks for Linux](https://www.cisecurity.org/benchmark/ubuntu_linux/)
- [NIST Linux Security Guidelines](https://csrc.nist.gov/publications/detail/sp/800-123/final)
- [CyberPatriot Linux Training Materials](https://www.uscyberpatriot.org/competition/training-materials/linux)
