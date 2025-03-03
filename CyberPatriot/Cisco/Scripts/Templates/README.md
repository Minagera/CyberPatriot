# Cisco IOS Script Templates

This directory contains template scripts for common Cisco device configurations. These templates can be customized and used to quickly implement secure configurations on Cisco routers and switches during CyberPatriot competitions.

## Using These Templates

1. These templates are text files containing Cisco IOS commands
2. They can be copy-pasted into a Cisco device console or used with a terminal emulator's send file feature
3. Review and modify each template before use to adapt it to your specific device and network requirements
4. Comments are provided to explain the purpose of each section and configuration line

## Available Templates

### Basic Security Templates

1. **Router_Basic_Security_Template.txt**
   - Basic router security hardening commands
   - Includes password configuration, SSH setup, and service disabling
   - Starting point for any router security implementation

2. **Switch_Basic_Security_Template.txt**
   - Basic switch security hardening commands
   - Includes password configuration, SSH setup, and port security

### Intermediate Security Templates

3. **ACL_Standard_Template.txt**
   - Templates for standard access control lists
   - Includes examples for filtering management access

4. **ACL_Extended_Template.txt**
   - Templates for extended access control lists
   - Examples for filtering various protocols and traffic types

5. **Secure_Routing_Protocol_Template.txt**
   - Templates for securing routing protocols (OSPF, EIGRP)
   - Authentication configuration for routing updates

### Advanced Security Templates

6. **Advanced_Device_Hardening_Template.txt**
   - Comprehensive security hardening commands
   - Includes control plane policing and advanced security features

7. **AAA_Configuration_Template.txt**
   - Authentication, Authorization, and Accounting setup
   - Local and server-based authentication examples

## Template Format

Each template follows this general format:

```
! =======================================================
! [Template Name]
! Purpose: [Brief description of the template's purpose]
! Usage: [How to use this template]
! =======================================================

! --- Section 1: [Section Name] ---
[Commands for this section]
! [Explanation of important commands]

! --- Section 2: [Section Name] ---
[Commands for this section]
! [Explanation of important commands]

! ... additional sections ...
```

## Customizing Templates

Before applying these templates, you should customize them by:

1. Replacing placeholder values (indicated by [BRACKETS])
2. Removing or commenting out commands that don't apply to your scenario
3. Adding any specific commands required for your network
4. Testing on a lab device or Packet Tracer before applying in competition

## Important Notes

- These templates are starting points, not complete solutions
- Always understand what each command does before using it
- Not all commands will be appropriate for every scenario
- During CyberPatriot competitions, make sure all required services remain functional
- Document any changes you make to the network

## Example Usage

Here's how you might use one of these templates:

1. Open the template file in a text editor
2. Modify it for your specific device (replace hostnames, IP addresses, etc.)
3. Connect to your Cisco device via console or SSH
4. Enter configuration mode: `enable` then `configure terminal`
5. Copy and paste sections of the template one at a time
6. Verify each section works as expected before continuing
7. Save the configuration: `copy running-config startup-config`

## Creating Your Own Templates

You're encouraged to create your own templates based on your experiences. When creating new templates:

1. Follow the established format
2. Include clear comments explaining each section
3. Test your template thoroughly
4. Submit a pull request to add it to this repository

## Additional Resources

- [Cisco IOS Command Reference](https://www.cisco.com/c/en/us/support/ios-nx-os-software/ios-xe-16/products-command-reference-list.html)
- [Cisco Configuration Best Practices](https://www.cisco.com/c/en/us/support/docs/ip/routing-information-protocol-rip/13608-26.html)
- [CyberPatriot Cisco Resources](https://www.uscyberpatriot.org/competition/training-materials/networking)
