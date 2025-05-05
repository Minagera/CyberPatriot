# Linux Security Scripts for CyberPatriot (Bash)

This directory contains unique Bash scripts designed for security auditing and reconnaissance on Linux systems (primarily Ubuntu/Debian) during CyberPatriot competitions. **Scripts focus on safe information gathering to guide manual hardening efforts.**

**Disclaimer:** Understand each script before execution. Test thoroughly in practice VMs. Use scripts to speed up reconnaissance, not as a replacement for understanding. **Always prioritize the competition README over script output.**

## Scripting Philosophy for CyberPatriot

-   **Read-Only First:** Prioritize scripts that gather information without making changes. Use commands like `cat`, `ls`, `ss`, `ps`, `systemctl status`, `grep`, `find`, `awk`. Avoid commands like `rm`, `chmod`, `userdel` within audit scripts.
-   **Targeted Information:** Scripts should collect specific, relevant security data (users, services, ports, cron jobs, permissions, etc.).
-   **Baseline-Friendly Output:** Format output consistently (e.g., sorted lists, clear headers) to make comparison with `diff` tools (like Meld) easier. Use `echo` for headers. Redirect command output (`>`).
-   **Efficiency:** Automate repetitive checks to save time.
-   **Safety:** Avoid commands that could disrupt required services or violate competition rules. Run non-privileged commands where possible; use `sudo` only when necessary for specific commands (e.g., `sudo ss -tulpn`, `sudo find / -perm ...`).
-   **Clarity:** Comment scripts well to explain their purpose and commands used.

## Available Scripts (Examples - Create/Update as needed)

-   **`audit_users_sudo.sh`** (Placeholder - Create if missing)
    *   *Purpose:* Lists local users (from `/etc/passwd`), checks for UID 0 accounts, lists members of the `sudo` group, and checks `/etc/sudoers` and `/etc/sudoers.d/` for configurations.
    *   *Output:* Console output summarizing users, UID 0 accounts, and sudo configuration details. Requires `sudo` to read sudoers files accurately.
-   **`check_listening_services.sh`** (Placeholder - Create if missing)
    *   *Purpose:* Uses `ss` to list all listening TCP and UDP ports and the associated processes. Helps identify potentially unnecessary network services.
    *   *Output:* Formatted list of listening ports, protocols, and process names/PIDs. Requires `sudo` for full process information.
-   **`find_suspicious_files.sh`** (Placeholder - Create if missing)
    *   *Purpose:* Searches for common suspicious file types or locations, such as world-writable files/directories, SUID/SGID binaries in non-standard locations, and potentially large media files (if specified).
    *   *Output:* Lists potentially suspicious files/directories found. Requires `sudo` for full filesystem scan.
-   **`check_common_persistence_linux.sh`** (Placeholder - Create if missing)
    *   *Purpose:* Checks common Linux persistence locations: user crontabs, system cron directories (`/etc/cron.*`, `/etc/crontab`), enabled `systemd` services/timers (user/system), and common shell startup files.
    *   *Output:* Lists entries found in common persistence locations. Requires `sudo` for system-level checks.

## How to Use

1.  Transfer the script(s) to the target Linux VM.
2.  Make the script executable: `chmod +x script_name.sh`
3.  Run the script. Some scripts may require `sudo` for full functionality: `./script_name.sh` or `sudo ./script_name.sh`
4.  **Analyze the output carefully.** Use the findings to inform your investigation and hardening actions based on the competition README.

## Contribution

Develop new scripts focusing on:
-   **Targeted Auditing:** Checking specific configurations (e.g., SSH settings, PAM password policies, UFW rules), searching logs for specific event patterns.
-   **Safe Information Gathering:** Avoid scripts that make changes. Focus on reporting system state.
-   **Clarity & Comments:** Ensure scripts are well-commented. Use tools like `shellcheck` to validate syntax and suggest improvements.
-   **Uniqueness:** Tailor scripts for CyberPatriot scenarios, avoiding direct copies of generic online scripts.

---
*All scripts are unique and designed for Grissom JROTC CyberPatriot training. Test thoroughly before use.*

## Directory Structure

