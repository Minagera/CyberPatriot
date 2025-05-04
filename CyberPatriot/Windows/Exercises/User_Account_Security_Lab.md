# User Account Security Lab

## Overview

This lab will guide you through auditing and securing user accounts on both Windows and Linux systems. You will identify unauthorized users, enforce password policies, and document your changes.

## Objectives

- Audit all user accounts and groups
- Remove unauthorized or suspicious accounts
- Enforce strong password policies
- Secure group memberships (especially Administrators/sudo)
- Document all changes and findings

## Instructions

### Part 1: Windows

1. List all user accounts:
   - `net user`
2. List all groups and their members:
   - `net localgroup`
   - `net localgroup Administrators`
3. Remove unauthorized users:
   - `net user <username> /delete`
4. Enforce password policy:
   - `net accounts /minpwlen:12 /maxpwage:90 /uniquepw:5`
5. Remove users from Administrators group if not authorized:
   - `net localgroup Administrators <username> /delete`
6. Document all changes in your change log.

### Part 2: Linux

1. List all users:
   - `cut -d: -f1 /etc/passwd`
2. List sudo group members:
   - `getent group sudo`
3. Remove unauthorized users:
   - `sudo deluser <username>`
4. Enforce password policy:
   - Edit `/etc/login.defs` and `/etc/pam.d/common-password`
5. Remove users from sudo group if not authorized:
   - `sudo deluser <username> sudo`
6. Document all changes in your change log.

## Deliverables

- Completed change log documenting all actions
- Answers to the following questions:
  1. How did you identify unauthorized accounts?
  2. What password policies did you implement?
  3. How did you verify group memberships were correct?

*This lab is unique and designed for CyberPatriot training. Practice these steps regularly!*
