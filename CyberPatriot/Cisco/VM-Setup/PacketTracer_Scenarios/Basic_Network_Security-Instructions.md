# Basic Network Security Scenario Instructions

## Topology
- 1 Router (R1)
- 1 Switch (S1)
- 2 PCs (PC1, PC2)

## Tasks

1. **Device Access Security**
   - Set a unique, strong enable secret password.
   - Configure local user accounts for device login.
   - Require login on console and VTY lines.
   - Enable SSH version 2; disable Telnet on VTY lines.
   - Encrypt all passwords (`service password-encryption`).

2. **Banner Configuration**
   - Set a Message of the Day (MOTD) banner warning unauthorized users.

3. **Interface Security**
   - Disable all unused switch ports (shutdown).
   - Disable any unused router interfaces.

4. **Service Hardening**
   - Disable CDP on all interfaces if not required.
   - Disable HTTP/HTTPS server on router.

5. **Verification**
   - Test SSH access from PC1.
   - Attempt Telnet (should fail).
   - Verify that only active ports are up.

6. **Documentation**
   - Save the configuration.
   - Write a summary of all changes made.

*This scenario is unique for CyberPatriot training. Do not distribute externally.*
