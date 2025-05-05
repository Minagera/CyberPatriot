# Linux Security Checklist for CyberPatriot (Ubuntu/Mint Focus)

**Reminder: This checklist is a guide for general hardening. Always prioritize the specific instructions, requirements, authorized users/services, and forensic questions found in the official Competition README file provided with the image.**

## CRITICAL FIRST STEP: Read the Competition README File!
Before making any changes, thoroughly read the README file provided with the competition image. It contains:
- Required services/daemons that must remain operational (e.g., Apache, SSH).
- User accounts that must be maintained or have specific roles.
- Prohibited actions (e.g., "Do not remove user 'svc_account'").
- Answers to forensics questions (worth points!).
- Competition-specific requirements that override general security practices.

**README INSTRUCTIONS TRUMP THIS CHECKLIST!**

---

## User Account Management

### Critical User Settings
- [ ] **README Check:** Identify authorized users and required group memberships (sudo, service accounts, etc.).
- [ ] Change all user passwords to strong, unique passwords (unless README prohibits).
  ```bash
  sudo passwd username
  # Consider scripting for multiple users if allowed/efficient
  ```
- [ ] Remove unauthorized user accounts (verify against README first!).
  ```bash
  sudo userdel -r username # -r removes home directory
  ```
- [ ] Check for users with UID 0 (root privileges). Investigate any non-`root` users with UID 0.
  ```bash
  sudo awk -F: '($3 == 0) {print}' /etc/passwd
  ```
- [ ] Check sudo access. Review `/etc/sudoers` and files in `/etc/sudoers.d/`. Use `sudo visudo` for safe editing.
  ```bash
  sudo cat /etc/sudoers
  sudo ls /etc/sudoers.d/
  grep -Po '^sudo.+:\K.*$' /etc/group # Check sudo group members
  ```
- [ ] Remove unauthorized users/groups from sudo access (e.g., `sudo` group).
  ```bash
  sudo deluser username sudo
  # Or edit sudoers file using visudo to remove specific entries
  ```
- [ ] Disable (lock) user accounts that should not be active but might be needed later or are specified in README.
  ```bash
  sudo passwd -l username
  # Or: sudo usermod -L username
  # To re-enable: sudo passwd -u username / sudo usermod -U username
  ```
