# Cisco Packet Tracer Scenarios

This directory contains Cisco Packet Tracer (`.pkt`) files designed for CyberPatriot training exercises. Each scenario presents a network topology with specific security challenges to address.

**Note:** Ensure you have a compatible version of Cisco Packet Tracer installed.

## Scenario Index

-   [**Basic_Hardening_Scenario.pkt**](Basic_Hardening_Scenario.pkt)
    *   **Description:** A simple network with one router and one switch. Devices have default configurations.
    *   **Objective:** Apply basic device hardening (hostname, enable secret, line passwords, banner, encrypt passwords, disable unused services/ports). See `../Exercises/Basic_Device_Hardening_Exercise.md`.
-   [**SSH_Access_Scenario.pkt**](SSH_Access_Scenario.pkt)
    *   **Description:** Router needs secure remote management configured.
    *   **Objective:** Configure SSH access and disable Telnet. See `../Exercises/SSH_Configuration_Exercise.md`.
-   [**Standard_ACL_Scenario.pkt**](Standard_ACL_Scenario.pkt)
    *   **Description:** A router connecting two LAN segments. Requires traffic filtering based on source network.
    *   **Objective:** Implement a standard ACL to meet specific permit/deny requirements. See `../Exercises/Standard_ACL_Exercise.md`.
-   [**Extended_ACL_Scenario.pkt**](Extended_ACL_Scenario.pkt)
    *   **Description:** A network requiring granular filtering based on source/destination IPs and ports (e.g., allow web traffic, deny FTP).
    *   **Objective:** Implement an extended ACL to meet specific permit/deny requirements. See `../Exercises/Extended_ACL_Exercise.md`.
-   [**Port_Security_Scenario.pkt**](Port_Security_Scenario.pkt)
    *   **Description:** A switch connected to multiple PCs. Requires securing access ports.
    *   **Objective:** Configure switchport security (sticky MAC, max hosts, violation mode). See `../Exercises/Switch_Port_Security_Exercise.md`.

## How to Use

1.  Download the `.pkt` file.
2.  Open the file in Cisco Packet Tracer.
3.  Review the network topology and any instructions within the Packet Tracer scenario itself (check the yellow notes icon).
4.  Refer to the corresponding exercise `.md` file in `../Exercises/` for detailed tasks.
5.  Configure the devices using the CLI.
6.  Use Packet Tracer's simulation mode or built-in checks (if available) to test connectivity and security.

## Contribution

Create new `.pkt` scenarios covering different topologies or security challenges (VLANs, routing, etc.). Provide a clear description and objective, and ideally link it to a new exercise file.

---

*All scenarios are unique and tailored for CyberPatriot training.*
