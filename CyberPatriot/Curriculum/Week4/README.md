# Week 4: Security Principles & User Account Management

## Learning Objectives
By the end of this session, cadets will be able to:
- Explain core cybersecurity principles and best practices
- Implement user account security across Windows and Linux
- Configure password policies and security settings
- Identify unauthorized or suspicious user accounts
- Manage user privileges and permissions effectively
- Apply the principle of least privilege
- Audit and monitor user account activity
- Implement user security templates in competition scenarios

## Pre-class Preparation
- Review [Windows User Management Guide](../../Windows/Guides/Basic/Windows_User_Management.md)
- Review [Linux User Management Guide](../../Linux/Guides/Basic/Linux_User_Management.md)
- Watch [User Account Security video](https://www.youtube.com/watch?v=example) (placeholder link)
- Read [Core Cybersecurity Principles](../../Resources/Core_Security_Principles.md)

## Lesson Plan

### 1. Cybersecurity Fundamentals (30 minutes)
- Core security principles:
  - Confidentiality, Integrity, Availability (CIA triad)
  - Defense in depth
  - Principle of least privilege
  - Separation of duties
  - Need to know
- Common attack vectors and threats
- Security controls (preventive, detective, corrective)
- Risk assessment basics
- Security compliance and standards
- Relevance to CyberPatriot competition

### 2. Windows User Account Management (40 minutes)
- Windows user account types and security contexts
- Built-in accounts (Administrator, Guest, etc.)
- Local users vs. domain users
- User account properties and security settings
- User groups and their security implications
- Password policies and account lockout
- User rights assignment
- Auditing user account activity
- Common user security misconfigurations in Windows

### 3. Linux User Account Management (40 minutes)
- Linux user account fundamentals
- Understanding `/etc/passwd`, `/etc/shadow`, and `/etc/group`
- User and group creation, modification, and deletion
- User privileges and sudo access
- PAM (Pluggable Authentication Modules)
- Password aging and complexity
- Login restrictions
- User environment security
- Common user security misconfigurations in Linux

### 4. Cross-Platform User Security Strategies (25 minutes)
- Similarities and differences in Windows and Linux user security
- Unified approach to user management
- Identifying authorized vs. unauthorized accounts
- User security baselines
- Password policy standardization
- Account lifecycle management
- Administrative access control
- User security documentation

### 5. Hands-on Exercise (60 minutes)
- **Exercise**: [User Security Challenge](../../Exercises/User_Security_Challenge.md)
  - Identify and remediate user account vulnerabilities
  - Implement proper password policies
  - Configure appropriate user rights and permissions
  - Audit user account settings
  - Document user security changes

### 6. Team Challenge (25 minutes)
- Teams compete to find and fix the most user security issues in a simulated environment
- Points awarded for each correct fix and documentation

### 7. Assessment (20 minutes)
- [User Account Security Quiz](../../Quizzes/Quiz-Files/User_Account_Security_Quiz.md)
- Discussion of user security scenarios
- Review of common mistakes

### 8. Wrap-up and Preview (10 minutes)
- Recap key user security concepts
- Assign homework (see below)
- Preview next week (Windows System Hardening)
- Q&A session

## Homework Assignment
1. Create a comprehensive user security checklist for both Windows and Linux
2. Research and document three advanced user security features for each platform
3. Practice implementing user security controls on your VMs
4. Review user security items from past CyberPatriot competition scenarios

## Additional Resources
- [NIST Digital Identity Guidelines](https://pages.nist.gov/800-63-3/)
- [CIS Benchmarks for User Security](https://www.cisecurity.org/cis-benchmarks/)
- [Windows User Security Best Practices](https://example.com/windows-user-security) (placeholder link)
- [Linux User Security Best Practices](https://example.com/linux-user-security) (placeholder link)
- [User Account Management Scripts](../../Scripts/Templates/)

## Materials Needed
- Windows and Linux VMs for each cadet
- User security scenario worksheets
- User account templates and examples
- Security baseline documents
- Projection system for demonstrations
- Access to repository materials
- Quiz handouts or online quiz system

## Instructor Notes
- This session bridges Windows and Linux concepts - highlight similarities
- Use real examples of user security issues from past competitions
- Have cadets work in pairs for the hands-on portions if helpful
- Create realistic user scenarios that might be encountered in competition
- Prepare a "cheat sheet" of essential user management commands
- Be ready to demonstrate proper user security techniques
- Emphasize documentation of user security changes
- Consider creating a virtual "hall of fame" for well-secured user environments
