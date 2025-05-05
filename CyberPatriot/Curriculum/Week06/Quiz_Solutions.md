# Week 6 Quiz - Mentor Review Notes

## Quiz Focus: Linux System Hardening (Firewall, SSH, Services)

### Key Concepts to Reinforce:

-   **UFW:** Simple firewall management. Default deny incoming is key. Need to explicitly allow required services (SSH, HTTP/S, etc., per README). `ufw status verbose`.
-   **SSH Hardening:** `/etc/ssh/sshd_config` is the target. `PermitRootLogin no` is non-negotiable unless README forces it. Restart service after changes (`sudo systemctl restart sshd`).
-   **`systemctl`:** The standard tool for managing services (status, start, stop, enable, disable). Know how to find running services and disable unneeded ones (check README!).
-   **Permissions Risks:** World-writable files/dirs can be modified by anyone. SUID binaries run with the owner's privileges (often root) - dangerous if misused or applied to insecure scripts/programs.
-   **Updates Caution:** Updates are good *in general*, but in CP, only update if the README allows it AND you have time AND you understand the risk (potential scoring issues). `apt update && apt upgrade -y`.
-   **README First:** Always, always check the README before disabling services or blocking ports.

### Common Mistakes/Misconceptions:

-   Enabling UFW but forgetting to allow SSH (locking themselves out).
-   Setting UFW rules but forgetting `sudo ufw enable`.
-   Editing `sshd_config` but forgetting to restart the `sshd` service.
-   Disabling services required by the README (e.g., `apache2` for a web server task).
-   Confusing `systemctl stop` (temporary) with `systemctl disable` (persistent).
-   Being overly aggressive with `chmod -s` on SUID files without understanding their purpose (some are necessary).
-   Running `apt upgrade` without checking the README or considering the time impact.
-   Incorrect `find` syntax for permissions.

### Discussion Points for Review:

-   Ask cadets the commands to enable UFW, deny incoming traffic by default, and allow SSH connections.
-   Ask the most important setting to change in `sshd_config` for security. What command restarts SSH?
-   How do you check which services are currently running? How do you stop a service called `badservice` and prevent it from starting on boot?
-   Explain the risk of a world-writable script in `/usr/local/bin`. How would you find it? How would you fix it?
-   Explain the risk of an unknown SUID binary owned by root. How would you find it?
-   Scenario: "The README says the system must host a website. Which service should you NOT disable? Which port should you allow in UFW?" (apache2/nginx/etc., port 80/443).

*(Detailed answers and explanations should reference the actual quiz solution file: `../Quizzes/Solutions/Linux_System_Hardening_Quiz_Solution.md`)*

---
*Mentor notes for internal team use. Focus on practical commands and security impact.*
