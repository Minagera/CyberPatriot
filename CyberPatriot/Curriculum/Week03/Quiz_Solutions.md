# Week 3 Quiz - Mentor Review Notes

## Quiz Focus: Networking Fundamentals & Cisco Basics

### Key Concepts to Reinforce:

-   **IP Addressing:** Ensure cadets grasp the purpose of IP address, subnet mask, and default gateway. Private vs. Public IP ranges (`10.x`, `172.16-31.x`, `192.168.x`).
-   **Troubleshooting Commands:** `ping` checks reachability, `ipconfig`/`ip a` shows local config, `tracert`/`traceroute` shows path. DNS resolves names to IPs.
-   **Cisco Modes:** The difference between User EXEC (`>`), Privileged EXEC (`#`), and Global Config (`(config)#`) is crucial. How to move between them (`enable`, `conf t`, `exit`, `end`).
-   **Basic Security:** Setting `enable secret` (not `enable password`), securing `line console 0` and `line vty 0 4` with passwords and `login` is fundamental. `service password-encryption` is weak but standard practice.
-   **Saving Config:** Emphasize `copy run start` to make changes persistent across reboots.
-   **Packet Tracer:** Basic usage - placing devices, choosing correct cables (straight-through vs. crossover basics), accessing CLI.

### Common Mistakes/Misconceptions:

-   Confusing subnet mask with default gateway.
-   Not understanding why a device needs a gateway to reach other networks.
-   Forgetting `enable` to enter Privileged EXEC mode.
-   Trying to run configuration commands outside of Global Config mode.
-   Using `enable password` instead of `enable secret`.
-   Forgetting the `login` command on console/VTY lines (passwords won't be checked).
-   Forgetting to save the configuration (`copy run start`).
-   Using the wrong cable types in Packet Tracer.

### Discussion Points for Review:

-   Ask a cadet to explain how their computer gets to google.com (involving DNS, gateway, routing).
-   Give an IP/Mask (e.g., 192.168.1.50 / 255.255.255.0) and ask for the network address.
-   Have cadets demonstrate configuring a hostname and enable secret on a router in Packet Tracer.
-   Ask how to secure the console port. Ask how to secure Telnet/SSH access (VTY lines).
-   Ask the command to save the current configuration so it survives a reboot.
-   Discuss why `enable secret` is better than `enable password`.

*(Detailed answers and explanations should reference the actual quiz solution file: `../Quizzes/Solutions/Cisco_IOS_Basics_Quiz_Solution.md`)*

---
*Mentor notes for internal team use. Focus on foundational concepts and basic IOS commands.*
