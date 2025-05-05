# Week 8: Scripting Introduction & Baselining Concepts

## Learning Objectives

By the end of this week, cadets will be able to:
-   Write basic PowerShell scripts for information gathering on Windows.
-   Write basic Bash scripts for information gathering on Linux.
-   Understand the concept of baselining for identifying system changes.
-   Use scripting outputs for simple baseline comparisons.
-   Use tools like Meld (or equivalent diff tools) to compare baseline text files.

## Topics Covered

-   **PowerShell Basics (Windows):**
    -   Execution Policy (`Set-ExecutionPolicy RemoteSigned -Scope Process`).
    -   Basic syntax: Variables (`$var`), Comments (`#`), Cmdlets (`Verb-Noun`), Piping (`|`).
    -   Common Cmdlets for Info Gathering: `Get-LocalUser`, `Get-LocalGroupMember`, `Get-Service`, `Get-Process`, `Get-NetIPConfiguration`, `Get-ScheduledTask`, `Get-ItemProperty` (for Registry Run keys).
    -   Output Formatting: `Format-Table`, `Format-List`, `Out-File`.
    -   Simple Script Structure: Shebang (optional), comments, commands.
    -   Example Script: Gather user list, admin group members, running services into a text file.
-   **Bash Scripting Basics (Linux):**
    -   Shebang (`#!/bin/bash`).
    -   Making scripts executable (`chmod +x script.sh`).
    -   Basic syntax: Variables (`var=value`, `$var`), Comments (`#`), Commands, Piping (`|`).
    -   Common Commands for Info Gathering: `whoami`, `hostname`, `ip a`, `ss -tulpn`, `ps aux`, `systemctl list-units --type=service`, `cat /etc/passwd`, `grep sudo /etc/group`, `crontab -l`, `find`.
    -   Redirecting Output: `>` (overwrite), `>>` (append).
    -   Simple Script Structure: Shebang, comments, commands.
    -   Example Script: Gather hostname, IP info, listening ports, running services into a text file.
-   **Baselining Concepts:**
    -   Definition: Capturing the known state of a system (or parts of it) at a specific point in time.
    -   Purpose in CyberPatriot: Quickly identify unauthorized changes made to competition images by comparing the current state to a baseline (either a clean image or an initial scan).
    -   What to Baseline: User accounts, group memberships, running services, listening ports, scheduled tasks/cron jobs, startup items (Registry Run keys), critical configuration files (`sshd_config`, `hosts`), installed software, file permissions (SUID/world-writable).
-   **Using Scripts for Baselining:**
    -   Run info-gathering scripts on a clean VM to create baseline output files (`baseline_users.txt`, `baseline_services.txt`, etc.).
    -   Run the *same* scripts on the competition image *at the start*.
    -   Compare the output files.
-   **Using Diff Tools (Meld):**
    -   Introduction to Meld (or `diff`, `vimdiff`, VS Code compare).
    -   Opening two files (baseline vs. current state) for comparison.
    -   Identifying differences (added lines, deleted lines, modified lines).
    -   Applying this to compare script outputs or configuration files.

## Activities/Exercises

-   **Lab 1 (PowerShell):** Write a simple PowerShell script to list enabled local users and output to a file. Run it. Add commands to list admin group members and running services.
-   **Lab 2 (Bash):** Write a simple Bash script to display hostname, IP address, and listening ports, outputting to a file. Run it. Add commands to list running services and sudo group members.
-   **Lab 3 (Baselining):** Run the scripts from Lab 1 & 2 on clean VMs to create baseline files. Run them on practice compromised VMs (`../VM-Setup/`).
-   **Lab 4 (Meld):** Install Meld (or use built-in diff). Compare the baseline output files with the compromised system output files from Lab 3. Identify the differences (e.g., extra users, different services running). Compare `/etc/passwd` or `/etc/ssh/sshd_config` from baseline vs. compromised.
-   **Exercise:** [Unique Scripting & Baselining Exercise](../Exercises/Cross-Platform/Scripting_Baselining/README.md) - Write simple audit scripts for both Win/Lin, generate baseline outputs, run on compromised images, and use Meld/diff to identify specific unauthorized changes listed in a scenario.

## Assessment

-   Completion and successful execution of basic PowerShell and Bash scripts.
-   Ability to use Meld/diff to identify differences between text files.
-   Completion of [Unique Scripting & Baselining Exercise](../Exercises/Cross-Platform/Scripting_Baselining/README.md).
-   (Optional) Quiz covering basic scripting commands and baselining concepts.

## Resources

-   [Unique Windows Scripting Guide](../Windows/Scripts/README.md) (and potentially a new Basic PS guide)
-   [Unique Linux Scripting Guide](../Linux/Scripts/README.md) (and potentially a new Basic Bash guide)
-   [Unique Baselining Guide using Meld](../Meld/README.md)
-   PowerShell `Get-Help` command.
-   Bash `man` pages.
-   Meld website/documentation.

---
*This weekly plan is uniquely designed for the Grissom JROTC CyberPatriot program.*
