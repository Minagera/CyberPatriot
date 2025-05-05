# Cisco Router Security Guide

This guide covers intermediate-level security configurations for Cisco routers. These techniques are essential for hardening network devices during the CyberPatriot competition and follow industry best practices for securing network infrastructure.

## Table of Contents

- [Authentication Security](#authentication-security)
- [Management Plane Security](#management-plane-security)
- [Control Plane Security](#control-plane-security)
- [Data Plane Security](#data-plane-security)
- [Logging and Monitoring](#logging-and-monitoring)
- [Implementing Security Policies](#implementing-security-policies)
- [Security Verification](#security-verification)
- [Common CyberPatriot Router Security Issues](#common-cyberpatriot-router-security-issues)

## Authentication Security

### Strong Password Configuration

```cisco
! Set minimum password length
Router(config)# security passwords min-length 10

! Enforce password complexity
Router(config)# aaa new-model
Router(config)# aaa local authentication attempts max-fail 3
Router(config)# aaa authentication password-prompt "Password: "
Router(config)# aaa authentication username-prompt "Username: "

! Encrypt all passwords in the configuration
Router(config)# service password-encryption

! Set a strong enable secret (preferred over enable password)
Router(config)# enable algorithm-type sha256 secret Str0ng3n@bleP@ss!

! Set login delay to prevent brute-force attacks
Router(config)# login delay 3
Router(config)# login block-for 120 attempts 3 within 60
```

### Secure User Authentication

```cisco
! Create local user accounts with encrypted passwords
Router(config)# username admin privilege 15 algorithm-type sha256 secret Adm1nP@ssw0rd!
Router(config)# username operator privilege 5 algorithm-type sha256 secret 0per@torP@ss!

! Configure console line with authentication
Router(config)# line console 0
Router(config-line)# exec-timeout 5 0        ! Timeout after 5 minutes of inactivity
Router(config-line)# login local             ! Use local user database for authentication
Router(config-line)# exit

! Configure VTY lines (Telnet/SSH) with authentication
Router(config)# line vty 0 4
Router(config-line)# exec-timeout 5 0        ! Timeout after 5 minutes of inactivity
Router(config-line)# login local             ! Use local user database for authentication
Router(config-line)# transport input ssh     ! Allow only SSH (no Telnet)
Router(config-line)# exit
```

### SSH Configuration

```cisco
! Configure domain name (required for SSH)
Router(config)# ip domain name cyberpatriot.org

! Generate RSA key pair (2048 bits recommended for security)
Router(config)# crypto key generate rsa modulus 2048

! Configure SSH version 2 (more secure than version 1)
Router(config)# ip ssh version 2

! Set SSH timeout and authentication retries
Router(config)# ip ssh time-out 60
Router(config)# ip ssh authentication-retries 3

! Configure SSH for local login with timeout
Router(config)# line vty 0 4
Router(config-line)# transport input ssh
Router(config-line)# login local
Router(config-line)# exec-timeout 5 0
```

## Management Plane Security

The management plane handles administrative traffic to the router itself.

### Secure Management Access

```cisco
! Create a management access control list
Router(config)# ip access-list standard MGMT-ACCESS
Router(config-std-nacl)# permit 192.168.10.0 0.0.0.255  ! Allow management from trusted subnet
Router(config-std-nacl)# deny any log               ! Deny and log all other access attempts
Router(config-std-nacl)# exit

! Apply the ACL to restrict management access
Router(config)# line vty 0 4
Router(config-line)# access-class MGMT-ACCESS in
Router(config-line)# exit
```

### Disable Unnecessary Services

```cisco
! Disable unnecessary services that could be exploited
Router(config)# no service pad                   ! Disable PAD service
Router(config)# no ip bootp server               ! Disable BOOTP server
Router(config)# no ip http server                ! Disable HTTP server
Router(config)# no ip http secure-server         ! Disable HTTPS server if not used
Router(config)# no service tcp-small-servers     ! Disable small TCP servers
Router(config)# no service udp-small-servers     ! Disable small UDP servers
Router(config)# no ip finger                     ! Disable finger service
Router(config)# no ip source-route               ! Disable IP source routing
Router(config)# no ip gratuitous-arps            ! Disable gratuitous ARPs
```

### SNMP Security (if SNMP is required)

```cisco
! Configure SNMPv3 (more secure than v1/v2)
Router(config)# ip access-list standard SNMP-ACCESS
Router(config-std-nacl)# permit 192.168.10.5     ! SNMP management station
Router(config-std-nacl)# exit

Router(config)# snmp-server view RESTRICTED iso included
Router(config)# snmp-server group ADMIN v3 priv read RESTRICTED write RESTRICTED
Router(config)# snmp-server user SNMPAdmin ADMIN v3 auth sha Auth@Password priv aes 128 Priv@Password
Router(config)# snmp-server host 192.168.10.5 version 3 priv SNMPAdmin
Router(config)# snmp-server enable traps
Router(config)# snmp-server community public view RESTRICTED ro SNMP-ACCESS
```

### NTP Authentication (if NTP is required)

```cisco
! Configure authenticated NTP (Network Time Protocol)
Router(config)# ntp authenticate
Router(config)# ntp authentication-key 1 md5 NTPAuthK3y!
Router(config)# ntp trusted-key 1
Router(config)# ntp server 192.168.10.10 key 1
```

## Control Plane Security

The control plane manages routing and signaling traffic.

### Control Plane Protection

```cisco
! Enable Control Plane Policing (CoPP)
Router(config)# control-plane
Router(config-cp)# service-policy input CONTROL-PLANE-POLICY
Router(config-cp)# exit
```

### Routing Protocol Authentication

```cisco
! Configure OSPF authentication (MD5)
Router(config)# router ospf 1
Router(config-router)# area 0 authentication message-digest
Router(config-router)# exit

Router(config)# interface GigabitEthernet0/0
Router(config-if)# ip ospf message-digest-key 1 md5 0SPFAuthK3y!
Router(config-if)# ip ospf authentication message-digest
Router(config-if)# exit
```

### Disable Unused Routing Protocols

```cisco
! Verify and disable any unused routing protocols
Router# show ip protocols
Router(config)# no router rip       ! Disable RIP if not used
Router(config)# no router eigrp 100 ! Disable EIGRP if not used
```

## Data Plane Security

The data plane handles forwarding user traffic through the router.

### Access Control Lists (ACLs)

```cisco
! Create an extended ACL to filter traffic
Router(config)# ip access-list extended INBOUND-FILTER
Router(config-ext-nacl)# remark Allow established TCP connections
Router(config-ext-nacl)# permit tcp any any established
Router(config-ext-nacl)# remark Allow ICMP echo replies and unreachables
Router(config-ext-nacl)# permit icmp any any echo-reply
Router(config-ext-nacl)# permit icmp any any unreachable
Router(config-ext-nacl)# remark Deny any other ICMP
Router(config-ext-nacl)# deny icmp any any log
Router(config-ext-nacl)# remark Allow HTTP/HTTPS traffic to web server
Router(config-ext-nacl)# permit tcp any host 192.168.20.25 eq 80
Router(config-ext-nacl)# permit tcp any host 192.168.20.25 eq 443
Router(config-ext-nacl)# remark Deny all other traffic and log it
Router(config-ext-nacl)# deny ip any any log
Router(config-ext-nacl)# exit

! Apply the ACL to an interface
Router(config)# interface GigabitEthernet0/1
Router(config-if)# ip access-group INBOUND-FILTER in
Router(config-if)# exit
```

### Anti-Spoofing Protections

```cisco
! Configure anti-spoofing by filtering known bogus IP addresses
Router(config)# ip access-list extended ANTI-SPOOF
Router(config-ext-nacl)# deny ip 127.0.0.0 0.255.255.255 any log
Router(config-ext-nacl)# deny ip 10.0.0.0 0.255.255.255 any log
Router(config-ext-nacl)# deny ip 172.16.0.0 0.15.255.255 any log
Router(config-ext-nacl)# deny ip 192.168.0.0 0.0.255.255 any log
Router(config-ext-nacl)# deny ip 224.0.0.0 31.255.255.255 any log
Router(config-ext-nacl)# permit ip any any
Router(config-ext-nacl)# exit

! Apply the anti-spoofing ACL on the outside interface
Router(config)# interface GigabitEthernet0/0
Router(config-if)# ip access-group ANTI-SPOOF in
Router(config-if)# exit
```

### Unicast Reverse Path Forwarding (uRPF)

```cisco
! Enable uRPF to prevent IP spoofing
Router(config)# interface GigabitEthernet0/0
Router(config-if)# ip verify unicast source reachable-via rx  ! Strict mode
Router(config-if)# exit
```

## Logging and Monitoring

### Syslog Configuration

```cisco
! Configure logging
Router(config)# service timestamps log datetime msec show-timezone
Router(config)# service timestamps debug datetime msec show-timezone
Router(config)# logging buffered 16384
Router(config)# logging console critical
Router(config)# logging trap informational
Router(config)# logging source-interface Loopback0
Router(config)# logging host 192.168.10.20
```

### NetFlow (if supported)

```cisco
! Configure NetFlow to monitor traffic patterns
Router(config)# ip flow-export source GigabitEthernet0/0
Router(config)# ip flow-export version 9
Router(config)# ip flow-export destination 192.168.10.20 2055
Router(config)# interface GigabitEthernet0/0
Router(config-if)# ip flow ingress
Router(config-if)# ip flow egress
Router(config-if)# exit
```

## Implementing Security Policies

### Security Banner

```cisco
! Configure a legal warning banner
Router(config)# banner login #
UNAUTHORIZED ACCESS TO THIS DEVICE IS PROHIBITED
You must have explicit, authorized permission to access this device.
Unauthorized attempts and actions to access or use this system may result in civil and/or criminal penalties.
All activities performed on this device are logged and monitored.
#
```

### Interface Hardening

```cisco
! Disable CDP and LLDP on external interfaces
Router(config)# interface GigabitEthernet0/0
Router(config-if)# no cdp enable
Router(config-if)# no lldp transmit
Router(config-if)# no lldp receive
Router(config-if)# exit
```

## Security Verification

After implementing security measures, verify your configurations:

```cisco
! Check for vulnerable services
Router# show running-config | include service

! Verify interface security settings
Router# show ip interface

! Check ACLs
Router# show access-lists
Router# show ip access-lists

! Verify SSH configuration
Router# show ip ssh

! Check users and privileges
Router# show users
Router# show privilege

! Check logging configuration
Router# show logging
```

## Common CyberPatriot Router Security Issues

During CyberPatriot competitions, look for these common router security issues:

1. **Default or weak passwords**
   - Check all password configurations (enable, console, vty, users)
   - Ensure password encryption is enabled

2. **Insecure management access**
   - Telnet enabled instead of SSH
   - No access restrictions on management interfaces

3. **Unnecessary services running**
   - HTTP/HTTPS servers enabled
   - CDP running on external interfaces
   - Unused routing protocols active

4. **Missing ACLs**
   - No filtering on external interfaces
   - No anti-spoofing protections

5. **Insecure routing protocols**
   - No authentication configured for routing protocols
   - Routing updates accepted from untrusted sources

6. **Insufficient logging**
   - Logging disabled or minimally configured
   - No timestamps on log messages

## CyberPatriot Router Security Checklist

Use this checklist during competition:

- [ ] Configure strong passwords for all access methods
- [ ] Enable password encryption
- [ ] Configure SSH and disable Telnet
- [ ] Set appropriate timeout values for console and VTY lines
- [ ] Disable unnecessary services
- [ ] Configure appropriate banners
- [ ] Implement ACLs to restrict traffic
- [ ] Configure anti-spoofing protections
- [ ] Secure routing protocols with authentication
- [ ] Enable appropriate logging
- [ ] Document all changes made

## Next Steps

After implementing these router security measures, proceed to:

1. [Switch Security Guide](./Switch_Security.md)
2. [Advanced Access Control Lists](../Advanced/Advanced_ACLs.md)
3. Try the [Secure Router Configuration Exercise](../../Exercises/Router_Security_Exercise.md)

## Additional Resources

- [Cisco Guide to Harden Cisco IOS Devices](https://www.cisco.com/c/en/us/support/docs/ip/access-lists/13608-21.html)
- [CIS Cisco IOS Benchmarks](https://www.cisecurity.org/benchmark/cisco/)
- [NSA Cisco Router Hardening Guidelines](https://apps.nsa.gov/iaarchive/library/ia-guidance/security-configuration/networks/cisco-switch-security-configuration-guide.cfm)

# Cisco Device Hardening Guide for CyberPatriot

Follow these steps to secure Cisco routers and switches:

## 1. Set Hostname and Banner
```plaintext
hostname CYBERPATRIOT-RTR
banner motd ^Authorized access only. Violators will be prosecuted.^
```

## 2. Secure Enable and Console Access
```plaintext
enable secret [STRONG_PASSWORD]
line console 0
 password [STRONG_PASSWORD]
 login
 exec-timeout 5 0
```

## 3. Encrypt Passwords
```plaintext
service password-encryption
```

## 4. Configure SSH and Disable Telnet
```plaintext
ip domain-name cyberpatriot.local
crypto key generate rsa modulus 2048
username admin secret [STRONG_PASSWORD]
line vty 0 4
 transport input ssh
 login local
 exec-timeout 5 0
```

## 5. Disable Unused Services and Interfaces
```plaintext
no ip http server
no cdp run
interface range [UNUSED_PORTS]
 shutdown
```

## 6. Apply ACLs for Management Access
```plaintext
access-list 10 permit [TRUSTED_IP]
line vty 0 4
 access-class 10 in
```

## 7. Save Configuration
```plaintext
write memory
```

*Adapt these steps to the specific scenario and always check the README for required services!*

# Cisco Guides Overview

This directory contains step-by-step guides for configuring and securing Cisco routers and switches, with a focus on CyberPatriot competition requirements.

## Subdirectories

- **Basic/**:  
  - Fundamentals of Cisco IOS, CLI navigation, basic configuration, and device security.
- **Intermediate/**:  
  - Switch security, VLANs, ACLs, management plane security, and advanced hardening.
- **Advanced/**:  
  - Advanced routing, network segmentation, advanced ACLs, and forensics.

## How to Use

- Start with the Basic guides if you are new to Cisco IOS.
- Progress to Intermediate and Advanced as you build confidence.
- Use these guides as references during Packet Tracer exercises and competitions.
- Each guide includes practical configuration examples and verification commands.

*All guides are unique and tailored for CyberPatriot training. If you have suggestions for new topics, please contribute!*

# Cisco Guides Directory

This directory contains step-by-step guides for configuring and securing Cisco devices in CyberPatriot competitions.

## Available Guides

- [Basic Guide](./Basic/README.md): Initial device setup, passwords, and basic security.
- [Intermediate Guide](./Intermediate/README.md): VLANs, SSH, ACLs, and troubleshooting.
- [Advanced Guide](./Advanced/README.md): Advanced security, monitoring, and forensics.

*All guides are unique and tailored for CyberPatriot cadet training.*

# Cisco IOS Security Guides

This directory contains guides explaining Cisco IOS configuration and security concepts relevant to CyberPatriot.

## Guide Index

-   [**Basic_IOS_Commands.md**](Basic_IOS_Commands.md)
    *   Covers: Accessing CLI modes (User EXEC, Privileged EXEC, Global Config), basic navigation (`?`, tab completion), hostname, saving configuration (`copy run start`).
-   [**Device_Hardening_Guide.md**](Device_Hardening_Guide.md)
    *   Covers: `enable secret`, console/VTY line security (`password`, `login`, `exec-timeout`), `service password-encryption`, MOTD banner, disabling HTTP server, CDP.
-   [**SSH_Configuration_Guide.md**](SSH_Configuration_Guide.md)
    *   Covers: Steps to enable SSH (`ip domain-name`, `crypto key generate rsa`, `username`, `line vty`, `login local`, `transport input ssh`), disabling Telnet.
-   [**ACL_Guide.md**](ACL_Guide.md)
    *   Covers: Standard vs. Extended ACLs, numbered vs. named ACLs, syntax (`access-list`, `ip access-list`), wildcard masks, application (`ip access-group`), verification (`show access-lists`).
-   [**VLAN_Security_Guide.md**](VLAN_Security_Guide.md)
    *   Covers: VLAN creation, assigning ports to VLANs (`switchport access vlan`), trunking (`switchport mode trunk`), native VLAN, basic switchport security (`switchport port-security`).

## How to Use

-   Read these guides to understand the concepts and commands needed for the exercises and competition.
-   Use them as a reference when configuring devices in Packet Tracer or real equipment.

## Contribution

Create new guides covering topics like basic routing protocols (RIP, OSPF, EIGRP) security, DHCP configuration/snooping, NTP security, or advanced switch security features. Ensure guides are clear, accurate, and provide practical examples.

---

*All guides are unique and tailored for CyberPatriot training.*
