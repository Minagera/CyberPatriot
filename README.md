# Grissom High School JROTC CyberPatriot Program

This repository provides a structured and comprehensive set of unique resources designed for training high school JROTC cadets for the Air Force Association's CyberPatriot National Youth Cyber Defense Competition. It incorporates strategies focused on incident response, system hardening, and forensic analysis across Windows, Linux, and Cisco platforms, aiming for Nationals-level proficiency. All content herein is developed specifically for this program and aims for originality.

**Always start by reading the README file in each directory to understand its contents and navigation.**

## Directory Reference

-   [**Curriculum/**](./CyberPatriot/Curriculum/README.md): Structured 12-week training plans, objectives, exercises, and quizzes.
-   [**Windows/**](./CyberPatriot/Windows/README.md): Guides, platform-specific exercises, scripts, and quizzes specific to Windows (Windows 11/Server).
-   [**Linux/**](./CyberPatriot/Linux/README.md): Guides, platform-specific exercises, scripts, and quizzes specific to Linux (Ubuntu/Mint).
-   [**Cisco/**](./CyberPatriot/Cisco/README.md): Guides, platform-specific exercises, Packet Tracer resources, and quizzes specific to Cisco IOS networking.
-   [**Checklists/**](./CyberPatriot/Checklists/README.md): Centralized, actionable security checklists for rapid hardening during competition. **Crucially, always read the competition README first!**
-   [**Exercises/**](./CyberPatriot/Exercises/README.md): General or cross-platform hands-on practice scenarios simulating competition challenges. Platform-specific exercises reside within `Windows/Exercises/`, `Linux/Exercises/`, `Cisco/Exercises/`.
-   [**Quizzes/**](./CyberPatriot/Quizzes/README.md): General or cross-platform assessment tools. Platform-specific quizzes reside within `Windows/Quizzes/`, `Linux/Quizzes/`, `Cisco/Quizzes/`. Solutions are typically in a `Solutions/` subdirectory for mentor use only.
-   [**Resources/**](./CyberPatriot/Resources/README.md): Reusable templates (Change Logs, Reports), command references (Cheat Sheets), core security principles, and potentially tools.
-   [**VM-Setup/**](./CyberPatriot/VM-Setup/README.md): Scripts and guides for creating vulnerable virtual machine environments ([Windows](./CyberPatriot/VM-Setup/Windows/README.md), [Linux](./CyberPatriot/VM-Setup/Linux/README.md)) and Cisco Packet Tracer scenarios ([Cisco](./CyberPatriot/VM-Setup/Cisco/README.md)) for realistic practice.
-   [**Team_Resources/**](./CyberPatriot/Team_Resources/README.md): Guides and templates for competition strategy, team roles, workflow, and communication protocols.
-   [**Meld/**](./CyberPatriot/Meld/README.md): Guides on using baselining techniques with tools like Meld for effective vulnerability discovery.
-   [**Sponsorships/**](./CyberPatriot/Sponsorships/README.md): Templates and information for seeking program support and funding (e.g., for Grissom HS JROTC).

---

## Directory Index

Below is a complete index of the `CyberPatriot` directory, organized for quick navigation and understanding.

-   **Curriculum/**: 12-week training curriculum, lesson plans, and objectives. (e.g., `Week01/`, `Week02/`)
-   **Windows/**: Windows 11/Server security training.
    -   `Guides/`: Basic, Intermediate, Advanced security concepts.
    -   `Exercises/`: Hands-on Windows challenges.
    -   `Scripts/`: PowerShell scripts for auditing/automation (Templates, Examples, Solutions).
    -   `Quizzes/`: Windows-specific assessments (Quiz-Files, Solutions).
-   **Linux/**: Ubuntu/Mint security training.
    -   `Guides/`: Basic, Intermediate, Advanced security concepts.
    -   `Exercises/`: Hands-on Linux challenges.
    -   `Scripts/`: Bash scripts for auditing/automation (Templates, Examples, Solutions).
    -   `Quizzes/`: Linux-specific assessments (Quiz-Files, Solutions).
-   **Cisco/**: Cisco Packet Tracer and IOS security training.
    -   `Guides/`: Basic, Intermediate, Advanced networking concepts.
    -   `Exercises/`: Hands-on Cisco CLI challenges.
    -   `PacketTracer/`: `.pkt` scenarios and solutions.
    -   `Scripts/`: Configuration script templates/examples.
    -   `Quizzes/`: Cisco-specific assessments (Quiz-Files, Solutions).
-   **Checklists/**: Centralized security checklists for competition use.
    -   `Windows/`: Windows hardening checklist.
    -   `Linux/`: Linux hardening checklist.
    -   `Cisco/`: Cisco hardening checklist.
-   **Exercises/**: General/cross-platform hands-on practice scenarios.
-   **Quizzes/**: General/cross-platform quizzes with solutions for mentors.
    -   `Quiz-Files/`: Cadet-facing quiz documents.
    -   `Solutions/`: Mentor-only answer keys.
-   **Resources/**: Shared assets.
    -   `Templates/`: Change Logs, Incident Reports, Forensics Answers, etc.
    -   `References/`: Command Cheat Sheets (Win, Lin, Cisco).
    -   `Tools/`: Placeholder for future utilities.
    -   `Core_Security_Principles.md`: Foundational concepts.
-   **VM-Setup/**: Scripts and docs for creating practice environments.
    -   `Windows/`: PowerShell script (`.ps1`) and README for Windows VM setup.
    -   `Linux/`: Bash script (`.sh`) and README for Linux VM setup.
    -   `Cisco/`: Packet Tracer files (`.pkt`) and README for Cisco scenario setup.
-   **Team_Resources/**: Guides on competition strategy, team roles, workflow, communication protocols, and practice schedules.
-   **Meld/**: Baselining guides for using Meld to compare clean and compromised systems.
-   **Sponsorships/**: Templates and info for seeking program support (brochures, letters).
-   **CONTRIBUTING.md**: Guidelines for contributing to the repository.
-   **LICENSE**: License information (e.g., MIT).

---

## Overview

This repository contains unique training materials, exercises, and resources specifically developed for the Grissom High School JROTC CyberPatriot teams. The materials are designed to prepare cadets for the CyberPatriot competition by providing structured learning paths, hands-on exercises, and competition preparation resources, focusing on an incident response and remediation mindset suitable for reaching the National Finals.

## Table of Contents

-   [What is CyberPatriot?](#what-is-cyberpatriot)
-   [Repository Structure](#repository-structure)
-   [Getting Started](#getting-started)
-   [Training Approach (Nationals Focus)](#training-approach-nationals-focus)
-   [Training Tracks](#training-tracks)
-   [Competition Preparation](#competition-preparation)
-   [Resources](#resources)
-   [Team Information](#team-information)
-   [Scenario Generation and Automation](#scenario-generation-and-automation)
-   [Gap Analysis and Roadmap (25-26 Season Focus)](#gap-analysis-and-roadmap-25-26-season-focus)
-   [Contributing](#contributing)
-   [License](#license)

## What is CyberPatriot?

CyberPatriot is the National Youth Cyber Defense Competition created by the Air Force Association (AFA). It places teams in the position of newly hired IT professionals tasked with managing the network of a small company. In the rounds of competition, teams are given a set of virtual operating systems (Windows, Linux) and network simulations (Cisco Packet Tracer) and are tasked with finding cybersecurity vulnerabilities, removing malware/persistence, hardening the systems, and maintaining critical services within a limited time frame. It is best viewed as an **incident response and remediation competition** under pressure.

The competition consists of three main scored components:
1.  **Windows Operating System Security** (e.g., Windows 11, Windows Server)
2.  **Linux Operating System Security** (e.g., Ubuntu, Linux Mint)
3.  **Cisco Networking Challenge** (includes Packet Tracer simulation and conceptual quiz)

Success requires technical proficiency, strategic thinking, effective teamwork, and meticulous documentation.

## Repository Structure

This repository is organized into several key directories within the main `CyberPatriot` folder:

-   `Curriculum/` - Overall curriculum structure and learning paths (e.g., 12 Weeks).
-   `Windows/` - Windows security training materials and platform-specific exercises/quizzes.
-   `Linux/` - Linux security training materials and platform-specific exercises/quizzes.
-   `Cisco/` - Cisco networking training materials and platform-specific exercises/quizzes.
-   `Checklists/` - Security checklists for all platforms (Use *after* reading the competition README).
-   `Exercises/` - General/cross-platform hands-on practice scenarios. Platform-specific exercises are in the respective OS/Cisco directories.
-   `Quizzes/` - General/cross-platform knowledge assessment quizzes. Platform-specific quizzes are in the respective OS/Cisco directories.
-   `Resources/` - Templates, references, tools, and core principles.
-   `VM-Setup/` - Scripts and instructions for creating practice VMs ([Windows](./CyberPatriot/VM-Setup/Windows/README.md), [Linux](./CyberPatriot/VM-Setup/Linux/README.md)) and Packet Tracer scenarios ([Cisco](./CyberPatriot/VM-Setup/Cisco/README.md)).
-   `Team_Resources/` - Team management materials and competition workflows.
-   `Meld/` - Baselining and comparison guides using tools like Meld.
-   `Sponsorships/` - Sponsorship and support templates (tailored for Grissom HS JROTC).

## Getting Started

### Prerequisites

To effectively utilize these materials for Nationals-level training, cadets should have access to:

1.  A computer with sufficient resources: 16GB+ RAM, multi-core CPU, SSD recommended.
2.  Virtualization Software: VMware Workstation/Player (preferred for compatibility) or VirtualBox.
3.  Base OS Images: Clean installs of Windows (10/11 Pro/Enterprise) and Ubuntu (22.04 LTS Desktop/Server). Obtain legally licensed copies where required.
4.  Cisco Packet Tracer: Latest version (downloadable free via Cisco Networking Academy registration).
5.  Basic computer literacy and a willingness to learn command-line interfaces.
6.  Consistent internet access for research and updates.

### Setup Instructions

1.  Clone this repository:
    ```bash
    git clone https://github.com/Minagera/CyberPatriot.git
    cd CyberPatriot # Navigate into the repository root
    ```
2.  Review the `README.md` files in each top-level directory within `CyberPatriot/` to understand the organization.
3.  Follow the setup guides within the `CyberPatriot/VM-Setup/` subdirectories ([Windows](./CyberPatriot/VM-Setup/Windows/README.md), [Linux](./CyberPatriot/VM-Setup/Linux/README.md), [Cisco](./CyberPatriot/VM-Setup/Cisco/README.md)) to create practice environments. **Always snapshot clean base images before running any setup scripts.**
4.  Begin with the `CyberPatriot/Curriculum/` structure, starting with Week 01, or dive into specific platform `Guides/Basic/` sections if familiar with fundamentals.

## Training Approach (Nationals Focus)

Reaching the National Finals requires more than just basic hardening. This repository emphasizes a deeper, more strategic approach:

1.  **Incident Response Mindset:** Treat every image as a compromised system. Focus on identifying attacker actions, removing persistence, and understanding the *how* and *why* of vulnerabilities, not just applying fixes.
2.  **Deep OS/Network Familiarity:** Develop expert-level knowledge of Windows (Registry, WMI, GPO, Services, Event Logs, PowerShell), Linux (PAM, Systemd, Cron, Permissions, Logs, Bash), and Cisco IOS (CLI, ACLs, SSH, common protocols).
3.  **Rapid Research & Adaptation:** Learn to quickly research unfamiliar services, applications, or vulnerabilities encountered during competition and apply secure configurations.
4.  **Systematic Baselining:** Master techniques to compare competition images against known-good states or initial scans (using tools like Meld, PowerShell/Bash scripting, or manual checks) to rapidly identify unauthorized users, files, processes, services, tasks, and configuration changes.
5.  **Structured Workflow:** Follow a repeatable, efficient process: **Read README & Forensics -> Initial Baseline/Recon -> User Accounts & Groups -> Persistence Mechanisms -> Service Hardening -> Policy Enforcement -> File System Security -> Network Security -> Final Forensics -> Verify Score & Documentation.** Adapt based on README priorities.
6.  **Effective Teamwork & Communication:** Utilize defined roles (see `CyberPatriot/Team_Resources/`) and clear communication protocols (SITREP, BLOCKER) to maximize efficiency and minimize errors under pressure. Documentation is key.

## Training Tracks

### Windows Security Track

Covers security for Windows 11/Server, aiming for advanced proficiency. Topics include user/group management, advanced policy configuration (Local Security Policy/GPO), service hardening & permissions, registry analysis, advanced firewall rules, Defender tuning, PowerShell scripting for security, auditing & log analysis, and common persistence techniques.

[Go to Windows Security Track](./CyberPatriot/Windows/README.md)

### Linux Security Track

Focuses on Ubuntu/Mint security for advanced users. Topics include advanced user/permission management (ACLs, capabilities), PAM configuration, `sudoers` deep dive, `systemd` unit files & security, advanced UFW/iptables, SSH hardening & key management, logging frameworks (journald, syslog-ng/rsyslog), file system security (mount options, auditing), Bash scripting for automation, and common Linux malware/persistence methods.

[Go to Linux Security Track](./CyberPatriot/Linux/README.md)

### Cisco Networking Track

Provides training for complex networking scenarios. Topics include advanced IOS commands, comprehensive device hardening, secure SSH/AAA configuration, complex ACLs (standard, extended, named), VLANs & inter-VLAN routing, switch security (port security, DHCP snooping), common routing protocols (OSPF/EIGRP security), and advanced Packet Tracer troubleshooting.

[Go to Cisco Networking Track](./CyberPatriot/Cisco/README.md)

## Competition Preparation

### Competition Day Strategy

1.  **READ THE README & FORENSICS:** Absolutely critical first step. Identify scenario, authorized items, prohibited actions, point values, and specific tasks. This dictates priorities.
2.  **Assign Roles & Initial Plan:** Quickly confirm roles (Win, Lin, Cisco, Docs/Forensics, Orchestrator) and develop a high-level plan based on the README.
3.  **Initial Recon & Baseline:** Perform quick scans (users, services, processes, network connections, scheduled tasks, startup items). Document the initial state if possible (e.g., using scripts or Meld).
4.  **Prioritize & Execute:** Tackle high-point forensic questions and critical vulnerabilities identified in the README first. Address user accounts and obvious persistence early.
5.  **Document EVERYTHING:** Use templates from `CyberPatriot/Resources/Templates/` (Change Log is essential). Note *what* was changed, *why*, and *when*. This is crucial for troubleshooting and potential score disputes.
6.  **Communicate Effectively:** Use agreed-upon protocols (`CyberPatriot/Team_Resources/`). Announce major changes. Use SITREPs. Use the BLOCKER protocol if stuck for more than a few minutes.
7.  **Verify Scoring Engine:** Check the scoring report frequently. Understand point gains/losses. Revert changes carefully if points are lost unexpectedly, consulting the change log.
8.  **Final Sweep & Review:** Before time expires, review checklists, ensure all forensic questions are answered, finalize documentation, and double-check critical services are running.

[Complete Competition Strategy Guide](./CyberPatriot/Team_Resources/Competition_Strategy_Guide.md)

## Resources

### Official CyberPatriot Materials

-   [CyberPatriot Website](https://www.uscyberpatriot.org/)
-   [CyberPatriot Rules Book](https://www.uscyberpatriot.org/competition/rules-book) (Mandatory reading each season for rule changes)
-   [CyberPatriot Training Materials](https://www.uscyberpatriot.org/competition/training-materials) (Official resources, use as supplementary material)

### Internal Repository Resources

-   [Security Checklists](./CyberPatriot/Checklists/README.md): Quick guides for hardening (use *after* README).
-   [Reference Materials](./CyberPatriot/Resources/References/README.md): Command cheat sheets (Win, Lin, Cisco).
-   [Core Security Principles](./CyberPatriot/Resources/Core_Security_Principles.md): Foundational concepts guiding decisions.
-   [Templates](./CyberPatriot/Resources/Templates/README.md): For documentation during competition (Change Log, Forensics Answers, etc.).

## Team Information

### Team Structure (Recommended)

-   Aim for teams of 2-6 members per AFA rules. Optimize for 4-5 active members if possible.
-   Designated Platform Specialists (Primary/Backup): Windows, Linux, Cisco. Crucial for depth.
-   Supporting Roles:
    -   **Documentation Lead:** Meticulously records all changes, answers forensics questions, manages templates.
    -   **Forensics Lead:** Focuses on finding hidden flags/answers, analyzing logs, investigating based on README clues. Often overlaps with platform specialists.
    -   **Team Captain/Orchestrator:** Manages time, tracks overall progress against README, facilitates communication, makes strategic decisions, monitors scoring engine.

### Practice Schedule

-   Regular weekly sessions (2-3 hours) focusing on specific topics or platforms from the `CyberPatriot/Curriculum/`.
-   Bi-weekly or monthly full-duration sessions (e.g., 4-6 hours) using practice images from CyberPatriot or scenarios generated using `CyberPatriot/VM-Setup/` to simulate competition pressure.
-   Incorporate deliberate practice on weak areas identified in previous sessions.

[Team Formation Guidelines](./CyberPatriot/Team_Resources/team_formation.md)
[Practice Schedule Template](./CyberPatriot/Team_Resources/practice_schedule.md)

## Scenario Generation and Automation

The `CyberPatriot/VM-Setup/` directory contains unique scripts and guides to create compromised VM environments and Packet Tracer scenarios tailored for practice, simulating the incident response nature of the competition.

-   **Windows:** Scripts and guides in `CyberPatriot/VM-Setup/Windows/` (e.g., `enterprise-workstation-setup.ps1`) create scenarios with unauthorized users, various persistence methods (tasks, registry, services), weak policies, disabled security features, and forensic artifacts.
-   **Linux:** Scripts and guides in `CyberPatriot/VM-Setup/Linux/` (e.g., `corporate-server-breach.sh`) set up scenarios with unauthorized users (including UID 0), misconfigured services (SSH, web), persistence (cron, SUID, systemd), disabled firewall, and forensic clues.
-   **Cisco:** Packet Tracer files (`.pkt`) and setup guides are located in `CyberPatriot/VM-Setup/Cisco/`, designed to test hardening, ACLs, and secure configuration skills in a network context.

Future goals include adding more sophisticated generation options (randomization, difficulty levels) and basic scoring mechanisms for self-assessment within these scenarios. See the `CyberPatriot/Resources/Tools/` directory for potential future automation scripts (distinct from setup scripts).

## Gap Analysis and Roadmap (25-26 Season Focus)

This section tracks missing content and planned improvements for enhancing Nationals-level readiness:

-   [ ] **Content Population:** Fully develop advanced guides, exercises, and quizzes for all topics outlined in the curriculum, focusing on complex scenarios, less common vulnerabilities, and techniques seen in recent Nationals rounds. Ensure all content is unique and original.
-   [ ] **VM Setup Scripts:** Enhance scripts with more varied and subtle vulnerabilities (e.g., WMI persistence, advanced registry keys, fileless techniques - simulated), complex forensic trails requiring deeper analysis, and integrated basic scoring checks aligned with CP scoring engines. Add options for difficulty scaling (e.g., Basic, Intermediate, Advanced vulnerability sets).
-   [ ] **Packet Tracer Scenarios:** Create a wider range of challenging Cisco scenarios covering advanced routing security (OSPF/EIGRP auth), IPv6 security basics, VPN concepts (if relevant to CP), complex troubleshooting across multiple devices, and switch security features (DAI, IPSG).
-   [ ] **Advanced Exercises:** Develop multi-stage, cross-platform incident response exercises requiring coordination between team roles, simulating realistic attack chains. Include exercises focused purely on forensic analysis.
-   [ ] **Forensics Focus:** Add dedicated guides and exercises on advanced log analysis (correlating events across Win/Lin logs), memory forensics basics (using tools like Volatility if appropriate for training context), file system forensics techniques (metadata analysis, deleted file recovery concepts), and steganography basics.
-   [ ] **Instructor Guides:** Add detailed solution guides, potential pitfalls, and scoring rubrics within `VM-Setup` and `Exercises` for instructors/mentors. Include explanations of *why* certain vulnerabilities were chosen.
-   [ ] **Uniqueness & Relevance:** Continuously review and update materials based on feedback from official CP rounds and evolving cybersecurity trends, ensuring uniqueness and alignment with competition scope. Add sections on researching unknown applications/services found on images.
-   [ ] **Tooling:** Explore adding guides or simple tools in `Resources/Tools/` for common competition tasks like automated baselining report generation or checklist tracking (distinct from platform audit scripts).

Contributions and suggestions are highly encouraged! See [CONTRIBUTING.md](./CONTRIBUTING.md).

## Contributing

Contributions to this repository are welcome and essential for keeping the material fresh and effective. Please see the [CONTRIBUTING.md](./CONTRIBUTING.md) file for guidelines on how to contribute effectively, ensuring originality and relevance.

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details. All contributed content must be compatible with this license and be original work suitable for educational use under the CyberPatriot program rules.