- [ ] Check `/etc/passwd` for users with non-standard shells (e.g., `/bin/false`, `/usr/sbin/nologin` are often okay for service accounts, but check for unexpected shells).
- [ ] Check `/etc/shadow` for accounts with no password (`!*` or `*` usually okay, empty field is bad) or weak hashes (though cracking isn't usually feasible/allowed).

### Password Policy (`/etc/login.defs` and PAM)
- [ ] Configure password aging in `/etc/login.defs` (edit with `sudo nano` or `sudo vim`):
    - `PASS_MAX_DAYS 90` (or less, e.g., 60)
    - `PASS_MIN_DAYS 1` (or more)
    - `PASS_WARN_AGE 7` (or 14)
- [ ] Configure password complexity via PAM (requires `libpam-pwquality` package):
    - `sudo apt update && sudo apt install libpam-pwquality` (if allowed/needed)
    - Edit `/etc/pam.d/common-password` (use `sudo nano`):
      - Add/modify line for `pam_pwquality.so`: `password requisite pam_pwquality.so retry=3 minlen=12 difok=3 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1` (Adjust minlen, credits as desired - e.g., 14 chars, require upper, lower, digit, other).
- [ ] Configure password history via PAM:
    - Edit `/etc/pam.d/common-password`:
      - Add `remember=5` to the line containing `pam_unix.so`: `password sufficient pam_unix.so sha512 shadow nullok remember=5` (Ensure `remember=X` is added/modified).

---

## System Security

### Updates
- [ ] **README Check:** Verify if updating is allowed/required.
- [ ] Apply updates if allowed and network/time permit.
  ```bash
  sudo apt update
  sudo apt upgrade -y
  ```

### Secure Boot / Kernel Settings (Less Common, Advanced)
- [ ] Check kernel parameters (`sysctl -a`). Look for insecure defaults if investigating deeply (e.g., related to networking). Generally, don't change unless directed or very knowledgeable.
- [ ] Check `/etc/sysctl.conf` or files in `/etc/sysctl.d/` for custom settings.

### Logging
- [ ] Ensure logging service (`rsyslog` or `journald`) is running.
  ```bash
  sudo systemctl status rsyslog # If applicable
  sudo systemctl status systemd-journald
  ```
- [ ] Review key logs for suspicious activity based on README/forensics:
    - `journalctl` (general system logs, use flags like `-u ssh`, `-p err`, `--since "1 hour ago"`)
    - `/var/log/auth.log` (Authentication attempts, sudo usage)
    - `/var/log/syslog` (General system messages)
    - `/var/log/ufw.log` (Firewall activity)
    - Application-specific logs (e.g., `/var/log/apache2/error.log`)

### Auditing (Advanced)
- [ ] Install and configure `auditd` if deep forensic analysis is needed and allowed (less common for basic hardening).

---

## Services and Applications

### Disable Unnecessary Services (`systemctl`)
- [ ] **README Check:** Identify required services/daemons (e.g., `apache2`, `sshd`, `mysql`).
- [ ] List running services and listening ports.
  ```bash
  sudo systemctl list-units --type=service --state=running
  sudo ss -tulpn # Show listening TCP/UDP ports and processes
  ```
- [ ] Disable unnecessary/insecure services (e.g., `telnetd`, `vsftpd` if not needed, `rpcbind`, `nfs-server`, web server if not required).
  ```bash
  sudo systemctl disable --now service-name
  # Example: sudo systemctl disable --now telnet.socket
  ```

### Secure Running Services
- [ ] **SSH (`/etc/ssh/sshd_config`):**
    - `PermitRootLogin no`
    - `PasswordAuthentication no` (If using keys, otherwise ensure strong passwords)
    - `AllowUsers user1 user2` (If specific users allowed)
    - `Protocol 2`
    - `UsePAM yes`
    - Check `Port` (usually 22, change only if README allows/instructs)
    - Restart SSH service after changes: `sudo systemctl restart sshd`
- [ ] **Web Server (Apache/Nginx):** Check configuration for security headers, disable directory listing, ensure proper permissions on web root (`/var/www/html`), remove default/test pages. (More advanced topic).
- [ ] Other services: Review configuration files in `/etc/` for required services, looking for insecure settings.

### Remove Unauthorized Software (`apt`)
- [ ] **README Check:** Identify required applications.
- [ ] List installed packages (`apt list --installed`). Look for suspicious/unauthorized software (hacking tools like `nmap`, `john`, `hydra`; games; P2P clients; remote access tools like `vncserver`).
- [ ] Remove unauthorized packages.
  ```bash
  sudo apt remove package-name
  sudo apt purge package-name # Also removes config files
  sudo apt autoremove # Remove unused dependencies
  ```

---

## File System Security

### Permissions
- [ ] Find and fix world-writable files/directories (excluding `/tmp`, `/var/tmp`, sticky bit directories unless suspicious).
  ```bash
  sudo find / -path /proc -prune -o -path /sys -prune -o -type d -perm -0002 -exec ls -ld {} \; # Directories
  sudo find / -path /proc -prune -o -path /sys -prune -o -type f -perm -0002 -exec ls -l {} \; # Files
  # Fix: sudo chmod o-w /path/to/world_writable_item
  ```
- [ ] Find and investigate SUID/SGID files. Remove bit if unnecessary/suspicious.
  ```bash
  sudo find / -path /proc -prune -o -path /sys -prune -o -perm /6000 -type f -exec ls -l {} \;
  # Fix: sudo chmod -s /path/to/suspicious_suid_file
  ```
- [ ] Check permissions on sensitive files (`/etc/shadow`, `/etc/sudoers`, `/etc/ssh/sshd_config`). Ensure proper ownership and restricted permissions.
  ```bash
  ls -l /etc/shadow /etc/sudoers /etc/ssh/sshd_config
  # Expected: -rw-r----- root shadow /etc/shadow
  # Expected: -r--r----- root root /etc/sudoers
  # Expected: -rw-r--r-- root root /etc/ssh/sshd_config
  ```
- [ ] Check home directory permissions (should not be world-readable/writable).

### File System Mounts (`/etc/fstab`)
- [ ] Review `/etc/fstab`. Check mount options for partitions (e.g., add `nodev`, `nosuid`, `noexec` to partitions like `/tmp` or separate `/home` if applicable and doesn't break requirements - advanced).

### Prohibited Files
- [ ] **README Check:** See if specific file types are prohibited (e.g., media files).
- [ ] Search for prohibited files if required.
  ```bash
  sudo find /home /root /tmp /var/tmp -type f \( -name "*.mp3" -o -name "*.mp4" -o -name "*.avi" -o -name "*.mov" \) -exec ls -l {} \;
  # Remove if found and prohibited: sudo rm /path/to/prohibited_file
  ```

---

## Network Security

### Firewall (UFW)
- [ ] **README Check:** Identify required ports/services.
- [ ] Ensure UFW is installed (`sudo apt install ufw`).
- [ ] Enable UFW (`sudo ufw enable`). **Allow required services FIRST** (e.g., `sudo ufw allow ssh`, `sudo ufw allow http`, `sudo ufw allow 80/tcp`).
- [ ] Set default policies: `sudo ufw default deny incoming`, `sudo ufw default allow outgoing`.
- [ ] Check status: `sudo ufw status verbose`. Verify rules match requirements. Remove unnecessary `allow` rules.

### Network Configuration
- [ ] Check network interface configuration (`ip addr show`).
- [ ] Check listening services/ports (`sudo ss -tulpn`). Verify only required services are listening.
- [ ] Check active network connections (`sudo ss -tnp`). Look for suspicious established connections.
- [ ] Check DNS settings (`cat /etc/resolv.conf`). Ensure it points to valid DNS servers.
- [ ] Check `hosts` file (`cat /etc/hosts`) for malicious redirects.

---

## Search for Forensics Questions / Persistence

- [ ] **README Check:** Re-read forensic questions. What specific information, files, users, logs, or events are needed?
- [ ] Search common locations for flags/answers: User Desktops (`/home/*/Desktop`, `/root/Desktop`), Documents, Downloads, `/tmp`, `/var/tmp`, web roots (`/var/www/html`). Look for `README*`, `*.txt`, image files, etc.
  ```bash
  find /home /root -name "README*" 2>/dev/null
  find / -name "*.txt" -not -path "/proc/*" -not -path "/sys/*" -mtime -1 2>/dev/null # Recently modified txt files
  ```
- [ ] Check Cron Jobs (Persistence):
    - User crontabs: `for user in $(cut -f1 -d: /etc/passwd); do sudo crontab -u $user -l; done`
    - System cron directories: `sudo ls -l /etc/cron.* /etc/crontab`
    - Remove/comment out suspicious entries (`sudo crontab -u user -e` or edit system files).
- [ ] Check systemd Timers/Services (Persistence):
    - `sudo systemctl list-timers --all`
    - `sudo ls -l /etc/systemd/system/*.timer /etc/systemd/system/*.service`
    - Investigate/disable suspicious units: `sudo systemctl disable --now suspicious.timer`
- [ ] Check Shell Startup Files (Persistence):
    - `~/.bashrc`, `~/.profile`, `~/.bash_profile`, `~/.bash_login`
    - `/etc/bash.bashrc`, `/etc/profile`, files in `/etc/profile.d/`
    - Look for strange commands, aliases, or functions being defined.
- [ ] Check for SUID Binaries (Persistence - already checked in File System section, re-verify).
- [ ] Check for unusual running processes (`ps auxf`, `top`).
- [ ] Check command history (`history`, `sudo cat /home/*/.bash_history`, `sudo cat /root/.bash_history`).
- [ ] Check logs (`journalctl`, `/var/log/auth.log`, `/var/log/syslog`) for clues related to forensic questions (logon times, specific commands, errors).

---

## Common CyberPatriot Scoring Items (Verify based on README)

- [ ] Unauthorized users removed.
- [ ] Strong passwords set for all authorized accounts.
- [ ] Root/sudo access properly restricted.
- [ ] Password policies configured (Aging, Complexity, History).
- [ ] Updates installed (if allowed/required).
- [ ] Firewall enabled and configured correctly (UFW - default deny in, allow required).
- [ ] SSH server secured (Root login disabled, etc.) or disabled if not needed.
- [ ] Unnecessary/insecure services disabled (telnet, vsftpd, etc.).
- [ ] Malware/Persistence removed (Cron, systemd, SUID, startup files).
- [ ] Unauthorized software removed (hacking tools, games).
- [ ] Critical file permissions set properly (world-writable fixed, sensitive files restricted).
- [ ] Prohibited media files removed (if applicable).
- [ ] Finding and answering forensics questions correctly.

---

## Quick Status Check Commands

### User and Group Management
```bash
# List all users (name, UID, home dir)
cat /etc/passwd | cut -d: -f1,3,6

# List all sudo users (check sudo group and /etc/sudoers)
grep -Po '^sudo.+:\K.*$' /etc/group
sudo cat /etc/sudoers /etc/sudoers.d/*

# List logged-in users
who
last -a # Recent logins
```

### Service Status
```bash
# Check running services
sudo systemctl list-units --type=service --state=running

# Check services listening on network
sudo ss -tulpn
```

### System Security Checks
```bash
# Check firewall status
sudo ufw status verbose

# Check SSH configuration (non-commented lines)
grep -vE '^\s*#|^\s*$' /etc/ssh/sshd_config

# Check for SUID binaries (excluding common/expected ones can help)
sudo find / -path /proc -prune -o -path /sys -prune -o -perm /4000 -type f -ls # Basic find
# More advanced: Compare against a known good list if possible
```

### File System
```bash
# Check world-writable files/dirs (excluding /proc, /sys)
sudo find / -path /proc -prune -o -path /sys -prune -o -perm -o+w -ls
```

---
*Checklist Version X.Y - Last Updated YYYY-MM-DD*
*Remember to adapt based on the specific competition image and README.*
