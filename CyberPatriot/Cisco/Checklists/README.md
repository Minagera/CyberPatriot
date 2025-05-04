# Cisco Checklists Directory

This directory contains unique checklists for securing Cisco devices in CyberPatriot competitions.

## Included Checklists

- `Cisco_Security_Checklist.md`: Step-by-step checklist for router and switch security.

*All checklists are original and tailored for CyberPatriot. Use them during practice and competition for maximum points.*

# Cisco Security Checklist for CyberPatriot

This checklist is designed for use during CyberPatriot competitions to secure Cisco routers and switches.

## Basic Device Hardening

- [ ] Change default passwords and set strong enable secret
- [ ] Set unique device hostname
- [ ] Configure login banners (MOTD, login, exec)
- [ ] Disable unused interfaces (`shutdown`)
- [ ] Set console and VTY timeouts
- [ ] Require login for console and VTY lines
- [ ] Enable password encryption (`service password-encryption`)
- [ ] Disable HTTP/HTTPS server if not needed
- [ ] Disable CDP if not required
- [ ] Set clock and timezone

## Secure Remote Access

- [ ] Disable Telnet, enable SSH only
- [ ] Set SSH version 2
- [ ] Restrict VTY access with access-class
- [ ] Use local user database for SSH login

## Access Control

- [ ] Create and apply standard/extended ACLs to restrict management and user traffic
- [ ] Apply ACLs to VTY lines and interfaces as appropriate

## Save and Verify

- [ ] Save configuration (`write memory`)
- [ ] Verify all changes with `show running-config` and `show version`
- [ ] Document all changes for scoring and troubleshooting

---
