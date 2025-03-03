# Windows Security Exercises

This directory contains hands-on exercises for practicing Windows security concepts and techniques for the CyberPatriot competition. These exercises range from basic to advanced and are designed to build skills that will be directly applicable in competition scenarios.

## Exercise Structure

Each exercise follows a similar structure:

- **Overview**: Brief description of the exercise scenario
- **Difficulty Level**: Basic, Intermediate, or Advanced
- **Estimated Time**: Approximate time to complete
- **Learning Objectives**: Skills you'll gain from the exercise
- **Prerequisites**: Required knowledge and setup
- **Setup Instructions**: How to prepare your environment
- **Exercise Tasks**: Step-by-step instructions
- **Forensic Questions**: Investigation challenges to solve
- **Scorecard**: A way to track your progress
- **Solution Reference**: Available for mentors (in the Solutions directory)

## Available Exercises

### Basic Level

1. **[Windows_User_Management_Exercise.md](./Windows_User_Management_Exercise.md)**
   - Focuses on managing user accounts and security
   - Practice creating, modifying, and securing user accounts
   - Learn to implement proper password policies

2. **[Windows_Defender_Configuration_Exercise.md](./Windows_Defender_Configuration_Exercise.md)**
   - Configure Windows Defender security settings
   - Run scans and interpret results
   - Implement real-time protection features

3. **[Windows_Update_Exercise.md](./Windows_Update_Exercise.md)**
   - Configure Windows Update settings
   - Learn to manage and prioritize updates
   - Implement update policies

### Intermediate Level

4. **[Windows_Security_Hardening_Exercise.md](./Windows_Security_Hardening_Exercise.md)**
   - Comprehensive system hardening scenario
   - Multiple security areas to address
   - Similar to actual competition challenges

5. **[Windows_Firewall_Exercise.md](./Windows_Firewall_Exercise.md)**
   - Configure Windows Firewall with Advanced Security
   - Create custom rules and policies
   - Monitor firewall effectiveness

6. **[Group_Policy_Hardening_Exercise.md](./Group_Policy_Hardening_Exercise.md)**
   - Implement security via Local Group Policy
   - Configure security templates
   - Apply and verify policy settings

### Advanced Level

7. **[Malware_Removal_Exercise.md](./Malware_Removal_Exercise.md)**
   - Identify and remove simulated malware
   - Find persistence mechanisms
   - Clean up compromised systems

8. **[Registry_Hardening_Exercise.md](./Registry_Hardening_Exercise.md)**
   - Secure critical registry keys
   - Find and fix registry-based vulnerabilities
   - Implement registry monitoring

9. **[Windows_Event_Log_Analysis_Exercise.md](./Windows_Event_Log_Analysis_Exercise.md)**
   - Configure advanced auditing
   - Analyze security logs
   - Identify security incidents from logs

## How to Use These Exercises

1. **Start with the basics**: If you're new to Windows security, begin with the Basic level exercises
2. **Use a test environment**: Always practice in a virtual machine that can be reset
3. **Take notes**: Document your process, as this is valuable during competitions
4. **Time yourself**: Competitions have time limits; practice working efficiently
5. **Try without solutions first**: Challenge yourself to solve issues before checking solutions
6. **Review and repeat**: After completing an exercise, review what you learned and retry to build speed

## Setting Up Your Practice Environment

Before starting the exercises, you'll need a properly configured Windows system:

1. Follow the instructions in the [VM-Setup](../VM-Setup) directory to create practice VMs
2. Ensure you have administrative access to the VM
3. Take a snapshot of your clean VM state before starting each exercise
4. Some exercises may require downloading additional files or tools

## Exercise Files

Some exercises reference downloadable files such as:
- VM configuration scripts
- Pre-configured scenarios
- Tools for specific exercises
- Documentation templates

These files can be found in the individual exercise directories when applicable.

## Team Practice Scenarios

For teams preparing for CyberPatriot:

1. **Time trials**: Set a timer and see how many issues can be fixed in a limited time
2. **Role rotation**: Have team members take turns addressing different aspects of security
3. **Documentation practice**: Have one team member document while others implement fixes
4. **Red team/blue team**: Have one group introduce security issues for others to find
5. **Mock competitions**: Simulate a full competition environment with time limits

## Contributing

If you develop additional exercises or improve existing ones:

1. Follow the established format
2. Include clear instructions
3. Provide solution references for mentors
4. Test exercises thoroughly
5. Submit a pull request to contribute back to the repository

## Additional Resources

- [CyberPatriot Windows Training Materials](https://www.uscyberpatriot.org/competition/training-materials/windows)
- [Microsoft Security Documentation](https://docs.microsoft.com/en-us/security/)
- [CIS Windows Benchmarks](https://www.cisecurity.org/benchmark/microsoft_windows_desktop/)
- [Windows Security Log Events Reference](https://www.ultimatewindowssecurity.com/securitylog/encyclopedia/)
