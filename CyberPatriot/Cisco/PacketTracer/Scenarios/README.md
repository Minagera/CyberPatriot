# Packet Tracer Scenarios

This directory contains Packet Tracer scenario files (.pkt) that simulate various network configurations for practice. Each scenario is designed to help develop skills needed for the CyberPatriot Cisco Networking Challenge.

## Available Scenarios

- **Basic_Network_Security.pkt**: Basic router/switch security
- **Basic_VLAN_Setup.pkt**: VLANs and inter-VLAN routing
- **ACL_Implementation.pkt**: Standard and extended ACLs
- **Remote_Access_Security.pkt**: SSH and management access
- **Enterprise_Network_Security.pkt**: Advanced, multi-device security
- **Network_Troubleshooting.pkt**: Find and fix security misconfigurations
- **Advanced_Branch_Security.pkt**: Multi-VLAN, segmentation, and forensics

## How to Use

1. Download the scenario file.
2. Open it in Cisco Packet Tracer.
3. Read the accompanying exercise document in the [Exercises](../../Exercises) directory.
4. Complete the required tasks and verify your solution.

*Scenarios are designed for CyberPatriot training. Practice with different scenarios to build your skills!*

## Scenario Development Notes

- All scenarios are created using Packet Tracer version 8.0 or later
- Each scenario includes notes within the Packet Tracer file that explain the setup
- Scenarios are designed to mimic real-world network security challenges
- All scenarios have been tested to ensure they are solvable

## Scenario Randomization Workflow

While Packet Tracer does not support full automation, you can:
1. Use provided scenario templates as a base.
2. Randomly change device names, passwords, VLANs, and IPs.
3. Save each variant as a new .pkt file for practice.
4. Use the scoring TCL script to check student solutions.

*For advanced users: Consider scripting .pkt file modifications externally (see resources).*

## Creating Your Own Scenarios

If you'd like to contribute your own Packet Tracer scenarios:

1. Follow the naming convention: `[Difficulty]_[Topic]_[Description].pkt`
2. Include clear notes within the Packet Tracer file
3. Create an accompanying exercise document
4. Provide a solution file
5. Submit a pull request with all files

## Troubleshooting

If you encounter issues with any scenario file:

- Ensure you're using a compatible version of Packet Tracer
- Check that all devices power on properly
- Verify the initial configurations are loaded
- Consult the troubleshooting section in the exercise document

For persistent issues, please open an issue in the GitHub repository.
