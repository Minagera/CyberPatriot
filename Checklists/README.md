# Security Checklists for CyberPatriot

This directory centralizes unique, actionable security checklists designed for rapid system hardening during CyberPatriot competitions. They serve as reminders and structured guides AFTER initial reconnaissance and README analysis.

## CRITICAL FIRST STEP: Always Read the Competition README First!

**The single most important step in any CyberPatriot competition is to thoroughly read and understand the README file provided with each challenge image!**

-   The README contains:
    -   **Scenario Context:** What system are you securing? What is its purpose?
    -   **Authorized Users/Services:** Items that MUST remain operational. Disabling them will likely lose points.
    -   **Prohibited Actions:** Things you should NOT do (e.g., "Do not delete user 'admin'", "Do not disable Apache").
    -   **Forensic Questions:** Specific questions you need to answer, often requiring investigation guided by the README. These are direct point sources.
    -   **Specific Requirements:** Rules or configurations unique to this image that override general best practices.

**README INSTRUCTIONS ALWAYS TRUMP THESE CHECKLISTS!** Use checklists as a guide for *general* hardening *after* accounting for all README specifics.

## Overview

Security checklists provide:
-   A systematic approach to securing systems under time pressure.
-   A way to ensure common critical security issues aren't overlooked.
-   A reference for typical vulnerabilities and fixes relevant to CyberPatriot.
-   A basis for documenting completed tasks (though a separate Change Log is better).

## Available Checklists

-   [**Windows/**](Windows/README.md): Checklist for hardening Windows 11/Server.
-   [**Linux/**](Linux/README.md): Checklist for hardening Ubuntu/Mint.
-   [**Cisco/**](Cisco/README.md): Checklist for hardening Cisco IOS devices (via Packet Tracer).

## How to Use

1.  **READ THE COMPETITION README.** (Cannot be stressed enough). Note required services, users, and specific tasks.
2.  Perform initial reconnaissance (users, services, processes, network, etc.).
3.  Answer high-priority forensic questions from the README.
4.  Address critical vulnerabilities identified in the README or during recon (e.g., unauthorized admin accounts).
5.  **THEN,** use the relevant checklist(s) as a guide for further hardening, skipping items that conflict with the README.
6.  Document all changes made in a separate Change Log (`../Resources/Templates/Change_Log_Template.md`).

## Team Strategy

-   Assign platform specialists (Windows, Linux, Cisco) to manage their respective checklists.
-   The Documentation Lead or Team Captain should ensure README requirements are communicated and tracked against checklist actions.
-   Don't blindly follow the checklist; think critically about each item in the context of the specific scenario.

## Additional Resources

-   [Core Security Principles](../Resources/Core_Security_Principles.md)
-   [Reference Sheets](../Resources/References/)
-   [Competition Strategy Guide](../Team_Resources/Competition_Strategy_Guide.md)

## Customizing Checklists

-   Teams are encouraged to adapt these checklists based on their experience and lessons learned from practice rounds.
-   Add notes or highlight items frequently encountered.
-   Ensure any customizations still emphasize reading the README first.

---
*These checklists are unique starting points developed for CyberPatriot training. Always prioritize the official competition README.*
