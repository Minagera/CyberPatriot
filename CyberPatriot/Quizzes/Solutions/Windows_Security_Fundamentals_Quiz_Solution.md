# Windows Security Fundamentals Quiz - Solutions

**Mentor Use Only**

1.  **Which command is used to disable the local Guest account in Windows Command Prompt?**
    *   **Correct:** b) `net user Guest /active:no`
    *   **Explanation:** The `/active:no` switch disables the account. PowerShell uses `Set-LocalUser -Enabled $false`.

2.  **What is the primary purpose of the Windows Defender Firewall?**
    *   **Correct:** b) To filter incoming and outgoing network traffic based on rules.
    *   **Explanation:** Firewalls control network access based on predefined rules. Antivirus scans for malware.

3.  **In Local Security Policy (`secpol.msc`), where would you configure the minimum password length requirement?**
    *   **Correct:** b) Account Policies > Password Policy
    *   **Explanation:** Password policies govern complexity, length, age, and history.

4.  **Which group typically has the highest level of privilege on a standalone Windows system?**
    *   **Correct:** c) Administrators
    *   **Explanation:** The Administrators group has full control over the system.

5.  **What does UAC (User Account Control) primarily help prevent?**
    *   **Correct:** b) Unauthorized system changes by malware or users
    *   **Explanation:** UAC prompts for elevation before allowing actions that could affect the system, preventing silent changes.

6.  **Which tool allows you to view security-related events, such as failed login attempts?**
    *   **Correct:** c) Event Viewer (eventvwr.msc)
    *   **Explanation:** Event Viewer logs system, application, and security events, including logon successes and failures.

7.  **True or False: Setting "Password must meet complexity requirements" to Enabled forces users to include characters from at least three categories (uppercase, lowercase, numbers, symbols).**
    *   **Correct:** a) True
    *   **Explanation:** This is the standard definition of Windows password complexity.

8.  **What is a common first step when encountering a potentially unauthorized user account during a CyberPatriot competition?**
    *   **Correct:** c) Consult the competition README file to see if the account is required.
    *   **Explanation:** Deleting a required account can lose points. Always check the README first.

9.  **Which Windows feature provides real-time protection against viruses, spyware, and other malicious software?**
    *   **Correct:** b) Windows Defender Antivirus
    *   **Explanation:** This is the core anti-malware component of Windows Security.

10. **Why is it generally recommended to remove the "Everyone" group from file share permissions?**
    *   **Correct:** c) It grants access to potentially any user, including unauthenticated ones in some contexts.
    *   **Explanation:** The "Everyone" group is very broad and often includes anonymous users, posing a security risk for shares.
