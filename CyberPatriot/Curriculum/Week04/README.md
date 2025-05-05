# Week 4: Core Security Principles & User Account Security

## Learning Objectives

By the end of this week, cadets will be able to:
-   Explain the CIA Triad (Confidentiality, Integrity, Availability) in the context of CyberPatriot.
-   Explain the Principle of Least Privilege and its importance.
-   Describe Defense in Depth as a security strategy.
-   Implement basic user account security policies in Windows (Password Policy, Account Lockout).
-   Implement basic user account security policies in Linux (Password Aging, Complexity via PAM basics).
-   Secure user accounts by removing unauthorized users, disabling unnecessary accounts (Guest), and managing group memberships (Administrators/sudo).

## Topics Covered

-   **Core Security Principles:**
    -   Confidentiality (Preventing unauthorized disclosure)
    -   Integrity (Preventing unauthorized modification)
    -   Availability (Ensuring access for authorized users - *critical* for CP required services)
    -   Defense in Depth (Layered security)
    -   Least Privilege (Minimum necessary permissions)
-   **Windows User Account Security:**
    -   Review: User vs. Admin accounts, `lusrmgr.msc`.
    -   Password Policy (`secpol.msc` -> Account Policies -> Password Policy): Complexity, Length, History, Age.
    -   Account Lockout Policy (`secpol.msc` -> Account Policies -> Account Lockout Policy): Threshold, Duration, Counter Reset.
    -   Identifying and Removing Unauthorized Users (`net user <user> /delete`, `lusrmgr.msc`).
    -   Disabling Accounts: The built-in Guest account (SID S-1-5-32-546).
    -   Group Management: Checking/modifying Administrators, Remote Desktop Users groups (`lusrmgr.msc`, `net localgroup Administrators`). Importance of removing unauthorized members.
-   **Linux User Account Security:**
    -   Review: Standard vs. root, `sudo`, `/etc/passwd`, `/etc/shadow`, `/etc/group`.
    -   Password Aging: `chage` command (viewing and setting expiry). Configuration in `/etc/login.defs`.
    -   Password Complexity (Introduction): Role of PAM (`/etc/pam.d/common-password`), `pam_pwquality` module (mention `minlen`, `dcredit`, `ucredit`, `ocredit`, `lcredit`). Installation (`sudo apt install libpam-pwquality`).
    -   Identifying and Removing Unauthorized Users (`sudo userdel -r <user>`).
    -   Disabling Accounts (`sudo passwd -l <user>`, `sudo usermod -L <user>`).
    -   Group Management: Checking/modifying `sudo` (or `wheel`) group (`grep sudo /etc/group`, `sudo deluser <user> sudo`). Importance of removing unauthorized members.

## Activities/Exercises

-   **Discussion:** Discuss the CIA triad with examples relevant to CyberPatriot (e.g., Availability - keeping a required web server running). Discuss Least Privilege - why shouldn't every user be an admin?
-   **Lab 1 (Windows):** Configure Password Policy and Account Lockout Policy in `secpol.msc`. Create a test user, set a weak password, observe complexity enforcement. Lock out the account.
-   **Lab 2 (Linux):** Use `chage` to view/set password expiry for a user. Edit `/etc/login.defs` (show relevant settings). Install `libpam-pwquality` and edit `common-password` to enforce basic complexity (e.g., min length). Test password changes.
-   **Lab 3 (Win/Lin):** Practice identifying and removing unauthorized users and group members. Disable the Guest account (Windows) or lock an unused account (Linux).
-   **Exercise:** [Unique User Account Security Exercise](../Exercises/Cross-Platform/User_Security/README.md) - Given scenarios on both Windows and Linux VMs, enforce password policies, remove unauthorized users/groups, and disable accounts according to instructions.

## Assessment

-   Participation in discussions and labs.
-   Completion of [Unique User Account Security Exercise](../Exercises/Cross-Platform/User_Security/README.md).
-   [Unique User Account Security Quiz](../Quizzes/Quiz-Files/User_Account_Security_Quiz.md)

## Resources

-   [Unique Core Security Principles Guide](../Resources/Core_Security_Principles.md)
-   [Unique Windows User Management Guide](../Windows/Guides/Basic/README.md) (Password Policy, Lockout, User/Group sections)
-   [Unique Linux User Management Guide](../Linux/Guides/Basic/README.md) (Password Aging, PAM Intro, User/Group sections)
-   `secpol.msc` documentation (Windows)
-   `pam.d`, `login.defs`, `chage` man pages (Linux)

---
*This weekly plan is uniquely designed for the Grissom JROTC CyberPatriot program.*
