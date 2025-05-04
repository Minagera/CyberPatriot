# Grissom High School JROTC CyberPatriot Program

## Directory Reference

This repository is organized into several tiers. Each tier contains a `README.md` file that explains its structure, purpose, and reference points.  
**Always start by reading the README in each directory to understand its contents and navigation.**

- [Curriculum/](./CyberPatriot/Curriculum/README.md): Weekly training plans, objectives, and resources.
- [Windows/](./CyberPatriot/Windows/README.md): Windows security guides, checklists, exercises, scripts, and quizzes.
- [Linux/](./CyberPatriot/Linux/README.md): Linux security guides, checklists, exercises, scripts, and quizzes.
- [Cisco/](./CyberPatriot/Cisco/README.md): Cisco networking guides, checklists, exercises, Packet Tracer scenarios, and scripts.
- [Checklists/](./CyberPatriot/Checklists/README.md): Centralized security checklists for all platforms.
- [Resources/](./CyberPatriot/Resources/README.md): Templates, references, and tools for documentation and automation.
- [Meld/](./CyberPatriot/Meld/README.md): Baselining and comparison guides.
- [Sponsorships/](./CyberPatriot/Sponsorships/README.md): Templates and info for program support.
- [Team_Resources/](./CyberPatriot/Team_Resources/): Team strategy, workflow, and documentation templates.
- [VM-Setup/](./CyberPatriot/VM-Setup/README.md): Scripts and instructions for creating practice VMs and Packet Tracer scenarios.

---

## Directory Index

Below is a complete index of the `CyberPatriot` directory, organized for quick navigation and understanding. Each section includes a brief description to help you find the right materials for Windows, Linux, and Cisco Packet Tracer training.

### Top-Level Structure

