# Windows System Hardening Quiz - Solutions

**Mentor Use Only**

1.  **Which policy setting helps prevent users from reusing the same passwords repeatedly?**
    *   **Correct:** c) Enforce password history
    *   **Explanation:** This policy remembers a specified number of previous passwords and prevents their reuse.

2.  **In `secpol.msc`, what does the "Account lockout threshold" policy define?**
    *   **Correct:** c) The number of invalid logon attempts allowed before an account is locked out.
    *   **Explanation:** This setting determines how many failed attempts trigger a lockout.

3.  **Disabling the "Remote Registry" service can help mitigate which type of risk?**
    *   **Correct:** b) Unauthorized remote modification of the system's registry.
    *   **Explanation:** This service allows remote users (with appropriate permissions) to modify registry settings. Disabling it closes that vector.

4.  **Which Security Option in Local Security Policy can be configured to display a warning message to users before they log in?**
    *   **Correct:** d) `Interactive logon: Message text for users attempting to log on`
    *   **Explanation:** This policy, along with the corresponding "Message title" policy, sets the legal notice or warning banner.

5.  **Enabling audit policies like "Audit account logon events" and "Audit logon events" primarily helps with:**
    *   **Correct:** c) Investigating security incidents after they occur.
    *   **Explanation:** Auditing creates logs that provide a trail of activity, crucial for forensic analysis.

6.  **True or False: Group Policy Objects (GPOs) applied at the Organizational Unit (OU) level override policies applied at the Domain level by default.**
    *   **Correct:** a) True
    *   **Explanation:** GPOs are applied in the order Local, Site, Domain, OU (LSDOU). Policies applied closer to the object (like OU) generally take precedence unless blocked or enforced.

7.  **What is the purpose of Software Restriction Policies or AppLocker?**
    *   **Correct:** b) To control which applications users are allowed to run.
    *   **Explanation:** These features allow administrators to create rules defining allowed or disallowed software execution.

8.  **Which command-line tool can be used to apply security templates (`.inf` files) to configure local security policy?**
    *   **Correct:** c) `secedit`
    *   **Explanation:** `secedit /configure /db <database> /cfg <template.inf>` is used to apply security templates.

9.  **Disabling administrative shares (like C$, ADMIN$) primarily enhances security by:**
    *   **Correct:** b) Making it harder for attackers or malware to move laterally across a network using default shares.
    *   **Explanation:** These shares provide administrative access to drives and system folders, often targeted by malware for propagation.

10. **Which registry hives contain configuration settings specific to the currently logged-on user and the local machine, respectively?**
    *   **Correct:** b) HKEY_CURRENT_USER and HKEY_LOCAL_MACHINE
    *   **Explanation:** HKCU stores settings for the active user profile, while HKLM stores system-wide hardware and software settings.
