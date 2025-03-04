# Comprehensive CyberPatriot Training Guide

This guide incorporates the key insights from Akshay's "How To Win CyberPatriot" document along with practical training strategies for your CyberPatriot cadets.

## Understanding CyberPatriot: The Correct Perspective

CyberPatriot is not simply a system hardening competition. Instead, it's best defined as:

> An incident response and remediation competition where teams step into the role of a corporate incident response team that has inherited a business computer network in the aftermath of a cyber-attack on the company's servers. During the competition, teams work to uncover forensic data around the incident, reverse malicious or extraneous changes made by the threat actors, and further harden the system to protect it from future threats.

This definition shifts the focus from merely collecting and applying hardening techniques to understanding attack vectors, persistence mechanisms, and forensic artifacts - skills closely aligned with real-world cybersecurity roles.

## Training Approach

### 1. Develop the Security Mindset

Rather than treating CyberPatriot like a "gotta catch 'em all" vulnerability hunt, teach cadets to develop a fundamental security mindset:

- **Research security principles**, not just specific fixes
- **Understand system internals** and how attackers might exploit them
- **Learn to baseline** a clean system and compare it to compromised ones
- **Respect the challenge** by doing things the "right way" rather than taking shortcuts

### 2. Focus on Operating System Familiarity

Develop deep knowledge of operating system mechanics:

#### Linux:
- User/group management and /etc/passwd, /etc/shadow, /etc/group
- Pluggable Authentication Modules (PAM)
- Package management (APT/DNF)
- Systemd services
- CRON jobs
- File permissions and ownership
- System logging

#### Windows:
- User management and authentication
- Registry structure and important keys
- Group Policy and Local Security Policy
- Service management
- Task Scheduler
- Windows Defender
- Event logs

### 3. Research-Driven Preparation

Research should occur before, during, and after each competition:

#### Critical Services to Research:
- HTTP/S: Apache2, IIS
- DNS: Windows DNS, Bind9
- Remote Management: OpenSSH, RDP
- Database: MySQL/MariaDB, MSSQL
- Mail: Exchange, Postfix
- File Sharing: FTP, SMB
- Identity Management: Active Directory

### 4. Baselining Strategy

The most effective approach to finding vulnerabilities:

1. **Create clean baselines** of systems and configurations
2. **Compare competition images** to these baselines
3. **Identify deviations** that may represent vulnerabilities or compromises

Tools like **Meld** (visual diff tool) can be invaluable for comparing configuration files.

### 5. Effective Team Composition

Optimal team structure:
- 2 Windows specialists
- 1 Linux specialist
- 1 Linux/Extra Challenge competitor
- 1 dedicated Cisco competitor
- 1 "Jack of All Trades" (likely substitute)

### 6. The Competition "Gameplan"

Develop a structured approach for each competition round:

1. Analyze the README and forensic questions
2. Fix potential issues that could affect tools or scripts
3. Perform comprehensive baselining to identify abnormalities
4. Manage users and groups according to requirements
5. Hunt for backdoors and malware
6. Update the system
7. Manage packages and services
8. Apply system hardening (PAM, sysctl, etc.)
9. Secure critical services
10. Fix file and directory permissions

## Training Resources

### 1. Incident Response Training VMs

The provided VM setup scripts create realistic post-attack scenarios that teach cadets to:
- Identify and remove attacker persistence mechanisms
- Analyze forensic artifacts to understand attack methods
- Secure vulnerable services and configurations
- Apply proper security measures to prevent future breaches

These VMs align with the actual CyberPatriot competition format - they're not just systems that need hardening, but systems that have been compromised and need investigation and remediation.

### 2. Cisco Network Training

The Cisco packet tracer scenarios focus on:
- Identifying and mitigating network vulnerabilities
- Securing network devices and services
- Implementing secure routing and access controls
- Troubleshooting security issues

### 3. Team Building Activities

To build cohesion and enhance teamwork:
- Schedule regular team meetings (2-3 hours weekly)
- Create a shared task management system
- Establish shared, organized repositories for scripts and checklists
- Conduct post-competition reviews to improve processes

## Implementation Schedule

### Pre-Competition (Summer/Early Fall)
1. Team formation and role assignments
2. Operating system and service fundamentals training
3. Introduction to baselining techniques
4. Development of initial scripts and checklists

### Initial Training Phase
1. Work with basic-level VMs to understand fundamental security concepts
2. Practice with Cisco packet tracer scenarios
3. Develop and refine competition "gameplan"
4. Participate in practice rounds

### Advanced Training Phase
1. Work with intermediate and advanced VMs that simulate real attacks
2. Practice baselining and malware/backdoor identification
3. Refine scripts and processes for consistency
4. Conduct timed practice competitions

## Continuous Improvement

After each competition round:
1. Review performance and identify knowledge gaps
2. Research services or vulnerabilities that were challenging
3. Update scripts and checklists
4. Practice with similar scenarios to reinforce learning

## Conclusion

Success in CyberPatriot comes from:
1. Understanding the true nature of the competition (incident response)
2. Developing a structured approach rather than just collecting fixes
3. Building deep knowledge of operating systems and security principles
4. Creating effective team dynamics and processes
5. Practicing with realistic scenarios that match the competition format

By following this guide, your CyberPatriot team will develop the skills needed for success in both the competition and future cybersecurity careers.
