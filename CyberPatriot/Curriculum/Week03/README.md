# Week 3: Networking Fundamentals & Cisco Basics

## Learning Objectives

By the end of this week, cadets will be able to:
-   Describe the basic functions of the TCP/IP and OSI models (conceptual understanding).
-   Explain IP addressing (IPv4), subnet masks, default gateways, and DNS.
-   Use basic network troubleshooting commands (`ipconfig`/`ifconfig`, `ping`, `tracert`/`traceroute`).
-   Identify common network devices (router, switch, firewall).
-   Understand basic Cisco IOS modes (User EXEC, Privileged EXEC, Global Configuration).
-   Perform basic Cisco device configuration (hostname, passwords, console/VTY security basics).
-   Navigate and use Cisco Packet Tracer for basic network simulation.

## Topics Covered

-   Networking Models: OSI vs. TCP/IP (Layers and basic functions - focus on Network, Transport, Application).
-   IP Addressing (IPv4): Address structure, Classes (briefly), Private vs. Public IPs, Subnet Masks, CIDR notation basics.
-   Network Services: Default Gateway, DNS (purpose), DHCP (purpose).
-   Network Troubleshooting Tools:
    -   Windows: `ipconfig /all`, `ping`, `tracert`, `nslookup`
    -   Linux: `ip a`, `ip r`, `ping`, `traceroute`, `dig`/`nslookup`
-   Network Devices: Router (connects networks), Switch (connects devices within a network), Firewall (filters traffic).
-   Introduction to Cisco IOS:
    -   Access methods (Console, Telnet, SSH - discuss security implications).
    -   IOS Modes: User EXEC (`>`), Privileged EXEC (`#`), Global Configuration (`(config)#`), Interface Configuration (`(config-if)#`). Command: `enable`, `configure terminal`, `interface <type/num>`, `exit`, `end`.
    -   Basic Configuration: `hostname <name>`, `enable secret <password>`, `line console 0`, `password <password>`, `login`, `line vty 0 4`, `password <password>`, `login`.
    -   Saving Configuration: `copy running-config startup-config`.
-   Introduction to Cisco Packet Tracer: Interface overview, placing devices, connecting devices (cable types), basic device configuration via CLI tab.

## Activities/Exercises

-   **Discussion:** Whiteboard session explaining IP addressing, subnetting basics, and the roles of gateway/DNS. Discuss TCP vs UDP.
-   **Lab 1:** Network Troubleshooting: Use `ipconfig`/`ip a`, `ping`, `tracert`/`traceroute` on VMs to check connectivity, identify IP/gateway, and trace paths. Use `nslookup`/`dig`.
-   **Lab 2:** Packet Tracer Introduction: Build a simple network (PC -> Switch -> Router -> PC). Configure basic IP addresses on PCs and router interfaces. Test connectivity with `ping` within Packet Tracer.
-   **Lab 3:** Basic Cisco IOS Configuration: In Packet Tracer, configure hostname, enable secret, console password, and basic VTY password on a router and switch. Save the configuration.
-   **Exercise:** [Unique Basic Networking & Cisco Intro Exercise](../Exercises/Networking/Intro/README.md) - Analyze network diagrams, calculate simple subnets, configure basic device security in Packet Tracer.

## Assessment

-   Participation in discussions and labs.
-   Completion of [Unique Basic Networking & Cisco Intro Exercise](../Exercises/Networking/Intro/README.md).
-   [Unique Cisco IOS Basics Quiz](../Quizzes/Quiz-Files/Cisco_IOS_Basics_Quiz.md)

## Resources

-   [Unique Cisco Basics Guide](../Cisco/Guides/Basic/README.md)
-   [Unique Cisco Command Reference](../Resources/References/Cisco_Security_Reference.md)
-   Packet Tracer Download (via NetAcad or AFA CyberPatriot Dashboard)
-   Online IP Subnetting tutorials/calculators.

---
*This weekly plan is uniquely designed for the Grissom JROTC CyberPatriot program.*
