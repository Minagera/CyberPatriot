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
    -   Configure firewalls (UFW, Windows Firewall, Cisco ACLs) carefully to allow necessary traffic while blocking malicious traffic. Don't accidentally block required access.
    -   Avoid making risky configuration changes that could crash the system or a critical service.
    -   Ensure sufficient resources (less applicable in CP VMs, but relevant conceptually).
    -   Address issues causing service crashes (check logs).

## 4. Defense in Depth
-   **Goal:** Implement multiple layers of security controls (technical, administrative). If one layer fails, others provide protection. Avoid single points of failure.
-   **CyberPatriot Actions:**
    -   Don't rely on just one fix. Combine multiple controls:
        -   Strong passwords **AND** account lockout policies.
        -   Firewall rules **AND** service hardening **AND** removing unnecessary services.
        -   Antivirus **AND** user permissions **AND** UAC (Windows).
        -   Secure SSH config **AND** firewall rules **AND** strong user passwords (Linux).
    -   Apply security at different levels: Network (Firewall/ACLs), OS (Policies, Permissions), Application (Service Config).

## 5. Least Privilege
-   **Goal:** Grant users, processes, and services only the minimum permissions necessary to perform their required functions.
-   **CyberPatriot Actions:**
    -   Remove users from the Administrators/sudo group unless explicitly required and authorized. Assign standard user roles where possible.
    -   Configure service accounts (if applicable) to run with minimal necessary privileges.
    -   Check file/share permissions: Remove `Everyone` or `Authenticated Users` / `Users` / `other` write/full control access unless absolutely necessary. Grant access only to specific, required users/groups.
    -   Review `sudoers` rules to ensure users can only run specific commands needed, not unrestricted `ALL`.
    -   Review User Rights Assignment (Windows) / Capabilities (Linux - advanced) to limit powerful rights.

## 6. Separation of Duties
-   **Goal:** Divide critical tasks among multiple people or roles to prevent fraud, errors, or abuse of power by a single entity.
-   **CyberPatriot Relevance:** While less directly applicable to *cadet actions* within a team, it underlies OS design principles. Understand *why* distinct admin/user roles exist and why giving one user account god-like privileges everywhere is inherently risky. Reinforces the principle of least privilege.

## 7. Need to Know
-   **Goal:** Limit access to specific information based on job requirements or authorization, even for users with the same general privilege level. Complements Least Privilege.
-   **CyberPatriot Actions:** Primarily relates to file and directory permissions. Ensure users in one simulated department (if applicable) cannot access files of another unless authorized by the scenario/README. Use groups effectively to manage access to shared resources.

## 8. Security Controls (Types)
-   **Preventive:** Stop incidents before they happen. (Firewall rules, strong passwords, permissions, disabling services, hardening configs). **CyberPatriot primary focus.**
-   **Detective:** Identify incidents when or after they occur. (Audit logs, Antivirus alerts, IDS/IPS - less common in CP setup, reviewing logs for IOCs). **Important for Forensics.**
-   **Corrective:** Remediate incidents or limit damage. (Removing malware, fixing misconfigurations, removing persistence). **CyberPatriot primary focus.**
-   **Deterrent:** Discourage attackers. (Warning banners).
-   **Compensating:** Alternative control when a primary control isn't feasible. (Less relevant in CP).

## 9. Risk Assessment (Simplified for CP)
-   **Goal:** Identify potential threats/vulnerabilities, assess their likely impact in the CP context (point loss, system compromise), and prioritize mitigation.
-   **CyberPatriot Actions:**
    -   Prioritize fixing vulnerabilities mentioned **in the README** or related to **forensic questions**.
    -   Address issues granting **admin/root access** first (unauthorized sudoers/admins, weak root/admin passwords).
    -   Fix easily exploitable **remote services** (Telnet, insecure FTP, unauthenticated web access).
    -   Address **persistence mechanisms** early.
    -   Balance fixing vulnerabilities with maintaining **availability** of required services.

## 10. Security Compliance (Simplified for CP)
-   **Goal:** Adhere to relevant rules, policies, and standards.
-   **CyberPatriot Actions:**
    -   **Follow the competition README and official Rules Book strictly.** These are your primary compliance documents.
    -   Apply security best practices (like those in checklists and guides) **UNLESS** contradicted by the README.
    -   **Document actions taken** (Change Log) to demonstrate compliance and aid troubleshooting.

---
*Apply these unique principles in every CyberPatriot scenario for maximum points and real-world readiness! Justify your actions based on these concepts.*
