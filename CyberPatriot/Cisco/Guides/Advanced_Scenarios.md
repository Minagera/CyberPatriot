# Advanced Cisco Scenarios for CyberPatriot

## VLAN and Trunking

- Create VLANs and assign ports:
  ```
  vlan 10
  name Workstations
  exit
  interface fa0/2
  switchport mode access
  switchport access vlan 10
  exit
  ```

- Configure trunk:
  ```
  interface fa0/24
  switchport mode trunk
  exit
  ```

## Access Control Lists (ACLs)

- Block Telnet from outside:
  ```
  access-list 100 deny tcp any any eq 23
  access-list 100 permit ip any any
  interface fa0/0
  ip access-group 100 in
  exit
  ```

## Troubleshooting Tips

- Show running config: `show running-config`
- Check interface status: `show ip interface brief`
- Verify VLANs: `show vlan brief`
- Test ACLs: `show access-lists`

*These scenarios are unique for CyberPatriot. Adapt as needed for your competition image.*
