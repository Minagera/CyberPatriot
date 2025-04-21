# Linux Service Hardening Quiz

## Overview

This quiz tests your knowledge of Linux service security, focusing on hardening common services like SSH, web servers, and database servers. Understanding how to securely configure services is essential for CyberPatriot competitions.

**Time Allowed**: 25 minutes  
**Total Points**: 40  
**Passing Score**: 32 points (80%)

## Instructions

1. Read each question carefully
2. Write your answers on a separate sheet or in a text file
3. Check your answers against the solution key when finished

---

## Multiple Choice Questions (2 points each)

### 1. Which configuration file should be edited to secure the OpenSSH server?

A. /etc/ssh/ssh.conf  
B. /etc/ssh/sshd_config  
C. /etc/openssh.conf  
D. /etc/services/sshd.conf  

### 2. Which SSH configuration setting prevents direct root login?

A. DisableRootLogin yes  
B. NoRootLogin true  
C. PermitRootLogin no  
D. RootLoginPermit false  

### 3. What is the recommended authentication method for SSH?

A. Password authentication  
B. Keyboard-interactive authentication  
C. Public key authentication  
D. Challenge-response authentication  

### 4. Which service should be used instead of Telnet for secure remote connections?

A. rsh  
B. SSH  
C. FTP  
D. Telnet with encryption  

### 5. What is the most secure way to configure Apache to handle SSL/TLS?

A. Use SSLv3 for maximum compatibility  
B. Enable only TLSv1.2 and TLSv1.3 protocols  
C. Allow all SSL/TLS protocols to ensure connectivity  
D. Use default SSL settings  

### 6. Which command shows all currently running services on a systemd-based Linux system?

A. ps aux  
B. service --status-all  
C. systemctl list-units --type=service --state=active  
D. chkconfig --list  

### 7. How should you disable an unnecessary service on an Ubuntu or Linux Mint system?

A. rm /etc/init.d/service-name  
B. service service-name stop  
C. systemctl disable --now service-name  
D. kill -9 $(pgrep service-name)  

### 8. What is the recommended way to verify service configurations for security issues?

A. Check the logs for errors  
B. Compare against security benchmarks like CIS  
C. Ask on online forums  
D. Test the service with default settings  

### 9. Which of these services is typically NOT needed on a secure server?

A. sshd  
B. telnetd  
C. chronyd  
D. auditd  

### 10. Which of the following is a secure configuration for a database server?

A. Enabling remote access with a strong password  
B. Running the service as root  
C. Binding to localhost only if remote access is not needed  
D. Using default database ports and credentials  

## True/False Questions (1 point each)

### 11. Services should always run with root privileges to ensure they can access all necessary resources.

True or False

### 12. It's more secure to disable a service by removing its package than by using systemctl disable.

True or False

### 13. The principle of least privilege suggests services should run with the minimum permissions needed.

True or False

### 14. All services in /etc/inetd.conf or /etc/xinetd.d/ are essential and should remain enabled.

True or False

### 15. Keeping service configuration files world-readable is a good security practice.

True or False

### 16. Using "AllowUsers" in SSH configuration is more secure than allowing all users and relying on passwords.

True or False

### 17. Rate limiting in SSH can help prevent brute force attacks.

True or False

### 18. The "nobody" user is commonly used to run services with elevated privileges.

True or False

### 19. A properly configured web server should include detailed version information in HTTP headers.

True or False

### 20. Default service configurations in Ubuntu and Linux Mint are fully secured and don't require additional hardening.

True or False

## Short Answer Questions (3 points each)

### 21. List three specific changes you would make to harden an SSH server configuration.

### 22. Explain the security implications of running a service on a port number below 1024 versus above 1024.

### 23. Describe how to properly secure a web server's document root directory.

### 24. Name three unnecessary services that are commonly found enabled on default Linux installations and should be disabled for security.

### 25. Explain the concept of "defense in depth" as it applies to service security.

## Scenario Questions (5 points each)

### 26. You discover that your Ubuntu server is running an FTP server that uses plain text authentication. What steps would you take to secure file transfer capabilities while maintaining functionality for users?

### 27. Your Linux server needs to run a web application that requires MySQL. Outline the steps you would take to secure both the web server and database server while ensuring they can still communicate with each other.

### 28. CyberPatriot Team Challenge (Team-Based Question - 10 points)

Your CyberPatriot team has been assigned a Linux server with multiple interconnected services. The system is running:
- A custom web application on port 8081
- A database service on port 9876
- A messaging service on port 6124
- A backup service that runs every hour

The README specifies that all services must remain functional, but you've discovered they're all running as root with default configurations. Design a service security strategy that:

A) Creates a team workflow to secure these services efficiently within a 30-minute window
B) Prioritizes which services to secure first and why
C) Includes at least two unique security measures per service
D) Specifies how you'll verify service functionality after hardening
E) Creates a documentation approach to track changes made by each team member

Note: This question tests both technical knowledge and competition strategy. Consider time management and point values in your answer.

---

*Note for mentors: The solution key is available in the [Solutions](../Solutions/Service_Hardening_Quiz_Solution.md) directory.*
