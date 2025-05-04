# Advanced Scenario: Branch Office Segmentation & Threat Response

## Overview
Your company’s branch office network has grown and now includes multiple VLANs, a guest WiFi, and a new VoIP system. A recent audit found several security gaps and evidence of attempted VLAN hopping and ARP spoofing. You must secure the network, document your changes, and answer forensics questions.

## Scenario Details
- Router and two switches, with three VLANs (Staff, Guest, Voice)
- Guest VLAN has internet access but should not access internal resources
- Voice VLAN must be isolated except for VoIP traffic
- Management interfaces are exposed to the wrong VLAN
- Telnet enabled on all devices, SSH not configured
- No port security or DHCP snooping
- Spanning Tree misconfigurations
- Suspicious MAC addresses and ARP entries detected

## Tasks
1. Harden all device access (enable secret, SSH only, disable Telnet, secure SNMP if present)
2. Implement and verify VLAN segmentation and trunking
3. Restrict management access to Staff VLAN only
4. Configure port security on all access ports
5. Enable DHCP snooping and Dynamic ARP Inspection on appropriate VLANs
6. Secure Spanning Tree (BPDU Guard, Root Guard, Loop Guard)
7. Apply ACLs to restrict Guest VLAN access
8. Remove unauthorized MAC addresses and clear ARP cache
9. Configure logging and banners
10. Document all changes and answer forensics questions:
    - What evidence of VLAN hopping or ARP spoofing did you find?
    - Which ports were most vulnerable and why?
    - How did you verify isolation between VLANs?

## Scoring
- Each security improvement and correct answer earns points.
- Bonus for clear documentation, verification steps, and forensics analysis.

*This scenario is unique and designed for advanced CyberPatriot practice.*
