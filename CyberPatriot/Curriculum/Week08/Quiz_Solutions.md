# Week 8 Quiz - Mentor Review Notes

## Quiz Focus: Scripting Introduction & Baselining Concepts

### Key Concepts to Reinforce:

-   **Scripting Purpose:** Automate repetitive information gathering. Ensure consistency in checks. Generate output for comparison (baselining).
-   **PowerShell Basics:** Cmdlet structure (`Verb-Noun`), piping (`|`), output redirection (`Out-File`). Key cmdlets for users, services, processes, network config. Execution policy.
-   **Bash Basics:** Shebang (`#!/bin/bash`), `chmod +x`, standard Linux commands, output redirection (`>`, `>>`). Key commands for users, services, processes, network config.
-   **Baselining:** What it is (snapshot of a state), why it's useful in CP (fast detection of changes), what key things to baseline (users, services, ports, tasks/cron, startup keys).
-   **Diff Tools (Meld):** How they visually show differences between files, making comparison much faster than manual review.

### Common Mistakes/Misconceptions:

-   PowerShell execution policy blocking scripts.
-   Syntax errors in scripts (variable names, command names, quotes).
-   Forgetting `chmod +x` for Bash scripts.
-   Incorrect output redirection (`>` vs `>>`).
-   Trying to baseline *everything* (focus on key security areas).
-   Running baseline scripts *after* making changes on the competition image.
-   Difficulty interpreting Meld/diff output initially.
-   Thinking scripts need to be complex; simple info gathering is the goal here.

### Discussion Points for Review:

-   Ask cadets the PowerShell command to get a list of running services and save it to `services.txt`.
-   Ask cadets the Bash command to get a list of listening TCP/UDP ports and save it to `ports.txt`.
-   Explain the difference between `>` and `>>` in Bash. How do you append in PowerShell? (`Out-File -Append`).
-   Ask: "Why is baselining useful in CyberPatriot?"
-   Ask: "What are 3 important things you would want to baseline on a Windows system? On a Linux system?"
-   Demonstrate comparing two simple text files with Meld and point out added/deleted/changed lines.
-   Discuss the importance of running the *exact same* script for baseline and current state comparison.

*(Consider creating a simple quiz focusing on command recognition and the concept of baselining, referencing relevant files in `../Quizzes/`)*

---
*Mentor notes for internal team use. Focus on the practical utility of simple scripts and diff tools for CP.*
