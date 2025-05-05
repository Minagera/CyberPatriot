# User Account Security Quiz - Solution Key (Mentor Use Only)

## Multiple Choice

1.  **C) `lusrmgr.msc`**
    *   Explanation: Local Users and Groups Manager (`lusrmgr.msc`) is the MMC snap-in for managing local user accounts and groups. `secpol.msc` is for security policies, `services.msc` for services, and `eventvwr.msc` for event logs.

2.  **B) `passwd`**
    *   Explanation: The `passwd` command is used to change passwords for user accounts in Linux. `chpasswd` is used for batch updates.

3.  **B) Granting users only the permissions necessary to perform their tasks.**
    *   Explanation: This is the definition of the principle of least privilege, minimizing potential damage if an account is compromised.

4.  **C) `/etc/shadow`**
    *   Explanation: The `/etc/shadow` file stores the hashed passwords and password aging information. `/etc/passwd` stores user account information (but typically not the hash itself anymore), `/etc/group` stores group information, and `/etc/sudoers` controls sudo privileges.

5.  **C) Administrators**
    *   Explanation: The Administrators group has full control over the system. Power Users is a legacy group with fewer privileges, and Remote Desktop Users only grants RDP access.

6.  **C) Execute a command as another user (usually root)**
    *   Explanation: `sudo` (superuser do) allows permitted users to run specific commands as the superuser (root) or another specified user.

7.  **B) It prevents unauthenticated or anonymous access.**
    *   Explanation: The Guest account provides a low-privilege way for users without an account to log in or access network resources, which is often a security risk.

8.  **A) Owner: RWX, Group: R-X, Other: ---**
    *   Explanation: Permissions are read in triplets (owner, group, other). `r`=4, `w`=2, `x`=1. So, `rwx` = 4+2+1=7, `r-x` = 4+0+1=5, `---` = 0+0+0=0. Thus, 750.

## Short Answer

9.  **Why is it important to enforce a strong password policy?**
    *   Explanation: Strong password policies make it significantly harder for attackers to guess or crack passwords using brute-force or dictionary attacks. Complexity (using upper/lower case, numbers, symbols) increases the keyspace. Length makes brute-forcing computationally infeasible. History prevents reusing easily guessable or previously compromised passwords. Aging forces users to change passwords periodically, limiting the window of opportunity if a password is compromised.

10. **In Windows, besides the `Administrators` group, what other group membership might grant a user significant remote access capabilities that should be reviewed?**
    *   Explanation: The **`Remote Desktop Users`** group. Members of this group are allowed to connect to the computer remotely using Remote Desktop Protocol (RDP), which grants significant interactive access. Other groups like Backup Operators might also have elevated privileges worth checking.

---
*(End of Solution Key)*
