# Cisco Security Checklist for CyberPatriot

## CRITICAL FIRST STEP: Read the Competition README File!
Before making any changes, thoroughly read the README file provided with the Cisco challenge. It contains:
- Required network services that must remain operational
- Existing network configurations that must be preserved
- Prohibited actions that could cause penalties
- Answers to forensics questions (worth points!)
- Competition-specific requirements that override general security practices

This checklist focuses on essential Cisco router and switch security configurations commonly tested in CyberPatriot competitions. Use this checklist to quickly identify and fix security issues, but always follow README instructions when they conflict with general security practices.

## Router Security Checklist

### Basic Security Setup
- [ ] Set hostname
  ```cisco
  Router(config)# hostname <secure-name>
  ```
- [ ] Set login banner with appropriate text
  ```cisco
  Router(config)# banner login #
  AUTHORIZED ACCESS ONLY
  Unauthorized access is prohibited.
  #
  ```

### Password Security
- [ ] Set strong enable secret password
  ```cisco
  Router(config)# enable secret <strong-password>
  ```
- [ ] Remove any existing enable password (use secret instead)
  ```cisco
  Router(config)# no enable password
  ```
- [ ] Enable password encryption
  ```cisco
  Router(config)# service password-encryption
  ```
- [ ] Configure console line security
  ```cisco
  Router(config)# line console 0
  Router(config-line)# password <console-password>
  Router(config-line)# login
  Router(config-line)# exec-timeout 5 0
  Router(config-line)# exit
  ```

### Remote Access Security
- [ ] Configure VTY lines with authentication
  ```cisco
  Router(config)# line vty 0 4
  Router(config-line)# password <vty-password>
  Router(config-line)# login
  Router(config-line)# exec-timeout 5 0
  Router(config-line)# exit
  ```
- [ ] Configure SSH (more secure than Telnet)
  ```cisco
  Router(config)# ip domain name example.com
  Router(config)# crypto key generate rsa modulus 1024
  Router(config)# ip ssh version 2
  Router(config)# line vty 0 4
  Router(config-line)# transport input ssh
  Router(config-line)# login local
  Router(config-line)# exit
  Router(config)# username admin secret <strong-password>
  ```

### Disable Unnecessary Services
- [ ] Disable HTTP server
  ```cisco
  Router(config)# no ip http server
  Router(config)# no ip http secure-server
  ```
- [ ] Disable CDP if not needed
  ```cisco
  Router(config)# no cdp run
  ```
- [ ] Disable unused small servers
  ```cisco
  Router(config)# no service tcp-small-servers
  Router(config)# no service udp-small-servers
  ```
- [ ] Disable finger service
  ```cisco
  Router(config)# no ip finger
  ```
- [ ] Disable IP source routing
  ```cisco
  Router(config)# no ip source-route
  ```

### Interface Security
- [ ] Add descriptions to interfaces
  ```cisco
  Router(config)# interface GigabitEthernet0/0
  Router(config-if)# description WAN Connection
  Router(config-if)# exit
  ```
- [ ] Disable unused interfaces
  ```cisco
  Router(config)# interface GigabitEthernet0/1
  Router(config-if)# shutdown
  Router(config-if)# exit
  ```
- [ ] Disable CDP on external interfaces
  ```cisco
  Router(config)# interface GigabitEthernet0/0
  Router(config-if)# no cdp enable
  Router(config-if)# exit
  ```

### Access Control Lists (Basic)
- [ ] Create ACL to restrict management access
  ```cisco
  Router(config)# ip access-list standard MGMT-ACCESS
  Router(config-std-nacl)# permit 192.168.1.0 0.0.0.255
  Router(config-std-nacl)# deny any log
  Router(config-std-nacl)# exit
  Router(config)# line vty 0 4
  Router(config-line)# access-class MGMT-ACCESS in
  Router(config-line)# exit
  ```

### Save Configuration
- [ ] Save your changes
  ```cisco
  Router# write memory
  ```
  or
  ```cisco
  Router# copy running-config startup-config
  ```

## Switch Security Checklist

### Basic Security Setup
- [ ] Set hostname
  ```cisco
  Switch(config)# hostname <secure-name>
  ```
- [ ] Set login banner with appropriate text
  ```cisco
  Switch(config)# banner login #
  AUTHORIZED ACCESS ONLY
  Unauthorized access is prohibited.
  #
  ```

### Password Security
- [ ] Set strong enable secret password
  ```cisco
  Switch(config)# enable secret <strong-password>
  ```
- [ ] Remove any existing enable password (use secret instead)
  ```cisco
  Switch(config)# no enable password
  ```
- [ ] Enable password encryption
  ```cisco
  Switch(config)# service password-encryption
  ```
- [ ] Configure console line security
  ```cisco
  Switch(config)# line console 0
  Switch(config-line)# password <console-password>
  Switch(config-line)# login
  Switch(config-line)# exec-timeout 5 0
  Switch(config-line)# exit
  ```

