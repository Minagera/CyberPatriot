# Basic Network Security Exercise

## Overview

In this exercise, you'll work with a small network in Packet Tracer that requires security improvements. You'll need to configure secure passwords, implement SSH, disable unnecessary services, and ensure proper access controls are in place. This exercise simulates a basic CyberPatriot Cisco Networking Challenge.

## Learning Objectives

- Configure secure device access methods
- Implement SSH for remote administration
- Disable unnecessary and insecure services
- Apply basic security best practices
- Verify network functionality while maintaining security

## Prerequisites

- Cisco Packet Tracer installed
- Basic understanding of Cisco IOS commands
- Familiarity with network security concepts

## Network Topology

The exercise uses the following topology:

```
                         Internet
                            |
                            |
                     +------+------+
                     |    Router    |
                     +------+------+
                            |
                            |
                     +------+------+
                     |    Switch    |
                     +------+------+
                       /         \
                      /           \
                     /             \
            +--------+              +--------+
            | Admin PC |            | User PC |
            +--------+              +--------+
```

## Setup Instructions

1. Download the [Basic_Network_Security.pkt](../PacketTracer/Scenarios/Basic_Network_Security.pkt) file
2. Open the file in Packet Tracer
3. Read the scenario information in the Notes section of the file

## Scenario

You are a security administrator for a small company. You've been asked to secure the network devices according to best practices. The current setup has basic connectivity but lacks security controls. Your task is to implement security measures while maintaining network functionality.

## Exercise Tasks

### Part 1: Router Security Configuration

1. Configure appropriate hostnames for network devices
2. Secure local and remote access to the router:
   - Configure a secure enable secret password
   - Configure console line with password and login
   - Configure VTY lines to use SSH (not Telnet)
   - Create a local user account for administrative access

3. Configure SSH access:
   - Set up domain name
   - Generate RSA keys (minimum 1024 bits)
   - Configure SSH version 2
   - Restrict SSH access to administrative VLANs only

4. Disable unnecessary services:
   - HTTP/HTTPS server
   - CDP on external interfaces
   - Small servers (TCP/UDP)
   - IP source routing

5. Configure appropriate login and MOTD banners

6. Implement logging:
   - Enable logging with timestamps
   - Configure buffer logging

### Part 2: Switch Security Configuration

1. Configure secure local and remote access to the switch:
   - Configure a secure enable secret password
   - Configure console line with password and login
   - Configure VTY lines to use SSH (not Telnet)
   - Create a local user account for administrative access

2. Configure SSH access similarly to the router

3. Disable unnecessary features:
   - HTTP/HTTPS server
   - CDP on external interfaces
   - Unused ports

4. Configure appropriate login and MOTD banners

### Part 3: Verification

1. Verify that all devices are still able to ping each other
2. Verify that you can SSH to the router and switch from the Admin PC
3. Verify that Telnet access is disabled
4. Verify that all required services are functioning properly

## Detailed Requirements

### Router Configuration Requirements

1. **Hostname**: Set the router hostname to "R-SECROUTER"

2. **Username and Password**:
   - Create a local user "admin" with the password "CyberP@tr1ot!"
   - Configure enable secret as "En@bleP@ss2023!"
   - Ensure all passwords are encrypted in the configuration

3. **Line Access**:
   - Console: Configure password "ConS0leP@ss!" with login
   - VTY: Configure for local authentication
   - Set exec timeout to 5 minutes on all lines

4. **SSH Configuration**:
   - Domain name: "cyberpatriot.local"
   - RSA key size: 1024 bits minimum
   - SSH version 2 only
   - SSH timeout: 60 seconds
   - SSH authentication retries: 3

5. **Service Disabling**:
   - Disable HTTP/HTTPS server
   - Disable CDP on Internet-facing interfaces
   - Disable TCP/UDP small servers
   - Disable IP source routing
   - Disable IP finger service

6. **Banners**:
   - Configure a MOTD banner with appropriate unauthorized access warning
   - Configure a login banner with authentication warning

7. **Logging**:
   - Enable buffered logging (size 16384)
   - Configure timestamps with date and time in milliseconds

### Switch Configuration Requirements

1. **Hostname**: Set the switch hostname to "S-SECSWITCH"

2. **Username and Password**:
   - Same requirements as the router

3. **Line Access**:
   - Same requirements as the router

4. **SSH Configuration**:
   - Same requirements as the router

5. **Service Disabling**:
   - Disable HTTP/HTTPS server
   - Disable CDP on uplink interfaces
   - Shut down unused ports (ports 5-24)

6. **Banners**:
   - Same requirements as the router

## Assessment Criteria

Your configuration will be evaluated based on:

1. **Security Implementation**: Are all required security measures properly implemented?
2. **Network Functionality**: Does the network still function properly after security measures are applied?
3. **Configuration Accuracy**: Are all configurations applied according to the requirements?
4. **Documentation**: Did you document the changes made?

## Completing the Exercise

1. After implementing all security measures, save your configurations on all devices
2. Test connectivity between all devices
3. Verify you can SSH to all devices from the Admin PC
4. Create a document listing all security measures implemented and why they are important
5. Save your Packet Tracer file as "Basic_Network_Security_Completed.pkt"

## Solution Reference

A solution file is available for mentors in the [Solutions](../PacketTracer/Solutions/Basic_Network_Security_Solution.pkt) directory. This should only be referenced after attempting the exercise.

## Example Configuration Snippets

Here are some example configurations to get you started:

### Example Router Hostname and Banner Configuration
```
Router> enable
Router# configure terminal
Router(config)# hostname R-SECROUTER
R-SECROUTER(config)# banner motd #
UNAUTHORIZED ACCESS TO THIS DEVICE IS PROHIBITED

This system is the property of CyberPatriot Training.
Unauthorized access is prohibited. Users are subject to monitoring.
#
R-SECROUTER(config)# banner login #
WARNING: Authentication required. Authorized personnel only.
#
```

### Example SSH Configuration
```
R-SECROUTER(config)# ip domain-name cyberpatriot.local
R-SECROUTER(config)# crypto key generate rsa
How many bits in the modulus [512]: 1024
R-SECROUTER(config)# ip ssh version 2
R-SECROUTER(config)# ip ssh time-out 60
R-SECROUTER(config)# ip ssh authentication-retries 3
```

## Quiz Questions

After completing the exercise, answer these questions to test your understanding:

1. Why is SSH preferred over Telnet for remote management?
2. What is the purpose of the "service password-encryption" command?
3. Why should unused switch ports be shut down?
4. What is the purpose of setting an exec timeout on console and VTY lines?
5. Why is it important to disable unnecessary services on network devices?

## Next Steps

After completing this basic exercise, move on to:
1. [Intermediate Router ACL Exercise](./Intermediate_Router_ACL_Exercise.md)
2. [VLANs and Inter-VLAN Routing Exercise](./VLAN_Security_Exercise.md)
3. [Advanced Router Security Exercise](./Advanced_Router_Security_Exercise.md)

## Additional Resources

- [Cisco IOS Security Configuration Guide](https://www.cisco.com/c/en/us/support/security/ios-firewall/products-installation-and-configuration-guides-list.html)
- [CyberPatriot Cisco Networking Resources](https://www.uscyberpatriot.org/competition/training-materials/networking)
- [NSA Cisco Router Hardening Guide](https://apps.nsa.gov/iaarchive/library/ia-guidance/security-configuration/networks/cisco-router-security-configuration-guide.cfm)
