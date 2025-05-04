# Solution: VM Setup and Investigation Scenario

## Grading Rubric

- User account audit and documentation: 8 points
- Insecure service identification and remediation: 8 points
- Firewall hardening and port verification: 8 points
- Forensics question discovery and answers: 6 points
- System hardening measures (at least 3): 6 points
- Documentation quality and justification: 2 points
- Service functionality verification: 2 points

## Sample Answers

### 1. User Account Audit
- Used `net user` (Windows) or `cat /etc/passwd` (Linux) to list accounts.
- Identified unauthorized accounts: e.g., "hacker", "testuser".
- Documented group memberships and disabled/deleted unauthorized users.

### 2. Insecure Services
- Disabled Telnet, FTP, Remote Registry, or SSH root login as appropriate.
- Used `services.msc` (Windows) or `systemctl` (Linux) to stop and disable services.

### 3. Firewall Hardening
- Enabled Windows Firewall or UFW.
- Allowed only required ports (e.g., 22, 80, 443).
- Verified with `netstat -ano` or `ss -tulpn`.

### 4. Forensics Questions
- Located README or answer files on Desktop/Documents.
- Provided correct answers (e.g., "What was the attacker's IP?").

### 5. System Hardening
- Set strong password policies.
- Disabled guest accounts.
- Applied updates and enabled audit logging.

### 6. Documentation
- Listed each change, command used, and reason for action.

### 7. Service Verification
- Confirmed required services (e.g., web server, SSH) still functioned after changes.

---

*Award partial credit for partial completion. Discuss workflow and reasoning with cadets for maximum learning.*
