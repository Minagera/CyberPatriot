# Week 2 Quiz - Mentor Review Notes

## Quiz Focus: Linux Fundamentals & CLI

### Key Concepts to Reinforce:

-   **CLI Proficiency:** Emphasize that the command line is essential for efficient Linux administration and security tasks in CyberPatriot. Accuracy matters (case sensitivity, syntax).
-   **Filesystem Navigation:** Ensure cadets understand absolute vs. relative paths, `.` vs `..`, and the purpose of key directories (`/etc`, `/home`, `/var/log`).
-   **Permissions:** Focus on the meaning of `rwx` for files vs. directories, and for User/Group/Other. Practice basic `chmod` (symbolic is often easier initially). Explain *why* permissions are a core security concept.
-   **`sudo`:** Explain that `sudo` grants temporary root privileges for specific commands, which is safer than logging in as root. Stress the importance of not using `sudo` unnecessarily.
-   **Package Management:** Explain the `update` vs. `upgrade` difference. Discuss the importance of keeping systems patched, but *only if allowed by the competition README*.

### Common Mistakes/Misconceptions:

-   Forgetting options for commands like `ls -la`.
-   Confusion between absolute and relative paths.
-   Incorrectly using `rm` (especially without `-r` for directories or accidentally using `-rf`).
-   Misinterpreting permission strings (e.g., `drwxr-xr-x`).
-   Trying to run privileged commands without `sudo`.
-   Mixing up `apt update` and `apt upgrade`.

### Discussion Points for Review:

-   Have cadets demonstrate navigating to a specific directory and listing its contents with details.
-   Ask cadets to explain the permissions needed to read, write, or execute a file, or list contents of a directory.
-   Present a permission string (`-rw-r-----`) and ask who can do what.
-   Discuss scenarios where `sudo` is required and why.
-   Ask how to find a file named `config.txt` somewhere under `/etc`.
-   Review the process for installing a new piece of software using `apt`.

*(Detailed answers and explanations should reference the actual quiz solution file: `../Quizzes/Solutions/Linux_Security_Fundamentals_Quiz_Solution.md`)*

---
*Mentor notes for internal team use. Focus on building comfort and accuracy with the CLI.*
