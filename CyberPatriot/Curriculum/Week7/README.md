# Week 7: Network Security & Firewall Configuration

## Learning Objectives
By the end of this session, cadets will be able to:
- Configure enterprise-grade network security settings
- Implement host-based and network-based firewalls
- Configure router and switch security features
- Understand network security protocols and standards
- Implement network segmentation and access control
- Detect and mitigate common network attacks
- Monitor network traffic for security incidents
- Apply network security principles across platforms

## Pre-class Preparation
- Review [Network Security Fundamentals](../../Resources/Network_Security_Fundamentals.md)
- Complete the [Router Security Guide](../../Cisco/Guides/Intermediate/Router_Security.md)
- Watch [Firewall Configuration video](https://www.youtube.com/watch?v=example) (placeholder link)
- Read [Cisco Security Configurations](../../Cisco/Guides/Basic/Security_Configuration_Guide.md)

## Lesson Plan

### 1. Network Security Architecture (25 minutes)
- Defense-in-depth for networks
- Network security zones and boundaries
- Perimeter security vs. internal security
- Network security devices and their roles
- Security services and protocols
- Network threat models
- Attack vectors and mitigation strategies
- Network security standards and compliance

### 2. Windows Firewall Configuration (35 minutes)
- Windows Firewall architecture
- Windows Firewall with Advanced Security (WFAS)
- Inbound and outbound rules
- Rule types and conditions
- Profile-based configurations
- Group Policy firewall management
- Firewall logging and monitoring
- Testing firewall configurations
- Common Windows firewall misconfigurations

### 3. Linux Firewall Configuration (35 minutes)
- Linux firewall recap
- Advanced iptables configurations
- Creating comprehensive rule sets
- Network address translation (NAT)
- Service-specific firewall rules
- Firewall management tools
- Rule optimization and organization
- Stateful vs. stateless inspection
- Firewall logging and analysis

### 4. Cisco Network Device Security (40 minutes)
- Cisco security best practices
- Access control lists (ACLs)
  - Standard ACLs
  - Extended ACLs
  - Named ACLs
- Interface security
- Routing protocol security
- Switch security features
  - Port security
  - VLAN security
  - DHCP snooping
  - Dynamic ARP inspection
- Implementing Cisco Firewall features
- Securing management interfaces

### 5. Network Segmentation and Access Control (25 minutes)
- VLAN implementation and security
- Network segregation strategies
- Controlling inter-segment traffic
- Access control strategies
- Network quarantine zones
- Public vs. private networks
- Implementing security zones
- DMZ configuration

### 6. Hands-on Exercise (60 minutes)
- **Exercise**: [Network Security Implementation](../../Exercises/Network_Security_Implementation.md)
  - Configure Windows Firewall with complex rules
  - Implement Linux firewall protections
  - Configure Cisco router and switch security
  - Test cross-platform network connectivity
  - Verify security configurations

### 7. Assessment (20 minutes)
- [Network Security & Firewall Quiz](../../Quizzes/Quiz-Files/Network_Security_Firewall_Quiz.md)
- Discussion of network security scenarios
- Troubleshooting common issues

### 8. Wrap-up and Preview (10 minutes)
- Recap network security concepts
- Assign homework (see below)
- Preview next week (Scripting for Automation)
- Q&A session

## Homework Assignment
1. Create a comprehensive network security plan for a small organization
2. Develop and test advanced firewall rule sets for Windows and Linux
3. Complete the [Cisco ACL Challenge](../../Cisco/PacketTracer/Scenarios/ACL_Challenge.pkt)
4. Research and document three common network attacks and their prevention

## Additional Resources
- [Network Security Best Practices](https://example.com/network-security) (placeholder link)
- [Windows Firewall Advanced Security Documentation](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-firewall/windows-firewall-with-advanced-security)
- [Linux Firewall Guide](https://wiki.archlinux.org/title/Iptables)
- [Cisco Network Security Guide](https://www.cisco.com/c/en/us/td/docs/ios-xml/ios/sec_data_acl/configuration/15-mt/sec-data-acl-15-mt-book.html)
- [Network Security Templates](../../Resources/Network_Security_Templates/)

## Materials Needed
- Windows and Linux VMs for each cadet
- Cisco Packet Tracer with network security scenarios
- Firewall configuration examples
- Network traffic analysis tools
- ACL configuration templates
- Projection system for demonstrations
- Access to repository materials

## Instructor Notes
- This session integrates concepts across all platforms - emphasize commonalities
- Use visual aids to explain network security concepts
- Prepare realistic firewall scenarios that might appear in competition
- Have prepared solutions for the hands-on exercises
- Consider using Wireshark for demonstrating traffic analysis if time permits
- Be ready to troubleshoot connectivity issues from security configurations
- If possible, demonstrate an actual network attack and defense
- Emphasize verification and testing of security controls
- Highlight the balance between security and functionality
- Connect topics to their practical application in CyberPatriot competitions
