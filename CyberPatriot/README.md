# Comprehensive CyberPatriot Training Guide

This repository provides a structured and comprehensive set of resources designed for training high school JROTC cadets for the Air Force Association's CyberPatriot National Youth Cyber Defense Competition. It incorporates strategies focused on incident response, system hardening, and forensic analysis across Windows, Linux, and Cisco platforms.

**Always start by reading the README file in each directory to understand its contents and navigation.**

## Directory Reference

-   [**Curriculum/**](Curriculum/README.md): Structured weekly training plans, objectives, exercises, and quizzes.
-   [**Windows/**](Windows/README.md): Guides, checklists, exercises, scripts, quizzes, and VM setup resources specific to Windows (Windows 11/Server).
-   [**Linux/**](Linux/README.md): Guides, checklists, exercises, scripts, quizzes, and VM setup resources specific to Linux (Ubuntu/Mint).
-   [**Cisco/**](Cisco/README.md): Guides, checklists, exercises, and Packet Tracer resources specific to Cisco IOS networking.
-   [**Checklists/**](Checklists/README.md): Centralized, actionable security checklists for rapid hardening during competition.
-   [**Exercises/**](Exercises/README.md): Hands-on practice scenarios simulating competition challenges across all platforms.
-   [**Quizzes/**](Quizzes/README.md): Assessment tools to test knowledge of security concepts, tools, and procedures.
-   [**Resources/**](Resources/README.md): Reusable templates, command references, core security principles, and tools.
-   [**VM-Setup/**](VM-Setup/README.md): Scripts and guides for creating vulnerable virtual machine environments for realistic practice.
-   [**Team_Resources/**](Team_Resources/README.md): Guides and templates for competition strategy, team roles, workflow, and communication.
-   [**Meld/**](Meld/README.md): Guides on using baselining techniques with tools like Meld for effective vulnerability discovery.
-   [**Sponsorships/**](Sponsorships/README.md): Templates and information for seeking program support and funding.

## Understanding CyberPatriot: The Correct Perspective

CyberPatriot is best defined as an **incident response and remediation competition**. Teams inherit compromised systems and must:
1.  Identify unauthorized changes and security issues.
2.  Find and analyze forensic artifacts.
3.  Remove attacker persistence mechanisms.
4.  Apply security hardening to prevent future attacks.
This requires a deeper understanding than simply applying fixes from a list.

## Training Approach

1.  **Develop the Security Mindset:** Focus on *why* security measures work, not just *what* they are. Understand attacker motivations and techniques.
2.  **Focus on Operating System Familiarity:** Build deep knowledge of Windows (Registry, GPO, Services, Event Logs) and Linux (Users, PAM, Systemd, Cron, Permissions, Logs).
3.  **Research-Driven Preparation:** Learn about common services (HTTP, DNS, SSH, RDP, SQL, Mail, SMB) and how to secure them *before* the competition.
4.  **Baselining Strategy:** Master comparing competition images to known-good configurations to quickly spot deviations. Use tools like Meld.
5.  **Effective Team Composition:** Assign roles (Windows, Linux, Cisco, Documentation/Forensics, Orchestrator) but encourage cross-training.
6.  **The Competition "Gameplan":** Develop a repeatable workflow: Read README -> Baseline -> Users/Groups -> Backdoors/Malware -> Updates -> Services -> Hardening -> Permissions -> Forensics -> Verify Score.

## Training Resources

-   **Incident Response Training VMs:** Use the `VM-Setup` scripts to create realistic post-breach scenarios.
-   **Cisco Packet Tracer Scenarios:** Practice network hardening, ACLs, and secure configurations in `Cisco/PacketTracer_Scenarios/`.
-   **Checklists & References:** Utilize materials in `Checklists/` and `Resources/References/` for quick access during practice and competition.
-   **Quizzes & Exercises:** Reinforce learning with materials in `Quizzes/` and `Exercises/`.

## Implementation Schedule

-   **Phase 1 (Fundamentals):** OS Basics, Networking, Security Principles, User Management.
-   **Phase 2 (Intermediate):** System Hardening (Win/Lin), Firewall Config, Basic Scripting.
-   **Phase 3 (Advanced):** Advanced Security (Win/Lin), Advanced Networking/Packet Tracer, Competition Strategy, Mock Competitions.

## Continuous Improvement

-   Conduct after-action reviews following each practice/competition round.
-   Identify knowledge gaps and areas for improvement.
-   Update checklists, scripts, and documentation based on lessons learned.
-   Research unfamiliar vulnerabilities or services encountered.

## Conclusion

Success in CyberPatriot requires a blend of technical skill, strategic thinking, effective teamwork, and a commitment to continuous learning. This repository provides the foundation for building a highly competitive team.

---
*All materials in this repository are intended to be unique and specifically tailored for CyberPatriot training. Contributions and improvements are welcome.*
