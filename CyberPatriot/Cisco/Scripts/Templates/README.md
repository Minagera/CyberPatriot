# Cisco IOS Configuration Templates

Reusable configuration templates for common security tasks:

- Basic device hardening
- SSH setup
- ACL configuration

Copy and adapt these templates for your Packet Tracer practice.

## Directory Index

```
Templates/
├── Router_Basic_Security_Template.txt
├── Switch_Basic_Security_Template.txt
├── ACL_Standard_Template.txt
├── ACL_Extended_Template.txt
├── Secure_Routing_Protocol_Template.txt
├── Advanced_Device_Hardening_Template.txt
├── AAA_Configuration_Template.txt
└── README.md
```

## Template Descriptions

- **Router_Basic_Security_Template.txt**  
  Basic router security: passwords, SSH, disable unnecessary services.

- **Switch_Basic_Security_Template.txt**  
  Basic switch security: passwords, SSH, port security.

- **ACL_Standard_Template.txt**  
  Standard access control lists for management filtering.

- **ACL_Extended_Template.txt**  
  Extended ACLs for protocol/traffic filtering.

- **Secure_Routing_Protocol_Template.txt**  
  OSPF/EIGRP authentication and secure routing.

- **Advanced_Device_Hardening_Template.txt**  
  Control plane policing, advanced security features.

- **AAA_Configuration_Template.txt**  
  Authentication, Authorization, Accounting (local and server-based).

## Template Usage

- Each template is a plain text file with Cisco IOS commands.
- Copy/paste into a Cisco device console or use with a terminal emulator.
- Review and modify for your device and scenario.
- Comments in templates explain each section.

## Template Format

```
! =======================================================
! [Template Name]
! Purpose: [Brief description]
! Usage: [How to use]
! =======================================================

! --- Section 1: [Section Name] ---
[Commands]
! [Explanation]

! --- Section 2: [Section Name] ---
[Commands]
! [Explanation]
```

## Customizing Templates

- Replace placeholder values (in [BRACKETS])
- Remove or comment out unneeded commands
- Add scenario-specific commands
- Test in Packet Tracer or a lab device before competition

## Important Notes

- Templates are starting points, not full solutions
- Understand each command before use
- Not all commands fit every scenario
- Ensure required services remain functional during competition
- Document all changes

## Example Usage

1. Open a template in a text editor
2. Modify for your device (hostnames, IPs, etc.)
3. Connect to the device (console/SSH)
4. Enter config mode: `enable` then `configure terminal`
5. Paste sections one at a time, verify each
6. Save config: `copy running-config startup-config`

## Creating Your Own Templates

- Follow the established format
- Add clear comments
- Test thoroughly
- Submit via pull request to contribute

## Additional Resources

- [Cisco IOS Command Reference](https://www.cisco.com/c/en/us/support/ios-nx-os-software/ios-xe-16/products-command-reference-list.html)
- [Cisco Configuration Best Practices](https://www.cisco.com/c/en/us/support/docs/ip/routing-information-protocol-rip/13608-26.html)
- [CyberPatriot Cisco Resources](https://www.uscyberpatriot.org/competition/training-materials/networking)
