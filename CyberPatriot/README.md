# Grissom High School JROTC CyberPatriot Program Training Repository (25-26 Season)

**Mission:** To provide a comprehensive, unique, and continuously improving set of training materials for Grissom High School JROTC cadets, enabling them to excel in the CyberPatriot National Youth Cyber Defense Competition through a deep understanding of incident response, system hardening, and teamwork.

**Always start by reading the README file in each directory to understand its contents and purpose.**

## Directory Reference

-   [**Curriculum/**](Curriculum/README.md): Structured weekly training plans tailored for the 25-26 season, including objectives, exercises, and assessment references.
-   [**Windows/**](Windows/README.md): Resources specific to securing Windows environments (Desktop/Server), including guides, checklists, scripts, and VM setup scenarios.
-   [**Linux/**](Linux/README.md): Resources specific to securing Linux environments (Ubuntu focus), including guides, checklists, scripts, and VM setup scenarios.
-   [**Cisco/**](Cisco/README.md): Resources for the Cisco Networking Challenge, including IOS guides, checklists, and Packet Tracer exercises.
-   [**Checklists/**](Checklists/README.md): Actionable checklists for rapid system hardening during competition, emphasizing README priority.
-   [**Exercises/**](Exercises/README.md): Hands-on practice scenarios simulating competition challenges across all platforms.
-   [**Quizzes/**](Quizzes/README.md): Assessment tools to reinforce learning and test knowledge relevant to competition tasks.
-   [**Resources/**](Resources/README.md): Reusable templates (documentation, forensics), command references, core security principles, and potentially helpful tools/links.
-   [**VM-Setup/**](VM-Setup/README.md): Scripts and instructions for creating realistic, compromised VM environments for practice. **Crucial for hands-on training.**
-   [**Team_Resources/**](Team_Resources/README.md): Guides on competition strategy, team roles, workflow optimization, and effective communication protocols.
-   [**Meld/**](Meld/README.md): Guidance on using baselining techniques (specifically with Meld) for efficient vulnerability discovery.
-   [**Sponsorships/**](Sponsorships/README.md): Templates and information related to seeking program support and funding.

## Understanding CyberPatriot: The Correct Perspective

CyberPatriot is fundamentally an **incident response and remediation competition**. Teams inherit compromised systems and must:
1.  **Investigate:** Identify unauthorized changes, malware, and security misconfigurations.
2.  **Analyze:** Find and interpret forensic artifacts to understand the compromise and answer specific questions.
3.  **Remediate:** Remove attacker persistence, malware, and unauthorized access.
4.  **Harden:** Apply security best practices and required configurations to prevent future attacks while maintaining essential services (as defined by the README).
This requires critical thinking and adaptability, not just rote application of fixes.

## Training Approach (25-26 Focus)

Success hinges on more than checklists. Our training emphasizes:

1.  **Security Mindset:** Understanding the *why* behind vulnerabilities and attacker TTPs (Tactics, Techniques, Procedures).
2.  **OS Fluency:** Deep, practical knowledge of Windows (Registry, GPO, Services, Event Logs, PowerShell) and Linux (Users/Groups, PAM, Systemd, Cron, Permissions, Logs, Bash).
3.  **Research Proficiency:** Quickly learning to secure unfamiliar services or configurations encountered during competition.
4.  **Baselining Mastery:** Systematically comparing competition images against known-good states or initial scans to rapidly identify deviations. Tools like Meld are key.
5.  **Structured Workflow:** Adhering to a repeatable process: **Read README -> Initial Baseline/Recon -> User Accounts -> Persistence Mechanisms -> Services/Applications -> Security Policies -> Network Security -> Forensics -> Verification/Scoring.**
6.  **Team Synergy:** Utilizing defined roles (Windows, Linux, Cisco, Documentation/Forensics, Orchestrator) and clear communication protocols (see `Team_Resources/`). Cross-training is encouraged.
7.  **Forensic Focus:** Treating forensic questions not as an afterthought, but as integral to the investigation process, worth significant points.

## Training Resources

-   **Incident Response VMs:** Utilize `VM-Setup/` scripts regularly to practice on realistic scenarios.
-   **Packet Tracer Scenarios:** Master Cisco concepts via `Cisco/PacketTracer_Scenarios/`.
-   **Checklists & References:** Use `Checklists/` and `Resources/References/` during practice to build speed and familiarity.
-   **Quizzes & Exercises:** Reinforce concepts from `Quizzes/` and `Exercises/`.
-   **Curriculum:** Follow the structured plan in `Curriculum/` for progressive skill development.

## Implementation Schedule (Example)

*(Refer to `Curriculum/README.md` for the detailed weekly breakdown)*
-   **Phase 1 (Fundamentals):** OS Basics (Win/Lin), Networking Concepts, Security Principles, User Management.
-   **Phase 2 (Intermediate):** System Hardening (Policies, Services, Firewalls), Basic Scripting (Audit/Recon), Intro to Baselining.
-   **Phase 3 (Advanced):** Advanced Security Features, Log Analysis, Forensics Techniques, Advanced Networking/Packet Tracer, Competition Strategy, Full Mock Competitions.

## Continuous Improvement

This repository is a living resource.
-   Conduct After Action Reviews (AARs) after practices/competitions.
-   Identify knowledge gaps and update materials accordingly.
-   Contribute improvements, new scripts, checklists, or scenarios via pull requests or direct updates (if permissions allow).
-   Research new vulnerabilities and defense techniques relevant to potential competition scenarios.

## Conclusion

Excelling in CyberPatriot requires dedication, technical proficiency, strategic thinking, and strong teamwork. This repository provides the framework and resources for the Grissom JROTC team to achieve success in the 25-26 season and beyond.

---
*All materials herein are uniquely developed or adapted for Grissom JROTC CyberPatriot training. Contributions focused on enhancing cadet readiness are encouraged.*
