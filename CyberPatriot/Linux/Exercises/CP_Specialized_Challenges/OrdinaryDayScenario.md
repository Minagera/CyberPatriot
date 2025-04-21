# The "Ordinary Day" Challenge

## Overview

This unconventional security challenge tests your ability to identify subtle security issues in an apparently normal Linux system. Unlike typical scenarios with obvious vulnerabilities, this exercise simulates a system where the previous administrator was security-conscious but made a few critical mistakes.

## Difficulty: Advanced

## Estimated Time: 90 minutes

## Learning Objectives

- Detect non-obvious security issues
- Distinguish between legitimate configurations and subtle security risks
- Develop deep inspection techniques
- Practice thorough system auditing when obvious issues are absent

## Scenario

Your CyberPatriot team has taken over administration of a Linux server that appears well-maintained. The previous administrator was security-focused but recently left the organization. Your mentor has mentioned that despite appearing secure, the system has at least 8 subtle security issues that would be exploitable in competition.

## Challenge Rules

1. The system is running Ubuntu 22.04 LTS with a standard LAMP stack
2. All security settings look proper at first glance
3. Services are configured correctly on the surface
4. Nothing is overtly broken or misconfigured
5. Password policies appear to be in place
6. Firewall is active with reasonable rules

## Your Tasks

1. Find and document the 8+ subtle security issues
2. For each issue:
   - Describe why it's a security risk
   - Explain how it could be exploited
   - Document your remediation steps
   - Verify your fix doesn't break functionality

## Subtle Issues Categories

The issues are distributed across these categories:
- User/permission subtleties (2)
- Service configuration nuances (2)
- Network/firewall edge cases (1)
- File system peculiarities (1)
- Scheduled task oddities (1)
- Data protection oversights (1)

## Hints System

This challenge includes a unique hint system:
- You start with 100 points
- Each hint costs 5 points
- Each correctly identified and fixed issue earns 15 points
- Your goal is to maximize your final score

To request a hint, run: `python3 /opt/challenge/hint_system.py --category [category_name]`

## Documentation Requirements

Create a file called `findings.md` with the following format for each issue:

```
## Issue X: [Brief Name]

### Description
[Detailed description of the issue]

### Risk Assessment
[Security implications]

### Discovery Method
[How you found it]

### Remediation
[Commands/steps to fix]

### Verification
[How you confirmed the fix]
```

## Example Subtle Issue

Here's an example of the type of subtle issue you might find:

A script in `/usr/local/bin` is owned by root and has the correct 755 permissions, but it sources a configuration file in `/opt/config/` that's world-writable. The script runs as a regular system process, but its behavior could be modified by changing the config file.

Good luck finding the real issues in the system!
