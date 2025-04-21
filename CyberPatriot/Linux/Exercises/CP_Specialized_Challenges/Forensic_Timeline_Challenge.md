# Forensic Timeline Challenge

## Overview

This unique forensics challenge tests a critical competition skill rarely practiced: reconstructing an attack timeline from system artifacts. Unlike standard hardening exercises, this challenge focuses on forensic analysis and deductive reasoning.

## Difficulty: Advanced

## Estimated Time: 120 minutes

## Learning Objectives

- Extract and analyze temporal information from Linux logs and artifacts
- Correlate events across multiple data sources
- Document findings in chronological order
- Present evidence in a competition-ready format

## Scenario

Your team has been given a Linux system that was compromised exactly one week ago. The attacker gained access, established persistence, exfiltrated data, and attempted to cover their tracks. Your task is to reconstruct what happened, when it happened, and how it happened.

## Challenge Format

This challenge uses a special "evidence-only" approach:
- The system has already been hardened post-incident
- Vulnerabilities have been patched
- Your task is purely analytical - reconstruct the timeline
- Success is measured by the accuracy and completeness of your timeline

## Required Analysis

Reconstruct the timeline of the following events:

1. **Initial Access**
   - When did the attacker first gain access?
   - What method did they use?
   - What credentials or vulnerability was exploited?

2. **Privilege Escalation**
   - When did the attacker gain elevated privileges?
   - What technique was used?
   - What evidence indicates the success of this stage?

3. **Persistence Mechanism**
   - When was persistence established?
   - What methods were used?
   - How was it concealed?

4. **Lateral Movement**
   - Did the attacker access other systems on the network?
   - What protocols or techniques were used?
   - What remote systems were targeted?

5. **Data Exfiltration**
   - What data was targeted?
   - When was it exfiltrated?
   - How was it exfiltrated?
   - Where was it sent?

6. **Anti-forensics**
   - What evidence tampering occurred?
   - When did log manipulation happen?
   - How did the attacker try to hide their activity?

## Evidence Sources

You'll need to gather and analyze evidence from:

- System logs (/var/log/*)
- Authentication logs
- Web server logs
- Database logs
- Command history files
- File system timestamps
- Process accounting data
- Network traffic capture files
- Modified configuration files
- Scheduled tasks

## Complicating Factors

This challenge includes several advanced factors:

- Log rotation has occurred since the attack
- Some logs were partially tampered with
- System clock was temporarily modified during the attack
- Attacker used techniques to obfuscate their activities
- Legitimate admin activities occurred alongside malicious ones

## Deliverable Format

Create a detailed timeline document with:

1. **Executive Summary** - Brief overview of the incident
2. **Timeline** - Chronological list of events with timestamps
3. **Evidence** - Specific artifacts supporting each timeline entry
4. **Methodology** - Techniques used to extract and correlate information
5. **Attack Map** - Visual representation of the attack sequence
6. **Indicators of Compromise** - List of all malicious artifacts
7. **Recommended Mitigations** - How to prevent similar attacks

## Scoring

Your timeline will be scored on:

- **Accuracy** - Events correctly placed in sequence
- **Completeness** - Percentage of actual events discovered
- **Evidence Quality** - Direct links to supporting data
- **Timeline Logic** - Proper cause-effect relationships
- **Technical Detail** - Precision in describing techniques
- **Investigative Thoroughness** - Coverage of all evidence sources

## Training Value

This challenge builds critical skills for CyberPatriot by:

- Developing incident analysis capabilities
- Strengthening understanding of attack techniques
- Enhancing log analysis abilities
- Improving evidence documentation skills
- Building investigative thought processes

Good luck, forensic investigators!
