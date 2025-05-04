# Cisco IOS Reference Sheet

## Basic Commands

- Enter enable mode: `enable`
- Enter config mode: `configure terminal`
- Save config: `write memory` or `copy running-config startup-config`
- Show running config: `show running-config`
- Show interfaces: `show interfaces status`
- Show VLANs: `show vlan brief`
- Show IP routes: `show ip route`
- Show users: `show users`

## Security Commands

- Set enable secret: `enable secret <password>`
- Configure SSH:  
  ```
  hostname <name>
  ip domain-name <domain>
  crypto key generate rsa modulus 1024
  ip ssh version 2
  line vty 0 4
  transport input ssh
  login local
  ```
- Set console password:  
  ```
  line console 0
  password <password>
  login
  ```
- Set VTY password:  
  ```
  line vty 0 4
  password <password>
  login
  ```
- Disable HTTP server: `no ip http server`
- Disable unused interfaces:  
  ```
  interface range <range>
  shutdown
  ```

## Troubleshooting

- Ping: `ping <ip>`
- Traceroute: `traceroute <ip>`
- Show logs: `show logging`
- Show access-lists: `show access-lists`

*This sheet is unique and designed for CyberPatriot competition use.*