- **Curriculum/**: 12-week training curriculum, lesson plans, and objectives.
- **Windows/**: Windows 11/2025 security training, guides, checklists, scripts, and exercises.
- **Linux/**: Ubuntu/Mint security training, guides, checklists, scripts, and exercises.
- **Cisco/**: Cisco Packet Tracer and IOS security training, guides, checklists, and exercises.
- **Checklists/**: Centralized security checklists for Windows, Linux, and Cisco.
- **Resources/**: Templates, references, and tools for documentation and automation.
- **Meld/**: Baselining guides for using Meld to compare clean and compromised systems.
- **Sponsorships/**: Templates and info for seeking program support.
- **Team_Resources/**: Team strategy, workflow, and documentation templates.
- **VM-Setup/**: Scripts and docs for creating Windows, Linux, and Cisco practice VMs.
- **CONTRIBUTING.md**: Guidelines for contributing to the repository.
- **LICENSE**: License information.

---

## Overview

This repository contains training materials, exercises, and resources for the Grissom High School JROTC CyberPatriot teams. The materials are designed to prepare cadets for the CyberPatriot competition by providing structured learning paths, hands-on exercises, and competition preparation resources.

## Table of Contents

- [What is CyberPatriot?](#what-is-cyberpatriot)
- [Repository Structure](#repository-structure)
- [Getting Started](#getting-started)
- [Training Tracks](#training-tracks)
- [Competition Preparation](#competition-preparation)
- [Resources](#resources)
- [Team Information](#team-information)
- [Scenario Generation and Automation](#scenario-generation-and-automation)
- [Gap Analysis and Roadmap](#gap-analysis-and-roadmap)

## What is CyberPatriot?

CyberPatriot is the National Youth Cyber Defense Competition created by the Air Force Association. It puts teams of high school and middle school students in the position of IT professionals tasked with managing the network of a small company. Through a series of online competition rounds, teams are given a set of virtual machines and are tasked with finding and fixing cybersecurity vulnerabilities while maintaining critical services.

The competition consists of three main components:
1. **Windows Operating System Security**
2. **Linux Operating System Security**
3. **Cisco Networking Challenge** (includes Packet Tracer and quiz)

## Repository Structure

This repository is organized into several key directories:

- `/curriculum/` - Overall curriculum structure and learning paths
- `/windows_security/` - Windows security training materials and exercises
- `/linux_security/` - Linux security training materials and exercises
- `/cisco_networking/` - Cisco networking training materials and exercises
- `/resources/` - Additional resources, checklists, and reference materials
- `/team_materials/` - Team management materials and competition workflows

## Getting Started

### Prerequisites

To make the most of these materials, cadets should have:

1. A computer with at least 8GB RAM (16GB recommended)
2. VMware Workstation/Player or VirtualBox installed
3. Basic familiarity with computers and operating systems
4. Access to Cisco Packet Tracer (available through NetAcad)

### Setup Instructions

1. Clone this repository:

   git clone https://github.com/Minagera/CyberPatriot.git

2. Follow the VM setup guides in the `/VM-Setup/` directory to create your practice environment.

3. Start with the fundamental modules in each track before advancing to more complex topics.

## Training Tracks

### Windows Security Track

The Windows Security track covers security concepts for Windows 10/11 and Windows Server. Topics include:

- User account management and security policies
- Service hardening and configuration
- Registry security
- Firewall configuration
- Group Policy Objects
- Windows security tools

[Go to Windows Security Track](./windows_security/)

### Linux Security Track

The Linux Security track focuses on Ubuntu and Linux Mint security. Topics include:

- User and permissions management
- Service configuration and security
- Firewall setup (UFW and iptables)
- File system security
- Package management and updates
- Security monitoring and auditing

[Go to Linux Security Track](./linux_security/)

### Cisco Networking Track

The Cisco Networking track provides training for the networking component of the competition. Topics include:

- Network fundamentals and the OSI model
- Switching and routing concepts
- Access control lists
- Network security and protocols
- Packet Tracer exercises
- Quiz preparation

[Go to Cisco Networking Track](./cisco_networking/)

## Competition Preparation

### Competition Day Checklist

1. Verify all team members know their assigned roles
2. Review security checklists for each platform
3. Establish communication protocols
4. Set up time management system
5. Prepare documentation templates

[Complete Competition Guide](./team_materials/competition_workflow.md)

## Resources

### Official CyberPatriot Materials

- [CyberPatriot Website](https://www.uscyberpatriot.org/)
- [CyberPatriot Training Materials](https://www.uscyberpatriot.org/competition/training-materials)

### Additional Learning Resources

- [Security Checklists](./resources/checklists/)
- [Reference Materials](./resources/references/)

## Team Information

### Team Structure

- 2-3 teams of 5-6 members (primary team and development team)
- Designated specialists for Windows, Linux, and Cisco
- Team captain roles with leadership responsibilities

### Practice Schedule

- Weekly 2-hour sessions
- Monthly 6-hour sessions (simulating competition environment)
- Additional sessions before competitions

[Team Formation Guidelines](./team_materials/team_formation.md)
[Practice Schedule](./team_materials/practice_schedule.md)

## Scenario Generation and Automation

To maximize cadet learning, this repository will include tools and templates for generating unique practice scenarios. These may include:

- **Randomized Windows/Linux/Cisco misconfiguration generators**
- **Automated scoring scripts for practice images**
- **Scenario templates for common CyberPatriot challenges**
- **Guides for instructors to create new scenarios quickly**

See the `/resources/scenario_tools/` directory for scripts and instructions (to be developed).

## Gap Analysis and Roadmap

This section tracks missing content and planned improvements:

- [ ] Populate all referenced directories with unique, practical content
- [ ] Add scenario generation scripts/templates for each platform
- [ ] Expand hands-on exercises and quizzes
- [ ] Add automation for scoring and reporting
- [ ] Provide instructor guides for scenario creation
- [ ] Ensure all materials are unique and competition-focused

Contributions and suggestions are welcome! See [CONTRIBUTING.md](./CONTRIBUTING.md).

## Contributing

Contributions to this repository are welcome. Please see the [CONTRIBUTING.md](./CONTRIBUTING.md) file for guidelines.

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.
