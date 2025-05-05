# Windows Security Basics Exercise

## Scenario

You have been given access to a Windows workstation that was recently used by an intern. Your task is to perform basic security checks and address any immediate issues found.

## Objectives

-   Identify and manage local user accounts.
-   Review basic password and lockout policies.
-   Identify and remove unauthorized or unnecessary software.
-   Check the status of Windows Firewall and Defender Antivirus.

## Tasks

1.  **User Account Review:**
    *   List all local user accounts.
    *   Identify any unauthorized or suspicious accounts (e.g., "test", "temp", "hacker").
    *   Disable the Guest account.
    *   Ensure the built-in Administrator account has a strong password (you may need to reset it).
    *   Check the membership of the Administrators group and remove any unauthorized users.
2.  **Basic Policy Check:**
    *   Open Local Security Policy (`secpol.msc`).
    *   Check the current settings for Minimum Password Length and Password Complexity. Are they adequate?
    *   Check the Account Lockout Threshold. Is it configured?
3.  **Software Audit:**
    *   Open Apps & Features (Settings > Apps).
    *   Identify and list any software that seems unauthorized or unnecessary for a standard workstation (e.g., games, peer-to-peer file sharing, hacking tools, multiple web browsers).
    *   (Simulated) Uninstall one piece of unauthorized software.
4.  **Basic Security Feature Check:**
    *   Check the status of Windows Defender Firewall for the Public and Private profiles. Is it enabled?
    *   Check the status of Windows Defender Antivirus. Is Real-time protection enabled?

## Deliverables

-   List of unauthorized users found and action taken.
-   List of unauthorized software identified.
-   Status of basic security policies and features checked.

## Hints

-   Use `net user`, `net localgroup Administrators`, `secpol.msc`, `services.msc`, `wf.msc`, and Settings.

*(This is a placeholder exercise. Content should be expanded with more specific details and potentially a corresponding VM setup.)*
