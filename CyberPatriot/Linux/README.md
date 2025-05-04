# Linux Security Training Materials

## Directory Structure

```
Linux/
├── Guides/                 # Educational guides for Linux security
│   ├── Basic/              # Fundamental Linux security concepts
│   │   ├── README.md
│   │   └── Linux_User_Management.md
│   ├── Intermediate/       # More advanced security configurations
│   │   └── README.md
│   └── Advanced/           # Complex security implementations
│       └── README.md
│
├── Exercises/              # Hands-on Linux security exercises
│   ├── README.md
│   └── Solutions/          # Mentor-only solutions for exercises
│
├── Scripts/                # Bash scripts for Linux hardening
│   ├── Templates/          # Script templates for cadets to modify
│   │   ├── secure_user_add.sh
│   │   ├── audit_services.sh
│   │   ├── find_world_writable.sh
│   │   ├── ufw_hardening.sh
│   │   ├── ssh_hardening.sh
│   │   └── user_management_template.sh
│   ├── Examples/           # Example scripts for reference
│   │   ├── Quick_User_Audit.sh
│   │   ├── Service_Checker.sh
│   │   ├── File_Permission_Scanner.sh
│   │   ├── Firewall_Status_Reporter.sh
│   │   ├── secure_user_add.sh
│   │   ├── audit_services.sh
│   │   ├── find_world_writable.sh
│   │   ├── ufw_hardening.sh
│   │   └── ssh_hardening.sh
│   └── Solutions/          # Solution scripts (mentor access only)
│       ├── linux_challenge_solution.sh
│       └── automated_hardening_solution.sh
│
├── Quizzes/                # Assessment materials
│   ├── README.md
│   ├── Quiz-Files/         # Quiz questions in various formats
│   │   ├── README.md
│   │   └── sample_quiz.md
│   └── Solutions/          # Answer keys for quizzes
│       ├── README.md
│       └── sample_quiz_solutions.md
│
└── VM-Setup/               # Instructions for setting up Linux VMs
    ├── README.md
    ├── corporate-server-breach.sh
    ├── cyberpatriot_linux_vm_setup.sh
    ├── ubuntu_vm_setup.sh
    ├── Linux_Security_Challenge.zip
    └── Linux_Security_Challenge.zip.README.md
```

## Getting Started

1. Begin by setting up a Linux VM using the instructions in the [VM-Setup](./VM-Setup) directory
2. Review the basic security concepts in the [Guides/Basic](./Guides/Basic) directory
3. Try the introductory exercises
4. Explore the script examples to learn about automation

## Learning Path

For optimal learning, we recommend following this sequence:

1. Basic Linux commands and system administration
2. User account security and permissions
3. Service and application security
4. Network security and firewall configuration
5. Logging and monitoring
6. Advanced security hardening techniques

## CyberPatriot Competition Tips

- The Linux portion of CyberPatriot typically involves:
  - Securing user accounts (removing unauthorized users, setting appropriate permissions)
  - Configuring password policies
  - Securing system services
  - Configuring the firewall (UFW/iptables)
  - Removing malware and unauthorized software
  - Addressing specific vulnerabilities mentioned in the competition README

- Focus on completing the highest-value items first
- Always read the competition README file thoroughly
- Use checklists to ensure you don't miss critical steps
- Document your changes in case you need to troubleshoot
- Learn to use the `find` command to locate suspicious files

## Linux Security Fundamentals

The key areas of Linux security covered in these materials include:

1. **User Account Security**
   - User management and authentication
   - Password policies
   - Privilege management
   - Group configuration
   - Sudo access control

2. **File System Security**
   - File permissions
   - Special permissions (SUID, SGID, sticky bit)
   - File attributes
   - Access Control Lists (ACLs)
   - Disk encryption

3. **System Service Security**
   - Service configuration and hardening
   - Disabling unnecessary services
   - Running services with minimal privileges
   - Secure SSH configuration
   - Secure web server configuration

