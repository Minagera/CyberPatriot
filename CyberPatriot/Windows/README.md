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

1. Begin by setting up a Windows VM using the instructions in the [VM-Setup](./VM-Setup) directory
2. Review the basic security concepts in the [Guides/Basic](./Guides/Basic) directory
3. Try the introductory exercises
4. Explore the script examples to learn about automation

## Learning Path

For optimal learning, we recommend following this sequence:

1. Basic Windows security principles and user account management
2. Windows Update and patch management
3. Windows Defender and security tools
4. Windows Firewall configuration
5. Service hardening and application security
6. Advanced security topics (Group Policy, Registry security, etc.)

## CyberPatriot Competition Tips

- The Windows portion of CyberPatriot typically involves:
  - Securing user accounts (removing unauthorized users, setting appropriate permissions)
  - Ensuring Windows Update is configured correctly
  - Enabling and configuring Windows security features
  - Removing malware and unauthorized software
  - Answering forensic questions
  - Implementing security policies

- Focus on completing the highest-value items first
- Always read the competition README file thoroughly
- Use checklists to ensure you don't miss critical steps
- Take snapshots of your VM when possible to create recovery points
- Document your changes in case you need to troubleshoot

## Windows Security Fundamentals

The key areas of Windows security covered in these materials include:

1. **User Account Security**
   - User account management
   - Password policies
   - User rights assignments
   - Administrator accounts

2. **System Security**
   - Windows Update configuration
   - Windows Defender settings
   - Windows Firewall
   - Service hardening

3. **Application Security**
   - Software restrictions
   - Application control
   - Browser security
   - Malware prevention and removal

4. **Policy-Based Security**
   - Local security policy
   - Group Policy (Server)
   - Security templates
   - Security compliance

5. **Monitoring and Auditing**
   - Event logs
   - Audit policies
   - Security monitoring

## Scripting and Automation

The Scripts directory contains PowerShell scripts for:
- Automating security checks
- Hardening system components
- Auditing security settings
- Performing system inventory

Learning to use these scripts will help you work more efficiently during competitions.

## Additional Resources

- [Microsoft Security Documentation](https://docs.microsoft.com/en-us/security/)
- [CIS Windows Benchmarks](https://www.cisecurity.org/benchmark/microsoft_windows_desktop/)
- [NIST Security Guidelines](https://nvlpubs.nist.gov/nistpubs/specialpublications/nist.sp.800-123.pdf)
- [CyberPatriot Windows Training Materials](https://www.uscyberpatriot.org/competition/training-materials/windows)
