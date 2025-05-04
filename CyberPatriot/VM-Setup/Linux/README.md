# CyberPatriot Linux VM Setup: "Corporate Server Breach" Scenario

This directory contains scripts and documentation for setting up unique Linux VMs for CyberPatriot training. The main scenario simulates a compromised Ubuntu server with multiple vulnerabilities and forensic artifacts.

## Quick Start

1. Create a new Ubuntu 22.04 VM (minimal install).
2. Download `corporate-server-breach.sh` to the VM.
3. Make executable: `chmod +x corporate-server-breach.sh`
4. Run as root: `sudo ./corporate-server-breach.sh`
5. Take a VM snapshot labeled "Innovatech Breach - Initial State" before distributing to cadets.

## Scenario Features

- Multiple unauthorized user accounts (including UID 0)
- SSH and service misconfigurations
- Malicious cron jobs and SUID binaries
- Disabled firewall and weak password policies
- Competition README with scenario, objectives, and forensic questions

## Usage

- Cadets log in as sysadmin_innovatech / InnovatechPass2024#
- Read the README-Innovatech-Incident.txt on the Desktop
- Remove all unauthorized users and persistence
- Harden services and restore security controls
- Answer forensic questions in the README

## Customization

- Edit usernames, passwords, or vulnerabilities in the script as needed
- Add/remove attack evidence for different difficulty levels

## Troubleshooting

- Ensure script is run as root on Ubuntu 22.04
- Check `/var/log/innovatech-vm-setup.log` for errors

*This scenario is unique and designed for CyberPatriot training only.*
