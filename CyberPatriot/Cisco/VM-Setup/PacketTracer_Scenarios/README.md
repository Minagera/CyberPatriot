# Packet Tracer Scenarios for CyberPatriot

Each scenario below is unique and designed for CyberPatriot competition practice. Open each `.pkt` file in Packet Tracer and follow the scenario instructions below and in the file comments.

---

## 1. Basic_Network_Security.pkt

**Scenario:**  
A small business has a single router and switch connecting two PCs. The network was recently audited and found to have weak security. Your task is to harden the network devices to meet company policy.

**Objectives:**
- Set unique, strong passwords for all device access (console, VTY, enable secret).
- Enable SSH for remote management; disable Telnet.
- Encrypt all plaintext passwords in the configuration.
- Configure a login banner warning of unauthorized access.
- Disable all unused switch ports and router interfaces.
- Ensure only required services are running (disable CDP, HTTP server if not needed).
- Save the configuration and verify secure access from PC1.

---

## 2. Advanced_Network_Security.pkt

**Scenario:**  
You are the network engineer for a company with three departments: HR, Engineering, and Finance. Each department is on its own VLAN. The network uses a router-on-a-stick configuration for inter-VLAN routing.

**Objectives:**
- Create and assign VLANs for each department.
- Configure trunking between the switch and router.
- Implement port security on all access ports (limit to one MAC, shutdown on violation).
- Restrict management access (SSH) to only the IT subnet (192.168.99.0/24).
- Set unique banners and encrypt all passwords.
- Disable all unused interfaces and unnecessary services (CDP, HTTP server).
- Test that VLANs are isolated except where routing is required.
- Save the configuration and document all changes.

---

## 3. ACL_Challenge.pkt

**Scenario:**  
A security audit revealed that sensitive servers are accessible from unauthorized hosts. You must implement access control lists (ACLs) to restrict network access according to company policy.

**Objectives:**
- Create a standard ACL to allow only the IT department to access the router's VTY lines.
- Create an extended ACL to block HTTP traffic from the Guest VLAN to the Finance VLAN.
- Permit DNS and ICMP traffic between all VLANs for troubleshooting.
- Apply ACLs to the correct interfaces and directions.
- Document each ACL with a comment in the configuration.
- Test that only authorized hosts can access management interfaces and that blocked traffic is denied.

---

*All scenarios are original and designed for CyberPatriot training. Do not share outside your team.*