- **Templates/**  
  Script templates for cadets to modify and use in exercises.  
  *Examples:*  
  - `user_management_template.sh`: Add/remove users, enforce password policies  
  - `service_audit_template.sh`: List and check running services  
  - `firewall_setup_template.sh`: Basic UFW/iptables configuration

- **Examples/**  
  Complete, ready-to-run scripts demonstrating best practices.  
  *Examples:*  
  - `secure_user_add.sh`: Adds users with secure defaults  
  - `audit_services.sh`: Reports on enabled/disabled services  
  - `find_world_writable.sh`: Finds world-writable files

- **Solutions/**  
  Mentor-only solution scripts for exercise scenarios.  
  *Examples:*  
  - `linux_challenge_solution.sh`: Full remediation for a challenge VM  
  - `automated_hardening_solution.sh`: Script that applies all required hardening steps

## How to Use

- Start with a template, adapt it to your scenario, and test in a VM.
- Review example scripts to learn scripting techniques and best practices.
- After attempting an exercise, compare your script to the mentor solution for feedback.

## Tips

- Always test scripts in a safe environment before using in competition.
- Document what each script does and any changes it makes.
- Use scripts to save time and reduce manual errors during CyberPatriot rounds.

*All scripts are unique and tailored for CyberPatriot training. Contributions are welcome!*

## Using These Scripts

Scripts in this directory are meant to be:

1. **Educational**: They demonstrate security concepts and automation techniques
2. **Customizable**: Templates can be modified for specific scenarios
3. **Practical**: They solve real security problems encountered in CyberPatriot

## Script Categories

The scripts are organized into several categories:

### Auditing Scripts
These scripts analyze system security and identify issues:
- System security auditing
- User account auditing
- File permission checks
- Network security analysis

### Hardening Scripts
These scripts implement security controls:
- System hardening
- Service security configuration
- User account security
- Firewall configuration

### Monitoring Scripts
These scripts provide ongoing security checks:
- Log monitoring
- File integrity checks
- Suspicious activity detection
- Security reporting

## Best Practices

When using or modifying these scripts:

1. **Always read and understand scripts before running them**
2. **Test scripts in a controlled environment before using in competition**
3. **Make scripts idempotent (safe to run multiple times)**
4. **Add error handling and logging**
5. **Document all changes made by scripts**
6. **Include clear comments within scripts**

## Templates vs. Examples

- **Templates**: Located in `Templates/`, these are starting points for cadets to build their own scripts.
- **Examples**: Located in `Examples/`, these show completed scripts for reference.
- **Solutions** are reference implementations for mentors (not to be shared with cadets until after exercises)

## Important Note

During CyberPatriot competitions, automated scripts should be used cautiously. While scripting is a valuable skill to learn, the competition emphasizes understanding security concepts. Cadets should know how to perform security tasks manually before automating them.

## Available Scripts

### System Security Audit Script
A comprehensive security scanner that:
- Checks user account security
- Audits system services
- Verifies file permissions
- Examines network security
- Reviews security software configurations
- Searches for suspicious files
- Generates a detailed report with remediation recommendations

### User Account Management Script
Automates user security tasks:
- Lists all user accounts with details
- Identifies suspicious or unauthorized accounts
- Checks for proper password policies
- Verifies group memberships
- Examines sudo access
- Suggests user security improvements

### Service Hardening Script
Secures system services:
- Disables unnecessary services
- Configures secure service parameters
- Sets up secure SSH configuration
- Implements proper service permissions
- Establishes secure defaults

### System Hardening Script
Applies system-wide security controls:
- Configures kernel security parameters
- Sets up secure filesystem mounts
- Implements firewall rules
- Configures security-related software
- Enables system auditing

## Example Scripts

- Add and secure users in bulk
- Audit running services and open ports
- Apply recommended file permissions
- Configure and test UFW firewall rules
- Search for world-writable files and SUID binaries

## Contributing

If you develop additional scripts or improve existing ones:

1. Follow the established format and style
2. Include clear comments and documentation
3. Test thoroughly before submitting
4. Add appropriate error handling
5. Submit a pull request to contribute back to the repository

## Additional Resources

- [Bash Scripting Guide](https://tldp.org/LDP/abs/html/)
- [Linux Security Hardening Guide](https://linuxsecurity.expert/security-tools/linux-security-hardening-guide/)
- [CIS Benchmarks for Linux](https://www.cisecurity.org/benchmark/ubuntu_linux/)
- [SANS Linux Security Checklists](https://www.sans.org/security-resources/posters/securing-linux-cheat-sheet/55/download)
