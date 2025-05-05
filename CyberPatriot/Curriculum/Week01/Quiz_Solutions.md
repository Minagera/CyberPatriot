# Week 1 Quiz Review - Mentor Notes

## Quiz Assigned:

-   [../Quizzes/Quiz-Files/Windows_Security_Fundamentals_Quiz.md](../Quizzes/Quiz-Files/Windows_Security_Fundamentals_Quiz.md) (Selected Questions)

## Review Points:

-   Discuss answers related to identifying core Windows tools (`secpol.msc`, `compmgmt.msc`, `eventvwr.msc`, `services.msc`).
-   Reinforce the command for managing local group membership (`net localgroup`).
-   Clarify the role of Windows Defender Antivirus vs. Firewall.
-   Review the concept of NTFS permissions (briefly, focus on Full Control).
-   Ensure understanding of where Security logs are found (Event Viewer).
-   Discuss why the Guest account should be disabled.
-   Explain how disabling services reduces attack surface.
-   Correct misconceptions about UAC or standard user limitations.

## Common Sticking Points / Areas for Re-teaching:

-   (Mentor to fill in based on team's performance)
-   Difference between `net user` and `net localgroup`.
-   Specific tool names (`secpol.msc` vs `gpedit.msc` - though gpedit includes secpol).
-   Location of Security logs.

## Links to Solutions:

-   [../Quizzes/Solutions/Windows_Security_Fundamentals_Quiz_Solution.md](../Quizzes/Solutions/Windows_Security_Fundamentals_Quiz_Solution.md)

# Week 1 Quiz Review Notes (Mentor Use Only)

## Quiz: Windows Security Fundamentals (Introductory Questions)

**Link to Official Solutions:** [../Quizzes/Solutions/Windows_Security_Fundamentals_Quiz_Solution.md](../Quizzes/Solutions/Windows_Security_Fundamentals_Quiz_Solution.md)

**Key Concepts to Reinforce:**
- Difference between Standard User and Administrator.
- Purpose of basic tools like Task Manager and Event Viewer.
- Importance of reading the CyberPatriot Rules Book.
- Basic command prompt usage (`ipconfig`).

**Common Mistakes/Areas for Clarification:**
- [Mentor: Add notes here based on cadet performance]
- Confusion about where to find specific settings.
- Misunderstanding the role of the scoring engine.

**Discussion Points:**
- Real-world implications of ethical hacking.
- How basic Windows knowledge applies to security.

*(This file is a placeholder for mentor notes during quiz review, not the actual answers.)*

# Week 1 Quiz - Mentor Review Notes

## Quiz Focus: Introduction, Ethics, Windows Fundamentals

### Key Concepts to Reinforce:

-   **Ethics & Rules:** Emphasize the absolute prohibition against attacking the scoring engine or external systems. Discuss the spirit of the competition (defense, remediation). Highlight key rules (e.g., no external media, authorized software only).
-   **Windows Basics:** Ensure cadets are comfortable navigating the GUI, finding essential tools (Settings, Control Panel, Task Manager, File Explorer, `lusrmgr.msc`), and understanding the *practical* difference between Admin and Standard users (what can/can't they do?).
-   **VM Usage:** Stress the importance of snapshots for recovery during practice. Explain the concept of a "clean" vs. "compromised" snapshot.
-   **Scoring Engine:** Explain that it checks for specific configurations and awards/deducts points accordingly. It's the primary feedback mechanism during competition. Points reflect adherence to the README and security best practices.
-   **Incident Response Mindset:** Introduce the idea that they are "inheriting" a potentially messy system and need to investigate before fixing.

### Common Mistakes/Misconceptions:

-   Confusing Control Panel and Settings app locations for specific items.
-   Not understanding how to show hidden files or file extensions, and why it's important.
-   Difficulty differentiating between processes and applications in Task Manager.
-   Underestimating the limitations of a Standard User account or the power of an Administrator account.
-   Thinking the goal is just to "run a checklist" vs. understanding the scenario.

### Discussion Points for Review:

-   Ask cadets to explain *why* certain actions are unethical in the context of CyberPatriot.
-   Have cadets demonstrate finding specific settings or system information using GUI tools AND basic commands (`ipconfig`, `hostname`, `whoami`).
-   Discuss scenarios where Admin privileges are required versus Standard user privileges.
-   Review the concept of "points" and how the scoring engine reflects security posture changes (both positive and negative if required services are stopped).
-   Ask: "What's the *first* thing you should do when you open a competition image?" (Answer: Read the README).

*(Detailed answers and explanations should reference the actual quiz solution file: `../Quizzes/Solutions/Windows_Security_Fundamentals_Quiz_Solution.md`)*

---

# Week 1 Quiz - Mentor Review Notes

This file is for mentor notes regarding the review of the Week 1 quiz (`../Quizzes/Quiz-Files/Windows_Security_Fundamentals_Quiz.md` or similar).

## Common Areas of Difficulty:

-   [Note specific questions or concepts cadets struggled with]
-   Example: Difficulty distinguishing between Task Manager and Event Viewer purpose.
-   Example: Confusion about Administrator vs. Standard user privileges.

## Key Takeaways for Cadets:

-   [Summarize the most important points reinforced by the quiz]
-   Example: The importance of checking user privileges.
-   Example: Where to find basic system information.

## Points for Next Session:

-   [Identify topics needing reinforcement in the next training session]
-   Example: Revisit Event Viewer filtering.
-   Example: Provide more hands-on practice with user creation.

---
*Use this space to track cadet understanding and tailor future sessions.*
*Formal answers are in `../Quizzes/Solutions/`.*
