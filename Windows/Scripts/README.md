# Windows Security Scripts for CyberPatriot

This directory contains unique PowerShell scripts designed to aid in auditing, information gathering, and potentially safe automation tasks relevant to Windows security in CyberPatriot competitions. The focus is on reconnaissance and analysis rather than automated fixing, promoting an understanding of the underlying issues.

## Script Philosophy

-   **Information Gathering:** Scripts should primarily focus on collecting data (users, services, tasks, policies, etc.) in a clear format.
-   **Non-Destructive:** Scripts should avoid making changes to the system unless explicitly designed for a very specific, safe hardening task and clearly documented as such.
-   **Educational:** Scripts should be well-commented to help cadets understand *what* the script is doing and *why*.
-   **CyberPatriot Context:** Scripts should target information relevant to typical CyberPatriot vulnerabilities and forensic questions.

## Directory Structure (Example)

-   **Examples/**: Ready-to-use scripts for common tasks (e.g., `audit_users.ps1`, `check_services.ps1`, `find_startup_items.ps1`).
-   **Templates/**: Basic script structures or function libraries cadets can adapt.
-   **Solutions/**: (Optional) Scripts related to specific exercises found in `../Exercises/`.

## How to Use

1.  Transfer the desired script to the target Windows machine (competition VM).
2.  Open PowerShell **as Administrator**.
3.  Navigate to the script's directory using `cd`.
4.  Review the script code briefly to understand its actions.
5.  Set the execution policy if necessary for the current session:
    ```powershell
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process -Force
    ```
6.  Run the script:
    ```powershell
    .\script_name.ps1
    ```
7.  Carefully analyze the output. Use the information gathered to inform your manual remediation steps.

## Contribution

Develop new scripts for common CyberPatriot tasks (e.g., checking specific registry keys for persistence, auditing share permissions, finding large media files, comparing against a baseline configuration). Ensure scripts are well-commented, focus on information gathering, and are tested. Submit unique contributions via pull request.

---

*All scripts are unique and designed for CyberPatriot training. Always test scripts in a safe environment before using them in competition. Understand what a script does before running it.*
