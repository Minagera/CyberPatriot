# CyberPatriot Training Curriculum (25-26 Season)

This directory outlines a structured 12-week+ curriculum designed to prepare Grissom JROTC cadets for the CyberPatriot competition, covering Windows, Linux, Cisco networking, incident response, and competition strategy.

## Curriculum Overview

The program builds skills progressively. Each week typically includes:
-   **Learning Objectives**: Specific skills cadets should master.
-   **Topics Covered**: Key theoretical and practical areas.
-   **Activities/Exercises**: References to hands-on practice (`../Exercises/`, `../Cisco/PacketTracer_Scenarios/`, `../VM-Setup/`). **Using VM-Setup scenarios early and often is critical.**
-   **Assessment**: References to relevant quizzes (`../Quizzes/Quiz-Files/`).
-   **Resources**: Links to relevant Guides (`../Windows/Guides/`, etc.), Checklists (`../Checklists/`), or external materials.

## Directory Index

```
Curriculum/
├── README.md                   # This file
├── Week01/
│   ├── README.md               # Objectives, Topics, Activities for Week 1
│   └── Quiz_Solutions.md       # Mentor notes/review points for Week 1 Quiz (Create if missing)
├── Week02/
│   ├── README.md               # Objectives, Topics, Activities for Week 2
│   └── Quiz_Solutions.md       # Mentor notes/review points for Week 2 Quiz (Create if missing)
├── Week03/
│   ├── README.md               # Objectives, Topics, Activities for Week 3
│   └── Quiz_Solutions.md       # Mentor notes/review points for Week 3 Quiz (Create if missing)
├── Week04/
│   ├── README.md               # Objectives, Topics, Activities for Week 4
│   └── Quiz_Solutions.md       # Mentor notes/review points for Week 4 Quiz (Create if missing)
├── Week05/
│   ├── README.md               # Objectives, Topics, Activities for Week 5
│   └── Quiz_Solutions.md       # Mentor notes/review points for Week 5 Quiz (Create if missing)
├── Week06/
│   ├── README.md               # Objectives, Topics, Activities for Week 6
│   └── Quiz_Solutions.md       # Mentor notes/review points for Week 6 Quiz (Create if missing)
├── Week07/
│   ├── README.md               # Objectives, Topics, Activities for Week 7
│   └── Quiz_Solutions.md       # Mentor notes/review points for Week 7 Quiz (Create if missing)
├── Week08/
│   ├── README.md               # Objectives, Topics, Activities for Week 8
│   └── Quiz_Solutions.md       # Mentor notes/review points for Week 8 Quiz (Create if missing)
├── Week09/
│   ├── README.md               # Objectives, Topics, Activities for Week 9
│   └── Quiz_Solutions.md       # Mentor notes/review points for Week 9 Quiz (Create if missing)
├── Week10/
│   ├── README.md               # Objectives, Topics, Activities for Week 10
│   └── Quiz_Solutions.md       # Mentor notes/review points for Week 10 Quiz (Create if missing)
├── Week11/
│   ├── README.md               # Objectives, Topics, Activities for Week 11
│   └── Quiz_Solutions.md       # Mentor notes/review points for Week 11 Quiz (Create if missing)
├── Week12/
│   ├── README.md               # Objectives, Topics, Activities for Week 12
│   └── Quiz_Solutions.md       # Mentor notes/review points for Week 12 Quiz (Create if missing)
└── ... (Potential additional weeks or specialized topics)
```
*(Note: Ensure all referenced `README.md` and `Quiz_Solutions.md` files exist within their respective `WeekXX` folders. Create basic placeholders if needed.)*

## Recommended Schedule (Adaptable)

*(Based on 3 Phases)*

### Phase 1: Fundamentals (Weeks 1-4)
-   **Week 1**: Intro to CyberPatriot, Ethics, Competition Structure, Windows Basics (GUI Navigation, User Accounts, Core Tools like Task Manager, Event Viewer).
-   **Week 2**: Linux Fundamentals (CLI Navigation, File System, Users/Groups, Permissions, `apt` package management).
-   **Week 3**: Networking Fundamentals (OSI/TCP-IP Models, IP Addressing/Subnetting), Intro to Cisco IOS & Packet Tracer Interface.
-   **Week 4**: Core Security Principles (CIA Triad, Least Privilege, etc.), Basic User Account Security (Win/Lin Password Policies, Group Management).

