# Enterprise Workstation Compromise - Windows Incident Response Scenario

This directory contains a PowerShell script to set up a realistic Windows incident response training environment for CyberPatriot competition preparation. The scenario simulates a compromised corporate workstation with multiple persistence mechanisms, security vulnerabilities, and evidence of unauthorized access.

## Quick Start

1. Create a new Windows 10/11 VM.
2. Download `enterprise-workstation-setup.ps1` to the VM.
3. Open PowerShell as Administrator.
4. Run:  
   `Set-ExecutionPolicy Bypass -Scope Process -Force`
5. Execute:  
   `.\enterprise-workstation-setup.ps1`
6. Take a VM snapshot labeled "Compromised State" before distributing to cadets.

## Scenario Features

- Hidden backdoor user account with admin rights
- Disabled Defender and Firewall
- Malicious scheduled task and registry autorun
- Competition-style README.txt with scenario and forensic questions
- Log file of all setup actions

## Usage

- Cadets log in as ITAdmin / Company2023!
- Read the README.txt on the desktop for scenario instructions
- Remove all unauthorized users and persistence
- Re-enable security features and harden the system
- Answer forensic questions in the README

## Customization

- Edit usernames, passwords, or persistence methods in the script as needed
- Add/remove vulnerabilities for different difficulty levels

## Troubleshooting

- Ensure PowerShell is run as Administrator
- VM must have internet access for Defender/Firewall commands
- Review `C:\setup_log_cyberpatriot.txt` for errors

*This scenario is unique and designed for CyberPatriot training only.*
