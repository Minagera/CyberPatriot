# ACL Challenge Scenario Instructions

## Topology
- 1 Router (R1)
- 1 Switch (S1)
- 3 VLANs: IT, Finance, Guest
- Web server in Finance VLAN

## Tasks

1. **VTY Access Control**
   - Create a standard ACL to allow only IT VLAN hosts to access VTY lines.
   - Apply the ACL to the VTY lines.

2. **Traffic Filtering**
   - Create an extended ACL to block HTTP traffic from Guest VLAN to Finance VLAN.
   - Permit DNS and ICMP between all VLANs.

3. **ACL Placement**
   - Apply ACLs to the correct interfaces and directions (inbound/outbound).

4. **Testing**
   - Verify that only IT VLAN can SSH to the router.
   - Test that Guest VLAN cannot access the web server via HTTP, but can ping and resolve DNS.

5. **Documentation**
   - Add comments to each ACL entry.
   - Save configuration and document all changes.

*This scenario is unique for CyberPatriot training. Do not distribute externally.*