### Phase 2: Intermediate Skills (Weeks 5-8)
-   **Week 5**: Windows System Hardening (Local Security Policy, Services Management, Windows Defender Firewall/Antivirus basics).
-   **Week 6**: Linux System Hardening (UFW Firewall, SSH Security (`sshd_config`), Service Management (`systemctl`), File Permissions Deep Dive).
-   **Week 7**: Network Security Concepts (ACL Theory, Basic Switch Security), Firewall Configuration Practice (Win/Lin).
-   **Week 8**: Introduction to Scripting for Auditing (PowerShell & Bash basics for checking users, services, tasks), Introduction to Baselining (Concepts & Meld Tool). **Start using VM-Setup scenarios.**

### Phase 3: Advanced Techniques & Strategy (Weeks 9-12+)
-   **Week 9**: Advanced Windows Security (Registry Forensics (Run Keys), Auditing Configuration, Basic Log Analysis, Persistence Mechanisms). Practice with Windows VM-Setup.
-   **Week 10**: Advanced Linux Security (PAM Configuration, System Logging (`journalctl`, `/var/log`), Cron Jobs, SUID/SGID, Persistence Mechanisms). Practice with Linux VM-Setup.
-   **Week 11**: Advanced Networking (VLANs, More Complex ACLs), Cisco Hardening Techniques, Packet Tracer Scenario Practice.
-   **Week 12**: Competition Strategy (Workflow Refinement, Roles, Time Management, Scoring Engine Dynamics), Forensics Question Hunting Techniques, Mock Competition & AAR.
-   **Post-Week 12**: Focus on full mock competitions, advanced scenario analysis, team communication refinement, and addressing specific weaknesses identified in AARs.

## Using This Curriculum

### For Mentors
1.  Review the `README.md` for the upcoming week(s).
2.  Prepare required resources: VMs (`../VM-Setup/`), Packet Tracer files (`../Cisco/PacketTracer_Scenarios/`), quizzes (`../Quizzes/Quiz-Files/`), exercises (`../Exercises/`).
3.  Adapt content based on cadet progress and competition focus shifts.
4.  Lead discussions, guide hands-on labs, and emphasize the *why*.
5.  Review cadet work, using `Quiz_Solutions.md` for notes and `../Quizzes/Solutions/` for formal answers.

### For Cadets
1.  Review weekly objectives and topics in `WeekXX/README.md`.
2.  Engage actively in labs, exercises, and discussions.
3.  Complete assigned quizzes and practice tasks diligently.
4.  Ask questions! Understand the concepts, don't just follow steps.
5.  Utilize Guides, Checklists, and Resources for self-study and reinforcement.

## Materials Required
-   Workstations capable of running Virtualization Software (VirtualBox recommended, VMware acceptable).
-   Clean Base VM Images: Windows (e.g., 10/11 Pro/Enterprise), Linux (Ubuntu 22.04 LTS Desktop recommended). **Keep snapshots of clean installs!**
-   Cisco Packet Tracer (Latest version from NetAcad).
-   Access to this GitHub repository (cloned locally recommended).
-   Internet access (for research, updates where allowed).
-   Meld (or similar diff tool) installed on host or within VMs.

## Adapting the Curriculum
This is a template. Adjust the pace, depth, and order based on team experience, available time, and specific competition trends. Add supplementary materials or guest speakers where beneficial.

## Tracking Progress
Monitor cadet understanding via:
-   Quiz scores (`../Quizzes/`).
-   Exercise completion and quality (`../Exercises/`).
-   Performance in mock competitions (`../VM-Setup/` scenarios).
-   Active participation and questions asked.
-   Ability to explain concepts and justify actions.

## Reference Templates
Encourage use of templates from `../Resources/Templates/` during all practice sessions:
-   [Incident Response Report Template](../Resources/Templates/Incident_Response_Report_Template.md)
-   [Change Log Template](../Resources/Templates/Change_Log_Template.md)
-   [Team Workflow Checklist](../Resources/Templates/Team_Workflow_Checklist.md)
-   [Forensics Question Response Template](../Resources/Templates/Forensics_Question_Response_Template.md)

## Additional Resources
-   [CyberPatriot Official Training Materials](https://www.uscyberpatriot.org/competition/training-materials) (Use as supplementary)
-   [Internal Guides](../Windows/Guides/, ../Linux/Guides/, ../Cisco/Guides/)
-   [Internal Checklists](../Checklists/)
-   [Internal Reference Sheets](../Resources/References/)
-   Online resources (e.g., Stack Exchange, vendor documentation, security blogs - use critically).

---
*This curriculum structure and all referenced files are uniquely tailored for Grissom JROTC CyberPatriot training. Ensure all linked files exist and are maintained.*
