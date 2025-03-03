# Windows Security Hardening Checklist

Use this checklist during CyberPatriot competitions to ensure you've covered the essential security hardening steps for Windows 11 and Windows Server 2025.

## Initial Assessment

- [ ] Document initial state of the system
- [ ] Take note of any scoring changes already showing
- [ ] Read the competition README file for specific requirements

## User Account Management

- [ ] Check all user accounts (`net user`)
- [ ] Identify and remove unauthorized accounts
- [ ] Verify Administrator group membership (`net localgroup Administrators`)
- [ ] Disable Guest account (`net user Guest /active:no`)
- [ ] Set strong passwords for all accounts
- [ ] Rename the Administrator account
- [ ] Check for accounts with password never expires

## Password Policy

- [ ] Set minimum password length (12+ characters)
- [ ] Enable password complexity requirements
- [ ] Set maximum password age (90 days or less)
- [ ] Set account lockout threshold (5 or less attempts)
- [ ] Set account lockout duration (30 minutes)

## Windows Updates

- [ ] Check Windows Update settings
- [ ] Configure automatic updates
- [ ] Install all available updates
- [ ] Enable automatic updates for Microsoft products

## Windows Defender & Security

- [ ] Verify Windows Defender is enabled
- [ ] Update virus definitions
- [ ] Run a full system scan
- [ ] Enable real-time protection
- [ ] Enable cloud-delivered protection
- [ ] Enable tamper protection
- [ ] Configure controlled folder access

## Windows Firewall

- [ ] Enable Windows Firewall for all profiles (Domain, Private, Public)
- [ ] Review and disable unnecessary inbound rules
- [ ] Review and disable unnecessary outbound rules
- [ ] Enable logging for Windows Firewall

## Services

- [ ] Disable unnecessary services:
  - [ ] Remote Registry
  - [ ] Telnet
  - [ ] FTP
  - [ ] Print Spooler (if not needed)
  - [ ] SNMP (if not needed)
  - [ ] Xbox services (if not needed)
  - [ ] Other unnecessary services

## Features and Roles

- [ ] Remove unnecessary Windows features
- [ ] Remove or secure unnecessary server roles (Server only)
- [ ] Configure server roles according to competition requirements

## File System

- [ ] Check for prohibited files (specified in README)
- [ ] Set appropriate permissions on sensitive files/folders
- [ ] Enable BitLocker (if available)
- [ ] Check for shared folders and remove unnecessary shares

## Group Policy (Local Security Policy)

- [ ] Disable anonymous SID enumeration
- [ ] Disable anonymous enumeration of shares
- [ ] Enable UAC
- [ ] Restrict remote access to the registry
- [ ] Disable autorun for all drives

## Registry

- [ ] Disable remote registry access
- [ ] Verify secure registry settings
- [ ] Check for unauthorized startup items

## Event Logging

- [ ] Configure security event logging
- [ ] Set appropriate log sizes
- [ ] Enable audit policies for account logon events
- [ ] Enable audit policies for account management
- [ ] Enable audit policies for system events

## Network Configuration

- [ ] Disable unnecessary network protocols
- [ ] Disable NetBIOS over TCP/IP if not needed
- [ ] Disable IPv6 if not needed
- [ ] Disable SMB 1.0 protocol
- [ ] Configure DNS settings properly

## Internet Browser Security

- [ ] Update all installed browsers
- [ ] Configure enhanced security for Internet Explorer
- [ ] Disable unnecessary browser extensions
- [ ] Set appropriate security zones

## Remote Access

- [ ] Disable Remote Desktop if not needed
- [ ] If RDP is required, enable Network Level Authentication
- [ ] Disable remote assistance if not needed
- [ ] Configure Windows Remote Management appropriately

## Server-Specific (For Windows Server)

- [ ] Check and secure Active Directory (if present)
- [ ] Secure DNS server (if present)
- [ ] Secure DHCP server (if present)
- [ ] Secure IIS web server (if present)
- [ ] Check Group Policy settings
- [ ] Verify FSMO roles (if Domain Controller)

## Final Verification

- [ ] Check scoring engine for progress
- [ ] Verify no critical services were disabled
- [ ] Document all changes made
- [ ] Look for any remaining vulnerabilities

## Competition-Specific

- [ ] Address any specific vulnerabilities mentioned in README
- [ ] Answer all forensic questions
- [ ] Complete any required tasks mentioned in README

---

## Notes

- Remember to check the scoring report frequently to see your progress
- If you're unsure about a service or feature, research it before disabling
- Document all significant changes you make to the system
- When in doubt, consult your mentor or competition rules
