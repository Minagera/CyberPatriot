# Week 12 Quiz - Mentor Review Notes

## Quiz Focus: Competition Strategy, Forensics Review & Teamwork

### Key Concepts to Reinforce:

-   **README is KING:** The absolute first step. Dictates priorities, rules, and often contains forensic answers.
-   **Workflow:** Having a structured approach (Recon -> Users -> Persistence -> Harden -> Forensics -> Verify) improves efficiency and reduces missed items. Adaptability is still key.
-   **Time Management:** Crucial under pressure. Allocate time, check scores, use SITREPs. Don't get bogged down.
-   **Prioritization:** High-point items, README tasks, critical security flaws (e.g., admin access) first. Balance fixing vs. breaking required services.
-   **Team Roles:** Clear roles improve parallelism, but cross-training helps flexibility. Orchestrator keeps track of the big picture.
-   **Communication:** Structured comms (SITREP, BLOCKER) prevent chaos and ensure everyone is aware of progress and problems.
-   **Forensics:** Systematic investigation using logs, file searches, config checks. Answer precisely based on evidence.
-   **Documentation:** Change logs help troubleshoot. Documenting forensic answers clearly is vital.
-   **AAR:** Learning from mistakes is critical for improvement. Honest self-assessment.

### Common Mistakes/Misconceptions:

-   Ignoring or only skimming the README.
-   Working chaotically without a plan or prioritization.
-   Spending too long on one difficult, low-point item.
-   Breaking required services while hardening, losing points.
-   Poor communication leading to duplicated effort or unresolved blockers.
-   Team members not fulfilling their roles or interfering with others.
-   Guessing on forensic questions instead of investigating.
-   Insufficient or unclear documentation.
-   Not learning from practice mistakes (repeating errors).

### Discussion Points for Review:

-   Ask cadets to outline their team's competition workflow.
-   Discuss how to prioritize tasks when starting an image.
-   Role-play a SITREP or a BLOCKER scenario.
-   Scenario: "A forensic question asks for the IP address of the last failed login." What steps would you take on Windows? On Linux? (Win: Event Viewer, Security Log, ID 4625. Lin: `/var/log/auth.log` or `journalctl`, search for failure messages).
-   Discuss the importance of the Change Log.
-   Ask cadets for one key takeaway or area for improvement identified during the mock competition AAR.
-   Reiterate the importance of maintaining availability of required services.

*(Detailed answers and explanations should reference the actual quiz solution file: `../Quizzes/Solutions/Competition_Strategy_Quiz_Solution.md`)*

---
*Mentor notes for internal team use. This week is about synthesis and performance under pressure.*
