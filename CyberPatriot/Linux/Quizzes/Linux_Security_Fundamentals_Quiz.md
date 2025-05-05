# Linux Security Fundamentals Quiz

**Instructions:** Answer the following questions to the best of your ability.

## Multiple Choice

1.  Which command is used to change file permissions in Linux?
    a) `chown`
    b) `chgrp`
    c) `chmod`
    d) `ls`

2.  What command displays the current directory you are in?
    a) `cd`
    b) `ls`
    c) `pwd`
    d) `whoami`

3.  Which command is used to install software packages on Ubuntu/Mint?
    a) `yum install`
    b) `pacman -S`
    c) `apt install`
    d) `rpm -i`

4.  What does the permission `rwxr-xr--` (octal 754) mean for a file?
    a) Owner: RWX, Group: RX, Others: R
    b) Owner: RWX, Group: RWX, Others: R
    c) Owner: R, Group: RX, Others: RWX
    d) Owner: RW, Group: RX, Others: R

5.  Which command is used to check the status of a service managed by systemd?
    a) `service [name] status`
    b) `systemctl status [name]`
    c) `/etc/init.d/[name] status`
    d) `chkconfig --list [name]`

## True/False

6.  The `root` user (UID 0) has unrestricted access to the system. (True/False)
7.  The command `useradd -m student` creates a user named 'student' and also creates their home directory. (True/False)
8.  The `/etc/passwd` file contains encrypted user passwords. (True/False)
9.  `grep` is used to search for text patterns within files. (True/False)
10. The command `find / -name "*.log"` searches the entire filesystem for files ending with `.log`. (True/False)

## Short Answer

11. What command would you use to change the owner of `file.txt` to `bob` and the group to `developers`?
12. Where are system-wide log files typically stored on a Linux system? (Give the directory path)
13. What is the purpose of the `sudo` command?
14. How do you view the contents of a text file named `config.txt` one page at a time?
15. What command lists the IP addresses configured on the system's network interfaces?

---

*(This is a placeholder quiz. Questions should be reviewed, expanded, and potentially randomized. A corresponding solution file needs to be created in Quizzes/Solutions/)*
