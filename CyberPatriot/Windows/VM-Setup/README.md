# Enterprise Workstation Compromise - Windows Incident Response Scenario

This directory contains a PowerShell script to set up a realistic Windows incident response training environment for CyberPatriot competition preparation. The scenario simulates a compromised corporate workstation with multiple persistence mechanisms, security vulnerabilities, and evidence of unauthorized access.

## Understanding the Competition

CyberPatriot is best defined as an **incident response and remediation competition** where teams inherit a business computer network that has been compromised. Teams must:

1. Identify unauthorized changes and security issues
2. Find and analyze forensic artifacts
3. Remove attacker persistence mechanisms
4. Apply security hardening to prevent future attacks

Rather than simply collecting and applying security fixes, successful teams develop a comprehensive approach to understanding and responding to security incidents.

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
- Competition-style README.txt file

## Requirements

- Windows 10 or Windows 11 (fresh installation)
- Windows Server 2019 or 2022 also works
- Minimum 50GB disk space
- 4GB RAM minimum (8GB recommended)
- Internet connection during setup
- Administrator access

## Quick Start

```powershell
# Allow script execution for this session
Set-ExecutionPolicy Bypass -Scope Process -Force

# Download the script
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Minagera/CyberPatriot/main/CyberPatriot/Windows/VM-Setup/enterprise-workstation-setup.ps1" -OutFile "setup.ps1"

# Run the script
.\setup.ps1
```

## Detailed Installation

1. Create a new Windows VM in your preferred virtualization software
2. Install Windows with default options
3. Create a user named "ITAdmin" during installation
4. Install VM guest additions if needed
5. Take a snapshot labeled "Clean Windows Install"
6. Run the quick start commands above
7. Take a snapshot labeled "Enterprise Workstation - Ready"

## Usage Instructions

1. Provide cadets with the VM in its compromised state
2. Have them login with credentials: ITAdmin / Company2023!
3. Direct them to read the README.txt file on the desktop
4. Set a time limit (90-120 minutes recommended)
5. Cadets can check their progress using the "Check Score" shortcut on the desktop

## Competition README

The script creates a competition-style README.txt file on the desktop that includes:

- A scenario description of a corporate workstation compromise
- Tasks for the incident response team
- Company security policy requirements
- Forensic questions that require investigation of logs and system artifacts

This mimics the actual README files provided during CyberPatriot competition rounds.

## Effective Training Approach

Based on the experiences of national champions, here are key strategies for effective CyberPatriot training:

### 1. Develop the Security Mindset
Focus on understanding security principles that can be applied broadly, rather than just collecting specific fixes.

### 2. Baselining Strategy
Train cadets to compare the competition image with clean systems to identify:
- Unauthorized user accounts
- Unusual running services
- Modified registry entries
- Suspicious scheduled tasks
- Unexpected network connections

### 3. Operating System Familiarity
Develop deep knowledge of operating system internals:
- User management and authentication
- Registry structure and important keys
- Group Policy and Local Security Policy
- Service management
- Task Scheduler
- Windows Event Logs

### 4. Structured Approach
During competition, follow a methodical process:
1. Review README and forensic questions
2. Analyze security logs and event viewer
3. Check for unauthorized users and groups
4. Examine startup items and scheduled tasks
5. Look for registry modifications
6. Enable and configure security features
7. Apply proper permissions and policies

## Training Session Structure

For optimal learning, structure training sessions as follows:

1. **Briefing** (10 minutes)
   - Explain the scenario background
   - Review previous lessons learned
   - Set clear objectives

2. **Investigation & Remediation** (90-120 minutes)
   - Provide access to the scenario VM
   - Allow cadets to work independently or in teams
   - Encourage documentation of findings

3. **Debrief** (30 minutes)
   - Review scoring results
   - Discuss challenges encountered
   - Share effective solutions
   - Identify knowledge gaps for future training

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
