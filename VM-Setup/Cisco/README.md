# CyberPatriot Cisco Scenario Setup (Packet Tracer)

This directory provides unique Cisco Packet Tracer (`.pkt`) files and documentation designed to simulate network scenarios for CyberPatriot practice. Unlike the OS setups, these are self-contained Packet Tracer environments.

## Goal

To provide realistic starting points for practicing Cisco IOS hardening, ACL implementation, switch security, and troubleshooting tasks commonly found in CyberPatriot networking challenges.

## Scenario Types

-   **Hardening Challenge:** A `.pkt` file with one or more Cisco devices (routers, switches) configured with basic connectivity but lacking security hardening. Cadets must apply hardening principles (passwords, SSH, banners, disable services, etc.).
-   **ACL Implementation:** A `.pkt` file with a defined network topology and specific traffic filtering requirements. Cadets must design, implement, and test appropriate Access Control Lists.
-   **Troubleshooting Scenario:** A `.pkt` file with a pre-configured network containing deliberate misconfigurations or connectivity issues. Cadets must use `show` commands, `ping`, and `traceroute` to diagnose and fix the problems.
-   **Combined Scenario:** A `.pkt` file incorporating elements of hardening, ACLs, and potentially basic switch security or routing.

## Available Scenarios

*(List specific .pkt files here as they are created)*

-   `Basic_Hardening_Challenge_Start.pkt`: Requires basic device hardening on a router and switch.
-   `Web_Server_ACL_Challenge_Start.pkt`: Requires implementing ACLs to control access to a web server.
-   `Connectivity_Troubleshooting_Scenario.pkt`: Contains issues preventing full network connectivity.
-   *(Add more scenarios)*

## Setup Instructions

1.  Ensure you have the latest version of Cisco Packet Tracer installed.
2.  Download the desired starting `.pkt` file from this directory.
3.  No VM setup is required; Packet Tracer is the environment.

## Usage Instructions for Cadets

1.  Open the downloaded starting `.pkt` file in Cisco Packet Tracer.
2.  **Carefully read the scenario instructions.** These might be:
    -   Within the Packet Tracer activity wizard (if used).
    -   In sticky notes placed on the topology workspace.
    -   In a separate `README.md` file accompanying the `.pkt` file (if provided).
    -   **THIS IS YOUR PRIMARY GUIDE.**
3.  Perform the required configuration, hardening, or troubleshooting tasks using the Cisco IOS CLI on the devices within Packet Tracer.
4.  Use commands learned from `../../Cisco/Guides/` and reference materials.
5.  Test connectivity and verify configurations using `show` commands, `ping`, etc.
6.  Save your completed `.pkt` file frequently (`File > Save As...`).
7.  Document key configurations (passwords, ACL logic, troubleshooting steps) using templates from `../../Resources/Templates/`.

## Customization

-   Instructors can modify existing `.pkt` files (save as new versions) to change requirements, add complexity, or introduce different faults.
-   Create entirely new scenarios using Packet Tracer, focusing on skills relevant to CyberPatriot.

## Contribution

-   Create new, unique `.pkt` scenarios relevant to CyberPatriot tasks.
-   Provide clear instructions/objectives within the `.pkt` file or a companion README.
-   Consider creating both starting and solution versions (clearly labeled).
-   Submit contributions via pull request.

---
*These Packet Tracer scenarios are unique resources designed for CyberPatriot network security training.*
