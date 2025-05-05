# Security Checklists for CyberPatriot

This directory centralizes actionable security checklists designed for rapid system hardening during CyberPatriot competitions.

## CRITICAL FIRST STEP: Always Read the Competition README First!

**The most important step in any CyberPatriot competition is to thoroughly read the README file provided with each challenge!**

-   Each competition image comes with a README file containing specific scenario information, required services/users, prohibited actions, and forensic questions.
-   The README may override general security practices with competition-specific requirements.
-   Answers to forensic questions are often found by following README instructions.

**Never make security changes without first consulting the README file for that specific challenge!**

## Overview

Security checklists provide:
-   A systematic approach to securing systems under time pressure.
-   A way to ensure critical security issues aren't overlooked.
-   A reference for common vulnerabilities and fixes relevant to CyberPatriot.
-   A basis for documenting completed tasks.

## Available Checklists

-   [**Windows/**](Windows/README.md): Checklist for Windows 11 / Windows Server. Covers user accounts, policies, services, features, file system, network security, and common forensic locations.
-   [**Linux/**](Linux/README.md): Checklist for Ubuntu / Linux Mint. Covers user accounts, password policies, services, firewall (UFW), SSH, permissions, logging, and common forensic locations.
-   [**Cisco/**](Cisco/README.md): Checklist for Cisco IOS devices (via Packet Tracer). Covers basic hardening, password security, SSH configuration, disabling unused services/interfaces, and basic ACL concepts.

## How to Use

1.  **Read the Competition README.**
2.  Use the relevant platform checklist as a guide.
3.  Prioritize items based on the README and potential point values (e.g., forensic questions, critical vulnerabilities).
4.  Document actions taken (use `../Resources/Templates/Change_Log_Template.md`).
5.  Adapt the checklist based on the specific image and scenario.

## Team Strategy

-   Assign specific sections to different team members based on roles (Windows Specialist, Linux Specialist, etc.).
-   Communicate findings and completed items.
-   Use the checklist to track progress and ensure coverage.
-   Prioritize high-value security fixes first.

## Additional Resources

For more detailed information on implementing these security measures, refer to:
-   The `Guides` directories within each platform folder (`../Windows/Guides/`, `../Linux/Guides/`, `../Cisco/Guides/`).
-   The `Exercises` directory for hands-on practice (`../Exercises/`).
-   The `Resources` directory for command references and templates (`../Resources/`).

## Customizing Checklists

Teams are encouraged to customize these checklists based on:
-   Team member expertise.
-   Specifics learned from practice images and past competitions.
-   Time management strategies.
-   Point-earning effectiveness observed via the scoring engine.

Remember that the competition README file's instructions always take precedence over general security practices in these checklists when there's a conflict.
