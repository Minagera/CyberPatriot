# Week 9 Quiz - Mentor Review Notes

## Quiz Focus: Advanced Windows Security & Incident Response Intro

### Key Concepts to Reinforce:

-   **Registry Persistence:** HKLM/HKCU Run keys are primary locations attackers use to auto-start malware. Know how to check them (`regedit`, PowerShell).
-   **Event Logs:** They record what happened. Need auditing enabled (`secpol.msc`). Key IDs for logon/logoff, user/group changes, service installs are crucial for forensics. Filtering is essential.
-   **Common Persistence:** Tasks (`taskschd.msc`), Services (`services.msc`), Startup Folders, Run Keys (`regedit`). Need to check all systematically.
-   **IR Lifecycle:** Understand the basic flow (Prep, ID, Contain, Eradicate, Recover, Lessons Learned) and how CP maps to it (ID/Contain/Eradicate/Recover = fixing image and scoring points).
-   **Investigation Process:** Use tools learned (logs, registry viewer, task scheduler, services) to hunt for clues based on the README and general suspicion.

### Common Mistakes/Misconceptions:

-   Fear of `regedit` (it's safe to view; caution needed for changes).
-   Not knowing which Registry keys are most relevant for persistence.
-   Audit policies not being enabled, resulting in empty/useless logs.
-   Difficulty filtering Event Logs effectively to find relevant events.
-   Overlooking persistence in Scheduled Tasks or Services.
-   Confusing the formal IR phases with the CP workflow (though they are related).
-   Not connecting log events back to specific forensic questions.

### Discussion Points for Review:

-   Ask cadets the full path to the HKLM Run key in the registry. How can you view it without `regedit`? (PowerShell `Get-ItemProperty`).
-   Scenario: "A forensic question asks when user 'badguy' was added to the Administrators group." Which log and Event ID would you look for? (Security Log, ID 4732).
-   Ask for 3 common places malware might hide to start automatically when Windows boots. (Run Keys, Scheduled Tasks, Services, Startup Folders).
-   How does finding and removing an unauthorized scheduled task fit into the IR lifecycle? (Identification, Eradication).
-   How does disabling an unnecessary, vulnerable service fit? (Containment/Eradication).
-   Discuss the importance of using the `VM-Setup` generated READMEs during practice exercises.

*(Detailed answers and explanations should reference the actual quiz solution file: `../Quizzes/Solutions/Incident_Response_Quiz_Solution.md`)*

---
*Mentor notes for internal team use. Connect advanced tools/locations to the practical goal of finding/fixing issues and answering questions.*
