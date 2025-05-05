# Linux Security Basics Exercise

## Scenario

You've logged into a Linux server used by several developers. Perform initial checks to understand the user environment and basic system state.

## Objectives

-   Practice basic user and group management commands.
-   Understand and modify basic file permissions.
-   Use commands to find files and check running services.

## Tasks

1.  **User & Group Exploration:**
    *   List all users present in `/etc/passwd`.
    *   List all groups in `/etc/group`.
    *   Identify which users are members of the `sudo` group.
    *   Create a new user named `testuser`.
    *   Create a new group named `testgroup`.
    *   Add `testuser` to `testgroup`.
    *   Verify `testuser`'s group memberships.
    *   Delete `testuser` and `testgroup`.
2.  **File Permissions:**
    *   Create a file named `myfile.txt` in your home directory (`touch myfile.txt`).
    *   View its default permissions using `ls -l`.
    *   Remove read permission for 'others' (`chmod o-r myfile.txt`). Verify the change.
    *   Add write permission for the 'group' (`chmod g+w myfile.txt`). Verify the change.
    *   Create a directory named `mydir` (`mkdir mydir`).
    *   Set permissions on `mydir` so that only the owner can read, write, and execute, and no one else has any permissions (`chmod 700 mydir`). Verify.
3.  **Finding Files:**
    *   Find all files in the `/etc` directory that end with `.conf`.
    *   Find all files in your home directory modified in the last 24 hours.
    *   Search for the text "PermitRootLogin" within the `/etc/ssh/sshd_config` file.
4.  **Service Status:**
    *   Check if the `ssh` service (sshd) is running.
    *   Check if the `ufw` service (firewall) is active.
    *   List all currently running services.
    *   List all listening network ports and the services associated with them.

## Deliverables

-   Commands used to perform each task.
-   Output snippets verifying changes (e.g., `ls -l` output, group membership confirmation).

## Hints

-   Commands: `cat`, `grep`, `useradd`, `groupadd`, `usermod`, `userdel`, `groupdel`, `id`, `touch`, `mkdir`, `ls`, `chmod`, `find`, `systemctl`, `ss`, `ufw`.
-   Use `man [command]` to learn more about command options.

*(This is a placeholder exercise.)*
