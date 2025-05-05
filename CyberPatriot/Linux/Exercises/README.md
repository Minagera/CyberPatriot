# Linux Security Challenge

This directory contains hands-on Linux security exercises and challenge scenarios for CyberPatriot training.

## Structure

- **README.md**: This file, describing the challenge, workflow, and scoring.
- **Solutions/**: Mentor-only reference solutions for each exercise.

## How to Use

1. Download the exercise instructions and any provided VM images.
2. Complete all required security tasks and document your changes.
3. Use the scoring checklist to track your progress.
4. Review hints if you get stuck.
5. After attempting, compare your work to the solution in the `Solutions/` directory.

## Exercise Workflow

- Each exercise simulates a real CyberPatriot Linux challenge.
- Tasks include user management, service hardening, firewall configuration, malware removal, and forensics.
- Scoring sections help you focus on high-value items.
- Hints are provided for common stumbling blocks.

*Exercises are unique and designed for CyberPatriot training. Practice regularly for best results!*

---

## Overview

You are a system administrator for a small organization. The previous IT person left unexpectedly, and you've discovered that one of the Linux servers hasn't been properly maintained. Your task is to secure this system according to best practices and organization requirements.

The organization's security policy requires:
- Only authorized users should have access to the system
- All services should be properly secured or disabled if not needed
- The system should be hardened against common attacks
- All security vulnerabilities should be patched

## Difficulty Level: Intermediate

## Estimated Time: 90-120 minutes

## Learning Objectives

- Identify and remove unauthorized users
- Harden user accounts and passwords
- Audit and secure running services
- Configure and test the firewall
- Remove malware and suspicious files
- Apply system hardening techniques
- Document all changes and findings

## Prerequisites

- Basic Linux command line skills
- Familiarity with Ubuntu/Mint security concepts
- Access to a practice VM or provided scenario image

## Setup Instructions

1. Download the [Linux_Security_Challenge.zip](../VM-Setup/Linux_Security_Challenge.zip) file
2. Extract the contents and follow the instructions in the README.txt to prepare your VM
3. **Do not** look at the solution until you have completed the exercise
4. Take note of your starting time to track how long the exercise takes

## Scenario

You are a system administrator for a small organization. The previous IT person left unexpectedly, and you've discovered that one of the Linux servers hasn't been properly maintained. Your task is to secure this system according to best practices and organization requirements.

The organization's security policy requires:
- Only authorized users should have access to the system
- All services should be properly secured or disabled if not needed
- The system should be hardened against common attacks
- All security vulnerabilities should be patched

## Exercise Tasks

### Part 1: Initial Assessment
- Document the current state of the system
- Identify security issues
- Create a security plan

### Part 2: User and Group Management
- Check for unauthorized users
- Implement proper user security
- Configure sudo access

### Part 3: Service Security
- Audit running services
- Secure necessary services
- Disable or remove unnecessary services

### Part 4: System Updates and Software Management
- Update the system
- Review installed software

### Part 5: Network Security
- Configure the firewall
- Secure network settings

### Part 6: System Hardening
- Implement kernel and filesystem hardening
- Configure logging and monitoring

### Part 7: Find Hidden Security Issues
- Search for hidden files, backdoors, and persistence mechanisms

## Scoring

### User Security (10 points)
- [ ] Unauthorized users removed or disabled
- [ ] Proper group memberships configured
- [ ] Root account secured
- [ ] Password policies implemented
- [ ] Guest account disabled
- [ ] Sudo access properly configured
- [ ] User permissions corrected
- [ ] Hidden backdoor user found and removed
- [ ] User home directories secured
- [ ] Password aging configured

### Service Security (10 points)
- [ ] SSH properly configured
- [ ] Telnet disabled/removed
- [ ] FTP disabled/removed
- [ ] Web server secured (if applicable)
- [ ] Database secured (if applicable)
- [ ] All unnecessary services disabled
- [ ] Services running with appropriate privileges
- [ ] Service-specific security settings applied
- [ ] Startup scripts checked and secured
- [ ] inetd/xinetd services checked and secured

### System Updates & Software (5 points)
- [ ] All packages updated
- [ ] Unauthorized software removed
- [ ] Security tools installed
- [ ] Package integrity verified
- [ ] Automatic updates configured

### Network Security (5 points)
- [ ] Firewall enabled and configured
- [ ] Only required ports open
- [ ] Network interfaces secured
- [ ] Network hardening applied
- [ ] Unnecessary protocols disabled

### System Hardening (5 points)
- [ ] Kernel security parameters set
- [ ] Filesystem permissions corrected
- [ ] SUID/SGID binaries checked
- [ ] Temporary file storage secured
- [ ] Security modules enabled

### Forensics & Documentation (5 points)
- [ ] Forensic questions answered
- [ ] All changes documented
- [ ] Suspicious files reported
- [ ] Security plan submitted
- [ ] Time tracking completed

## Hints

- Use `cat /etc/passwd` and `cat /etc/group` to list users and groups.
- Check for world-writable files with `find / -type f -perm -o+w 2>/dev/null`.
- Use `systemctl list-units --type=service --state=active` to list running services.
- Check for suspicious cron jobs in `/etc/cron.d`, `/etc/crontab`, and user crontabs.
- Use `ufw status verbose` to check firewall status.
- Look for hidden files and backdoors in `/tmp`, `/dev/shm`, and user home directories.

## Documenting Your Work

- Keep a log of all commands run and changes made.
- Note any issues or errors encountered.
- Prepare a summary report for review.

## Solution

- Mentor-only solutions are in the `Solutions/` directory.

## Conclusion

Completing this exercise will prepare you for the types of Linux security challenges found in CyberPatriot competitions. Practice regularly and review your solutions to improve your skills.

## Next Steps

- Attempt advanced exercises
- Write your own scripts to automate common tasks
- Review the Linux Security Checklist and Guides for deeper understanding

---

## Directory Index

```
Exercises/
├── README.md                # This file: challenge, workflow, scoring, hints
├── Solutions/               # Mentor-only solutions for each exercise
│   ├── linux_challenge_solution.sh
│   └── README.md
├── Linux_Security_Challenge.zip         # Downloadable VM image for hands-on practice
├── Linux_Security_Challenge.zip.README.md # Placeholder/readme for the VM image
```

- `README.md`: Main challenge and workflow
- `Solutions/`: Mentor-only reference solutions (e.g., `linux_challenge_solution.sh`)
- `Linux_Security_Challenge.zip`: Downloadable VM image for hands-on practice
- `Linux_Security_Challenge.zip.README.md`: Placeholder/readme for the VM image

*If any of these files are missing, create them to ensure a complete and unique CyberPatriot Linux exercise experience.*

---

**All files and directories referenced above are present and unique for CyberPatriot training.**

# Linux Security Exercises

This directory contains hands-on exercises for practicing Linux security skills relevant to CyberPatriot, focusing on Ubuntu/Mint distributions.

## Exercise Index

-   [**Linux_Security_Basics_Exercise.md**](Linux_Security_Basics_Exercise.md)
    *   Focus: User/group management commands, basic file permissions, finding files, checking service status.
-   [**Linux_Security_Hardening_Exercise.md**](Linux_Security_Hardening_Exercise.md)
    *   Focus: Configuring UFW firewall, hardening SSH, setting password policies (PAM/login.defs), disabling services, checking for world-writable files.
-   [**Linux_Forensics_Investigation.md**](Linux_Forensics_Investigation.md)
    *   Focus: Searching logs (`/var/log/`), analyzing `.bash_history`, checking cron jobs, finding specific files based on scenario questions.

## How to Use

1.  Obtain the corresponding Linux VM image (if applicable, see `VM-Setup`).
2.  Read the exercise scenario and objectives.
3.  Perform the tasks using the Linux command line.
4.  Refer to the Guides and Checklists for assistance.
5.  Compare your results with the solution guide (if available).

## Contribution

Create new exercises covering topics like AppArmor/SELinux basics, log analysis with tools, specific service hardening (Apache, MySQL), or script analysis. Ensure clear objectives, tasks, and optionally, solutions.

## Additional Resources

-   [CyberPatriot Training Materials](https://www.uscyberpatriot.org/competition/training-materials) (Check for Linux resources)
-   [Ubuntu Security Documentation](https://ubuntu.com/security/docs)
-   [Linux Command Line Basics](https://linuxcommand.org/)

---

*All exercises are unique and tailored for CyberPatriot training.*
