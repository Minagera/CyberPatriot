# Corporate Server Breach - Linux Incident Response Scenario

This directory contains a script to set up a realistic Linux incident response training environment for CyberPatriot competition preparation. The scenario simulates a compromised corporate server with multiple backdoors, persistence mechanisms, vulnerable services, and forensic artifacts.

## Understanding the Competition

CyberPatriot is best defined as an **incident response and remediation competition** where teams inherit a business computer network that has been compromised. Teams must:

1. Identify unauthorized changes and security issues
2. Find and analyze forensic artifacts
3. Remove attacker persistence mechanisms
4. Apply security hardening to prevent future attacks

Rather than simply collecting and applying security fixes, successful teams develop a comprehensive approach to understanding and responding to security incidents.

## Overview

The `corporate-server-breach.sh` script transforms a clean Ubuntu installation into a compromised server that exhibits signs of a successful attack with established persistence. Cadets must investigate the breach, identify unauthorized access methods, remove backdoors, and secure the system according to security requirements.

## Features

- SSH brute force attack evidence in log files
- Multiple attacker persistence mechanisms:
  - Backdoor user accounts
  - Malicious cron jobs
  - SUID binaries
  - Backdoor systemd services
- Vulnerable service configurations
- Leaked credentials and sensitive data
- Automated scoring system
- Competition-style README.txt file

## Requirements

- Ubuntu 20.04 LTS or 22.04 LTS (fresh installation)
- Minimum 20GB disk space
- 2GB RAM minimum (4GB recommended)
- Internet connection during setup (for package installation)
- Sudo/root access

## Quick Start

```bash
# Download the script
curl -O https://raw.githubusercontent.com/Minagera/CyberPatriot/main/CyberPatriot/Linux/VM-Setup/corporate-server-breach.sh

# Make it executable
chmod +x corporate-server-breach.sh

# Run with sudo
sudo ./corporate-server-breach.sh
```

## Detailed Installation

1. Create a new Ubuntu VM in your preferred virtualization software
2. Install Ubuntu with minimal installation options
3. Create a user named "sysadmin" during installation 
4. Install VM guest additions if needed
5. Take a snapshot labeled "Clean Ubuntu Install"
6. Run the quick start commands above
7. Take a snapshot labeled "Corporate Server Breach - Ready"

## Usage Instructions

1. Provide cadets with the VM in its compromised state
2. Have them login with credentials: sysadmin / Company2023!
3. Direct them to read the README.txt file in the home directory
4. Set a time limit (90-120 minutes recommended)
5. Cadets can check their progress using:
   - Command line: `check_score`
   - Web interface: http://localhost/score.php

## Competition README

The script creates a competition-style README.txt file in the home directory that includes:

- A scenario description of a corporate server breach
- Tasks for the incident response team
- Company security policy requirements
- Forensic questions that require investigation of log files and system artifacts

This mimics the actual README files provided during CyberPatriot competition rounds.

## Effective Training Approach

Based on the experiences of national champions, here are key strategies for effective CyberPatriot training:

### 1. Develop the Security Mindset
Focus on understanding security principles that can be applied broadly, rather than just collecting specific fixes.

### 2. Baselining Strategy
Train cadets to compare the competition image with clean systems to identify:
- Unauthorized user accounts
- Unusual running services
- Modified configuration files
- Suspicious scheduled tasks/cron jobs
- Unexpected network connections

### 3. Operating System Familiarity
Develop deep knowledge of operating system internals:
- Authentication mechanisms
- Service management
- Logging systems
- Permission models
- Configuration file structures

### 4. Structured Approach
During competition, follow a methodical process:
1. Review README and forensic questions
2. Baseline the system against a clean reference
3. Identify and remove unauthorized access methods
4. Update and patch the system
5. Secure configurations and services
6. Implement proper user and permission policies

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

- Change the `SCENARIO_LEVEL` variable to "basic", "intermediate", or "advanced"
- Edit usernames, passwords, or IP addresses to match your training scenario
- Add or remove specific vulnerabilities as needed

## Scoring

The scoring system evaluates cadets on their ability to:

- Remove unauthorized user accounts
- Disable malicious services and cron jobs
- Implement secure service configurations
- Apply proper password policies
- Enable and configure system security features

## Notes for Instructors

- This VM is designed for educational purposes only
- Do not connect the compromised VM directly to the internet
- Use an isolated network for multi-VM training scenarios
- Reset to the "Corporate Server Breach - Ready" snapshot between training sessions
- Consider having cadets document their findings and remediation steps

## Troubleshooting

If you encounter issues during setup:

- Check the Ubuntu version (20.04/22.04 recommended)
- Ensure the VM has internet access during setup
- Verify you have sufficient disk space
- Run the script with sudo privileges

For additional help, open an issue on the GitHub repository.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
