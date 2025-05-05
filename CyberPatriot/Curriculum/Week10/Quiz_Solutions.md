# Week 10 Quiz - Mentor Review Notes

## Quiz Focus: Advanced Linux Security & Incident Response Intro

### Key Concepts to Reinforce:

-   **PAM:** It's the gatekeeper for authentication. `/etc/pam.d/` contains service configs. `common-password` is key for password rules. `pam_pwquality` enforces complexity.
-   **Logging:** `journalctl` is the modern way (filtering!). `/var/log/` holds traditional text logs (`auth.log` for logins/sudo, `syslog` for general). `grep` is essential for searching text logs.
-   **Persistence:** Cron (user `crontab -l`, system `/etc/cron.*`, `/etc/crontab`), Systemd (`.service`/`.timer` files, `systemctl list-timers`), Startup Scripts (`.bashrc`, `/etc/profile.d`). Check them all.
-   **IR on Linux:** Similar principles to Windows. Identify suspicious processes (`ps`), connections (`ss`), files (`find`). Contain/Eradicate by killing processes (`kill`), removing cron jobs/services, fixing configs. Recover by ensuring required services are up.
-   **Investigation Tools:** `ps`, `ss`, `journalctl`, `grep`, `find`, `crontab -l`, `systemctl`, `cat`, `less`.

### Common Mistakes/Misconceptions:

-   Complexity of PAM configuration (focus on basic password quality/lockout).
-   Forgetting `journalctl` options or relying only on `/var/log`.
-   Not checking *all* cron locations (user and system).
-   Overlooking systemd timers/services as persistence.
-   Not knowing which startup scripts are most commonly abused (`.bashrc`, `/etc/profile.d`).
-   Difficulty correlating log entries with specific events or forensic questions.
-   Using `rm` carelessly when removing malicious scripts/files.

### Discussion Points for Review:

-   Ask cadets where PAM configuration files are typically located. Which file is commonly used for password settings? (`/etc/pam.d/`, `common-password`).
-   Ask the command to view all system logs since yesterday. How to view logs only for the `sshd` service? (`journalctl --since yesterday`, `journalctl -u sshd`).
-   Ask for 3 common places a malicious script might be scheduled to run automatically on Linux. (User crontab, system cron file/dir, systemd timer/service, `.bashrc`).
-   How do you list all active systemd timers? (`systemctl list-timers`).
-   Scenario: "You find a suspicious process using `ps aux`. What are the next steps?" (Investigate the process path, check network connections `ss`, check logs `journalctl`, potentially kill it `kill`, find how it started - cron/service?).
-   Scenario: "A forensic question asks who used `sudo` yesterday." Which log file would you check and what might you `grep` for? (`/var/log/auth.log`, `grep sudo`).

*(Detailed answers and explanations should reference the relevant sections in the Incident Response Quiz solution: `../Quizzes/Solutions/Incident_Response_Quiz_Solution.md`)*

---
*Mentor notes for internal team use. Emphasize systematic checking of persistence locations and log analysis.*
