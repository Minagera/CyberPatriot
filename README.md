# Grissom High School JROTC CyberPatriot Program

This repository provides a structured and comprehensive set of resources designed for training high school JROTC cadets for the Air Force Association's CyberPatriot National Youth Cyber Defense Competition. It incorporates strategies focused on incident response, system hardening, and forensic analysis across Windows, Linux, and Cisco platforms.

**Always start by reading the README file in each directory to understand its contents and navigation.**

## Directory Reference

- [**Curriculum/**](./CyberPatriot/Curriculum/README.md): Structured weekly training plans, objectives, exercises, and quizzes.
- [**Windows/**](./CyberPatriot/Windows/README.md): Guides, checklists, exercises, scripts, quizzes, and VM setup resources specific to Windows (Windows 11/Server).
- [**Linux/**](./CyberPatriot/Linux/README.md): Guides, checklists, exercises, scripts, quizzes, and VM setup resources specific to Linux (Ubuntu/Mint).
- [**Cisco/**](./CyberPatriot/Cisco/README.md): Guides, checklists, exercises, and Packet Tracer resources specific to Cisco IOS networking.
- [**Checklists/**](./CyberPatriot/Checklists/README.md): Centralized, actionable security checklists for rapid hardening during competition.
- [**Exercises/**](./CyberPatriot/Exercises/README.md): Hands-on practice scenarios simulating competition challenges across all platforms.
- [**Quizzes/**](./CyberPatriot/Quizzes/README.md): Assessment tools to test knowledge of security concepts, tools, and procedures.
- [**Resources/**](./CyberPatriot/Resources/README.md): Reusable templates, command references, core security principles, and tools.
- [**VM-Setup/**](./CyberPatriot/VM-Setup/README.md): Scripts and guides for creating vulnerable virtual machine environments for realistic practice.
- [**Team_Resources/**](./CyberPatriot/Team_Resources/README.md): Guides and templates for competition strategy, team roles, workflow, and communication.
- [**Meld/**](./CyberPatriot/Meld/README.md): Guides on using baselining techniques with tools like Meld for effective vulnerability discovery.
- [**Sponsorships/**](./CyberPatriot/Sponsorships/README.md): Templates and information for seeking program support and funding.

---

## Directory Index

Below is a complete index of the `CyberPatriot` directory, organized for quick navigation and understanding.

- **Curriculum/**: 12-week training curriculum, lesson plans, and objectives.
- **Windows/**: Windows 11/Server security training, guides, checklists, scripts, quizzes, and exercises.
- **Linux/**: Ubuntu/Mint security training, guides, checklists, scripts, quizzes, and exercises.
- **Cisco/**: Cisco Packet Tracer and IOS security training, guides, checklists, Packet Tracer scenarios, and exercises.
- **Checklists/**: Centralized security checklists for Windows, Linux, and Cisco.
- **Exercises/**: Hands-on practice scenarios for Windows, Linux, Cisco, and cross-platform challenges.
- **Quizzes/**: Platform-specific and general security quizzes with solutions for mentors.
- **Resources/**: Templates (Change Logs, Reports), References (Command Sheets), Tools (Placeholders), Core Security Principles.
- **VM-Setup/**: Scripts and docs for creating compromised Windows/Linux VMs and Cisco Packet Tracer scenarios.
- **Team_Resources/**: Guides on competition strategy, team roles, workflow, communication protocols, and practice schedules.
- **Meld/**: Baselining guides for using Meld to compare clean and compromised systems.
- **Sponsorships/**: Templates and info for seeking program support (brochures, letters).
- **CONTRIBUTING.md**: Guidelines for contributing to the repository.
- **LICENSE**: License information.

---

## Overview

This repository contains training materials, exercises, and resources for the Grissom High School JROTC CyberPatriot teams. The materials are designed to prepare cadets for the CyberPatriot competition by providing structured learning paths, hands-on exercises, and competition preparation resources, focusing on an incident response and remediation mindset.

## Table of Contents

- [What is CyberPatriot?](#what-is-cyberpatriot)
- [Repository Structure](#repository-structure)
- [Getting Started](#getting-started)
- [Training Approach](#training-approach)
- [Training Tracks](#training-tracks)
- [Competition Preparation](#competition-preparation)
- [Resources](#resources)
- [Team Information](#team-information)
- [Scenario Generation and Automation](#scenario-generation-and-automation)
- [Gap Analysis and Roadmap](#gap-analysis-and-roadmap)
- [Contributing](#contributing)
- [License](#license)

## What is CyberPatriot?

CyberPatriot is the National Youth Cyber Defense Competition created by the Air Force Association. It places teams in the position of newly hired IT professionals tasked with managing the network of a small company. In the rounds of competition, teams are given a set of virtual operating systems and are tasked with finding cybersecurity vulnerabilities and hardening the system while maintaining critical services. It is best viewed as an **incident response and remediation competition**.

The competition consists of three main components:
1.  **Windows Operating System Security** (e.g., Windows 11, Windows Server)
2.  **Linux Operating System Security** (e.g., Ubuntu, Linux Mint)
3.  **Cisco Networking Challenge** (includes Packet Tracer simulation and conceptual quiz)

## Repository Structure

This repository is organized into several key directories within the main `CyberPatriot` folder:

- `Curriculum/` - Overall curriculum structure and learning paths (12 Weeks)
- `Windows/` - Windows security training materials and exercises
- `Linux/` - Linux security training materials and exercises
- `Cisco/` - Cisco networking training materials and exercises
- `Checklists/` - Security checklists for all platforms
- `Exercises/` - Hands-on practice scenarios
- `Quizzes/` - Knowledge assessment quizzes
- `Resources/` - Templates, references, tools, and core principles
- `VM-Setup/` - Scripts and instructions for creating practice VMs and Packet Tracer scenarios
- `Team_Resources/` - Team management materials and competition workflows
- `Meld/` - Baselining and comparison guides
- `Sponsorships/` - Sponsorship and support templates

## Getting Started

### Prerequisites

To make the most of these materials, cadets should have:

1.  A computer with at least 8GB RAM (16GB+ recommended)
2.  Virtualization Software: VMware Workstation/Player or VirtualBox installed
3.  Base OS Images: Clean installs of Windows (10/11 Pro/Enterprise) and Ubuntu (22.04 LTS Desktop/Server)
4.  Cisco Packet Tracer: Latest version recommended (available via Cisco Networking Academy)
5.  Basic familiarity with computers and operating systems

### Setup Instructions

1.  Clone this repository:
    ```bash
    git clone https://github.com/Minagera/CyberPatriot.git
    cd CyberPatriot
    ```
2.  Review the `README.md` files in each directory, starting with `Curriculum/`.
3.  Follow the VM setup guides in the `CyberPatriot/VM-Setup/` directory to create your practice environment using the base OS images.
4.  Start with the fundamental modules in each track (`Windows/`, `Linux/`, `Cisco/`) before advancing.

## Training Approach

Success in CyberPatriot requires more than just following checklists. This repository emphasizes:

1.  **Security Mindset:** Understanding *why* vulnerabilities exist and *how* attackers exploit them.
2.  **OS Familiarity:** Deep knowledge of Windows (Registry, GPO, Services, Event Logs) and Linux (Users, PAM, Systemd, Cron, Permissions, Logs).
3.  **Research Skills:** Learning to quickly understand and secure unfamiliar services or configurations.
4.  **Baselining:** Comparing competition images to known-good states (using tools like Meld or documentation) to rapidly identify unauthorized changes.
5.  **Structured Workflow:** Following a repeatable process (Read README -> Baseline -> Users -> Persistence -> Services -> Policies -> Forensics -> Verify).
6.  **Teamwork & Communication:** Utilizing defined roles and communication protocols (see `Team_Resources/`).

## Training Tracks

### Windows Security Track

Covers security for Windows 11/Server. Topics include user/group management, policies (Local Security Policy/GPO), services, registry, firewall, Defender, auditing, and common tools.

[Go to Windows Security Track](./CyberPatriot/Windows/README.md)

### Linux Security Track

Focuses on Ubuntu/Mint security. Topics include user/permissions, PAM, `sudoers`, services (`systemd`), firewall (UFW), SSH, logging, file system security, and essential commands.

[Go to Linux Security Track](./CyberPatriot/Linux/README.md)

### Cisco Networking Track

Provides training for the networking component. Topics include IOS commands, basic device hardening, SSH, ACLs, VLANs, common protocols (HTTP, DNS, DHCP), and Packet Tracer usage.

[Go to Cisco Networking Track](./CyberPatriot/Cisco/README.md)

## Competition Preparation

### Competition Day Checklist

1.  **Read the README:** Thoroughly understand the scenario, rules, required services, and forensic questions. *This is the most critical step.*
2.  **Assign Roles:** Confirm who is handling Windows, Linux, Cisco, Documentation, and Orchestration.
3.  **Baseline (If Possible):** Quickly gather initial state information (users, services, processes, network).
4.  **Prioritize:** Focus on high-point items identified in the README (forensics, critical vulnerabilities).
5.  **Document Changes:** Use templates from `Resources/Templates/` (e.g., Change Log).
6.  **Communicate:** Use protocols from `Team_Resources/` (SITREP, BLOCKER).
7.  **Verify Scoring:** Regularly check the scoring engine report.

[Complete Competition Guide](./CyberPatriot/Team_Resources/competition_workflow.md)

## Resources

### Official CyberPatriot Materials

-   [CyberPatriot Website](https://www.uscyberpatriot.org/)
-   [CyberPatriot Rules Book](https://www.uscyberpatriot.org/competition/rules-book) (Review carefully each season)
-   [CyberPatriot Training Materials](https://www.uscyberpatriot.org/competition/training-materials) (Use as supplementary material)

### Internal Repository Resources

-   [Security Checklists](./CyberPatriot/Checklists/README.md): Quick guides for hardening.
-   [Reference Materials](./CyberPatriot/Resources/References/README.md): Command cheat sheets.
-   [Core Security Principles](./CyberPatriot/Resources/Core_Security_Principles.md): Foundational concepts.
-   [Templates](./CyberPatriot/Resources/Templates/README.md): For documentation during competition.

## Team Information

### Team Structure

-   Aim for teams of 2-6 members per AFA rules.
-   Designated specialists (Primary/Backup): Windows, Linux, Cisco.
-   Supporting Roles: Documentation Lead, Forensics Lead, Team Captain/Orchestrator.

### Practice Schedule

-   Regular weekly sessions focusing on specific topics or platforms.
-   Monthly sessions simulating competition duration and pressure.
-   Utilize practice images from CyberPatriot and scenarios generated using `VM-Setup/`.

[Team Formation Guidelines](./CyberPatriot/Team_Resources/team_formation.md)
[Practice Schedule Template](./CyberPatriot/Team_Resources/practice_schedule.md)

## Scenario Generation and Automation

The `CyberPatriot/VM-Setup/` directory contains scripts and guides to create unique, compromised VM environments for Windows and Linux, plus Packet Tracer scenarios for Cisco. This allows for realistic incident response practice.

-   **Windows:** `enterprise-workstation-setup.ps1` creates a scenario with unauthorized users, persistence (tasks, registry), weak policies, and forensic artifacts.
-   **Linux:** `corporate-server-breach.sh` sets up a scenario with unauthorized users (incl. UID 0), misconfigured services (SSH, UFW), persistence (cron, SUID), and forensic clues.
-   **Cisco:** Packet Tracer files (`.pkt`) are located in `CyberPatriot/Cisco/PacketTracer_Scenarios/`.

Future goals include adding more sophisticated generation options and basic scoring mechanisms for self-assessment within these scenarios. See the `/CyberPatriot/Resources/Tools/` directory for potential future automation scripts.

## Gap Analysis and Roadmap

This section tracks missing content and planned improvements:

-   [ ] **Content Population:** Fully develop guides, exercises, and quizzes for all topics outlined in the curriculum.
-   [ ] **VM Setup Scripts:** Enhance scripts with more varied vulnerabilities, persistence methods, and forensic questions. Add basic scoring checks.
-   [ ] **Packet Tracer Scenarios:** Create a wider range of Cisco scenarios covering different topologies and security challenges.
-   [ ] **Exercises:** Develop more complex, multi-stage exercises combining platform knowledge.
-   [ ] **Quizzes:** Ensure comprehensive quiz coverage for all curriculum topics.
-   [ ] **Instructor Guides:** Add notes within `VM-Setup` and `Exercises` for instructors on running scenarios and expected solutions.
-   [ ] **Uniqueness:** Continuously review and update materials to ensure they remain unique and relevant to current CyberPatriot trends.

Contributions and suggestions are welcome! See [CONTRIBUTING.md](./CONTRIBUTING.md).

## Contributing

Contributions to this repository are welcome. Please see the [CONTRIBUTING.md](./CONTRIBUTING.md) file for guidelines on how to contribute effectively.

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details. All contributed content must be compatible with this license and be original work suitable for educational use.
