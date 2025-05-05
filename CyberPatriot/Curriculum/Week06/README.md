# Week 6: Linux System Hardening (Firewall, SSH, Services)

## Learning Objectives

By the end of this week, cadets will be able to:
-   Configure the Uncomplicated Firewall (UFW) to allow/deny traffic and services.
-   Secure the SSH service (`sshd`) by modifying its configuration file.
-   Analyze and manage system services using `systemctl`.
-   Understand and correct insecure file permissions (world-writable files, excessive SUID/SGID).
-   Perform system updates safely (if permitted).

## Topics Covered

-   **Uncomplicated Firewall (UFW):**
    -   Checking status (`sudo ufw status verbose`, `sudo ufw status numbered`).
    -   Enabling/Disabling (`sudo ufw enable`/`disable`).
    -   Default policies (`sudo ufw default deny incoming`, `sudo ufw default allow outgoing`).
    -   Allowing/Denying services/ports (`sudo ufw allow <service/port>`, `sudo ufw deny <service/port>`).
    -   Deleting rules (`sudo ufw delete <rule_number>`).
    -   Rate limiting (e.g., `sudo ufw limit ssh`).
    -   *Crucial: Allow traffic required by README.*
-   **SSH Server Security (`sshd`):**
    -   Configuration file: `/etc/ssh/sshd_config`.
    -   Key security parameters:
        -   `PermitRootLogin no` (Critical)
        -   `PasswordAuthentication no` (If using keys - advanced, mention possibility) or ensure strong passwords are enforced via PAM.
        -   `AllowUsers` / `AllowGroups` (Restrict who can log in).
        -   `Port 22` (Consider changing if allowed/practical).
        -   `Protocol 2` (Ensure protocol 1 is disabled).
        -   `UsePAM yes` (Ensure it's enabled for PAM policies to apply).
    -   Restarting the SSH service: `sudo systemctl restart sshd`.
-   **Service Management (`systemctl`):**
    -   Listing units/services (`systemctl list-units --type=service`, `--state=running`, `--all`).
    -   Checking service status (`systemctl status <service>`).
    -   Starting/Stopping services (`sudo systemctl start/stop <service>`).
    -   Enabling/Disabling services at boot (`sudo systemctl enable/disable <service>`). Use `disable --now` to stop and disable.
    -   Identifying and disabling unnecessary/insecure services (e.g., `telnetd`, `vsftpd` if not needed, `apache2` if not needed - *check README*).
-   **File System Permissions Deep Dive:**
    -   Finding world-writable files/directories: `find / -type f -perm -0002 -ls`, `find / -type d -perm -0002 -ls` (excluding `/tmp`, `/var/tmp`). Correcting with `chmod o-w <file/dir>`.
    -   Finding SUID/SGID files: `find / -perm /6000 -type f -ls`. Investigating unusual entries. Removing unnecessary SUID/SGID bits (`chmod -s <file>`). Understanding the risk.
-   **System Updates:**
    -   Commands: `sudo apt update && sudo apt upgrade -y`.
    -   *Caution: Only run if explicitly allowed or required by the README and if time permits. Can sometimes break scoring.*

## Activities/Exercises

-   **Lab 1 (UFW):** Enable UFW, set default deny incoming. Allow SSH. Allow HTTP if a web server is running. Check status. Delete a rule.
-   **Lab 2 (SSH):** Edit `/etc/ssh/sshd_config` to disable root login. Restart `sshd`. Attempt to log in as root via SSH (should fail). Discuss other hardening options.
-   **Lab 3 (Services):** Use `systemctl` to check running services. Identify and disable an unnecessary service (e.g., `cups` if no printing).
-   **Lab 4 (Permissions):** Use `find` to locate world-writable files and directories (create some if needed for practice). Correct permissions using `chmod`. Find SUID files and discuss risks.
-   **Exercise:** [Unique Linux Hardening Exercise](../Exercises/Linux/Hardening/README.md) - Given a Linux VM and a mock README, configure UFW, harden SSH, disable listed services, fix world-writable files, and check for risky SUID files.

## Assessment

-   Participation in labs and configuration tasks.
-   Completion of [Unique Linux Hardening Exercise](../Exercises/Linux/Hardening/README.md).
-   [Unique Linux System Hardening Quiz](../Quizzes/Quiz-Files/Linux_System_Hardening_Quiz.md)

## Resources

-   [Unique Linux Hardening Guide](../Linux/Guides/Hardening/README.md) (Covers UFW, SSH, Services, Permissions)
-   [Unique Linux Checklist](../Checklists/Linux/README.md)
-   [Unique Linux Command Reference](../Resources/References/Linux_Security_Reference.md)
-   `ufw`, `sshd_config`, `systemctl`, `chmod`, `find` man pages.

---
*This weekly plan is uniquely designed for the Grissom JROTC CyberPatriot program.*
