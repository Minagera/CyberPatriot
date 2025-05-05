# Week 11 Quiz - Mentor Review Notes

## Quiz Focus: Advanced Networking & Packet Tracer Scenarios

### Key Concepts to Reinforce:

-   **VLANs:** Logical segmentation, reduces broadcasts, improves security. Devices in different VLANs cannot communicate without a router.
-   **Trunking (802.1q):** Carries multiple VLANs between devices (switch-switch, switch-router). Needs `switchport mode trunk`. Native VLAN is untagged.
-   **Access Ports:** Belong to a single VLAN. `switchport mode access`, `switchport access vlan X`.
-   **ROAS:** Using router subinterfaces (`int g0/0.10`), `encapsulation dot1q <vlan>`, and IP addresses to route between VLANs connected via a trunk. The router is the gateway for each VLAN.
-   **ACLs with VLANs:** Apply ACLs on the router (physical interface or subinterfaces) to control inter-VLAN traffic. Direction (in/out) relative to the router interface is critical.
-   **Troubleshooting:** Systematic use of `show` commands (`show vlan brief`, `show int trunk`, `show ip int brief`, `show ip route`, `show access-lists`) and `ping`/`traceroute` is key.

### Common Mistakes/Misconceptions:

-   Forgetting to create VLANs before assigning ports.
-   Assigning ports to the wrong VLAN.
-   Mismatch in trunk configuration (native VLAN, allowed VLANs) between devices.
-   Forgetting `switchport mode trunk` on one or both ends of a trunk link.
-   Incorrect ROAS configuration (wrong subinterface number, wrong `encapsulation dot1q <vlan>`, missing IP address, no trunk on switch side).
-   Applying ACLs to the wrong interface or in the wrong direction for inter-VLAN traffic.
-   ACL logic errors preventing desired traffic flow between VLANs.
-   Basic connectivity issues (wrong cables, IP address typos, interfaces shut down).

### Discussion Points for Review:

-   Ask cadets why VLANs are used.
-   Ask the difference between an access port and a trunk port.
-   Scenario: "You have VLAN 10 and VLAN 20 on a switch. How do you configure port Fa0/1 for a PC in VLAN 10?" (`int fa0/1`, `switchport mode access`, `switchport access vlan 10`).
-   Scenario: "How do you configure the link between a switch and a router for ROAS?" (Switch: `switchport mode trunk`. Router: `int g0/0.<vlan>`, `encapsulation dot1q <vlan>`, `ip address ...`).
-   Scenario: "You want to block VLAN 10 from accessing a server in VLAN 30, but allow VLAN 20." Where would you apply the ACL on a ROAS setup? (Router interface/subinterfaces, likely inbound on VLAN 10 subinterface or outbound on VLAN 30 subinterface, depending on exact policy).
-   Ask for 3 `show` commands useful for troubleshooting VLAN/trunking issues. (`show vlan brief`, `show int trunk`, `show ip int brief`).

*(Detailed answers and explanations should reference the actual quiz solution file: `../Quizzes/Solutions/Cisco_Packet_Tracer_Quiz_Solution.md`)*

---
*Mentor notes for internal team use. Packet Tracer allows complex scenarios; focus on systematic configuration and troubleshooting.*
