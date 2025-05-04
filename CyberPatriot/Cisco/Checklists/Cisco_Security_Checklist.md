# Detailed Cisco Security Checklist

## Device Hardening
- [ ] Set hostname and domain name
- [ ] Set enable secret and encrypt all passwords
- [ ] Configure login banners (MOTD, login, exec)
- [ ] Disable unused interfaces and assign to unused VLAN

## Access Security
- [ ] Set console and VTY passwords
- [ ] Enable SSH, disable Telnet
- [ ] Use local user accounts for login
- [ ] Set exec-timeout for all lines

## Service Security
- [ ] Disable unnecessary services (CDP, HTTP, finger, etc.)
- [ ] Restrict SNMP to authorized hosts or disable if not needed

## Network Security
- [ ] Configure basic ACLs to restrict management access
- [ ] Apply ACLs to VTY lines and interfaces

## Configuration Management
- [ ] Save configuration (`write memory`)
- [ ] Backup configuration to TFTP/FTP if allowed

*Always adapt this checklist to the specific competition scenario and README requirements.*
