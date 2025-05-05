# Week 4 Quiz - Mentor Review Notes

## Quiz Focus: Core Security Principles & User Account Security

### Key Concepts to Reinforce:

-   **CIA Triad:** Ensure cadets can define C, I, and A and give a CP-relevant example for each (e.g., A = keeping required services online).
-   **Least Privilege:** This is fundamental. Why is it risky to give everyone admin rights? How is it applied (standard users, specific groups)?
-   **Defense in Depth:** Security isn't one fix; it's layers (passwords + firewall + permissions + patching...).
-   **Password Policies:** Key settings (length, complexity, history, age) and where to configure them (Win: `secpol.msc`, Lin: `login.defs`/PAM).
-   **Account Lockout:** Purpose (brute-force prevention) and key settings (Win: `secpol.msc`).
-   **User/Group Hygiene:** Regularly check for unauthorized accounts and inappropriate group memberships (esp. Administrators/sudo). Know how to remove/disable them safely. Disabling the *real* Windows Guest account.
-   **PAM Basics:** Understand that PAM controls authentication-related tasks in Linux and `common-password` is key for password rules. `pam_pwquality` enforces complexity.

### Common Mistakes/Misconceptions:

-   Confusing Confidentiality and Integrity.
-   Not understanding the practical impact of Availability in CP (losing points for down services).
-   Setting password policies but not enforcing them (e.g., not enabling complexity).
-   Difficulty finding the correct policy locations (`secpol.msc` navigation, Linux file paths).
-   Forgetting the `-r` in `userdel` (leaves home directory).
-   Confusing disabling (locking) an account vs. deleting it.
-   Not realizing changes to PAM or `login.defs` might require service restarts or re-logins to take effect (less critical for quiz, important for practice).
-   Removing required users/groups mentioned in the README.

### Discussion Points for Review:

-   Ask cadets to explain Least Privilege using an analogy.
-   Scenario: "A required web server is down. Which part of the CIA triad is violated?" (Availability).
-   Have cadets describe the steps to enforce a 12-character complex password policy on Windows and Linux.
-   Ask: "Where do you check who is in the Administrators group on Windows? The sudo group on Linux?"
-   Discuss the difference between deleting a user and disabling/locking their account. When might you do each?
-   Reiterate the importance of checking the README before removing any user or group.

*(Detailed answers and explanations should reference the actual quiz solution file: `../Quizzes/Solutions/User_Account_Security_Quiz_Solution.md`)*

---
*Mentor notes for internal team use. Connect principles to practical actions.*
