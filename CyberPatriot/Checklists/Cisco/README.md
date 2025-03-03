# Cisco Security Checklist

This comprehensive checklist covers essential security configurations for Cisco routers and switches. Use it during CyberPatriot competitions to ensure you address all critical security aspects of network devices.

## Router Security Checklist

### Authentication and Password Security
- [ ] Set hostname (`hostname <name>`)
- [ ] Configure strong enable secret password (`enable algorithm-type sha256 secret <password>`)
- [ ] Enable password encryption (`service password-encryption`)
- [ ] Set minimum password length (`security passwords min-length 10`)
- [ ] Configure strong local user accounts (`username <name> privilege 15 algorithm-type sha256 secret <password>`)
- [ ] Set login delay (`login delay 3`)
- [ ] Configure login timeout (`login block-for 120 attempts 3 within 60`)

### Console Access Security
- [ ] Set console password (`line console 0` → `password <password>` → `login local`)
- [ ] Configure console timeout (`exec-timeout 5 0`)
- [ ] Enable console login authentication (`login local`)

### VTY (Telnet/SSH) Access Security
- [ ] Set VTY password (`line vty 0 4` → `password <password>`)
- [ ] Configure VTY timeout (`exec-timeout 5 0`) 
- [ ] Restrict VTY access to SSH only (`transport input ssh`)
- [ ] Enable VTY login authentication (`login local`)
- [ ] Apply access control list to VTY lines (`access-class <ACL-name> in`)

### SSH Configuration
- [ ] Set domain name (`ip domain name <domain>`)
- [ ] Generate RSA keys (`crypto key generate rsa modulus 2048`)
- [ ] Enable SSH version 2 (`ip ssh version 2`)
- [ ] Set SSH timeout (`ip ssh time-out 60`)
- [ ] Set SSH authentication retries (`ip ssh authentication-retries 3`)

### Disable Unnecessary Services
- [ ] Disable HTTP server (`no ip http server`)
- [ ] Disable HTTPS server if not needed (`no ip http secure-server`)
- [ ] Disable CDP if not needed (`no cdp run`)
- [ ] Disable PAD service (`no service pad`)
- [ ] Disable BOOTP server (`no ip bootp server`)
- [ ] Disable small TCP servers (`no service tcp-small-servers`)
- [ ] Disable small UDP servers (`no service udp-small-servers`)
- [ ] Disable finger service (`no ip finger`)
- [ ] Disable IP source routing (`no ip source-route`)
- [ ] Disable gratuitous ARPs (`no ip gratuitous-arps`)
- [ ] Disable proxy ARP on interfaces (`no ip proxy-arp`)

### Access Control Lists (ACLs)
- [ ] Create management access ACL (`ip access-list standard MGMT-ACCESS`)
- [ ] Create inbound traffic filtering ACL (`ip access-list extended INBOUND-FILTER`)
- [ ] Create anti-spoofing ACL (`ip access-list extended ANTI-SPOOF`)
- [ ] Apply ACLs to appropriate interfaces (`ip access-group <name> in/out`)

### Routing Protocol Security
- [ ] Configure routing protocol authentication (OSPF, EIGRP, etc.)
- [ ] Disable unused routing protocols
- [ ] Filter routing updates

### Interface Security
- [ ] Add descriptions to interfaces (`description <text>`)
- [ ] Disable unused interfaces (`shutdown`)
- [ ] Disable CDP on external interfaces (`no cdp enable`)
- [ ] Disable LLDP on external interfaces (`no lldp transmit`, `no lldp receive`)
- [ ] Enable unicast reverse path forwarding where appropriate (`ip verify unicast source reachable-via rx`)

### Logging and Monitoring
- [ ] Configure log timestamps (`service timestamps log datetime msec show-timezone`)
- [ ] Configure debug timestamps (`service timestamps debug datetime msec show-timezone`)
- [ ] Set appropriate logging levels (`logging console critical`, `logging buffered 16384`)
- [ ] Configure logging host if available (`logging host <ip-address>`)
- [ ] Enable NetFlow if available (`ip flow-export`)

### Miscellaneous
- [ ] Configure a legal warning banner (`banner login #...#`)
- [ ] Save configuration (`copy running-config startup-config`)
- [ ] Document all changes made

## Switch Security Checklist

### Authentication and Password Security
- [ ] Set hostname (`hostname <name>`)
- [ ] Configure strong enable secret password (`enable algorithm-type sha256 secret <password>`)
- [ ] Enable password encryption (`service password-encryption`)
- [ ] Set minimum password length (`security passwords min-length 10`)
- [ ] Configure strong local user accounts (`username <name> privilege 15 algorithm-type sha256 secret <password>`)
- [ ] Set login delay (`login delay 3`)
- [ ] Configure login timeout (`login block-for 120 attempts 3 within 60`)

### Console Access Security
- [ ] Set console password (`line console 0` → `password <password>` → `login local`)
- [ ] Configure console timeout (`exec-timeout 5 0`)
- [ ] Enable console login authentication (`login local`)

### VTY (Telnet/SSH) Access Security
- [ ] Set VTY password (`line vty 0 15` → `password <password>`)
- [ ] Configure VTY timeout (`exec-timeout 5 0`) 
- [ ] Restrict VTY access to SSH only (`transport input ssh`)
- [ ] Enable VTY login authentication (`login local`)
- [ ] Apply access control list to VTY lines (`access-class <ACL-name> in`)

