# CyberPatriot Training Curriculum

This directory contains a structured 12-week curriculum for preparing teams for the CyberPatriot competition, covering Windows, Linux, Cisco networking, and competition strategy.

## Curriculum Overview

The training program progressively builds skills from basic concepts to advanced techniques. Each week includes:
-   **Learning Objectives**: Specific skills and knowledge cadets will gain.
-   **Topics Covered**: Key areas of focus for the week.
-   **Activities/Exercises**: References to hands-on practice in other directories (`../Exercises/`, `../Cisco/PacketTracer_Scenarios/`).
-   **Assessment**: References to relevant quizzes (`../Quizzes/`).
-   **Resources**: Links to relevant Guides (`../Windows/Guides/`, `../Linux/Guides/`, `../Cisco/Guides/`), Checklists (`../Checklists/`), or external materials.

## Directory Index

```
Curriculum/
├── README.md                   # This file
├── Week01/
│   ├── README.md               # Objectives, Topics, Activities for Week 1
│   └── Quiz_Solutions.md       # Placeholder for Mentor notes on Week 1 Quiz review
├── Week02/
│   ├── README.md               # Objectives, Topics, Activities for Week 2
│   └── Quiz_Solutions.md       # Placeholder for Mentor notes on Week 2 Quiz review
├── Week03/
│   ├── README.md               # Objectives, Topics, Activities for Week 3
│   └── Quiz_Solutions.md       # Placeholder for Mentor notes on Week 3 Quiz review
├── Week04/
│   ├── README.md               # Objectives, Topics, Activities for Week 4
│   └── Quiz_Solutions.md       # Placeholder for Mentor notes on Week 4 Quiz review
├── Week05/
│   ├── README.md               # Objectives, Topics, Activities for Week 5
│   └── Quiz_Solutions.md       # Placeholder for Mentor notes on Week 5 Quiz review
├── Week06/
│   ├── README.md               # Objectives, Topics, Activities for Week 6
│   └── Quiz_Solutions.md       # Placeholder for Mentor notes on Week 6 Quiz review
├── Week07/
│   ├── README.md               # Objectives, Topics, Activities for Week 7
│   └── Quiz_Solutions.md       # Placeholder for Mentor notes on Week 7 Quiz review
├── Week08/
│   ├── README.md               # Objectives, Topics, Activities for Week 8
│   └── Quiz_Solutions.md       # Placeholder for Mentor notes on Week 8 Quiz review
├── Week09/
│   ├── README.md               # Objectives, Topics, Activities for Week 9
│   └── Quiz_Solutions.md       # Placeholder for Mentor notes on Week 9 Quiz review
├── Week10/
│   ├── README.md               # Objectives, Topics, Activities for Week 10
│   └── Quiz_Solutions.md       # Placeholder for Mentor notes on Week 10 Quiz review
├── Week11/
│   ├── README.md               # Objectives, Topics, Activities for Week 11
│   └── Quiz_Solutions.md       # Placeholder for Mentor notes on Week 11 Quiz review
└── Week12/
    ├── README.md               # Objectives, Topics, Activities for Week 12
    └── Quiz_Solutions.md       # Placeholder for Mentor notes on Week 12 Quiz review
```

-   `Quiz_Solutions.md` are placeholders for mentors to potentially store notes or links related to reviewing quizzes assigned that week, not the actual quiz answers (which reside in `../Quizzes/Solutions/`).
-   All referenced files are unique and tailored for CyberPatriot cadet training.

## Recommended Schedule

*(Based on Phase descriptions in main README)*

### Phase 1: Fundamentals (Weeks 1-4)
-   **Week 1**: Competition Overview, Ethics, Windows Basics (GUI, Users, Tools)
-   **Week 2**: Linux Fundamentals (CLI Basics, Users, Permissions, `apt`)
-   **Week 3**: Networking Fundamentals (OSI/TCP-IP, IP Addressing) & Cisco Basics (IOS Intro, Packet Tracer)
-   **Week 4**: Security Principles (CIA Triad, Least Privilege), User Account Management (Win/Lin Policies)

### Phase 2: Intermediate Skills (Weeks 5-8)
-   **Week 5**: Windows System Hardening (Policies, Services, Firewall, Defender)
-   **Week 6**: Linux System Hardening (UFW, SSH, Services, Permissions)
-   **Week 7**: Network Security (ACLs, Basic Switch Security) & Firewall Configuration (Win/Lin)
-   **Week 8**: Introduction to Scripting (PowerShell & Bash Basics for Auditing) & Baselining Concepts (Meld Intro)

### Phase 3: Advanced Techniques & Strategy (Weeks 9-12)
-   **Week 9**: Advanced Windows Security (Registry, Auditing, Forensics Intro) & VM Setup Usage
-   **Week 10**: Advanced Linux Security (PAM, Logging, Forensics Intro) & VM Setup Usage
-   **Week 11**: Advanced Networking (VLANs, More ACLs) & Packet Tracer Scenarios
-   **Week 12**: Competition Strategies (Workflow, Roles, Time Management), Forensics Review, Mock Competition Debrief

## Using This Curriculum

### For Mentors
1.  Review the `README.md` for the upcoming week.
2.  Prepare necessary VMs (`../VM-Setup/`), Packet Tracer files (`../Cisco/PacketTracer_Scenarios/`), quizzes (`../Quizzes/`), and exercises (`../Exercises/`).
3.  Adapt the content based on team progress and experience.
4.  Facilitate discussions and hands-on activities.
5.  Review quiz/exercise results and provide feedback using `Quiz_Solutions.md` for notes and `../Quizzes/Solutions/` for answers.

### For Cadets
1.  Review the objectives and topics for the week in the corresponding `WeekXX/README.md`.
2.  Actively participate in exercises and discussions.
3.  Complete assigned quizzes and practice tasks.
4.  Ask questions and seek clarification.
5.  Utilize the Guides, Checklists, and Resources directories for self-study.

## Materials Required
-   Workstations with Virtualization Software (VirtualBox, VMware)
-   Windows 10/11 Pro/Enterprise VM image (clean base)
-   Ubuntu 22.04 LTS Desktop/Server VM image (clean base)
-   Cisco Packet Tracer (latest version recommended)
-   Access to this GitHub repository
-   Internet access

## Adapting the Curriculum
Feel free to adjust the pace, add supplementary materials, or modify exercises to suit your team's specific needs and learning style.

## Tracking Progress
Use quiz results (`../Quizzes/`), exercise completion (`../Exercises/`), and participation in mock competitions to gauge understanding and identify areas needing more focus.

## Reference Templates
Utilize templates from `../Resources/Templates/` for documentation during practice:
-   [Incident Response Report Template](../Resources/Templates/Incident_Response_Report_Template.md)
-   [Change Log Template](../Resources/Templates/Change_Log_Template.md)
-   [Team Workflow Checklist](../Resources/Templates/Team_Workflow_Checklist.md)
-   [Forensics Question Response Template](../Resources/Templates/Forensics_Question_Response_Template.md)

## Additional Resources
-   [CyberPatriot Official Training Materials](https://www.uscyberpatriot.org/competition/training-materials)
-   [Windows Security Guides](../Windows/Guides/)
-   [Linux Security Guides](../Linux/Guides/)
-   [Cisco Networking Guides](../Cisco/Guides/)
-   [Security Checklists](../Checklists/)
-   [Reference Sheets](../Resources/References/)

---
*This directory and all referenced files are unique and tailored for CyberPatriot cadet training. If you find a missing file, create it using the format above.*
