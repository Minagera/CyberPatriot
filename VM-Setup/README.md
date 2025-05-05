# CyberPatriot VM-Setup Directory

This directory provides unique scripts and documentation for creating compromised virtual machine environments (Windows, Linux) and Cisco Packet Tracer scenarios suitable for realistic CyberPatriot incident response training.

**Goal:** To simulate the initial state of a CyberPatriot competition image, complete with vulnerabilities, persistence mechanisms, and forensic artifacts, allowing cadets to practice the full cycle of identification, remediation, hardening, and documentation.

## Directory Structure

-   [**Windows/**](Windows/README.md)
    *   Contains the `enterprise-workstation-setup.ps1` PowerShell script and a detailed `README.md` explaining how to use it to set up a compromised Windows VM (Win 10/11). Focuses on common workstation vulnerabilities, persistence, and forensic clues.
-   [**Linux/**](Linux/README.md)
    *   Contains the `corporate-server-breach.sh` Bash script and a detailed `README.md` explaining how to use it to set up a compromised Linux VM (Ubuntu 22.04). Focuses on server misconfigurations, unauthorized access, persistence, and forensic artifacts.
-   [**Cisco/**](Cisco/README.md)
    *   Contains Packet Tracer (`.pkt`) files and a `README.md` describing network scenarios designed for practicing Cisco device hardening, ACL implementation, and troubleshooting in a competition-like context.

## Usage Instructions (General)

1.  **Choose your platform** (Windows, Linux, or Cisco).
2.  **Navigate to the platform subdirectory** (e.g., `VM-Setup/Windows/`).
3.  **Read the `README.md`** in that subdirectory for detailed setup steps specific to that platform and scenario.
4.  **Prepare a clean base VM** of the appropriate OS (Win 10/11 Pro/Enterprise or Ubuntu 22.04 LTS recommended). **Snapshot the clean, updated base state** before running any setup scripts. This "Clean Snapshot" is crucial for reuse.
5.  **Transfer the setup script** (`.ps1` or `.sh`) to the clean VM. For Cisco, download the `.pkt` file.
6.  **Run the provided setup script** **as Administrator/root** on the clean VM, following instructions in the platform-specific README.
7.  **Review script output and logs** (e.g., `C:\setup_log_cyberpatriot.txt` or `/var/log/cyberpatriot_setup.log`) for successful completion or errors.
8.  **Shut down the VM** after the script finishes successfully.
9.  **Snapshot the VM** in its newly compromised state (e.g., "Windows Compromised - Scenario A - Initial State"). **This is the snapshot to distribute to cadets for practice.** Label snapshots clearly.
10. For Cisco, simply distribute the starting `.pkt` file from the `Cisco/` directory.

## Customization

-   The platform-specific READMEs provide guidance on customizing the scripts (`.ps1`, `.sh`) to modify vulnerabilities, users, passwords, persistence methods, or forensic clues.
-   Instructors can create multiple scenario variations by tweaking the scripts and saving different snapshots.
-   Ensure customizations maintain realism and align with CyberPatriot's scope.

## Troubleshooting

-   Refer to the platform-specific READMEs for troubleshooting tips related to script execution or VM setup.
-   Ensure base VMs meet prerequisites (OS version, updates, required features).
-   Verify scripts are run with appropriate privileges (Administrator/root).

## Contribution

-   If you create new, unique scenarios (scripts or `.pkt` files) or significantly improve existing ones, please contribute them back via pull request.
-   Ensure any new scenarios align with the CyberPatriot incident response focus, introduce realistic vulnerabilities/misconfigurations, and include clear documentation (a dedicated README).
-   All files must be unique and tailored for CyberPatriot training.

---

*This index and all referenced files are unique and designed for CyberPatriot cadet training. Use these tools to practice realistic incident response scenarios.*
