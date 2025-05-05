# Week 2: Linux Fundamentals and Command Line Interface (CLI)

## Learning Objectives

By the end of this week, cadets will be able to:
-   Navigate the Linux file system using essential CLI commands.
-   Manage files and directories (create, delete, copy, move, view).
-   Understand and interpret basic Linux file permissions (read, write, execute for user, group, other).
-   Use common Linux utilities for system information and text manipulation (`ls`, `cd`, `pwd`, `mkdir`, `rm`, `cp`, `mv`, `cat`, `less`, `grep`, `find`, `sudo`).
-   Understand the concept of `root` and the use of `sudo`.
-   Perform basic package management using `apt` (`update`, `upgrade`, `install`, `remove`).

## Topics Covered

-   Introduction to Linux Distributions (Ubuntu/Mint focus)
-   The Linux Filesystem Hierarchy Standard (FHS) overview (`/`, `/home`, `/etc`, `/var`, `/tmp`, `/bin`, `/sbin`)
-   Essential CLI Navigation: `pwd`, `ls` (with options like `-l`, `-a`, `-h`), `cd` (absolute/relative paths, `..`, `~`)
-   File/Directory Management: `mkdir`, `rmdir`, `touch`, `rm` (`-r`, `-f`), `cp` (`-r`), `mv`
-   Viewing Files: `cat`, `less`, `more`, `head`, `tail`
-   Permissions: Understanding `rwx` for User, Group, Other; `chmod` (symbolic and octal basics), `chown` (basic usage)
-   Users and Groups: Basic concepts, `whoami`, `id`, `groups`
-   Superuser (`root`) and `sudo`: Executing commands with elevated privileges.
-   Searching for Files/Text: `find` (basic usage by name), `grep` (basic pattern matching)
-   Package Management: `sudo apt update`, `sudo apt upgrade`, `sudo apt install <package>`, `sudo apt remove <package>`, `apt list --installed`

## Activities/Exercises

-   **Lab 1:** Guided tour of the Linux CLI on a clean Ubuntu/Mint VM. Practice navigation, file/directory manipulation, and viewing file contents.
-   **Lab 2:** Permissions Practice: Create files/directories, view default permissions, use `chmod` to change permissions, observe effects on access. Use `sudo` to perform privileged operations.
-   **Lab 3:** Package Management: Update package lists, install a simple tool (e.g., `htop`), list installed packages, remove the tool.
-   **Exercise:** [Unique Linux CLI Basics Exercise](../Exercises/Linux/Intro/README.md) - Navigate to specific directories, create a file structure, set specific permissions, find files containing certain text, install/remove a package.

## Assessment

-   Participation in labs and CLI practice.
-   Completion of [Unique Linux CLI Basics Exercise](../Exercises/Linux/Intro/README.md).
-   [Unique Linux Fundamentals Quiz](../Quizzes/Quiz-Files/Linux_Security_Fundamentals_Quiz.md)

## Resources

-   [Unique Linux Basics Guide](../Linux/Guides/Basic/README.md) (Focus on CLI, Filesystem, Permissions)
-   [Unique Linux Command Reference](../Resources/References/Linux_Security_Reference.md)
-   Online Linux command tutorials (e.g., Linux Journey, Ubuntu tutorials)

---
*This weekly plan is uniquely designed for the Grissom JROTC CyberPatriot program.*
