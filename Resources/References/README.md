# CyberPatriot Reference Sheets

This directory contains unique quick-reference materials ("cheat sheets") summarizing commands, file paths, tools, and configurations commonly used for Windows, Linux, and Cisco security tasks within the CyberPatriot competition.

## Available Reference Sheets

-   [**Windows_Security_Reference.md**](Windows_Security_Reference.md)
    *   **Content:** Common commands (`net user`, `net localgroup`, `ipconfig`, `tasklist`, `schtasks`, PowerShell equivalents like `Get-LocalUser`, `Get-Service`, `Get-NetIPConfiguration`), key GUI tools (`secpol.msc`, `services.msc`, `wf.msc`, `eventvwr.msc`, `lusrmgr.msc`, `taskschd.msc`), important registry key locations (Run keys), common Event IDs (4624, 4625).
-   [**Linux_Security_Reference.md**](Linux_Security_Reference.md)
    *   **Content:** Essential CLI commands (`ls`, `cd`, `grep`, `find`, `chmod`, `chown`, `useradd`, `passwd`, `systemctl`, `ufw`, `ss`, `ps`, `journalctl`), important file paths (`/etc/passwd`, `/etc/shadow`, `/etc/sudoers`, `/etc/ssh/sshd_config`, `/var/log/`, `/etc/pam.d/common-password`, `/etc/login.defs`), common service names.
-   [**Cisco_IOS_Reference.md**](Cisco_IOS_Reference.md)
    *   **Content:** Key IOS commands for different modes (enable, configure terminal, interface, line), basic hardening sequence (hostname, enable secret, passwords, banner, SSH setup), ACL syntax examples (standard, extended), common `show` commands (`show run`, `show ip int brief`, `show access-lists`).

*(Note: Ensure these placeholder reference files exist or are created.)*

## How to Use

-   Print these sheets or keep them open digitally during practice and competition for **fast lookup**.
-   Use them to quickly recall syntax or file locations you haven't fully memorized yet.
-   **Do not rely solely on these sheets.** The goal is to internalize the commands and concepts through practice. These are aids, not replacements for knowledge.
-   Add your own notes or frequently used commands as you learn.

## Contribution

Suggest additions of useful commands, common event IDs, important file paths, configuration snippets, or tool flags relevant to CyberPatriot tasks. Ensure accuracy, clarity, and uniqueness. Focus on items frequently needed under time pressure. Submit via pull request.

---
*These reference sheets are unique summaries tailored for CyberPatriot cadets. Use them wisely to enhance your speed and accuracy.*
