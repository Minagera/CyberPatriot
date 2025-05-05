# Cisco Configuration Scripts & Templates

This directory contains example configuration snippets and templates for common Cisco IOS hardening tasks relevant to CyberPatriot.

**Note:** Unlike Windows/Linux, full automation scripting isn't typically used directly on Cisco devices during CyberPatriot. These are primarily reference templates to copy/paste or adapt.

## Template Index

-   [**Basic_Hardening_Template.txt**](Basic_Hardening_Template.txt)
    *   Provides commands for hostname, enable secret, console/VTY passwords, banner, password encryption.
-   [**SSH_Configuration_Template.txt**](SSH_Configuration_Template.txt)
    *   Provides the sequence of commands to configure SSH access and disable Telnet.
-   [**Standard_ACL_Template.txt**](Standard_ACL_Template.txt)
    *   Shows example syntax for standard numbered and named ACLs.
-   [**Extended_ACL_Template.txt**](Extended_ACL_Template.txt)
    *   Shows example syntax for extended named ACLs filtering TCP/UDP ports.
-   [**Port_Security_Template.txt**](Port_Security_Template.txt)
    *   Provides commands for configuring basic switchport security.

## How to Use

1.  Review the template relevant to the task.
2.  Copy the commands.
3.  Paste them into the Cisco device CLI (usually in global configuration mode or interface configuration mode as appropriate).
4.  **Adapt the commands** with specific passwords, usernames, IP addresses, interface names, ACL numbers/names, etc., required by the scenario.
5.  Verify the configuration using `show` commands.
6.  **Save the configuration!** (`copy run start`)

## Contribution

Create new templates for other common configurations (e.g., VLAN setup, basic routing, NTP). Ensure templates are well-commented and clearly indicate where scenario-specific values need to be inserted.

---

*All templates are unique references designed for CyberPatriot training.*
