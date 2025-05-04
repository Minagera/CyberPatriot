# Intermediate Cisco Security Guide

Topics:
- Configuring VLANs and trunking
- Enabling SSH and disabling Telnet
- Setting up basic ACLs
- Interface security best practices

## Example: Enable SSH

```plaintext
ip domain-name cyberpatriot.local
crypto key generate rsa
username cadet privilege 15 secret StrongCadetPass!
line vty 0 4
  transport input ssh
  login local
```

*Test SSH access in Packet Tracer after configuration.*

# Intermediate Cisco Security

This guide covers VLANs, ACLs, and switch security for CyberPatriot.

- Create and assign VLANs
- Configure trunk ports
- Implement standard and extended ACLs
- Enable port security on switches
- Secure management access

*Use these techniques to secure your Packet Tracer scenarios and real devices.*

## Table of Contents

- [Authentication Security](#authentication-security)
- [Management Plane Security](#management-plane-security)
- [Data Plane Security](#data-plane-security)
- [Port Security](#port-security)
- [VLAN Security](#vlan-security)
- [Spanning Tree Security](#spanning-tree-security)
- [DHCP Snooping](#dhcp-snooping)
- [Dynamic ARP Inspection](#dynamic-arp-inspection)
- [Logging and Monitoring](#logging-and-monitoring)
- [Security Verification](#security-verification)
- [Common CyberPatriot Switch Security Issues](#common-cyberpatriot-switch-security-issues)

## Authentication Security

### Strong Password Configuration

```cisco
! Set minimum password length
Switch(config)# security passwords min-length 10

! Enforce password complexity
Switch(config)# aaa new-model
Switch(config)# aaa local authentication attempts max-fail 3
Switch(config)# aaa authentication password-prompt "Password: "
Switch(config)# aaa authentication username-prompt "Username: "

! Encrypt all passwords in the configuration
Switch(config)# service password-encryption

! Set a strong enable secret (preferred over enable password)
Switch(config)# enable algorithm-type sha256 secret Str0ng3n@bleP@ss!

! Set login delay to prevent brute-force attacks
Switch(config)# login delay 3
Switch(config)# login block-for 120 attempts 3 within 60
```

### Secure User Authentication

```cisco
! Create local user accounts with encrypted passwords
Switch(config)# username admin privilege 15 algorithm-type sha256 secret Adm1nP@ssw0rd!
Switch(config)# username operator privilege 5 algorithm-type sha256 secret 0per@torP@ss!

! Configure console line with authentication
Switch(config)# line console 0
Switch(config-line)# exec-timeout 5 0        ! Timeout after 5 minutes of inactivity
Switch(config-line)# login local             ! Use local user database for authentication
Switch(config-line)# exit

! Configure VTY lines (Telnet/SSH) with authentication
Switch(config)# line vty 0 15
Switch(config-line)# exec-timeout 5 0        ! Timeout after 5 minutes of inactivity
Switch(config-line)# login local             ! Use local user database for authentication
Switch(config-line)# transport input ssh     ! Allow only SSH (no Telnet)
Switch(config-line)# exit
```

### SSH Configuration

```cisco
! Configure domain name (required for SSH)
Switch(config)# ip domain name cyberpatriot.org

! Generate RSA key pair (2048 bits recommended for security)
Switch(config)# crypto key generate rsa modulus 2048

! Configure SSH version 2 (more secure than version 1)
Switch(config)# ip ssh version 2

! Set SSH timeout and authentication retries
Switch(config)# ip ssh time-out 60
Switch(config)# ip ssh authentication-retries 3

! Configure SSH for local login with timeout
Switch(config)# line vty 0 15
Switch(config-line)# transport input ssh
Switch(config-line)# login local
Switch(config-line)# exec-timeout 5 0
```

## Management Plane Security

The management plane handles administrative traffic to the switch itself.

### Secure Management Access

```cisco
! Create a management access control list
Switch(config)# ip access-list standard MGMT-ACCESS
Switch(config-std-nacl)# permit 192.168.10.0 0.0.0.255  ! Allow management from trusted subnet
Switch(config-std-nacl)# deny any log               ! Deny and log all other access attempts
Switch(config-std-nacl)# exit

! Apply the ACL to restrict management access
Switch(config)# line vty 0 15
Switch(config-line)# access-class MGMT-ACCESS in
Switch(config-line)# exit

! Create a management VLAN
Switch(config)# vlan 999
Switch(config-vlan)# name Management
Switch(config-vlan)# exit

! Configure the management interface
Switch(config)# interface vlan 999
Switch(config-if)# ip address 192.168.10.2 255.255.255.0
Switch(config-if)# no shutdown
Switch(config-if)# exit
```

### Disable Unnecessary Services

```cisco
! Disable unnecessary services that could be exploited
Switch(config)# no service pad                   ! Disable PAD service
Switch(config)# no ip http server                ! Disable HTTP server
Switch(config)# no ip http secure-server         ! Disable HTTPS server if not used
Switch(config)# no service tcp-small-servers     ! Disable small TCP servers
Switch(config)# no service udp-small-servers     ! Disable small UDP servers
Switch(config)# no ip source-route               ! Disable IP source routing
Switch(config)# no ip gratuitous-arps            ! Disable gratuitous ARPs
```

### SNMP Security (if SNMP is required)

```cisco
! Configure SNMPv3 (more secure than v1/v2)
Switch(config)# ip access-list standard SNMP-ACCESS
Switch(config-std-nacl)# permit 192.168.10.5     ! SNMP management station
Switch(config-std-nacl)# exit

Switch(config)# snmp-server view RESTRICTED iso included
Switch(config)# snmp-server group ADMIN v3 priv read RESTRICTED write RESTRICTED
Switch(config)# snmp-server user SNMPAdmin ADMIN v3 auth sha Auth@Password priv aes 128 Priv@Password
Switch(config)# snmp-server host 192.168.10.5 version 3 priv SNMPAdmin
Switch(config)# snmp-server enable traps
Switch(config)# snmp-server community public view RESTRICTED ro SNMP-ACCESS
```

## Data Plane Security

The data plane handles forwarding user traffic through the switch.

### Interface Security

```cisco
! Disable unused ports
Switch(config)# interface range gigabitethernet 0/10 - 24
Switch(config-if-range)# shutdown
Switch(config-if-range)# exit

! Add description to active ports
Switch(config)# interface gigabitethernet 0/1
Switch(config-if)# description Connection to Server1
Switch(config-if)# exit
```

## Port Security

Port security limits the number of MAC addresses that can be learned on a port and can prevent MAC address flooding attacks.

```cisco
! Configure port security on access ports
Switch(config)# interface gigabitethernet 0/1
Switch(config-if)# switchport mode access               ! Set port to access mode
Switch(config-if)# switchport access vlan 10            ! Assign to appropriate VLAN
Switch(config-if)# switchport port-security             ! Enable port security
Switch(config-if)# switchport port-security maximum 2   ! Allow up to 2 MAC addresses
Switch(config-if)# switchport port-security mac-address sticky  ! Dynamically learn and save MAC addresses
Switch(config-if)# switchport port-security violation shutdown  ! Shut down port if violation occurs
Switch(config-if)# spanning-tree portfast               ! Enable portfast for access ports
Switch(config-if)# spanning-tree bpduguard enable       ! Enable BPDU guard
Switch(config-if)# exit

! Configure port security on trunk port
Switch(config)# interface gigabitethernet 0/24
Switch(config-if)# switchport mode trunk               ! Set port to trunk mode
Switch(config-if)# switchport nonegotiate              ! Disable DTP
Switch(config-if)# exit
```

## VLAN Security

VLANs segment the network into separate broadcast domains. Properly securing VLANs is crucial for preventing VLAN hopping attacks.

```cisco
! Disable automatic trunking negotiation on access ports
Switch(config)# interface range gigabitethernet 0/1 - 8
Switch(config-if-range)# switchport mode access        ! Set as access port
Switch(config-if-range)# switchport nonegotiate        ! Disable DTP
Switch(config-if-range)# exit

! Secure trunk ports
Switch(config)# interface gigabitethernet 0/24
Switch(config-if)# switchport mode trunk               ! Set as trunk port
Switch(config-if)# switchport nonegotiate              ! Disable DTP
Switch(config-if)# switchport trunk native vlan 999     ! Change native VLAN from default
Switch(config-if)# switchport trunk allowed vlan 10,20,30,999  ! Explicitly define allowed VLANs
Switch(config-if)# exit

! Disable unused VLAN 1
Switch(config)# vlan 1
Switch(config-vlan)# name DoNotUse
Switch(config-vlan)# exit
Switch(config)# interface vlan 1
Switch(config-if)# shutdown
Switch(config-if)# exit

! Disable unused VLANs
Switch(config)# no vlan 2-999
! Except for those in use (10, 20, 30, 999 in this example)
Switch(config)# vlan 10
Switch(config)# vlan 20
Switch(config)# vlan 30
Switch(config)# vlan 999
```

## Spanning Tree Security

Spanning Tree Protocol (STP) prevents loops in switched networks but can be vulnerable to attacks.

```cisco
! Enable Rapid PVST+ (improved version of STP)
Switch(config)# spanning-tree mode rapid-pvst

! Configure root bridge priority for specific VLANs
Switch(config)# spanning-tree vlan 10,20,30 priority 4096

! Enable BPDU Guard globally for PortFast-enabled ports
Switch(config)# spanning-tree portfast bpduguard default

! Enable Root Guard on ports that should not become root ports
Switch(config)# interface gigabitethernet 0/8
Switch(config-if)# spanning-tree guard root
Switch(config-if)# exit

! Enable Loop Guard on all ports
Switch(config)# spanning-tree loopguard default
```

## DHCP Snooping

DHCP snooping prevents rogue DHCP servers from distributing IP addresses.

```cisco
! Enable DHCP snooping globally
Switch(config)# ip dhcp snooping
Switch(config)# ip dhcp snooping vlan 10,20,30

! Trust the port connected to the legitimate DHCP server
Switch(config)# interface gigabitethernet 0/2
Switch(config-if)# ip dhcp snooping trust
Switch(config-if)# exit

! Rate limit DHCP packets on untrusted ports
Switch(config)# interface range gigabitethernet 0/1, gigabitethernet 0/3-8
Switch(config-if-range)# ip dhcp snooping limit rate 10
Switch(config-if-range)# exit
```

## Dynamic ARP Inspection

Dynamic ARP Inspection (DAI) prevents ARP spoofing attacks.

```cisco
! Enable Dynamic ARP Inspection
Switch(config)# ip arp inspection vlan 10,20,30

! Trust ARP messages from the trusted port
Switch(config)# interface gigabitethernet 0/2
Switch(config-if)# ip arp inspection trust
Switch(config-if)# exit

! Configure DAI rate limit on untrusted ports
Switch(config)# interface range gigabitethernet 0/1, gigabitethernet 0/3-8
Switch(config-if-range)# ip arp inspection limit rate 15
Switch(config-if-range)# exit
```

## IP Source Guard

IP Source Guard prevents IP spoofing by filtering traffic based on DHCP snooping database.

```cisco
! Enable IP Source Guard on untrusted ports
Switch(config)# interface range gigabitethernet 0/1, gigabitethernet 0/3-8
Switch(config-if-range)# ip verify source
Switch(config-if-range)# exit
```

## Logging and Monitoring

### Syslog Configuration

```cisco
! Configure logging
Switch(config)# service timestamps log datetime msec show-timezone
Switch(config)# service timestamps debug datetime msec show-timezone
Switch(config)# logging buffered 16384
Switch(config)# logging console critical
Switch(config)# logging trap informational
Switch(config)# logging source-interface vlan 999
Switch(config)# logging host 192.168.10.20
```

## Implementing Security Policies

### Security Banner

```cisco
! Configure a legal warning banner
Switch(config)# banner login #
UNAUTHORIZED ACCESS TO THIS DEVICE IS PROHIBITED
You must have explicit, authorized permission to access this device.
Unauthorized attempts and actions to access or use this system may result in civil and/or criminal penalties.
All activities performed on this device are logged and monitored.
#
```

### Interface Hardening

```cisco
! Disable CDP and LLDP on external interfaces
Switch(config)# interface range gigabitethernet 0/1-8
Switch(config-if-range)# no cdp enable
Switch(config-if-range)# no lldp transmit
Switch(config-if-range)# no lldp receive
Switch(config-if-range)# exit
```

## Security Verification

After implementing security measures, verify your configurations:

```cisco
! Check for vulnerable services
Switch# show running-config | include service

! Verify interface security settings
Switch# show interfaces status
Switch# show port-security

! Check VLAN configuration
Switch# show vlan brief
Switch# show vlan

! Verify Spanning Tree configuration
Switch# show spanning-tree summary
Switch# show spanning-tree

! Check DHCP snooping status
Switch# show ip dhcp snooping
Switch# show ip dhcp snooping binding

! Verify Dynamic ARP Inspection
Switch# show ip arp inspection
Switch# show ip arp inspection interfaces

! Check IP Source Guard configuration
Switch# show ip verify source

! Check users and privileges
Switch# show users
Switch# show privilege

! Check logging configuration
Switch# show logging
```

## Common CyberPatriot Switch Security Issues

During CyberPatriot competitions, look for these common switch security issues:

1. **Default or weak passwords**
   - Check all password configurations (enable, console, vty, users)
   - Ensure password encryption is enabled

2. **Insecure management access**
   - Telnet enabled instead of SSH
   - No access restrictions on management interfaces
   - Default VLAN 1 used for management

3. **Unnecessary services running**
   - HTTP/HTTPS servers enabled
   - CDP running on external interfaces

4. **VLAN security issues**
   - Default VLAN 1 in use
   - Automatic trunking enabled on access ports
   - Default native VLAN on trunk ports

5. **Spanning Tree vulnerabilities**
   - No BPDU Guard on access ports
   - No Root Guard on appropriate ports

6. **Unused ports left enabled**
   - Ports not in use should be shut down

7. **No port security configured**
   - MAC address flooding vulnerabilities

8. **Missing DHCP snooping and ARP inspection**
   - Vulnerable to DHCP spoofing and ARP poisoning attacks

## CyberPatriot Switch Security Checklist

Use this checklist during competition:

- [ ] Configure strong passwords for all access methods
- [ ] Enable password encryption
- [ ] Configure SSH and disable Telnet
- [ ] Set appropriate timeout values for console and VTY lines
- [ ] Disable unnecessary services
- [ ] Configure appropriate banners
- [ ] Shutdown unused ports
- [ ] Configure port security on access ports
- [ ] Properly configure VLANs and trunking
- [ ] Secure the Spanning Tree configuration
- [ ] Implement DHCP snooping
- [ ] Configure Dynamic ARP Inspection
- [ ] Enable IP Source Guard
- [ ] Enable appropriate logging
- [ ] Document all changes made

## Next Steps

After implementing these switch security measures, proceed to:

1. [Router Security Guide](./Router_Security.md)
2. [VLAN Security Best Practices](../Advanced/VLAN_Security.md)
3. Try the [Secure Switch Configuration Exercise](../../Exercises/Switch_Security_Exercise.md)

## Additional Resources

- [Cisco Guide to Harden Cisco IOS Devices](https://www.cisco.com/c/en/us/support/docs/ip/access-lists/13608-21.html)
- [CIS Cisco IOS Benchmarks](https://www.cisecurity.org/benchmark/cisco/)
- [NSA Cisco Switch Security Configuration Guide](https://apps.nsa.gov/iaarchive/library/ia-guidance/security-configuration/networks/cisco-switch-security-configuration-guide.cfm)
