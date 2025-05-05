# Week 12: Competition Strategy, Forensics Review & Mock Competition

## Learning Objectives

By the end of this week, cadets will be able to:
-   Understand and apply effective CyberPatriot competition workflow and time management strategies.
-   Execute assigned team roles effectively.
-   Utilize communication protocols during simulated competition.
-   Systematically analyze and answer forensic questions based on evidence gathered.
-   Integrate skills learned across Windows, Linux, and Cisco in a mock competition setting.
-   Participate in an After-Action Review (AAR) to identify strengths and weaknesses.

## Topics Covered

-   **Competition Workflow & Strategy:**
    -   Review: Importance of reading the README first.
    -   Phased Approach: Initial Recon/Baseline -> User Security -> Persistence Hunting -> Service/Policy Hardening -> Forensics -> Verification/Troubleshooting.
    -   Time Management: Allocating time blocks, regular score checks, SITREPs.
    -   Prioritization: Focusing on high-point items, README tasks, and critical vulnerabilities first. Balancing security fixes with maintaining required services.
    -   Documentation: Using Change Logs (`../Resources/Templates/Change_Log_Template.md`), documenting forensic answers (`../Resources/Templates/Forensics_Question_Response_Template.md`).
-   **Team Roles & Communication:**
    -   Review Roles: Orchestrator/Captain, Windows Specialist, Linux Specialist, Cisco Specialist, Documentation/Forensics Lead (roles may overlap).
    -   Executing Roles: Responsibilities during competition simulation.
    -   Communication Protocols: Using SITREP and BLOCKER protocols (`../Team_Resources/communication_protocols.md`) during the mock competition. Importance of clear, concise communication.
-   **Forensic Question Analysis:**
    -   Types of Questions: Identifying users, finding files, determining event times, analyzing configurations, locating specific data mentioned in README.
    -   Investigation Techniques Review: Using logs (Event Viewer, `journalctl`, `/var/log`), file system searches (`find`, File Explorer search), registry checks, command history, configuration file analysis (`sshd_config`, `ufw status`, etc.).
    -   Answering Effectively: Providing precise answers based on evidence, citing sources/commands used if helpful, using the provided template.
-   **Mock Competition:**
    -   Setup: Using `VM-Setup` generated Windows/Linux images and a relevant Packet Tracer scenario. Distribute mock READMEs.
    -   Execution: Run a timed session (e.g., 2-4 hours) simulating competition conditions. Cadets work in teams, execute roles, apply workflow, communicate, and document. Mentors observe and note issues. Scoring engine (if available) or manual checks used.
-   **After-Action Review (AAR):**
    -   Process: What was supposed to happen? What actually happened? What went well? What could be improved?
    -   Focus Areas: Technical execution, workflow efficiency, communication effectiveness, time management, documentation quality, forensic accuracy.
    -   Outcome: Identify specific areas for future practice and improvement. Update team strategies or checklists.

## Activities/Exercises

-   **Discussion:** Review team roles, workflow, and communication protocols. Discuss common pitfalls in competition (e.g., spending too much time on low-point items, breaking required services, poor communication).
-   **Forensics Practice:** Provide sample forensic questions and have cadets describe the steps/commands they would use on Win/Lin to find the answers.
-   **Mock Competition:** Conduct the timed mock competition exercise using prepared VMs, Packet Tracer file, and READMEs.
-   **AAR Session:** Facilitate a structured AAR immediately following the mock competition. Encourage open and constructive feedback from all team members.

## Assessment

-   Observation of teamwork, communication, and workflow during the mock competition.
-   Quality of documentation (Change Log, Forensics Answers) produced during the mock competition.
-   Performance in the mock competition (points achieved, vulnerabilities addressed, forensic accuracy).
-   Participation and insights shared during the AAR.
-   [Unique Competition Strategy Quiz](../Quizzes/Quiz-Files/Competition_Strategy_Quiz.md)

## Resources

-   [Unique Competition Strategy Guide](../Team_Resources/Competition_Strategy_Guide.md)
-   [Unique Communication Protocols](../Team_Resources/communication_protocols.md)
-   [Unique Team Formation Guide](../Team_Resources/team_formation.md)
-   [Unique Incident Response Workflow](../Team_Resources/incident_response_workflow.md) (or similar workflow doc)
-   [Unique Documentation Templates](../Resources/Templates/)
-   All previously covered Guides, Checklists, and Reference sheets.
-   VMs/Scenarios from `../VM-Setup/`, `../Cisco/PacketTracer_Scenarios/`, `../Exercises/`.

---
*This weekly plan is uniquely designed for the Grissom JROTC CyberPatriot program, focusing on integrating skills and refining team performance.*
