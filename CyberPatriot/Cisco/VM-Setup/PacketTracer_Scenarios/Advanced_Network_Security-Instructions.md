# Advanced Network Security Scenario Instructions

## Topology
- 1 Router (R1)
- 1 Switch (S1)
- 3 VLANs: HR, Engineering, Finance
- 1 IT Management subnet (192.168.99.0/24)
- Multiple PCs per VLAN

## Tasks

1. **VLAN and Trunking**
   - Create VLANs for each department.
   - Assign switch ports to the correct VLANs.
   - Configure trunking between switch and router.

2. **Router-on-a-Stick**
   - Configure subinterfaces for each VLAN on the router.
   - Assign correct IP addresses.

3. **Port Security**
   - Enable port security on all access ports (limit to 1 MAC, shutdown on violation).

4. **Management Access Control**
   - Restrict SSH access to only the IT Management subnet.
   - Disable Telnet.

5. **Device Hardening**
   - Set unique enable secret and user passwords.
   - Encrypt all passwords.
   - Set banners (MOTD, login).
   - Disable unused interfaces and services (CDP, HTTP server).

6. **Testing**
   - Verify VLAN isolation.
   - Test SSH from IT subnet (should work), from others (should fail).
   - Test port security by moving PCs between ports.

7. **Documentation**
   - Save configuration.
   - Document all security measures implemented.

*This scenario is unique for CyberPatriot training. Do not distribute externally.*
