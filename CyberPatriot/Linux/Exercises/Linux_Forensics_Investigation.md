# Linux Forensic Investigation Exercise

## Overview

This exercise simulates a post-breach forensic investigation scenario frequently encountered in advanced CyberPatriot competitions. You'll analyze a compromised Linux system to identify the attack vectors, persistence mechanisms, and data exfiltration methods used by the attacker.

## Difficulty Level: Advanced

## Estimated Time: 120 minutes

## Learning Objectives

By completing this exercise, you will be able to:
- Apply Linux forensic analysis techniques
- Identify signs of system compromise
- Discover and analyze persistence mechanisms
- Trace an attacker's actions through log analysis
- Document findings in a forensic report

## Prerequisites

- Intermediate Linux knowledge
- Understanding of basic security concepts
- Familiarity with log files and system services
- Access to a preconfigured "compromised" Ubuntu VM

## Setup Instructions

1. Download the VM image from the VM-Setup directory
2. Import the VM into VirtualBox or VMware
3. Start the VM with the following credentials:
   - Username: investigator
   - Password: Cyb3rP@tr10t

## Scenario

You are a security analyst for a company that has suffered a security breach. The company's Linux web server has been compromised, and management needs you to determine:

1. How the attacker gained initial access
2. What persistence mechanisms were established
3. Whether any data was exfiltrated
4. The full timeline of the attack

This is critical for both remediation and potential legal proceedings.

## Exercise Tasks

### Part 1: Initial System Assessment

1. Verify the system's current state:
   - Check running processes
   - Examine active network connections
   - List logged-in users and recent logins
   
2. Document basic system information:
   - Hostname and IP configuration
   - Kernel and OS version
   - Uptime and last reboot
   - Mounted filesystems

### Part 2: User Account Investigation

1. Analyze user accounts:
   - Identify all user accounts on the system
   - Check for unauthorized accounts
   - Review sudo permissions and group memberships
   - Look for accounts with UID 0 (root privileges)

2. Examine authentication logs:
   - Analyze `/var/log/auth.log`
   - Look for failed login attempts
   - Identify suspicious successful logins
   - Check for password changes or account modifications

### Part 3: File System Analysis

1. Look for suspicious files:
   - Find recently created or modified files
   - Identify files with unusual permissions
   - Check for hidden files and directories
   - Search for files with suspicious names or extensions

2. Check for unauthorized SUID/SGID binaries:
   - Find all SUID/SGID files
   - Compare against a known good baseline
   - Analyze any suspicious executables

### Part 4: Service and Process Investigation

1. Examine running services:
   - Identify all active services
   - Look for unusual or unnecessary services
   - Check service configurations for modifications
   - Analyze listening ports and associated processes

2. Analyze running processes:
   - Look for processes with suspicious names
   - Identify processes running as root
   - Check for unusual parent-child relationships
   - Examine command line arguments

### Part 5: Persistence Mechanism Discovery

1. Check startup locations:
   - Examine systemd service files
   - Check init scripts
   - Review cron jobs and at jobs
   - Inspect user startup files (.bashrc, .profile)

2. Look for kernel-level persistence:
   - Check loaded kernel modules
   - Look for unauthorized kernel modifications
   - Check for rootkits using chkrootkit or rkhunter

### Part 6: Log Analysis

1. Analyze various system logs:
   - Review `/var/log/syslog` for system events
   - Check web server logs for attack indicators
   - Examine `/var/log/apt/history.log` for unauthorized package installations
   - Correlate events across multiple log files

2. Create a timeline of suspicious activity:
   - Order events chronologically
   - Identify patterns or recurring IP addresses
   - Note gaps in logs that might indicate log tampering

### Part 7: Network Analysis

1. Analyze network activity:
   - Review current network connections
   - Check firewall rules and modifications
   - Look for unusual outbound connections
   - Identify any data exfiltration attempts

2. Examine network configuration changes:
   - Check for proxy settings
   - Look for DNS modifications
   - Review network interface configurations

## Forensic Questions to Answer

Based on your investigation, answer the following questions:

1. What was the initial attack vector used to compromise the system?

2. When did the initial compromise occur? Provide the exact date and time if possible.

3. What persistence mechanisms did the attacker establish? List all that you find.

4. Were any backdoor accounts or SSH keys created?

5. Did the attacker attempt to escalate privileges? If so, how?

6. Was any data exfiltrated? If so, what type of data and to where?

7. What tools or techniques did the attacker use?

8. Was there evidence of attempts to hide activity or clear logs?

9. Were any legitimate credentials compromised?

10. What is the complete timeline of the attack from initial compromise to your investigation?

## Deliverables

Create a forensic investigation report that includes:

1. Executive Summary (1 paragraph overview)
2. System Information (hostname, OS version, etc.)
3. Investigation Methodology
4. Findings (ordered chronologically)
5. Evidence of Compromise (with specific file paths, log excerpts, etc.)
6. Attack Timeline
7. Answers to the Forensic Questions
8. Recommendations for Remediation

## Evidence Collection Commands

Here are some useful commands for your investigation:

```bash
# System information
hostname
uname -a
cat /etc/os-release
uptime
who
last

# User accounts
cat /etc/passwd
cat /etc/shadow
lastlog
cat /etc/sudoers
grep -Po '^sudo:.*:\K.*$' /etc/group

# Process investigation
ps -auxf
lsof -p <PID>
ps -eo pid,ppid,user,args
systemctl list-units --type=service

# Network investigation
ss -tulpn
netstat -antup
lsof -i
iptables -L

# File system investigation
find / -type f -mtime -3 -not -path "/proc/*" -not -path "/sys/*" 2>/dev/null
find / -type f -perm -4000 -ls 2>/dev/null
find / -type f -name ".*" 2>/dev/null
find / -type f -size +10M -size -100M 2>/dev/null

# Log analysis
grep -i "fail" /var/log/auth.log
journalctl --since="2023-10-01" --until="2023-10-02"
less /var/log/apache2/access.log
grep -r "suspicious term" /var/log/
```

## Hints

<details>
  <summary>Hint 1: Initial Access Vector</summary>
  
  Check the web server logs for evidence of exploitation attempts against the web application. Look for unusual HTTP requests containing SQL injection or file inclusion patterns.
</details>

<details>
  <summary>Hint 2: Persistence Locations</summary>
  
  Don't forget to check both system-wide persistence locations (/etc/systemd/system, /etc/init.d) and user-specific locations (~/.bashrc, ~/.ssh/). The attacker likely used multiple methods.
</details>

<details>
  <summary>Hint 3: Data Exfiltration</summary>
  
  Look for evidence of outbound connections to unusual IP addresses or domains. Check for large data transfers or scheduled jobs that might be sending data to remote servers.
</details>

<details>
  <summary>Hint 4: Timeline Construction</summary>
  
  Many log files have different formats. To create an accurate timeline, extract timestamps from different logs and sort them chronologically. Pay attention to timezone information.
</details>

## Solution

After completing the exercise, check your findings against the [solution guide](./Solutions/Linux_Forensics_Investigation_Solution.md).

## Next Steps

After completing this forensic investigation exercise:

1. Create a hardening plan to address the vulnerabilities exploited
2. Implement detection measures for similar attacks
3. Develop incident response procedures based on lessons learned
4. Practice with more advanced forensic techniques and tools like Volatility for memory analysis