4. **Network Security**
   - Firewall configuration (UFW/iptables)
   - Network service hardening
   - Port management
   - Traffic filtering
   - Intrusion detection

5. **Auditing and Logging**
   - Log configuration
   - Log monitoring
   - Audit frameworks
   - Intrusion detection systems

## Scripting and Automation

The Scripts directory contains Bash scripts for:
- Automating security checks
- Hardening system components
- Auditing security settings
- Performing system inventory

Learning to use these scripts will help you work more efficiently during competitions.

## Additional Resources

- [Ubuntu Security Documentation](https://ubuntu.com/security)
- [CIS Benchmarks for Linux](https://www.cisecurity.org/benchmark/ubuntu_linux/)
- [NIST Linux Security Guidelines](https://csrc.nist.gov/publications/detail/sp/800-123/final)
- [CyberPatriot Linux Training Materials](https://www.uscyberpatriot.org/competition/training-materials/linux)

---

## Directory Index

### Guides/
- **Basic/**: User management, permissions, sudo, password policies, login security, group management, and common CyberPatriot scenarios.
  - `README.md`: Overview and step-by-step user security
  - `Linux_User_Management.md`: In-depth user management
- **Intermediate/**: Service hardening, firewall, auditing, malware removal, prioritized hardening, and common competition tasks.
  - `README.md`: System hardening, service security, audit, and automation
- **Advanced/**: SELinux/AppArmor, kernel hardening, advanced auditing, forensics, threat hunting, and advanced CyberPatriot strategies.
  - `README.md`: Advanced security, forensics, and threat hunting

### Exercises/
- `README.md`: Linux Security Challenge scenario, workflow, scoring, hints, and documentation guidance
- `Solutions/`: Mentor-only reference solutions for each exercise

### Scripts/
- **Templates/**:
  - `secure_user_add.sh`, `audit_services.sh`, `find_world_writable.sh`, `ufw_hardening.sh`, `ssh_hardening.sh`, `user_management_template.sh`
- **Examples/**:
  - `Quick_User_Audit.sh`, `Service_Checker.sh`, `File_Permission_Scanner.sh`, `Firewall_Status_Reporter.sh`, `secure_user_add.sh`, `audit_services.sh`, `find_world_writable.sh`, `ufw_hardening.sh`, `ssh_hardening.sh`
- **Solutions/**:
  - `linux_challenge_solution.sh`, `automated_hardening_solution.sh`

### Quizzes/
- `README.md`: Quiz usage and structure
- **Quiz-Files/**:
  - `README.md`: Quiz instructions
  - `sample_quiz.md`: Example quiz on Linux security
- **Solutions/**:
  - `README.md`: Mentor-only answer keys
  - `sample_quiz_solutions.md`: Answers for sample quiz

### VM-Setup/
- `README.md`: Scenario overview, setup instructions, customization, troubleshooting, and license
- `corporate-server-breach.sh`: Unique scenario generator for a compromised Ubuntu server
- `cyberpatriot_linux_vm_setup.sh`: Alternate scenario generator for instructors
- `ubuntu_vm_setup.sh`: Simple, unique Ubuntu setup script for practice
- `Linux_Security_Challenge.zip`: Downloadable VM image for hands-on practice
- `Linux_Security_Challenge.zip.README.md`: Placeholder/readme for the VM image

---

## Reference Files

- **[../Resources/References/Linux_Security_Reference.md](../Resources/References/Linux_Security_Reference.md)**: Quick reference for user management, permissions, services, firewall, and forensics.
- **[../Checklists/Linux/README.md](../Checklists/Linux/README.md)**: Competition checklist for Ubuntu/Mint hardening.
- **[../Resources/Core_Security_Principles.md](../Resources/Core_Security_Principles.md)**: Core security principles for CyberPatriot.

---

*All materials in this directory are unique and tailored for CyberPatriot cadet training. If you find missing content or have suggestions, please contribute!*
