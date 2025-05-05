# Linux Security Scripts for CyberPatriot

This directory contains unique Bash scripts designed to aid in auditing, information gathering, and potentially safe automation tasks relevant to Linux security (Ubuntu/Mint) in CyberPatriot competitions. The focus is on reconnaissance and analysis to inform manual remediation efforts.

## Script Philosophy

-   **Information Gathering:** Scripts should primarily focus on collecting data (users, groups, services, processes, network info, permissions, cron jobs, etc.) in a clear, readable format.
-   **Non-Destructive:** Scripts should avoid making changes to the system. Focus on reporting issues, not fixing them automatically.
-   **Educational:** Scripts should be well-commented (`#`) to help cadets understand *what* commands are being run and *why*. Use tools like `shellcheck` to ensure script quality.
-   **CyberPatriot Context:** Scripts should target information relevant to typical CyberPatriot vulnerabilities (e.g., world-writable files, SUID binaries, unauthorized users, common persistence locations) and forensic questions.

## Directory Structure (Example)

-   **Examples/**: Ready-to-use scripts for common tasks (e.g., `audit_users.sh`, `check_listening_ports.sh`, `find_suid_files.sh`, `check_cron.sh`).
-   **Templates/**: Basic script structures or function libraries cadets can adapt.
-   **Solutions/**: (Optional) Scripts related to specific exercises found in `../Exercises/`.

## How to Use

1.  Transfer the desired script to the target Linux machine (competition VM).
2.  Make the script executable:
    ```bash
    chmod +x script_name.sh
    ```
3.  Review the script code briefly using `cat` or `less` to understand its actions.
4.  Run the script (usually requires `sudo` for comprehensive system info):
    ```bash
    sudo ./script_name.sh
    ```
5.  Carefully analyze the output. Pipe output to `less` (`sudo ./script_name.sh | less`) or redirect to a file (`sudo ./script_name.sh > output.txt`) for easier review. Use the information gathered to inform your manual remediation steps.

## Contribution

Develop new scripts for common CyberPatriot tasks (e.g., checking PAM configuration snippets, auditing log files for specific events like failed logins, checking for common web vulnerabilities if applicable). Ensure scripts are well-commented, focus on information gathering, pass `shellcheck`, and are tested. Submit unique contributions via pull request.

---

*All scripts are unique and designed for CyberPatriot training. Always test scripts in a safe environment before using them in competition. Understand what a script does before running it.*
