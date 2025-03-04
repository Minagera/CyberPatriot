# Enterprise Workstation Compromise - Windows Incident Response Scenario

This directory contains a PowerShell script to set up a realistic Windows incident response training environment for CyberPatriot competition preparation. The scenario simulates a compromised corporate workstation with multiple persistence mechanisms, security vulnerabilities, and evidence of unauthorized access.

## Overview

The `enterprise-workstation-setup.ps1` script transforms a clean Windows installation into a compromised workstation that contains traces of a successful attack. Cadets must investigate the breach, identify how attackers gained and maintained access, remove malicious components, and implement proper security controls.

## Features

- RDP brute force attack evidence in event logs
- Multiple attacker persistence mechanisms:
  - Hidden backdoor user accounts
  - Malicious scheduled tasks
  - Registry autoruns
  - Startup folder items
- Disabled security features (Windows Defender, Firewall)
- Insecure system configurations
- Leaked credentials and sensitive data
- Automated scoring system

## Requirements

- Windows 10 or Windows 11 (fresh installation)
- Windows Server 2019 or 2022 also works
- Minimum 50GB disk space
- 4GB RAM minimum (8GB recommended)
- Internet connection during setup
- Administrator access

## Installation

1. Create a new Windows VM in your preferred virtualization software
2. Install Windows with default options
3. Create a user named "ITAdmin" during installation
4. Install VM guest additions if needed
5. Take a snapshot labeled "Clean Windows Install"
6. Run the following commands in PowerShell as Administrator:

```powershell
# Allow script execution for this session
Set-ExecutionPolicy Bypass -Scope Process -Force

# Download the script
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Minagera/CyberPatriot/main/CyberPatriot/Windows/VM-Setup/enterprise-workstation-setup.ps1" -OutFile "setup.ps1"

# Run the script
.\setup.ps1
```

7. Take a snapshot labeled "Enterprise Workstation - Ready"

## Usage Instructions

1. Provide cadets with the VM in its compromised state
2. Have them login with credentials: ITAdmin / Company2023!
3. Direct them to read the README.txt file on the desktop
4. Set a time limit (90-120 minutes recommended)
5. Cadets can check their progress using the "Check Score" shortcut on the desktop

## Forensic Questions

The scenario includes several forensic questions that require investigation:

1. What IP address was used in the apparent brute force attack?
2. What user account was compromised in the initial attack?
3. Identify all persistence mechanisms the attacker installed on the system.
4. What sensitive information may have been compromised?
5. What methods did the attacker use to maintain access to the system?

## Customization

You can modify the script to adjust difficulty level or change specific aspects:

- Edit usernames, passwords, or IP addresses to match your training scenario
- Add or remove specific vulnerabilities as needed
- Modify the scoring script to change point values or add new checks

## Scoring

The scoring system evaluates cadets on their ability to:

- Remove unauthorized user accounts
- Identify and remove malicious scheduled tasks
- Clean up registry autoruns and startup items
- Enable Windows security features
- Implement proper password policies
- Secure Remote Desktop settings

## Notes for Instructors

- This VM is designed for educational purposes only
- Do not connect the compromised VM directly to the internet
- Use an isolated network for multi-VM training scenarios
- Reset to the "Enterprise Workstation - Ready" snapshot between training sessions
- Consider having cadets document their findings and remediation steps

## Troubleshooting

If you encounter issues during setup:

- Ensure PowerShell is running as Administrator
- Verify the VM has internet access during setup
- Check Windows version compatibility
- Make sure Windows Update is not running during script execution

For additional help, open an issue on the GitHub repository.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
