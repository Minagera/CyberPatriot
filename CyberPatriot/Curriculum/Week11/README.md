# Week 11: Advanced Networking & Packet Tracer Scenarios

## Learning Objectives

By the end of this week, cadets will be able to:
-   Explain the concept and benefits of VLANs (Virtual LANs).
-   Configure basic VLANs and trunking on Cisco switches.
-   Assign switch ports to specific VLANs.
-   Configure Inter-VLAN routing using Router-on-a-Stick (ROAS).
-   Implement more complex ACLs (extended, potentially reflexive/dynamic intro).
-   Apply various Cisco hardening techniques in integrated scenarios.
-   Troubleshoot common network configuration issues in Packet Tracer.

## Topics Covered

-   **VLAN Concepts:**
    -   Purpose: Segmenting a physical switch into multiple logical broadcast domains.
    -   Benefits: Security, performance, flexibility, reduced broadcast traffic.
    -   VLAN Tagging (802.1q): How switches identify VLAN membership for traffic crossing trunks. Native VLAN.
-   **VLAN Configuration (Cisco Switch):**
    -   Creating VLANs: `vlan <vlan_id>`, `name <vlan_name>`.
    -   Assigning Access Ports: `interface <type/num>`, `switchport mode access`, `switchport access vlan <vlan_id>`.
    -   Verifying VLANs: `show vlan brief`.
-   **Trunking (Cisco Switch):**
    -   Purpose: Carry traffic for multiple VLANs between switches or between a switch and a router.
    -   Configuration: `interface <type/num>`, `switchport mode trunk`, `switchport trunk allowed vlan {add | remove | all | except} <vlan_list>`, `switchport trunk native vlan <vlan_id>`.
    -   Verifying Trunks: `show interfaces trunk`.
-   **Inter-VLAN Routing (Router-on-a-Stick - ROAS):**
    -   Concept: Using a single router interface connected via a trunk link to route between multiple VLANs.
    -   Configuration (Router):
        -   Create subinterfaces: `interface <type/num>.<subinterface_id>` (often matches VLAN ID).
        -   Set encapsulation: `encapsulation dot1q <vlan_id> [native]`.
        -   Assign IP address (gateway for the VLAN): `ip address <ip_address> <subnet_mask>`.
    -   Configuration (Switch): Ensure connected port is configured as a trunk.
-   **Advanced ACLs (Review & Expansion):**
    -   Applying extended ACLs in multi-VLAN scenarios.
    -   Importance of ACL placement for inter-VLAN traffic.
    -   (Optional Intro) Reflexive ACLs (allow return traffic for established sessions), Dynamic ACLs (lock-and-key).
-   **Integrated Hardening Practice:**
    -   Combining basic hardening (passwords, SSH, banners, disable services) with VLANs, ACLs, and Port Security in complex Packet Tracer scenarios.
-   **Troubleshooting in Packet Tracer:**
    -   Using `ping`, `traceroute` within PT.
    -   Using `show` commands (`show ip interface brief`, `show vlan brief`, `show interfaces trunk`, `show access-lists`, `show ip route`) to diagnose connectivity issues, VLAN assignments, trunk status, ACL blocks, routing problems.

## Activities/Exercises

-   **Discussion:** Whiteboard VLANs, trunking, and ROAS concepts. Explain how traffic flows between VLANs via the router.
-   **Lab 1 (Packet Tracer - VLANs & Trunking):** Configure multiple VLANs on two switches. Assign ports to VLANs. Configure a trunk link between the switches. Verify VLANs and trunk status. Test connectivity within VLANs, observe lack of connectivity between VLANs.
-   **Lab 2 (Packet Tracer - ROAS):** Add a router to the Lab 1 topology. Configure ROAS with subinterfaces for each VLAN. Configure the switch-router link as a trunk. Test connectivity between VLANs.
-   **Lab 3 (Packet Tracer - ACLs with VLANs):** Apply extended ACLs on the router subinterfaces (or physical interface) to control traffic flow between specific VLANs (e.g., allow VLAN 10 to access a server in VLAN 20 via HTTP, but deny other traffic).
-   **Lab 4 (Packet Tracer - Troubleshooting):** Provide a pre-configured but broken Packet Tracer file (e.g., incorrect VLAN assignment, trunk issue, ACL blocking traffic, ROAS misconfiguration). Cadets use `show` commands and `ping`/`traceroute` to find and fix the issue(s).
-   **Exercise:** [Unique Advanced Networking Scenario (VLANs, ROAS, ACLs)](../Exercises/Networking/VLAN_ROAS_ACL/README.md) - A complex Packet Tracer scenario requiring configuration of VLANs, trunking, ROAS, ACLs, and basic device hardening based on a network diagram and requirements document.

## Assessment

-   Participation and successful configuration in Packet Tracer labs.
-   Ability to troubleshoot basic network issues using `show` commands.
-   Completion of [Unique Advanced Networking Scenario (VLANs, ROAS, ACLs)](../Exercises/Networking/VLAN_ROAS_ACL/README.md).
-   [Unique Cisco Packet Tracer Quiz](../Quizzes/Quiz-Files/Cisco_Packet_Tracer_Quiz.md) (Scenario-based questions)

## Resources

-   [Unique Cisco VLAN & Trunking Guide](../Cisco/Guides/VLANs_Trunking/README.md) (New or enhance existing)
-   [Unique Cisco Inter-VLAN Routing Guide](../Cisco/Guides/InterVLAN_Routing/README.md) (New or enhance existing)
-   [Unique Cisco ACL Guide](../Cisco/Guides/ACLs/README.md) (Review Extended section)
-   Packet Tracer tutorials on VLANs, ROAS, ACLs.

---
*This weekly plan is uniquely designed for the Grissom JROTC CyberPatriot program.*
