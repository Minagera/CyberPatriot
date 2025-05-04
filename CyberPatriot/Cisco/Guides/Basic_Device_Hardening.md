# Basic Cisco Device Hardening Guide

This guide provides step-by-step instructions for hardening Cisco routers and switches in CyberPatriot competitions.

## 1. Set Hostname and Banners

```plaintext
configure terminal
hostname CP-Router
banner motd ^Authorized Use Only - CyberPatriot Competition^
banner login ^Unauthorized access prohibited^
exit
```

## 2. Secure Console and VTY Access

```plaintext
line console 0
password SecureCon!2024
login
exec-timeout 5 0
exit

line vty 0 4
password SecureVTY!2024
login
transport input ssh
exec-timeout 5 0
exit
```

## 3. Enable SSH and Disable Telnet

```plaintext
ip domain-name cyberpatriot.local
crypto key generate rsa modulus 2048
ip ssh version 2
username admin privilege 15 secret StrongAdmin!2024
```

## 4. Disable Unused Services

```plaintext
no ip http server
no ip http secure-server
no cdp run
```

## 5. Disable Unused Interfaces

```plaintext
interface range g0/1 - 3
shutdown
exit
```

## 6. Save Configuration

```plaintext
write memory
```

---
