# Linux System Hardening Quiz

**Instructions:** Answer the following questions related to Linux security hardening techniques.

## Multiple Choice

1.  Which UFW command allows incoming traffic on TCP port 80?
    a) `sudo ufw allow 80`
    b) `sudo ufw allow tcp 80`
    c) `sudo ufw allow http`
    d) Both b and c

2.  In `/etc/ssh/sshd_config`, setting `PermitRootLogin no` achieves what?
    a) Allows root login only with SSH keys
    b) Disables SSH access entirely
    c) Prevents the root user from logging in via SSH
    d) Requires root to use a specific password

3.  Which file is typically edited to configure password aging policies (like `PASS_MAX_DAYS`)?
    a) `/etc/passwd`
    b) `/etc/shadow`
    c) `/etc/pam.d/common-password`
    d) `/etc/login.defs`

4.  What does the SUID (Set User ID) permission bit allow when set on an executable file?
    a) Allows any user to modify the file
    b) Allows the program to run with the file owner's privileges
    c) Allows the program to run with the file group's privileges
    d) Allows the program to be executed only by the owner

5.  Which command is used to stop and disable a service named `apache2` from starting on boot using systemd?
    a) `sudo systemctl stop apache2 && sudo systemctl disable apache2`
    b) `sudo service apache2 stop && sudo update-rc.d apache2 disable`
    c) `sudo killall apache2 && sudo rm /etc/init.d/apache2`
    d) `sudo systemctl kill apache2`

## True/False

6.  UFW (Uncomplicated Firewall) is enabled by default on most Ubuntu installations. (True/False)
7.  Changing the default SSH port makes the SSH service fundamentally more secure against targeted attacks. (True/False)
8.  Cron jobs defined in `/etc/cron.d/` run with the privileges of the root user by default. (True/False)
9.  World-writable directories (`chmod 777`) are generally considered secure for temporary file storage. (True/False)
10. The `/var/log/auth.log` file typically records successful and failed login attempts. (True/False)

## Short Answer

11. What command would you use to find all files in `/var/www` that are world-writable?
12. Name one setting in `/etc/ssh/sshd_config` (other than `PermitRootLogin` or `Port`) that enhances security.
13. What is the purpose of installing and configuring `libpam-pwquality`?
14. How can you view the scheduled cron jobs for the user `www-data`?
15. What potential security risk is associated with unnecessary SUID binaries?

---

*(This is a placeholder quiz. Questions should be reviewed, expanded, and potentially randomized. A corresponding solution file needs to be created in Quizzes/Solutions/)*
