# Grissom High School JROTC CyberPatriot Program

## Directory Index

Below is a complete index of the `CyberPatriot` directory, organized for quick navigation and understanding. Each section includes a brief description to help you find the right materials for Windows, Linux, and Cisco Packet Tracer training.

### Top-Level Structure

- **/CyberPatriot/Curriculum/**  
  Structured weekly curriculum for Windows, Linux, and Cisco.  
  - `README.md`: Curriculum overview and schedule  
  - `Week1/` ... `Week12/`: Weekly plans, objectives, and resources

- **/CyberPatriot/Windows/**  
  Windows 10/11/2025 security training, guides, checklists, scripts, and exercises.  
  - `README.md`: Windows security topics and resources  
  - `Guides/`: Basic, Intermediate, Advanced security guides  
  - `Checklists/`: Competition checklists for Windows hardening  
  - `Exercises/`: Hands-on security scenarios  
  - `Scripts/`: PowerShell automation for security tasks  
  - `Quizzes/`: Practice quizzes and solutions  
  - `VM-Setup/`: Scripts and docs for creating Windows practice VMs

- **/CyberPatriot/Linux/**  
  Ubuntu/Mint security training, guides, checklists, scripts, and exercises.  
  - `README.md`: Linux security topics and resources  
  - `Guides/`: Basic, Intermediate, Advanced security guides  
  - `Checklists/`: Competition checklists for Linux hardening  
  - `Exercises/`: Hands-on security scenarios  
  - `Scripts/`: Bash automation for security tasks  
    - `Templates/`: Script templates for common tasks  
    - `Examples/`: Complete example scripts  
    - `Solutions/`: Mentor-only solutions  
  - `Quizzes/`: Practice quizzes and solutions  
  - `VM-Setup/`: Scripts and docs for creating Linux practice VMs

- **/CyberPatriot/Cisco/**  
  Cisco Packet Tracer and IOS security training, guides, checklists, and exercises.  
  - `README.md`: Cisco networking topics and resources  
  - `Guides/`: Basic, Intermediate, Advanced IOS guides  
  - `Checklists/`: Competition checklists for routers and switches  
  - `Exercises/`: Packet Tracer and CLI-based security scenarios  
    - `Solutions/`: Mentor-only solutions  
  - `PacketTracer/`:  
    - `Scenarios/`: .pkt files for practice  
    - `Solutions/`: Solution .pkt files  
  - `Quizzes/`: Practice quizzes and solutions  
  - `Scripts/`: IOS config templates and automation

- **/CyberPatriot/Checklists/**  
  Centralized security checklists for Windows, Linux, and Cisco.  
  - `README.md`: How to use checklists in competition  
  - `Windows/`, `Linux/`, `Cisco/`: Platform-specific checklists

- **/CyberPatriot/Team_Resources/**  
  Competition strategy, team roles, workflow, and documentation templates.  
  - `Competition_Strategy_Guide.md`: Team roles, communication, and scoring strategies  
  - `Team_Coordination_Templates.md`: Templates for team management  
  - `Documentation_Templates.md`: Templates for documenting changes and findings

- **/CyberPatriot/Meld/**  
  Baselining guides for using Meld to compare clean and compromised systems.

- **/CyberPatriot/Sponsorships/**  
  Sample letters and info for seeking program support.

- **/CyberPatriot/CONTRIBUTING.md**  
  Guidelines for contributing to the repository.

- **/CyberPatriot/LICENSE**  
  License information.

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
