# Windows Security Training Materials

This directory contains training materials, exercises, and resources for the Windows portion of the CyberPatriot competition. The content covers Windows 11 and Windows Server 2025 security hardening techniques and best practices.

## Directory Structure

```
Windows/
├── Guides/                 # Educational guides for Windows security
│   ├── Basic/              # Fundamental Windows security concepts
│   ├── Intermediate/       # More advanced security configurations
│   └── Advanced/           # Complex security implementations
│
├── Exercises/              # Hands-on Windows security exercises
│
├── Scripts/                # PowerShell scripts for Windows hardening
│   ├── Templates/          # Script templates for cadets to modify
│   ├── Examples/           # Example scripts for reference
│   └── Solutions/          # Solution scripts (mentor access only)
│
├── Quizzes/                # Assessment materials
│   ├── Quiz-Files/         # Quiz questions in various formats
│   └── Solutions/          # Answer keys for quizzes
│
└── VM-Setup/               # Instructions for setting up Windows VMs
```

## Getting Started

1. Set up a Windows VM using [VM-Setup](./VM-Setup)
2. Review [Guides/Basic](./Guides/Basic) for foundational security concepts
3. Complete introductory exercises
4. Explore script examples for automation

## Learning Path

1. User account management and password policies
2. Windows Update and patch management
3. Windows Defender and security tools
4. Windows Firewall configuration
5. Service hardening and application security
6. Advanced topics: Group Policy, Registry security, auditing

## CyberPatriot Competition Tips

- Always read the competition README file first
- Use checklists to ensure you don't miss critical steps
- Focus on high-value items: user accounts, updates, Defender, Firewall, services
- Document your changes for troubleshooting and reporting

## Windows Security Fundamentals

- User Account Security (accounts, passwords, rights, admin)
- System Security (updates, Defender, Firewall, services)
- Application Security (software restrictions, browser, malware removal)
- Policy-Based Security (Local Security Policy, Group Policy, templates)
- Monitoring and Auditing (event logs, audit policies)

## Scripting and Automation

The Scripts directory contains PowerShell scripts for:
- Automating security checks
- Hardening system components
- Auditing security settings
- Performing system inventory

## Additional Resources

- [Microsoft Security Documentation](https://docs.microsoft.com/en-us/security/)
- [CIS Windows Benchmarks](https://www.cisecurity.org/benchmark/microsoft_windows_desktop/)
- [NIST Security Guidelines](https://nvlpubs.nist.gov/nistpubs/specialpublications/nist.sp.800-123.pdf)
- [CyberPatriot Windows Training Materials](https://www.uscyberpatriot.org/competition/training-materials/windows)
