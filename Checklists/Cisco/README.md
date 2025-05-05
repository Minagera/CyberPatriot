# Cisco IOS Security Checklist for CyberPatriot

**Reminder: This checklist is a guide for general hardening using Cisco IOS commands, typically within Packet Tracer. Always prioritize the specific instructions, network topology, required connectivity, and security tasks found in the official Competition README or scenario file.**

## CRITICAL FIRST STEP: Read the Competition README/Scenario!
Before making any configuration changes:
- Understand the network diagram provided.
- Identify required connectivity (which devices need to talk to each other, using which protocols/ports).
- Note any specific IP addressing schemes or device roles.
- Identify authorized services that must remain operational.
- Note any prohibited actions or configurations.
- Understand the specific security tasks required (e.g., configure SSH, implement specific ACLs).

**README/SCENARIO INSTRUCTIONS TRUMP THIS CHECKLIST!**

---

## Basic Device Hardening (Router/Switch)

- [ ] **README Check:** Note required hostname, domain name, specific passwords/usernames if provided.
- [ ] Set unique hostname.
  ```ios
  enable
  configure terminal
  hostname <DeviceName>
  ```
- [ ] Set strong enable secret.
  ```ios
  enable secret <StrongPassword>
  ```
- [ ] Secure console line.
  ```ios
  line console 0
   password <StrongConsolePassword>
   login
   exec-timeout 5 0  # Set console timeout (5 min 0 sec)
  end
  configure terminal # Re-enter config mode if needed
  ```
- [ ] Secure VTY lines (for Telnet/SSH).
  ```ios
  line vty 0 4  # Or 0 15 depending on device/needs
   password <StrongVTYPassword> # Needed even if using login local for SSH fallback
   login # Use 'login local' if configuring SSH with local users
   exec-timeout 5 0 # Set VTY timeout
   transport input ssh # Prefer SSH over Telnet. Use 'none' to disable remote access. Use 'telnet' only if explicitly required by README.
  end
  configure terminal
  ```
- [ ] Encrypt clear-text passwords.
  ```ios
  service password-encryption
  ```
- [ ] Set MOTD Banner.
  ```ios
  banner motd # Authorized Access Only. Violators will be prosecuted. #
  ```
- [ ] Disable unused services.
  ```ios
  no ip http server
  no ip http secure-server
  no cdp run # Disable Cisco Discovery Protocol unless needed for scenario
  ```
- [ ] Shut down unused interfaces.
  ```ios
  interface range <TypeStartPort - EndPort> # e.g., interface range fa0/1 - 24
   shutdown
  end
  configure terminal
  ```

---

## Secure Remote Access (SSH)

- [ ] **README Check:** Verify if SSH is required, and if specific usernames/passwords are given.
- [ ] Configure hostname (if not already done).
- [ ] Configure IP domain name.
  ```ios
  ip domain-name <domain.local> # e.g., cyberpatriot.local
  ```
- [ ] Generate RSA crypto keys (for SSH). Use 2048 bits if possible.
  ```ios
  crypto key generate rsa modulus 2048
  ```
- [ ] Create local user(s) for SSH login.
  ```ios
  username <AdminUser> secret <StrongUserPassword>
  ```
- [ ] Configure VTY lines for SSH login.
  ```ios
  line vty 0 4 # Or 0 15
   login local # Use local user database for login
   transport input ssh # Allow only SSH
  end
  configure terminal
  ```

---

## Access Control Lists (ACLs)

- [ ] **README Check:** Carefully analyze ACL requirements. What traffic should be permitted/denied? Between which networks/hosts? Which protocols/ports?
- [ ] Define ACLs (Use named extended ACLs for clarity and flexibility unless standard suffices).
  ```ios
  ip access-list extended <ACL_NAME>
   remark <Description of rule>
   permit tcp <source_network> <source_wildcard> <dest_network> <dest_wildcard> eq <port> # Example: permit tcp 192.168.1.0 0.0.0.255 host 10.0.0.1 eq 80
   permit icmp any any echo-reply # Allow ping replies (often useful)
   deny ip any any log # Explicit deny at the end (optional: log)
  exit
  ```
- [ ] Apply ACLs to the correct interface and direction (`in` or `out`).
  ```ios
  interface <TypeNumber> # e.g., GigabitEthernet0/0
   ip access-group <ACL_NAME> in # Or 'out'
  end
  configure terminal
  ```
- [ ] Verify ACLs.
  ```ios
  show access-lists
  show ip interface <TypeNumber> # Check if ACL is applied
  # Test connectivity using ping/telnet from allowed/denied sources in Packet Tracer
  ```

---

## Switch Security (If Applicable)

- [ ] **README Check:** See if switch security tasks are required (Port Security, VLANs).
- [ ] Configure Port Security on access ports (connect to end devices).
  ```ios
  interface <TypeNumber>
   switchport mode access
   switchport port-security
   switchport port-security maximum 1 # Allow only 1 MAC address
   switchport port-security violation restrict # Or 'shutdown' or 'protect'
   switchport port-security mac-address sticky # Learn MAC dynamically and save to config (optional)
   # Or manually specify MAC: switchport port-security mac-address <aaaa.bbbb.cccc>
   shutdown # Shut down unused ports (already covered in basic hardening)
   no shutdown # Enable configured ports
  end
  configure terminal
  ```
- [ ] Configure VLANs if required by scenario (more advanced).

---

## Final Steps

- [ ] Verify all README requirements have been met.
- [ ] Test required connectivity using `ping`, `traceroute`, or application simulation in Packet Tracer.
- [ ] Save the configuration!
  ```ios
  end
  copy running-config startup-config
  # Or: write memory (wr)
  ```
- [ ] Document key passwords, usernames, and ACL logic.

---
*Checklist Version X.Y - Last Updated YYYY-MM-DD*
*Remember to adapt based on the specific competition image and README/scenario.*
