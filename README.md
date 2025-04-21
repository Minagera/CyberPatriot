# Grissom High School JROTC CyberPatriot Program

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

## Contributing

Contributions to this repository are welcome. Please see the [CONTRIBUTING.md](./CONTRIBUTING.md) file for guidelines.

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.
