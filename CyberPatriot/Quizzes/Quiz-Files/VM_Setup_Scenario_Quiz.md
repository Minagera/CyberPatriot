# CyberPatriot VM Setup Scenario Analysis Quiz

**Instructions:** Analyze the following hypothetical descriptions or outputs related to the VM Setup scripts (`enterprise-workstation-setup.ps1` or `corporate-server-breach.sh`) used for creating practice environments. Answer the questions based *only* on the information provided in each scenario snippet.

---

## Scenario 1: Linux Script Snippet Analysis

**Script Description:** A section of the `corporate-server-breach.sh` script includes the following commands:

```bash
# Add backdoor user
useradd -o -u 0 -g 0 -M -d /root -s /bin/bash bkdooradm
echo "bkdooradm:SomeWeakPass" | chpasswd
# Add user to sudo group
usermod -aG sudo serviceacc
```

**Questions:**

1.  What is the primary security risk introduced by the `useradd` command shown?
    *   A. Creates a user with a weak password.
    *   B. Creates a user with UID 0 (root privileges).
    *   C. Creates a user without a home directory.
    *   D. Creates a user that cannot log in.

2.  What privilege escalation method is granted to the `serviceacc` user?
    *   A. Direct root login.
    *   B. SUID binary execution.
    *   C. Membership in the `sudo` group.
    *   D. Cron job execution as root.

---

## Scenario 2: Windows Script Output Analysis

**Script Log Output (`C:\setup_log_cyberpatriot.txt`):**

```
...
[+] Creating unauthorized user 'TempAdmin'
[+] Adding 'TempAdmin' to Administrators group
[+] Setting weak password for 'TempAdmin'
[+] Disabling Windows Defender Real-time Protection via Registry
    - Set HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection\DisableRealtimeMonitoring to 1
[+] Creating scheduled task 'MalwareUpdate' to run C:\Windows\System32\evil.exe daily
...
```

**Questions:**

3.  Besides the unauthorized user, what is a significant security feature disabled by this script snippet?
    *   A. Windows Firewall
    *   B. User Account Control (UAC)
    *   C. Windows Defender Real-time Protection
    *   D. Windows Update

4.  What persistence mechanism is being established according to the log?
    *   A. A malicious service
    *   B. A registry run key
    *   C. A scheduled task
    *   D. A startup folder item

---

*(Add more scenarios covering different aspects like service misconfiguration, firewall rules, file permission changes, etc., as described in the VM-Setup READMEs)*

---
*This quiz is uniquely designed to test understanding of how practice VMs are compromised.*
