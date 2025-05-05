# Linux Security Hardening Exercise

## Scenario

Secure a Linux server by configuring the firewall, hardening the SSH service, setting password policies, and addressing common vulnerabilities.

## Objectives

-   Configure basic UFW firewall rules.
-   Modify `sshd_config` for better security.
-   Implement password complexity and aging policies.
-   Identify and disable unnecessary services.
-   Find and fix world-writable file permissions.

## Tasks

1.  **Firewall Configuration (UFW):**
    *   Ensure UFW is installed.
    *   Enable UFW.
    *   Set the default incoming policy to deny.
    *   Set the default outgoing policy to allow.
    *   Allow incoming traffic for SSH (port 22/tcp).
    *   Allow incoming traffic for HTTP (port 80/tcp).
    *   Check the UFW status to verify rules.
2.  **SSH Hardening:**
    *   Edit the `/etc/ssh/sshd_config` file (use `sudo nano` or `sudo vim`).
    *   Change the default SSH port from 22 to 2222 (Note: Ensure UFW rule matches!).
    *   Disable root login (`PermitRootLogin no`).
    *   Disable password authentication (`PasswordAuthentication no`) - *Requires setting up SSH keys first, which is outside the scope of this basic exercise. For now, just note this setting.*
    *   Set `MaxAuthTries` to 3.
    *   Restart the SSH service (`sudo systemctl restart sshd`).
3.  **Password Policies:**
    *   Install `libpam-pwquality` if not present (`sudo apt install libpam-pwquality`).
    *   Edit `/etc/pam.d/common-password` and modify the `pam_pwquality.so` line to require: minimum length 12, 1 uppercase, 1 lowercase, 1 digit (`minlen=12 ucredit=-1 lcredit=-1 dcredit=-1`).
    *   Edit `/etc/login.defs` and set `PASS_MAX_DAYS` to 60, `PASS_MIN_DAYS` to 1, `PASS_WARN_AGE` to 7.
    *   Apply the new aging policy to an existing user (e.g., your own user) using `sudo chage -M 60 -m 1 -W 7 [username]`.
4.  **Service Management:**
    *   Assume the `telnet` service (`inetutils-telnetd`) and `vsftpd` (FTP server) are installed and running but not required.
    *   Stop and disable both services using `systemctl`.
5.  **Permission Hardening:**
    *   Find any world-writable files in the `/home` directory.
    *   If any are found, remove the world-writable permission (`chmod o-w [filepath]`).
    *   Find any SUID binaries owned by users other than root in `/usr/bin` and `/usr/sbin`. List them if found. (Use `find ... -perm /4000 ...`)

## Deliverables

-   Output of `sudo ufw status verbose`.
-   Modified lines from `/etc/ssh/sshd_config`.
-   Modified lines from `/etc/pam.d/common-password` and `/etc/login.defs`.
-   Commands used to disable telnet and vsftpd.
-   Commands used to find world-writable files and list of any found/fixed.
-   List of any non-root SUID binaries found.

## Hints

-   Always back up configuration files before editing (`sudo cp file file.bak`).
-   Restart services after changing their configuration files.
-   Be careful changing the SSH port or disabling password authentication if you rely on it to connect.

*(This is a placeholder exercise.)*
