# Cisco Networking Training Materials

This directory provides resources for learning Cisco IOS configuration and security, specifically tailored for the networking components of the CyberPatriot competition, including Packet Tracer scenarios.

## Directory Index

### [Checklists/](Checklists/README.md)
Links to the detailed Cisco checklist in the main `Checklists/Cisco/` directory. Covers device hardening, secure access, ACLs, VLAN security, and verification commands.

### [Exercises/](Exercises/README.md)
Hands-on practice labs and configuration challenges, often designed for use with Cisco Packet Tracer.

### [Guides/](Guides/README.md)
In-depth guides explaining Cisco IOS commands, security concepts (ACLs, VLANs, SSH, AAA), and common CyberPatriot configuration tasks.
-   **[Basic_IOS_Commands.md](Guides/Basic_IOS_Commands.md)**: Introduction to navigating IOS, basic configuration modes, saving configs.
-   **[Device_Hardening_Guide.md](Guides/Device_Hardening_Guide.md)**: Securing console/VTY lines, enable passwords/secrets, banners, disabling unused services.
-   **[ACL_Guide.md](Guides/ACL_Guide.md)**: Standard and Extended Access Control Lists syntax and application.
-   **[VLAN_Security_Guide.md](Guides/VLAN_Security_Guide.md)**: VLAN configuration, trunking, and switchport security concepts.

### [PacketTracer_Scenarios/](PacketTracer_Scenarios/README.md)
Pre-built Cisco Packet Tracer (`.pkt`) files simulating network environments with security challenges to solve. Includes scenarios for basic hardening, ACL implementation, and VLAN configuration.

### [Quizzes/](Quizzes/README.md)
Quizzes testing knowledge of Cisco IOS commands, networking concepts, security best practices, and Packet Tracer usage.

### [Scripts/](Scripts/README.md)
Example configuration snippets or templates for common Cisco hardening tasks. (Note: Automation is less common for Cisco in CP compared to Win/Lin).

---

## CyberPatriot Competition Tips for Cisco

-   **Read the README/Scenario:** Understand the network topology, required connectivity, prohibited actions, and specific security tasks.
-   **Basic Hardening:**
    *   Set a unique hostname (`hostname [name]`).
    *   Set `enable secret [strong_password]`.
    *   Secure console (`line console 0`, `password [strong_password]`, `login`, `exec-timeout 5 0`).
    *   Secure VTY lines (`line vty 0 4` or `0 15`, `password [strong_password]`, `login`, `exec-timeout 5 0`).
    *   Encrypt passwords (`service password-encryption`).
    *   Set a MOTD banner (`banner motd # Authorized Access Only #`).
-   **Secure Remote Access:**
    *   Configure SSH (requires hostname, domain name, crypto keys, local user): `ip domain-name cp.local`, `crypto key generate rsa modulus 2048`, `username [admin] secret [strong_password]`, `line vty 0 4`, `login local`, `transport input ssh`.
    *   Disable Telnet (`transport input none` or just `transport input ssh` on VTY lines).
-   **Disable Unused Services/Interfaces:**
    *   `no ip http server`, `no cdp run` (unless needed).
    *   Shut down unused physical interfaces (`interface [type/num]`, `shutdown`).
-   **Access Control Lists (ACLs):**
    *   Implement ACLs as required by the scenario to permit/deny traffic between networks/hosts. Use standard or extended ACLs as appropriate. Apply them to interfaces (`ip access-group [num/name] in|out`). Remember the implicit deny at the end. Use remarks (`remark ...`) to document ACL entries.
-   **Switch Security (if applicable):**
    *   Configure port security (`switchport port-security`, `mac-address sticky`, `maximum [num]`, `violation shutdown`).
    *   Disable unused switch ports (`shutdown`).
    *   Configure VLANs and secure trunk links if required. Avoid using VLAN 1 for user data.
-   **Verification:** Use `show running-config`, `show ip interface brief`, `show access-lists`, `show port-security interface [int]`, `ping`, `traceroute` to verify configuration and connectivity.
-   **Save Configuration:** `copy running-config startup-config` or `write memory`. **CRITICAL STEP!**

---

## Additional Resources

-   [Cisco Networking Academy](https://www.netacad.com/)
-   [CyberPatriot Cisco Networking Resources](https://www.uscyberpatriot.org/competition/training-materials/networking)

*All materials are unique and designed for CyberPatriot training.*
