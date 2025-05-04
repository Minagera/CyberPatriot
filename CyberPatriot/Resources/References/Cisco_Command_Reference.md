# Cisco IOS Command Reference

## Device Access

- Enter privileged EXEC mode:  
  `enable`
- Enter global configuration mode:  
  `configure terminal`
- Save configuration:  
  `copy running-config startup-config`
- Show running configuration:  
  `show running-config`
- Show interface status:  
  `show interfaces status`
- Show VLANs:  
  `show vlan brief`

## User and Password Management

- Set enable secret:  
  `enable secret StrongPassword`
- Set console password:  
  `line console 0`  
  `password ConsolePass`  
  `login`
- Set VTY password:  
  `line vty 0 4`  
  `password VtyPass`  
  `login`
- Create local user:  
  `username admin secret AdminPass`

## SSH Configuration

- Set hostname:  
  `hostname RouterName`
- Set domain name:  
  `ip domain-name example.com`
- Generate RSA keys:  
  `crypto key generate rsa modulus 1024`
- Enable SSH:  
  `ip ssh version 2`
- Restrict VTY to SSH only:  
  `line vty 0 4`  
  `transport input ssh`

## Service Management

- Disable HTTP server:  
  `no ip http server`
- Disable CDP:  
  `no cdp run`
- Disable small servers:  
  `no service tcp-small-servers`  
  `no service udp-small-servers`

## Interface Management

- Show IP interfaces:  
  `show ip interface brief`
- Configure interface:  
  `interface GigabitEthernet0/0`  
  `ip address 192.168.1.1 255.255.255.0`  
  `no shutdown`
- Shutdown unused interface:  
  `interface GigabitEthernet0/1`  
  `shutdown`

## Security

- Configure banner:  
  `banner motd # Unauthorized access prohibited #`
- Enable password encryption:  
  `service password-encryption`
- Configure ACL:  
  `ip access-list standard MGMT-ACCESS`  
  `permit 192.168.1.0 0.0.0.255`  
  `deny any log`

*Add more commands as you learn them!*
