# Security Checklists for CyberPatriot (25-26 Season)

This directory centralizes unique, actionable security checklists designed for rapid system hardening during CyberPatriot competitions. They cover Windows, Linux, and Cisco IOS.

## CRITICAL FIRST STEP: Always Read the Competition README First!

**The single most important action in any CyberPatriot round is to thoroughly read and understand the README file provided with each image!**

The README contains:
-   **Scenario Context:** Background story, system roles.
-   **Authorized Items:** Users, groups, services, applications that MUST remain operational.
-   **Prohibited Actions:** Specific things you must NOT do (e.g., "Do not disable Service X").
-   **Scored Tasks:** Specific configurations or fixes required for points.
-   **Forensic Questions:** Questions worth points, requiring investigation within the image.
-   **Overrides:** Competition-specific requirements that **TRUMP** general security best practices or checklist items.

**Never make changes without consulting the README! Adapt these checklists based on its specific instructions.** Document README constraints before starting work.

## Overview

These checklists provide:
-   A **structured workflow** for securing systems under time pressure.
-   A method to **avoid overlooking critical security areas**.
-   A quick reference for **common CyberPatriot vulnerabilities and fixes**.
-   A basis for **documenting actions taken** (check off items as completed).
-   A **training tool** to reinforce hardening steps.

## Available Checklists

-   [**Windows/README.md**](Windows/README.md): Comprehensive checklist for Windows Desktop/Server hardening (Users, Policies, Services, Firewall, Persistence, Forensics).
-   [**Linux/README.md**](Linux/README.md): Comprehensive checklist for Ubuntu/Debian hardening (Users, PAM, Services, UFW, Permissions, Persistence, Forensics).
-   [**Cisco/README.md**](Cisco/README.md): Checklist for basic Cisco IOS device hardening (Passwords, SSH, Services, Banners, Interface Security).

## How to Use

1.  **READ THE README FIRST.** Note all constraints and required items.
2.  Select the appropriate checklist (Windows, Linux, Cisco).
3.  Follow the suggested workflow (often Recon -> Users -> Persistence -> Services -> Policies -> Network -> Forensics -> Verify).
4.  **Adapt** the checklist based on the README (skip steps if prohibited, add steps if required).
5.  Check off items as you complete them.
6.  **Document** changes made (use `../Resources/Templates/Change_Log_Template.md`).
7.  **Verify** scoring engine updates frequently. If points are lost, review recent changes using your documentation.

## Team Strategy

-   Assign checklist sections to team members based on roles (Windows Specialist, Linux Specialist).
-   Use the checklist to ensure coverage but encourage deeper investigation beyond just ticking boxes.
-   Communicate findings and completed sections within the team.
-   Use the "Common Scoring Items" section as a final review before time expires, cross-referenced with the README.

## Additional Resources

-   [Guides](../Windows/Guides/, ../Linux/Guides/, ../Cisco/Guides/): For deeper understanding of checklist items.
-   [Scripts](../Windows/Scripts/, ../Linux/Scripts/): To automate reconnaissance related to checklist items.
-   [References](../Resources/References/): For quick command lookups.

## Customizing Checklists

-   Mentors/Teams can fork or copy these checklists and customize them based on team strengths, weaknesses, or specific competition trends observed.
-   Add specific commands or steps your team finds particularly useful.
-   Reorder sections based on your team's preferred workflow. Ensure uniqueness is maintained.

---
*These checklists are unique resources developed for Grissom JROTC CyberPatriot training.*
