# Core Cybersecurity Principles for CyberPatriot

Understanding these fundamental principles is essential for making sound security decisions during the CyberPatriot competition and justifying your actions. Apply these concepts to move beyond just following checklists towards strategic hardening and remediation. This guide is uniquely tailored to the CyberPatriot context.

## 1. Confidentiality
-   **Goal:** Ensure only authorized users/processes can access sensitive information. Prevent unauthorized disclosure.
-   **CyberPatriot Actions:**
    -   Set strong, unique passwords for all accounts.
    -   Remove unauthorized user accounts.
    -   Restrict file permissions (NTFS/Linux `chmod`) so only authorized users/groups can read sensitive files.
    -   Secure remote access (Configure SSH securely, disable Telnet, secure/disable RDP).
    -   Check for overly permissive network shares.
    -   Encrypt passwords in configurations (e.g., `service password-encryption` in Cisco).

## 2. Integrity
-   **Goal:** Protect data and system configurations from unauthorized modification or destruction. Ensure accuracy, trustworthiness, and non-repudiation.
-   **CyberPatriot Actions:**
    -   Use file integrity concepts (Baselining - compare current state to known good state using tools like Meld or script outputs).
    -   Check for unauthorized changes in critical configuration files (`/etc/passwd`, `/etc/sudoers`, `sshd_config`, registry run keys, `hosts` file).
    -   Restrict write permissions on files and directories.
    -   Use secure configurations for services to prevent unauthorized changes.
    -   Review audit logs for unauthorized change attempts (Policy Change events, file access).
    -   Remove malware or scripts that modify system files.

## 3. Availability
-   **Goal:** Ensure systems, services, and data are accessible to authorized users when needed. Prevent Denial of Service.
-   **CyberPatriot Actions:**
    -   **CRITICAL: Do NOT disable required services/users mentioned in the README.** This is a common way to lose points.
    -   Ensure required services (`httpd`, `sshd`, etc.) are running (`systemctl status`, `Get-Service`) and configured correctly.
