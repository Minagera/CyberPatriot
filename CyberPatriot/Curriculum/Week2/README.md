# Week 2: Linux Fundamentals

## Learning Objectives
By the end of this session, cadets will be able to:
- Navigate the Linux command line interface with confidence
- Execute basic Linux commands for system administration
- Understand Linux file permissions and ownership concepts
- Identify key Linux system directories and their purposes
- Perform basic security checks in a Linux environment
- Use common Linux security tools

## Pre-class Preparation
- Install Ubuntu 22.04 or Linux Mint VM on your system
- Read [Linux/README.md](../../Linux/README.md) in the repository
- Complete the [Linux Command Line Basics tutorial](https://linuxjourney.com/) (Grasshopper level)
- Watch [Introduction to Linux Security video](https://www.youtube.com/watch?v=example) (placeholder link)

## Lesson Plan

### 1. Introduction to Linux (25 minutes)
- Linux philosophy and open-source model
- Common Linux distributions used in CyberPatriot (Ubuntu, Linux Mint)
- Linux vs. Windows: key differences in security approach
- Linux architecture overview
- Key Linux security features

### 2. Command Line Fundamentals (35 minutes)
- Terminal interface overview
- Basic navigation commands (`cd`, `ls`, `pwd`)
- File manipulation commands (`cp`, `mv`, `rm`, `mkdir`)
- Text processing commands (`cat`, `grep`, `less`)
- System information commands (`uname`, `top`, `ps`, `who`)
- Command structure and syntax
- Command history and tab completion

### 3. Linux File System Security (40 minutes)
- Linux file system hierarchy standard
- File permissions explained (read, write, execute)
- User, group, and other permission contexts
- Viewing permissions with `ls -l`
- Changing permissions with `chmod`
- Changing ownership with `chown` and `chgrp`
- Special permissions (SUID, SGID, sticky bit)
- Understanding `/etc/passwd` and `/etc/shadow`

### 4. Linux User Management (30 minutes)
- User accounts and groups in Linux
- Creating and managing users (`useradd`, `usermod`, `userdel`)
- Managing groups (`groupadd`, `groupmod`, `groupdel`)
- Password policies and management
- Switching users with `su` and `sudo`
- Understanding the root account and its security implications

### 5. Hands-on Exercise (60 minutes)
- **Exercise**: [Linux Security Basics Lab](../../Linux/Exercises/Linux_Security_Basics_Lab.md)
  - Set up a secure Linux user environment
  - Configure appropriate file permissions
  - Practice command line security tools
  - Analyze system logs for security events

### 6. Assessment (20 minutes)
- [Linux Fundamentals Quiz](../../Linux/Quizzes/Quiz-Files/Linux_Fundamentals_Quiz.md)
- Group review of answers
- Discussion of common misconceptions

### 7. Wrap-up and Preview (10 minutes)
- Recap key Linux concepts
- Assign homework (see below)
- Preview next week (Networking Fundamentals & Cisco Basics)
- Q&A session

## Homework Assignment
1. Complete the [Linux User Management Guide](../../Linux/Guides/Basic/Linux_User_Management.md)
2. Practice 10 essential Linux commands and document their security uses
3. Identify three critical system files in Linux and explain their security implications
4. Begin exploring basic system hardening techniques for Linux

## Additional Resources
- [Linux Security Documentation](https://wiki.archlinux.org/title/Security)
- [CyberPatriot Linux Security Checklist](../../Checklists/Linux/Linux_Security_Checklist.md)
- [The Linux Command Line book by William Shotts](http://linuxcommand.org/tlcl.php)
- [Linux Journey - Permissions](https://linuxjourney.com/lesson/file-permissions)
- [Common Linux Vulnerabilities in CyberPatriot](https://example.com/linux-vulnerabilities) (placeholder link)

## Materials Needed
- Ubuntu 22.04/Linux Mint VM for each cadet
- Projection system for demonstrations
- Printed command reference sheets
- Access to repository materials
- Quiz handouts or online quiz system

## Instructor Notes
- Many cadets may have limited Linux experience - be patient with basics
- Encourage using the terminal rather than GUI tools
- Have reference materials ready for common commands
- Allow time for troubleshooting VM issues
- Emphasize the importance of careful typing and syntax in commands
- Highlight commands and techniques commonly needed in competition
- Be ready to assist with permission concepts, which can be confusing for beginners
