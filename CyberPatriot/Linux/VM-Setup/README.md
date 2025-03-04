# Corporate Server Breach - Linux Incident Response Scenario

This directory contains a script to set up a realistic Linux incident response training environment for CyberPatriot competition preparation. The scenario simulates a compromised corporate server with multiple backdoors, persistence mechanisms, vulnerable services, and forensic artifacts.

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

## Requirements

- Ubuntu 20.04 LTS or 22.04 LTS (fresh installation)
- Minimum 20GB disk space
- 2GB RAM minimum (4GB recommended)
- Internet connection during setup (for package installation)
- Sudo/root access

## Installation

1. Create a new Ubuntu VM in your preferred virtualization software
2. Install Ubuntu with minimal installation options
3. Create a user named "sysadmin" during installation 
4. Install VM guest additions if needed
5. Take a snapshot labeled "Clean Ubuntu Install"
6. Run the following commands:

```bash
# Download the script
curl -O https://raw.githubusercontent.com/Minagera/CyberPatriot/main/CyberPatriot/Linux/VM-Setup/corporate-server-breach.sh

# Make it executable
chmod +x corporate-server-breach.sh

# Run with sudo
sudo ./corporate-server-breach.sh
```

7. Take a snapshot labeled "Corporate Server Breach - Ready"

## Usage Instructions

1. Provide cadets with the VM in its compromised state
2. Have them login with credentials: sysadmin / Company2023!
3. Direct them to read the README.txt file in the home directory
4. Set a time limit (90-120 minutes recommended)
5. Cadets can check their progress using:
   - Command line: `check_score`
   - Web interface: http://localhost/score.php

## Forensic Questions

The scenario includes several forensic questions that require investigation:

1. What IP address was used in the apparent brute force attack?
2. How many failed login attempts were made during the brute force attack?
3. What user account was eventually compromised in this attack?
4. Identify all persistence mechanisms the attacker installed.
5. What sensitive information may have been compromised?

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
