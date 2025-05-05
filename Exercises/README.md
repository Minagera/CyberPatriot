# CyberPatriot Exercises Directory

This directory serves as a central point for understanding the exercise structure but primarily directs users to platform-specific exercise directories. It may also contain general or cross-platform exercises.

## Directory Structure

Hands-on exercises are crucial for building practical skills. Most exercises are platform-specific and located within their respective directories:

-   [**../Windows/Exercises/**](../Windows/Exercises/README.md): Exercises focused on Windows security tasks, tools, and incident response.
-   [**../Linux/Exercises/**](../Linux/Exercises/README.md): Exercises focused on Linux command-line security, configuration, and incident response.
-   [**../Cisco/Exercises/**](../Cisco/Exercises/README.md): Exercises focused on Cisco IOS configuration and troubleshooting, typically using Packet Tracer (`../Cisco/PacketTracer/`).

This directory might contain:
-   **Cross-Platform Scenarios:** Exercises involving interactions between Windows, Linux, and/or Cisco components.
-   **General Security Concepts:** Exercises focused on broader topics like network scanning interpretation (using provided logs, not live scanning), or basic cryptography concepts relevant to CP.

## How to Use

1.  Navigate to the relevant platform-specific directory (`../Windows/Exercises/`, `../Linux/Exercises/`, `../Cisco/Exercises/`) for most exercises.
2.  Follow the `README.md` file within those directories for specific instructions.
3.  Complete exercises related to the topics currently being studied in the `../Curriculum/` or `../Guides/`.
4.  Use the `../VM-Setup/` scripts or `../Cisco/PacketTracer/` files to create the necessary practice environments if required by an exercise.
5.  **Document your steps and findings** meticulously, just as you would during a competition. Use templates from `../Resources/Templates/`.

## VM Setup Scripts

Many advanced exercises, especially incident response scenarios, rely on the compromised environments created by scripts in the `../VM-Setup/` directory. Ensure you have followed the setup instructions there and use the appropriate VM snapshots.

## Additional Notes

-   Exercises range in difficulty from basic familiarization to complex incident response scenarios designed for Nationals-level practice.
-   Focus on understanding the *why* behind each step, not just completing the task. Research commands or concepts you don't understand.
-   Practice effective documentation alongside technical execution.

---
*All exercises are unique and tailored for CyberPatriot cadet training. Contribute new exercises or improvements via pull request to the appropriate directory.*
