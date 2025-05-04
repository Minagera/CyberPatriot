# Solution: Advanced Branch Office Segmentation & Threat Response

## Key Steps
- Hardened device access: set enable secret, disabled Telnet, enabled SSH, secured SNMP
- VLANs configured and trunking verified; native VLAN changed from default
- Management interfaces restricted to Staff VLAN via ACLs
- Port security enabled (sticky MAC, violation shutdown)
- DHCP snooping and DAI enabled on Staff and Guest VLANs
- Spanning Tree secured (BPDU Guard on access, Root Guard on uplinks, Loop Guard globally)
- ACLs applied to block Guest VLAN from internal resources
- Cleared unauthorized MACs and ARP entries
- Logging and banners configured

## Forensics Answers
- **VLAN hopping evidence:** Trunk ports allowed all VLANs, native VLAN was default, access ports misconfigured.
- **ARP spoofing evidence:** Multiple MACs on single port, ARP table entries with unexpected IP/MAC pairs.
- **Vulnerable ports:** Guest VLAN access ports, trunk ports without allowed VLAN restriction.
- **Verification:** Used `show vlan`, `show mac address-table`, `show ip arp`, and inter-VLAN ping tests.

## Verification Steps
- Confirmed isolation by pinging between VLANs (should fail except for allowed traffic)
- Checked port security status and violation counters
- Verified DHCP snooping and DAI bindings
- Reviewed logs for unauthorized access attempts

## Common Mistakes
- Forgetting to restrict native VLAN or trunk allowed VLANs
- Not enabling port security on all access ports
- Leaving Telnet enabled or not fully disabling HTTP/HTTPS

*This solution is for mentor reference and should be adapted to your specific scenario variant.*
