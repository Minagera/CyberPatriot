# Solution: User Security Quiz

1. B
2. B
3. B
4. B
5. B
6. False
7. True
8. False
9. True
10. True

11. Review the list of users and compare to the authorized list; look for accounts with unusual names or recent creation dates.
12. Password expiration forces users to change passwords regularly, reducing the risk of compromised credentials being used long-term.
13. More admin users increase the attack surface and risk of accidental or malicious changes.
14. On Windows: `net localgroup Administrators`; on Linux: `getent group sudo` or `grep '^sudo:' /etc/group`.
15. Edit `/etc/pam.d/common-password` to require complexity, or use `passwdqc`/`pam_pwquality` modules.

*Discuss any unclear answers with your mentor!*
