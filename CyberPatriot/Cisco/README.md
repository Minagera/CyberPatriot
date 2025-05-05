# Cisco Networking Training Materials (CyberPatriot Focus)

This section provides unique guides, checklists, Packet Tracer scenarios, and resources specifically tailored for mastering Cisco IOS security and networking concepts within the CyberPatriot competition context. The focus is on practical configuration, hardening, troubleshooting, and understanding concepts relevant to the Cisco component of the competition.

## Directory Index

-   [**Guides/**](Guides/README.md)
    *   Unique, step-by-step guides covering Cisco IOS basics, device hardening, ACL configuration (standard, extended), VLANs, trunking, Inter-VLAN routing (ROAS), switch security (Port Security), and troubleshooting techniques relevant to CyberPatriot.
-   [**Checklists/**](../Checklists/Cisco/README.md)
    *   Actionable checklist for systematic Cisco device hardening during competition, emphasizing README compliance and prioritization. (Link points to the main Checklists directory - *Needs Creation if not present*).
-   [**PacketTracer_Scenarios/**](PacketTracer_Scenarios/README.md)
    *   A collection of unique Cisco Packet Tracer (`.pkt`) files simulating various network topologies and security challenges encountered in CyberPatriot. Includes basic labs, hardening exercises, VLAN/ACL scenarios, and troubleshooting challenges. Each scenario should have clear objectives.
-   [**Quizzes/**](../Quizzes/Quiz-Files/README.md)
    *   Links to relevant unique quizzes covering Cisco IOS commands, networking concepts, security features, and Packet Tracer interpretation. (Points to main Quizzes directory).

---

## CyberPatriot Competition Tips for Cisco (Nationals Prep)

-   **Read the README/Scenario:** This is paramount. Understand the network topology diagram, required connectivity/services, prohibited actions, specific security tasks (e.g., configure specific ACLs, secure VTY), scoring elements, and any conceptual questions. *README instructions override general best practices.*
-   **Basic Device Hardening (Router/Switch):**
    *   Set a unique hostname (`hostname [name]`).
    *   Set a strong `enable secret [strong_password]`. Avoid `enable password`.
    *   Secure console access (`line console 0`, `password [strong_password]`, `login`, `exec-timeout 5 0` or similar).
    *   Secure VTY lines for remote access (`line vty 0 4` or `0 15`, `password [strong_password]`, `login`, `exec-timeout 5 0`).
    *   **Configure SSH:** (More secure than Telnet) Requires hostname, domain name, crypto keys, local user: `ip domain-name cp.local`, `crypto key generate rsa modulus 2048` (or higher), `username [admin] privilege 15 secret [strong_password]`, `line vty 0 4`, `login local`, `transport input ssh`.
    *   **Disable Telnet:** `transport input none` or just `transport input ssh` on VTY lines.
    *   Encrypt plaintext passwords (`service password-encryption`). Weak, but standard practice.
    *   Set a MOTD banner (`banner motd # Authorized Access Only. Activity Monitored. #`).
-   **Disable Unused Services/Interfaces:**
    *   `no ip http server` / `no ip http secure-server` (Unless web management is required by README).
    *   `no cdp run` (Globally, unless CDP is needed for troubleshooting or specific tasks). Can also disable per-interface (`no cdp enable`).
    *   Shut down unused physical interfaces (`interface range [type/num]`, `shutdown`, `description **UNUSED**`).
-   **Switch Security:**
    *   **Port Security:** (`interface range [...]`, `switchport mode access`, `switchport port-security`, `switchport port-security maximum 1`, `switchport port-security mac-address sticky`, `switchport port-security violation shutdown`). Apply to access ports.
    *   Assign unused ports to a "blackhole" VLAN and shut them down.
    *   Secure trunk links (`switchport trunk allowed vlan [...]`, `switchport trunk native vlan <unused_vlan_id>`).
    *   Disable DTP (`switchport nonegotiate`) on trunk and access ports.
-   **Access Control Lists (ACLs):**
    *   Implement ACLs precisely as required by the README or security policy.
    *   Use standard ACLs (source IP only) near the destination.
    *   Use extended ACLs (source/dest IP/port) near the source.
    *   Remember the implicit `deny any` at the end. Ensure necessary traffic is permitted.
    *   Apply to interfaces correctly (`ip access-group <name/num> {in | out}`).
    *   Use `show access-lists` to verify configuration and check hit counts.
-   **VLANs and Inter-VLAN Routing:**
    *   Configure VLANs, trunks, and ROAS (or SVIs if applicable) as per the topology/requirements.
    *   Ensure correct VLAN assignments, trunk configurations (allowed VLANs, native VLAN), and subinterface encapsulation/IP addressing.
-   **Verification and Troubleshooting:**
    *   Save configuration frequently (`copy running-config startup-config` or `wr`).
    *   Use `show` commands extensively (`show run`, `show ip int brief`, `show int status`, `show vlan brief`, `show int trunk`, `show ip route`, `show access-lists`, `show port-security interface [...]`).
    *   Use `ping` and `traceroute` within Packet Tracer to test connectivity systematically.
-   **Conceptual Questions:** Review networking fundamentals (OSI/TCP-IP, subnetting, routing logic) as quizzes often test these.

---

*All materials in this directory are unique and designed specifically for CyberPatriot training aiming for National-level performance. Use the README files within each subdirectory for more specific guidance.*
