# Cisco Networking Training Materials

This directory provides unique training materials focused on Cisco IOS configuration and security within the context of the CyberPatriot competition, primarily using Cisco Packet Tracer. The goal is to prepare cadets for networking challenges, including device hardening, ACL implementation, and troubleshooting.

**Always start by reading the README file in each subdirectory.**

## Directory Index

-   [**Guides/**](Guides/README.md)
    *   Contains unique guides covering Basic, Intermediate, and Advanced Cisco IOS concepts, command-line interface (CLI) usage, device hardening procedures, Access Control Lists (ACLs), VLANs, switch security, and other networking topics relevant to CyberPatriot.
-   [**Exercises/**](Exercises/README.md)
    *   Hands-on practice scenarios involving Cisco CLI configuration tasks, often requiring Packet Tracer. These exercises reinforce concepts from the guides.
-   [**PacketTracer/**](PacketTracer/README.md)
    *   Contains Cisco Packet Tracer (`.pkt`) files representing network topologies for exercises, challenges, and practice scenarios. May include pre-configured scenarios with vulnerabilities or starting points for configuration tasks. Solutions or completed `.pkt` files might be included.
-   [**Scripts/**](Scripts/README.md)
    *   Examples or templates of Cisco IOS configuration snippets or scripts. Useful for understanding blocks of configuration commands for common tasks (e.g., setting up SSH, basic hardening).
-   [**Quizzes/**](Quizzes/README.md)
    *   Cisco-specific quizzes (`Quiz-Files/`) and corresponding answer keys (`Solutions/`) covering IOS commands, networking concepts, security principles, and Packet Tracer interpretation relevant to CyberPatriot.
-   [**VM-Setup/**](../VM-Setup/Cisco/README.md) (Link to main VM-Setup section for Cisco)
    *   Provides Packet Tracer files (`.pkt`) and documentation for setting up specific network scenarios for practice, often simulating parts of a competition environment.

---

## Training Focus (Nationals Level)

-   **IOS Command Proficiency:** Mastering CLI navigation (user EXEC, privileged EXEC, global config, interface config, line config modes), command syntax, and using help (`?`).
-   **Device Hardening:** Securing access (enable secret, console/VTY passwords, SSH), disabling unnecessary services (HTTP server, CDP), setting banners, encrypting passwords.
-   **Access Control Lists (ACLs):** Implementing standard, extended, and named ACLs to filter traffic based on source/destination IP, ports, and protocols according to scenario requirements. Applying ACLs correctly to interfaces/lines.
-   **Switch Security:** Configuring port security, disabling unused ports, potentially implementing DHCP snooping or VLANs if required by advanced scenarios.
-   **Troubleshooting:** Using `show` commands (`show run`, `show ip interface brief`, `show interfaces`, `show access-lists`, `show vlan brief`, `show port-security interface`) and `ping`/`traceroute` within Packet Tracer to diagnose connectivity and configuration issues.
-   **Packet Tracer Skills:** Building simple topologies, configuring devices, using simulation mode, and interpreting device states and outputs within the Packet Tracer environment.

## CyberPatriot Competition Tips for Cisco

-   **Read the README/Scenario:** Understand the network topology, required connectivity/services, prohibited actions, specific security tasks, and any scoring details provided. *This is the most important step.*
-   **Basic Hardening (Apply Consistently):**
    *   Set a unique hostname (`hostname [name]`).
    *   Set a strong `enable secret [strong_password]`.
    *   Secure console access (`line console 0`, `password [strong_password]`, `login`, `exec-timeout 5 0`).
    *   Secure VTY lines (`line vty 0 4` or `0 15`, `password [strong_password]`, `login`, `exec-timeout 5 0`). Use `transport input ssh` if SSH is configured.
    *   Encrypt passwords (`service password-encryption`).
    *   Set a MOTD banner (`banner motd # Authorized Access Only. #`). Use a clear delimiter.
-   **Secure Remote Access (SSH Preferred):**
    *   Configure SSH (requires hostname, domain name, crypto keys, local user): `ip domain-name cp.local` (or similar), `crypto key generate rsa modulus 2048` (or higher), `username [admin] secret [strong_password]`, `line vty 0 4` (or `0 15`), `login local`, `transport input ssh`.
    *   Disable Telnet explicitly on VTY lines if SSH is enabled (`transport input ssh`) or implicitly if only SSH is allowed.
-   **Disable Unused Services/Interfaces:**
    *   `no ip http server` (unless a web interface is explicitly required by the README).
    *   `no cdp run` (globally, unless CDP is needed for troubleshooting or specific scenario requirements).
    *   Shut down unused physical interfaces (`interface [type/num]`, `shutdown`). Use `interface range` for efficiency.
-   **Access Control Lists (ACLs):**
    *   Carefully read requirements. Use extended named ACLs for flexibility unless a standard ACL suffices.
    *   Remember the implicit `deny any` at the end of every ACL.
    *   Apply ACLs to the correct interface and direction (`in` or `out`). Test connectivity after applying ACLs.
-   **Save Configuration:** Regularly use `copy running-config startup-config` or `write memory` (`wr`) to save your changes. Packet Tracer usually prompts, but it's good practice.
-   **Documentation:** Note down key configurations (passwords, usernames, ACL logic) in your team's shared documentation.

---

*All materials in this directory are unique and tailored for CyberPatriot training using Cisco IOS and Packet Tracer.*
