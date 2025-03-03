# Linux Security Fundamentals Quiz

## Overview

This quiz tests your knowledge of fundamental Linux security concepts essential for CyberPatriot competitions. It covers user management, file permissions, service configuration, and basic system hardening.

**Time Allowed**: 30 minutes  
**Total Points**: 50  
**Passing Score**: 40 points (80%)

## Instructions

1. Read each question carefully
2. Write down your answers on a separate sheet of paper or create a text file with your answers
3. Number your answers to match the question numbers
4. Check your answers against the solution key when finished or submit your answers for review

---

## Multiple Choice Questions (2 points each)

### 1. Which file contains encrypted user passwords on Ubuntu/Linux Mint?

A. /etc/passwd  
B. /etc/shadow  
C. /etc/users  
D. /etc/security/passwords  

### 2. What command is used to change a user's password in Linux?

A. userpass  
B. passwd  
C. chpass  
D. password  

### 3. Which of the following commands adds a user to the sudo group?

A. useradd sudo username  
B. sudo user-add username  
C. usermod -aG sudo username  
D. groupadd sudo username  

### 4. What is the correct permission notation (numeric) that gives read, write, and execute permissions to the owner, read and execute to the group, and no permissions to others?

A. 731  
B. 750  
C. 530  
D. 751  

### 5. Which command displays currently running services on a systemd-based Linux system?

A. ps aux  
B. service --status-all  
C. systemctl list-units --type=service  
D. chkservice  

### 6. What is the default UFW policy that should be set for incoming connections in a secure configuration?

A. allow  
B. reject  
C. deny  
D. drop  

### 7. Which configuration file is used to secure the SSH server on Ubuntu/Linux Mint?

A. /etc/ssh/ssh.conf  
B. /etc/ssh/sshd_config  
C. /etc/sshd.conf  
D. /etc/security/ssh.conf  

### 8. Which command is used to check if the firewall is active in Ubuntu/Linux Mint?

A. firewall-cmd --state  
B. iptables -L  
C. ufw status  
D. netfilter status  

### 9. Which special permission, when set on a directory, ensures that only the file's owner can delete or rename files within that directory regardless of the directory's other permissions?

A. SUID bit  
B. SGID bit  
C. Sticky bit  
D. Immutable bit  

### 10. Which Linux file defines how often users must change their passwords?

A. /etc/pam.d/password-auth  
B. /etc/passwd  
C. /etc/login.defs  
D. /etc/security/password  

### 11. Which tool is commonly used to detect rootkits on Linux systems?

A. antivirus  
B. chkrootkit  
C. scanrootkit  
D. rootscan  

### 12. What command shows all user accounts on the system?

A. cat /etc/passwd  
B. getent passwd  
C. ls -l /home  
D. user -l  

### 13. Which is the most secure method for remote administration of Linux systems?

A. Telnet  
B. SSH with password authentication  
C. SSH with key-based authentication  
D. FTP  

### 14. What is the correct command to find all SUID files on a system?

A. find / -perm /4000  
B. find / -type suid  
C. ls -l / | grep suid  
D. locate suid  

### 15. Which of these is NOT a common Linux security tool?

A. SELinux  
B. AppArmor  
C. Fail2ban  
D. WindowsDefender  

## True/False Questions (1 point each)

### 16. In Linux, the root user has the UID (User ID) of 0.

True or False

### 17. A SUID permission allows the user who executes a file to do so with the permissions of that file's group owner.

True or False

### 18. Files created in a directory with the SGID bit set will inherit the group ownership of that directory.

True or False

### 19. The command "chmod 777 file.txt" is considered secure because it ensures all users can access the file.

True or False

### 20. In Linux, a normal user can listen on ports below 1024 without special privileges.

True or False

### 21. The /etc/passwd file on modern Linux systems contains encrypted password hashes.

True or False

### 22. When using SSH key-based authentication, it's best practice to protect the private key with a passphrase.

True or False

### 23. AppArmor and SELinux are both implementations of Mandatory Access Control (MAC).

True or False

### 24. Setting "PermitRootLogin yes" in the SSH configuration file is a recommended security practice.

True or False

### 25. Running services with the minimum required privileges is a core principle of Linux security.

True or False

## Short Answer Questions (3 points each)

### 26. List three ways to check for unauthorized users on a Linux system.

### 27. Explain the principle of least privilege and why it's important for Linux security.

### 28. What is the purpose of the "umask" and how does it affect file creation permissions?

### 29. Describe three methods to secure SSH on a Linux server.

### 30. List three locations where an attacker might place a persistence mechanism (backdoor) on a Linux system.

## Scenario Questions (5 points each)

### 31. You're securing a Linux system and need to check who has sudo access. What commands would you use, and what files would you examine to get this information? Explain how you would interpret the results.

### 32. During a CyberPatriot competition, you discover several unfamiliar services running on your Ubuntu system. Describe the steps you would take to:
   a) Identify these services
   b) Determine if they are legitimate
   c) Secure or remove them if necessary
   Include specific commands you would use at each step.

### 33. You've been assigned to secure an Ubuntu web server. List five specific security measures you would implement, explaining why each is important and how you would implement it.

## Bonus Question (5 points)

### 34. Explain how an attacker might leverage weak file permissions on key system directories or files to escalate privileges on a Linux system. Give at least two examples of specific files or directories where improper permissions could lead to privilege escalation, and how you would secure them.

---

## Additional Information

- Google Forms Version: [Linux Security Fundamentals Quiz](https://forms.gle/examplelink) (fill in with actual link when created)
- PDF Version: [Download PDF Version](../Resources/Linux_Security_Fundamentals_Quiz.pdf)

## For Mentors

The solution key is available in the [Solutions](../Solutions/Linux_Security_Fundamentals_Quiz_Solution.md) directory. Consider using this quiz in the following ways:

1. **Individual Assessment**: Have cadets take the quiz independently and submit answers
2. **Team Competition**: Divide into teams and compete for the highest score
3. **Pre/Post Training**: Use as a before/after assessment for Linux security training
4. **Discussion Prompt**: Use questions as starting points for group discussions

---

*Note for mentors: Please do not share the solution key with cadets until after they've completed the quiz.*
