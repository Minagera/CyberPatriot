# Week 5: Windows System Hardening

## Learning Objectives
By the end of this session, cadets will be able to:
- Implement comprehensive Windows security policies
- Configure and manage Windows Group Policy for security
- Secure Windows services and applications
- Implement advanced user rights management
- Use Windows security auditing and logging
- Recognize and remediate common Windows vulnerabilities
- Apply security templates and baselines

## Pre-class Preparation
- Review [Windows Group Policy Fundamentals](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/manage/understand-policy-management)
- Complete the [Windows Services Overview](../../Windows/Guides/Intermediate/Windows_Services_Overview.md)
- Watch [Windows Group Policy Security video](https://www.youtube.com/watch?v=example) (placeholder link)
- Read the [Windows Security Baseline documentation](https://example.com/baseline) (placeholder link)

## Lesson Plan

### 1. Windows Security Policy Review (20 minutes)
- Recap basic Windows security concepts
- Windows security architecture review
- Security compliance and benchmarks
- Microsoft security baselines overview
- Security policy implementation strategies

### 2. Group Policy for Security (40 minutes)
- Group Policy architecture and management
- Local Security Policy tool deep dive
- Critical security policies:
  - Account policies
  - Local policies
  - Windows Defender settings
  - User rights assignment
  - Security options
- Group Policy application and inheritance
- Group Policy troubleshooting

### 3. Service Hardening (30 minutes)
- Windows services overview and management
- Service permissions and privileges
- Identifying unnecessary services
- Configuring secure service settings
- Service startup modes
- Service account security
- Windows service attack vectors

### 4. Advanced User and Rights Management (30 minutes)
- Privileged access management
- Built-in security groups and their proper use
- User rights assignment best practices
- Least privilege principle implementation
- Administrator account security
- Guest account security
- Application of security templates

### 5. Windows Security Auditing (30 minutes)
- Configuring security audit policies
- Important events to monitor
- Event log management
- Using Event Viewer effectively
- Creating custom views
- Security log analysis
- Identifying suspicious activity

### 6. Hands-on Exercise (60 minutes)
- **Exercise**: [Windows Group Policy Hardening Exercise](../../Windows/Exercises/Windows_Group_Policy_Hardening_Exercise.md)
  - Apply security-focused Group Policy settings
  - Secure Windows services
  - Configure audit policies
  - Test security configurations
  - Document implemented hardening measures

### 7. Assessment (20 minutes)
- [Windows System Hardening Quiz](../../Windows/Quizzes/Quiz-Files/Windows_System_Hardening_Quiz.md)
- Group discussion of key hardening techniques
- Review of common mistakes and misconceptions

### 8. Wrap-up and Preview (10 minutes)
- Recap Windows hardening techniques
- Assign homework (see below)
- Preview next week (Linux System Hardening)
- Q&A session

## Homework Assignment
1. Complete the [Windows Group Policy Hardening Guide](../../Windows/Guides/Intermediate/Windows_Group_Policy_Hardening.md)
2. Create a custom security audit policy for a Windows system
3. Develop a Windows services security checklist
4. Practice implementing security settings from the CyberPatriot Windows checklist

## Additional Resources
- [Microsoft Security Compliance Toolkit](https://www.microsoft.com/en-us/download/details.aspx?id=55319)
- [CIS Windows Benchmarks](https://www.cisecurity.org/benchmark/microsoft_windows_desktop/)
- [Windows Security Baselines](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-security-baselines)
- [Group Policy for Security](https://example.com/gpo-security) (placeholder link)
- [Windows Hardening Scripts](../../Windows/Scripts/Examples/)

## Materials Needed
- Windows 10/11 VM for each cadet
- Group Policy Object reference documentation
- Windows security templates
- Projection system for demonstrations
- Windows hardening checklist
- Access to repository materials

## Instructor Notes
- Ensure all VMs are properly configured before class
- This session is technical - prepare additional examples for complex concepts
- Group Policy can be confusing - have reference materials ready
- Allow extra time for troubleshooting policy application issues
- Emphasize documentation of changes made during hardening
- Highlight specific Group Policy settings commonly tested in competition
- Consider demonstrating a before/after security scan to show hardening effectiveness
- Be prepared with common CyberPatriot Windows vulnerabilities and their remediation