### SSH Configuration
- [ ] Set domain name (`ip domain name <domain>`)
- [ ] Generate RSA keys (`crypto key generate rsa modulus 2048`)
- [ ] Enable SSH version 2 (`ip ssh version 2`)
- [ ] Set SSH timeout (`ip ssh time-out 60`)
- [ ] Set SSH authentication retries (`ip ssh authentication-retries 3`)

### Management Interface Security
- [ ] Create a management VLAN (`vlan <number>` → `name Management`)
- [ ] Configure the management interface (`interface vlan <number>`) 
- [ ] Apply appropriate security to management VLAN ports

### Disable Unnecessary Services
- [ ] Disable HTTP server (`no ip http server`)
- [ ] Disable HTTPS server if not needed (`no ip http secure-server`)
- [ ] Disable CDP if not needed (`no cdp run`)
- [ ] Disable small TCP servers (`no service tcp-small-servers`)
- [ ] Disable small UDP servers (`no service udp-small-servers`)
- [ ] Disable IP source routing (`no ip source-route`)
- [ ] Disable gratuitous ARPs (`no ip gratuitous-arps`)

### Port Security
- [ ] Enable port security on access ports (`switchport port-security`)
- [ ] Set maximum MAC addresses (`switchport port-security maximum <number>`)
- [ ] Configure violation mode (`switchport port-security violation {shutdown|restrict|protect}`)
- [ ] Enable sticky MAC learning where appropriate (`switchport port-security mac-address sticky`)
- [ ] Shut down unused ports (`shutdown`)

### VLAN Security
- [ ] Create appropriate VLANs (`vlan <number>`)
- [ ] Assign ports to appropriate VLANs (`switchport access vlan <number>`)
- [ ] Configure trunk ports securely:
  - [ ] Set trunk mode explicitly (`switchport mode trunk`)
  - [ ] Specify allowed VLANs (`switchport trunk allowed vlan <list>`)
  - [ ] Change native VLAN from default VLAN 1 (`switchport trunk native vlan <number>`)
- [ ] Disable auto-trunking negotiation (`switchport nonegotiate`)
- [ ] Disable unused VLAN 1

### Spanning Tree Protocol (STP) Security
- [ ] Enable BPDU Guard on access ports (`spanning-tree bpduguard enable`)
- [ ] Enable PortFast on access ports (`spanning-tree portfast`)
- [ ] Configure Root Guard on appropriate ports (`spanning-tree guard root`)
- [ ] Set bridge priority if this should be the root bridge (`spanning-tree vlan <vlan-id> priority <priority>`)

### DHCP Snooping (if available)
- [ ] Enable DHCP snooping globally (`ip dhcp snooping`)
- [ ] Enable DHCP snooping on specific VLANs (`ip dhcp snooping vlan <vlan-list>`)
- [ ] Configure trusted ports (`ip dhcp snooping trust`)
- [ ] Set rate limits on untrusted ports (`ip dhcp snooping limit rate <rate>`)

### Dynamic ARP Inspection (if available)
- [ ] Enable DAI on VLANs (`ip arp inspection vlan <vlan-list>`)
- [ ] Configure trusted interfaces (`ip arp inspection trust`)
- [ ] Set rate limits (`ip arp inspection limit rate <rate>`)

### IP Source Guard (if available)
- [ ] Enable IP Source Guard on untrusted ports (`ip verify source`)

### Logging and Monitoring
- [ ] Configure log timestamps (`service timestamps log datetime msec show-timezone`)
- [ ] Configure debug timestamps (`service timestamps debug datetime msec show-timezone`)
- [ ] Set appropriate logging levels (`logging console critical`, `logging buffered 16384`)
- [ ] Configure logging host if available (`logging host <ip-address>`)

### Miscellaneous
- [ ] Configure a legal warning banner (`banner login #...#`)
- [ ] Save configuration (`copy running-config startup-config`)
- [ ] Document all changes made

## Verification Commands

### Router Verification
- `show running-config` - View current configuration
- `show version` - Check IOS version and system information
- `show ip interface brief` - Check interface status
- `show access-lists` - View configured ACLs
- `show ip protocols` - View enabled routing protocols
- `show users` - See who is logged in
- `show ip ssh` - Verify SSH configuration
- `show logging` - Check logging configuration

### Switch Verification
- `show running-config` - View current configuration
- `show version` - Check IOS version and system information
- `show interfaces status` - Check port status
- `show vlan brief` - View VLAN configuration
- `show port-security interface <int>` - Check port security status
- `show spanning-tree summary` - Verify STP configuration
- `show ip dhcp snooping` - Check DHCP snooping configuration (if available)
- `show ip arp inspection` - Check DAI status (if available)

## Common CyberPatriot Cisco Findings

These are commonly tested vulnerabilities in CyberPatriot competitions:

1. Default or weak passwords
2. Telnet enabled instead of SSH
3. Unencrypted passwords in configuration
4. HTTP/HTTPS servers enabled
5. Unused interfaces not shut down
6. No access lists restricting management access
7. Default VLANs and trunking settings
8. No port security configured
9. No login banners configured
10. CDP enabled on external interfaces
11. Insecure routing protocol configurations
12. Insufficient logging
