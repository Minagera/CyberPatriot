# Week 7: Network Security (ACLs, Firewall Config Practice)

## Learning Objectives

By the end of this week, cadets will be able to:
-   Explain the purpose and basic logic of Access Control Lists (ACLs).
-   Configure standard numbered and named IPv4 ACLs on Cisco routers.
-   Apply ACLs to Cisco router interfaces (inbound/outbound).
-   Verify ACL configuration and operation (`show access-lists`, `show ip interface`).
-   Apply firewall configuration concepts learned in Weeks 5 & 6 in more complex scenarios.
-   Understand basic switch security concepts (Port Security introduction).

## Topics Covered

-   **Access Control List (ACL) Concepts:**
    -   Purpose: Filter network traffic based on criteria (source/destination IP, ports, etc.).
    -   Implicit Deny: Any traffic not explicitly permitted by an ACL is denied.
    -   Placement: Standard ACLs (filter based on source IP only) placed close to the destination; Extended ACLs (filter on source/dest IP, ports) placed close to the source.
    -   Direction: Applying ACLs inbound or outbound on an interface.
-   **Cisco Standard ACLs (IPv4):**
    -   Numbered (1-99): `access-list <number> {permit | deny} {source_ip wildcard_mask | host source_ip | any}`
    -   Named: `ip access-list standard <NAME>`, `{permit | deny} {source_ip wildcard_mask | host source_ip | any}`
    -   Wildcard Masks: Inverse of subnet mask (e.g., `0.0.0.255` matches the last octet). `0.0.0.0` = host, `255.255.255.255` = any.
-   **Cisco Extended ACLs (IPv4 - Introduction):**
    -   Numbered (100-199): `access-list <number> {permit | deny} protocol source_ip wildcard destination_ip wildcard [operator port]` (e.g., `permit tcp host 1.1.1.1 host 2.2.2.2 eq 80`)
    -   Named: `ip access-list extended <NAME>`, rules similar to numbered.
    -   Common protocols: `ip`, `tcp`, `udp`, `icmp`.
    -   Operators/Ports: `eq` (equal), `lt` (less than), `gt` (greater than), common port numbers (80, 443, 22, 23, 53).
-   **Applying ACLs to Interfaces:**
    -   `interface <type/num>`
    -   `ip access-group {<number> | <NAME>} {in | out}`
-   **Verifying ACLs:**
    -   `show access-lists`
    -   `show running-config`
    -   `show ip interface <type/num>` (Shows applied ACLs)
-   **Firewall Configuration Practice (Win/Lin):**
    -   Reviewing and applying UFW/Windows Defender Firewall rules based on more complex mock README requirements (e.g., allowing specific source IPs, blocking specific ports).
-   **Switch Security Introduction:**
    -   Port Security (`switchport port-security`): Limiting MAC addresses per port, violation actions (`shutdown`, `restrict`, `protect`). Basic commands: `switchport mode access`, `switchport port-security`, `switchport port-security maximum <num>`, `switchport port-security mac-address sticky`, `switchport port-security violation {shutdown | restrict | protect}`.

## Activities/Exercises

-   **Discussion:** Whiteboard ACL logic (permit/deny statements, order, implicit deny). Explain wildcard masks. Discuss standard vs. extended ACL use cases.
-   **Lab 1 (Packet Tracer - Standard ACL):** Configure a standard ACL to permit traffic only from a specific subnet to a server. Apply it outbound on the router interface closest to the server. Verify.
-   **Lab 2 (Packet Tracer - Extended ACL):** Configure an extended ACL to permit HTTP traffic from any source to a specific web server but deny Telnet. Apply it inbound on the router interface closest to the source(s). Verify.
-   **Lab 3 (Packet Tracer - Port Security):** Configure basic port security on switch ports connected to PCs. Set maximum MAC addresses, sticky learning, and shutdown violation mode. Test by connecting another device.
-   **Lab 4 (VMs - Firewall Practice):** Using Windows/Linux VMs, implement firewall rules based on a mock README requiring specific source/destination/port filtering (e.g., allow RDP only from a specific management IP).
-   **Exercise:** [Unique Network Security Exercise (ACLs & Firewall)](../Exercises/Networking/ACL_Firewall/README.md) - Packet Tracer scenario requiring multiple ACLs (standard/extended) and potentially some VM firewall configuration based on a topology and requirements doc.

## Assessment

-   Participation in labs and Packet Tracer configurations.
-   Completion of [Unique Network Security Exercise (ACLs & Firewall)](../Exercises/Networking/ACL_Firewall/README.md).
-   [Unique Cisco Security Quiz](../Quizzes/Quiz-Files/Cisco_Security_Quiz.md) (Focus on ACLs, basic hardening)

## Resources

-   [Unique Cisco ACL Guide](../Cisco/Guides/ACLs/README.md)
-   [Unique Cisco Switch Security Guide](../Cisco/Guides/Switch_Security/README.md) (Port Security section)
-   [Unique Windows Hardening Guide](../Windows/Guides/Hardening/README.md) (Firewall section)
-   [Unique Linux Hardening Guide](../Linux/Guides/Hardening/README.md) (UFW section)
-   Packet Tracer tutorials on ACLs and Port Security.

---
*This weekly plan is uniquely designed for the Grissom JROTC CyberPatriot program.*
