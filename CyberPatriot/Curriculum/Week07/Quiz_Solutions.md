# Week 7 Quiz - Mentor Review Notes

## Quiz Focus: Network Security (ACLs, Firewall Config Practice)

### Key Concepts to Reinforce:

-   **ACL Purpose:** Traffic filtering based on rules.
-   **Standard vs. Extended:** Standard = Source IP only, place near destination. Extended = Source/Dest IP/Port, place near source.
-   **Wildcard Masks:** Inverse of subnet mask. `host` = `0.0.0.0`, `any` = `255.255.255.255`. Practice common ones (e.g., `/24` -> `0.0.0.255`).
-   **Implicit Deny:** If traffic doesn't match a `permit` rule, it's dropped. ACLs need at least one `permit` statement to allow anything (unless the goal is to block everything).
-   **Application:** `ip access-group <name/num> {in|out}` command under the interface configuration. Direction matters!
-   **Verification:** `show access-lists`, `show ip interface`.
-   **Port Security:** Basic MAC address control on switch ports. `shutdown` is the most common violation action in CP.
-   **Firewall Review:** Apply Win/Lin firewall knowledge to specific scenarios.

### Common Mistakes/Misconceptions:

-   Incorrect wildcard masks.
-   Placing standard ACLs too close to the source (ineffective filtering).
-   Placing extended ACLs too close to the destination (inefficient).
-   Applying ACLs in the wrong direction (in vs. out).
-   Forgetting the `ip access-group` command on the interface.
-   ACL logic errors (order of permit/deny statements, forgetting required permit statements).
-   Syntax errors in ACL commands (e.g., forgetting `host` keyword, wrong protocol name).
-   Confusing port security with ACLs.
-   Forgetting `switchport mode access` before configuring port security.

### Discussion Points for Review:

-   Ask cadets to explain the difference between a standard and extended ACL and where each should generally be placed.
-   Give a subnet mask (e.g., `255.255.255.0`) and ask for the wildcard mask (`0.0.0.255`).
-   Scenario: "Block host 10.1.1.5 from accessing anything, but allow all other traffic from the 10.1.1.0/24 network." Write the standard ACL. Where would you apply it and in which direction?
-   Scenario: "Allow host 192.168.1.10 to access web server 10.0.0.50 via HTTP, but deny all other traffic to that server." Write the extended ACL. Where would you apply it and in which direction?
-   Ask the commands to verify applied ACLs and see hit counts.
-   Ask the basic commands to enable port security on a switch interface to allow only one MAC address and shut down the port on violation.

*(Detailed answers and explanations should reference the actual quiz solution file: `../Quizzes/Solutions/Cisco_Security_Quiz_Solution.md`)*

---
*Mentor notes for internal team use. ACLs require practice; use Packet Tracer extensively.*
