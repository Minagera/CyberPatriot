# User Security Challenge (Cross-Platform)

## Scenario

You are given access to both a Windows workstation and a Linux server that share some user accounts (conceptually). You need to audit user accounts, enforce strong password policies, and remove unauthorized access across both systems according to a unified policy.

## Objectives

-   Apply user auditing techniques on both Windows and Linux.
-   Configure password policies consistently across platforms.
-   Identify and remove unauthorized users and group memberships on both OSs.
-   Practice cross-platform security consistency.

## Environment

-   Requires one Windows VM (e.g., from `../VM-Setup/Windows/`)
-   Requires one Linux VM (e.g., from `../VM-Setup/Linux/`)
-   Assume a shared (fictional) user directory or policy requirements apply to both.

## Policy Requirements (Example)

-   **Authorized Users:** `admin_corp`, `jdoe_hr`, `psmith_dev`
-   **Password Policy:** Min Length 12, Complexity Enabled (Win) / Equivalent (Lin), Max Age 60 days.
-   **Admin Groups:** Only `admin_corp` should be in `Administrators` (Win) and `sudo` (Lin).
-   **Guest/Default Accounts:** Must be disabled.

## Tasks

1.  **Windows Audit & Remediation:**
    *   Log into the Windows VM.
    *   List all local users. Identify any not in the authorized list.
    *   List members of the `Administrators` group. Identify any not authorized.
    *   Check the Guest account status.
    *   Check current password policy settings (`secpol.msc`).
    *   **Actions:** Remove unauthorized users, remove unauthorized admins from the group, disable Guest, configure password policy to meet requirements. Document actions.
2.  **Linux Audit & Remediation:**
    *   Log into the Linux VM.
    *   List all users (`/etc/passwd`). Identify any not in the authorized list (excluding system accounts).
    *   List members of the `sudo` group. Identify any not authorized.
    *   Check current password aging policy (`/etc/login.defs`, `chage -l [user]`).
    *   Check password complexity settings (`/etc/pam.d/common-password`).
    *   **Actions:** Remove unauthorized users (`userdel -r`), remove unauthorized users from `sudo` group (`deluser user sudo`), configure password aging (`login.defs`, `chage`), configure complexity (`common-password`). Document actions.
3.  **Password Changes:**
    *   Change passwords for all authorized users (`admin_corp`, `jdoe_hr`, `psmith_dev`) on *both* platforms to new, strong passwords that meet the policy.

## Deliverables

-   List of unauthorized users/group members removed from Windows.
-   Confirmation of Windows password policy settings.
-   List of unauthorized users/group members removed from Linux.
-   Confirmation of Linux password policy settings (aging and complexity).
-   Confirmation that authorized user passwords were changed on both platforms.

## Hints

-   Use `net user`, `net localgroup`, `secpol.msc` on Windows.
-   Use `cat /etc/passwd`, `grep sudo /etc/group`, `userdel`, `deluser`, `nano /etc/login.defs`, `nano /etc/pam.d/common-password`, `passwd`, `chage` on Linux.
-   Keep a consistent change log.

*(This is a placeholder exercise. Requires corresponding VMs and potentially more specific user overlaps or discrepancies.)*