### Remote Access Security
- [ ] Configure VTY lines with authentication
  ```cisco
  Switch(config)# line vty 0 15
  Switch(config-line)# password <vty-password>
  Switch(config-line)# login
  Switch(config-line)# exec-timeout 5 0
  Switch(config-line)# exit
  ```
- [ ] Configure SSH (if supported by switch)
  ```cisco
  Switch(config)# ip domain name example.com
  Switch(config)# crypto key generate rsa modulus 1024
  Switch(config)# ip ssh version 2
  Switch(config)# line vty 0 15
  Switch(config-line)# transport input ssh
  Switch(config-line)# login local
  Switch(config-line)# exit
  Switch(config)# username admin secret <strong-password>
  ```

### VLAN Security
- [ ] Check for and remove unnecessary VLANs
  ```cisco
  Switch# show vlan brief
  ```
- [ ] Configure native VLAN on trunk ports (not VLAN 1)
  ```cisco
  Switch(config)# interface GigabitEthernet0/1
  Switch(config-if)# switchport trunk native vlan 999
  Switch(config-if)# exit
  ```
- [ ] Configure trunk ports explicitly (no auto negotiation)
  ```cisco
  Switch(config)# interface GigabitEthernet0/1
  Switch(config-if)# switchport mode trunk
  Switch(config-if)# switchport nonegotiate
  Switch(config-if)# exit
  ```

### Port Security
- [ ] Enable port security on access ports
  ```cisco
  Switch(config)# interface GigabitEthernet0/2
  Switch(config-if)# switchport mode access
  Switch(config-if)# switchport port-security
  Switch(config-if)# switchport port-security maximum 1
  Switch(config-if)# switchport port-security violation shutdown
  Switch(config-if)# exit
  ```

### Disable Unnecessary Services
- [ ] Disable HTTP server
  ```cisco
  Switch(config)# no ip http server
  Switch(config)# no ip http secure-server
  ```
- [ ] Disable CDP if not needed
  ```cisco
  Switch(config)# no cdp run
  ```

### Interface Security
- [ ] Add descriptions to interfaces
  ```cisco
  Switch(config)# interface GigabitEthernet0/1
  Switch(config-if)# description Uplink to Router
  Switch(config-if)# exit
  ```
- [ ] Disable unused interfaces
  ```cisco
  Switch(config)# interface range GigabitEthernet0/5 - 24
  Switch(config-if-range)# shutdown
  Switch(config-if-range)# exit
  ```

### Spanning Tree Security
- [ ] Enable PortFast on access ports
  ```cisco
  Switch(config)# interface GigabitEthernet0/2
  Switch(config-if)# spanning-tree portfast
  Switch(config-if)# exit
  ```
- [ ] Enable BPDU Guard on access ports
  ```cisco
  Switch(config)# interface GigabitEthernet0/2
  Switch(config-if)# spanning-tree bpduguard enable
  Switch(config-if)# exit
  ```

### Save Configuration
- [ ] Save your changes
  ```cisco
  Switch# write memory
  ```
  or
  ```cisco
  Switch# copy running-config startup-config
  ```

## Verification Commands

### Router Verification
- [ ] Check running configuration
  ```cisco
  Router# show running-config
  ```
- [ ] Check interface status
  ```cisco
  Router# show ip interface brief
  ```
- [ ] Verify SSH configuration
  ```cisco
  Router# show ip ssh
  ```
- [ ] Check access lists
  ```cisco
  Router# show access-lists
  ```
- [ ] Check users with access
  ```cisco
  Router# show users
  ```

### Switch Verification
- [ ] Check running configuration
  ```cisco
  Switch# show running-config
  ```
- [ ] Check VLAN information
  ```cisco
  Switch# show vlan brief
  ```
- [ ] Check interface status
  ```cisco
  Switch# show interfaces status
  ```
- [ ] Check port security
  ```cisco
  Switch# show port-security
  ```
- [ ] Check spanning-tree status
  ```cisco
  Switch# show spanning-tree summary
  ```

## Common CyberPatriot Cisco Findings

These are frequently tested vulnerabilities in CyberPatriot competitions:

1. **Password Issues**
   - Default passwords or no passwords
   - Enable password used instead of enable secret
   - Passwords not encrypted
   - Weak passwords

2. **Access Issues**
   - Telnet enabled instead of SSH
   - No console timeout set
   - No VTY timeout set
   - No access restrictions

3. **Unnecessary Services**
   - HTTP/HTTPS server enabled
   - CDP running when not needed
   - Unused interfaces not shut down

4. **VLAN Issues (Switches)**
   - Default VLAN 1 used for management
   - Auto trunking enabled
   - No port security configured

5. **Configuration Management**
   - No interface descriptions
   - No login banners
   - Configuration not saved
