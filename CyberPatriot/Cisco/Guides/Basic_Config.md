# Basic Cisco Device Configuration for CyberPatriot

## Initial Setup

1. Set device hostname:
   ```
   configure terminal
   hostname CyberPatriot-Router
   ```

2. Secure console and VTY access:
   ```
   line console 0
   password SecureCon!
   login
   exit

   line vty 0 4
   password SecureVTY!
   login
   transport input ssh
   exit
   ```

3. Set enable secret:
   ```
   enable secret StrongSecret123
   ```

4. Encrypt passwords:
   ```
   service password-encryption
   ```

5. Disable unused interfaces:
   ```
   interface range fa0/1 - 24
   shutdown
   exit
   ```

6. Save configuration:
   ```
   write memory
   ```

*Practice these steps in Packet Tracer before competition. Always follow the scenario README for required settings.*
