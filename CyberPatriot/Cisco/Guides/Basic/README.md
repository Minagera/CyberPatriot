# Cisco IOS Fundamentals

This guide covers the fundamental concepts and commands needed to configure and secure Cisco devices through the Cisco IOS (Internetwork Operating System) command-line interface. This knowledge forms the foundation for the CyberPatriot Cisco Networking Challenge.

## Table of Contents

- [Introduction to Cisco IOS](#introduction-to-cisco-ios)
- [Accessing the CLI](#accessing-the-cli)
- [Command Modes](#command-modes)
- [Basic Navigation Commands](#basic-navigation-commands)
- [Configuration Commands](#configuration-commands)
- [Saving Configurations](#saving-configurations)
- [Device Security Basics](#device-security-basics)
- [Viewing System Information](#viewing-system-information)
- [Common Mistakes to Avoid](#common-mistakes-to-avoid)
- [Next Steps](#next-steps)

## Introduction to Cisco IOS

Cisco IOS (Internetwork Operating System) is the software used on most Cisco routers and switches. It provides a command-line interface (CLI) for configuring, monitoring, and maintaining network devices.

In Packet Tracer, the IOS interface simulates the actual IOS running on physical Cisco equipment, giving you practical experience that translates directly to real-world networking.

## Accessing the CLI

In Packet Tracer, you can access the CLI of a device by:

1. Clicking on the device in the topology
2. Selecting the "CLI" tab in the device configuration window

In a real environment, you would typically access the CLI through:

- Console connection (direct physical connection)
- Telnet (unsecured remote access - not recommended for production)
- SSH (secure remote access - recommended)

## Command Modes

Cisco IOS has several command modes, each with different privileges and available commands:

1. **User EXEC Mode**
   - Initial mode when logging in
   - Limited to basic monitoring commands
   - Prompt ends with `>`
   - Example: `Router>`

2. **Privileged EXEC Mode** (also called "Enable Mode")
   - Access to all device commands, including configuration
   - Entered by typing `enable` from User EXEC mode
   - Prompt ends with `#`
   - Example: `Router#`

3. **Global Configuration Mode**
   - Used to configure parameters affecting the entire device
   - Entered by typing `configure terminal` (or `conf t`) from Privileged EXEC mode
   - Prompt includes `(config)#`
   - Example: `Router(config)#`

4. **Specific Configuration Modes**
   - Interface configuration: `Router(config-if)#`
   - Line configuration: `Router(config-line)#`
   - Router configuration: `Router(config-router)#`
   - VLAN configuration: `Switch(config-vlan)#`

## Basic Navigation Commands

| Command | Description | Mode |
|---------|-------------|------|
| `?` | Display available commands | Any |
| `enable` | Enter privileged EXEC mode | User EXEC |
| `disable` | Exit privileged EXEC mode back to user EXEC | Privileged EXEC |
| `configure terminal` | Enter global configuration mode | Privileged EXEC |
| `exit` | Exit current mode to previous mode | Any configuration mode |
| `end` or `Ctrl+Z` | Exit to privileged EXEC mode | Any configuration mode |
| `show history` | Display command history | User/Privileged EXEC |
| `show running-config` | Display current configuration in RAM | Privileged EXEC |
| `show startup-config` | Display saved configuration in NVRAM | Privileged EXEC |

## Configuration Commands

Here are some essential configuration commands you'll need in the CyberPatriot competition:

### Device Identification
```
Router(config)# hostname R1
R1(config)#
```

### Setting Passwords
```
R1(config)# enable secret StrongPassword123   // Encrypted privileged EXEC password
R1(config)# line console 0
R1(config-line)# password ConsolePassword123  // Console line password
R1(config-line)# login                        // Enable password checking
R1(config-line)# exit
R1(config)# line vty 0 4                      // Telnet/SSH access lines
R1(config-line)# password VtyPassword123      // VTY line password
R1(config-line)# login                        // Enable password checking
```

### Interface Configuration
```
R1(config)# interface gigabitethernet 0/0     // Enter interface configuration
R1(config-if)# ip address 192.168.1.1 255.255.255.0  // Set IP address and subnet mask
R1(config-if)# description Connection to LAN   // Document interface purpose
R1(config-if)# no shutdown                     // Enable the interface
```

### Banner Configuration
```
R1(config)# banner motd #
Enter TEXT message. End with the character '#'.
AUTHORIZED ACCESS ONLY
Unauthorized access is prohibited and subject to legal action.
#
```

## Saving Configurations

Configuration changes in Cisco IOS are made to the running configuration in RAM. To preserve these changes through a reboot, you must save them to the startup configuration in NVRAM:

```
R1# copy running-config startup-config
Destination filename [startup-config]? [Press Enter]
Building configuration...
[OK]
```

Shorthand command:
```
R1# write memory
```
or simply:
```
R1# wr
```

## Device Security Basics

Securing a Cisco device is a critical step in the CyberPatriot competition. Here are essential security configurations:

### Secure Password Configuration
```
R1(config)# service password-encryption   // Encrypt all passwords in the configuration
R1(config)# security passwords min-length 8  // Require minimum 8-character passwords
```

### Disable Unused Services
```
R1(config)# no service tcp-small-servers
R1(config)# no service udp-small-servers
R1(config)# no ip http server              // Disable HTTP server
R1(config)# no ip finger                   // Disable finger service
R1(config)# no cdp run                     // Disable CDP globally (if not needed)
```

### Configure SSH (Secure Shell)
```
R1(config)# hostname R1                     // Set hostname (required for SSH)
R1(config)# ip domain-name example.com      // Set domain name
R1(config)# crypto key generate rsa         // Generate RSA keys
How many bits in the modulus [512]: 1024     // Minimum 1024 bits recommended

R1(config)# line vty 0 4
R1(config-line)# transport input ssh        // Only allow SSH (no Telnet)
R1(config-line)# login local                // Use local username/password
R1(config-line)# exit

R1(config)# username admin secret StrongP@ss  // Create local user
```

## Viewing System Information

These commands help you understand the device's current state and configuration:

| Command | Description |
|---------|-------------|
| `show version` | Displays IOS version, uptime, and basic hardware information |
| `show interfaces` | Displays status and statistics for all interfaces |
| `show ip interface brief` | Shows a summary of all interfaces with IP addressing |
| `show running-config` | Displays the current configuration in memory |
| `show startup-config` | Displays the saved configuration in NVRAM |
| `show vlan` (switches) | Displays VLAN information |
| `show ip route` (routers) | Displays the IP routing table |
| `show cdp neighbors` | Shows directly connected Cisco devices if CDP is enabled |

## Common Mistakes to Avoid

1. **Not saving configuration changes**
   - Always use `copy running-config startup-config` after making changes

2. **Locking yourself out**
   - Be careful when configuring access restrictions
   - Always test access after making security changes

3. **Mistyping IP addresses and subnet masks**
   - Double-check all addressing before committing changes

4. **Forgetting to enable interfaces**
   - New interfaces are disabled by default; use `no shutdown` to enable them

5. **Confusion about command modes**
   - Pay attention to the prompt to know which mode you're in
   - Some commands only work in specific modes

## Next Steps

After mastering these basics, proceed to:

1. [Router Security Guide](../Intermediate/Router_Security.md)
2. [Switch Security Guide](../Intermediate/Switch_Security.md)
3. [Basic ACL Configuration](../Intermediate/Access_Control_Lists.md)

Try the basic exercises in the [Exercises](../../Exercises) directory to practice these commands.

## Practice Exercises

1. Configure a router with the hostname "CP-Router1"
2. Set encrypted privileged EXEC password to "CyberP@triot"
3. Configure console and vty lines with password "Secure@ccess"
4. Set an appropriate login banner
5. Configure a loopback interface with IP 10.0.0.1/24
6. Save the configuration

## Additional Resources

- [Cisco IOS Command Reference](https://www.cisco.com/c/en/us/support/ios-nx-os-software/ios-xe-16/products-command-reference-list.html)
- [Cisco Learning Network](https://learningnetwork.cisco.com/)
- [Packet Tracer Labs](../../PacketTracer/Scenarios)
