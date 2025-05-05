# Windows System Hardening Quiz

**Instructions:** Answer the following questions related to advanced Windows security configurations.

## Multiple Choice

1.  Which Local Security Policy setting prevents users from reusing old passwords?
    a) Minimum password length
    b) Password must meet complexity requirements
    c) Enforce password history
    d) Maximum password age

2.  Setting the Account Lockout Threshold to 5 means:
    a) The account locks after 5 minutes of inactivity.
    b) The user must change their password every 5 days.
    c) The account locks after 5 unsuccessful login attempts.
    d) Only 5 users can be logged in simultaneously.

3.  Which Audit Policy setting would you enable to track changes to user rights assignments?
    a) Audit account management
    b) Audit logon events
    c) Audit policy change
    d) Audit privilege use

4.  Disabling the "Remote Registry" service primarily helps prevent:
    a) Malware infections
    b) Unauthorized remote modification of the registry
    c) Denial of service attacks
    d) Users from changing their own passwords

5.  Which Security Option in Local Security Policy can be used to display a warning banner before login?
    a) Interactive logon: Do not display last user name
    b) Interactive logon: Message text for users attempting to log on
    c) Accounts: Limit local account use of blank passwords
    d) Network access: Do not allow storage of passwords and credentials

## True/False

6.  Storing passwords using reversible encryption is a recommended security practice. (True/False)
7.  Configuring Windows Firewall rules via `wf.msc` provides more granular control than the basic interface in Settings. (True/False)
8.  Disabling SMBv1 can help mitigate vulnerabilities like WannaCry. (True/False)
9.  Scheduled Tasks cannot be used by attackers for persistence. (True/False)
10. The `HKCU\Software\Microsoft\Windows\CurrentVersion\Run` registry key contains startup programs for all users on the system. (True/False)

## Short Answer

11. What is the purpose of setting a "Minimum password age"?
12. Name one User Right Assignment policy and explain what it controls.
13. Why might you disable autorun/autoplay functionality via Group Policy or Registry?
14. What is the difference between auditing "Success" and "Failure" for logon events?
15. Besides disabling unnecessary services, what other action should you take regarding services in `services.msc` for hardening?

---

*(This is a placeholder quiz. Questions should be reviewed, expanded, and potentially randomized. A corresponding solution file needs to be created in Quizzes/Solutions/)*
