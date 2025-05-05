# Week 5 Quiz - Mentor Review Notes

## Quiz Focus: Windows System Hardening (Policies, Services, Firewall)

### Key Concepts to Reinforce:

-   **Policy Importance:** `secpol.msc` is a primary tool for enforcing security settings consistently. Audit Policy helps track activity; User Rights control privileges; Security Options set system-wide behaviors.
-   **Service Management:** Not all services are needed. Disabling unnecessary ones reduces the attack surface. *BUT* disabling required services loses points. Emphasize checking the README.
-   **Firewall Logic:** Understand profiles. Default block inbound is good practice. Rules allow specific, necessary traffic (programs/ports). Check existing rules for suspicious entries.
-   **Defender AV:** It needs to be ON, ideally updated, with real-time protection active.
-   **Application Control:** Unauthorized software can introduce vulnerabilities or violate rules. Know how to find and remove it.
-   **README Supremacy:** Reiterate constantly that the competition README overrides general best practices. If the README says Telnet must be running, leave it running (but note it as a risk if possible).

### Common Mistakes/Misconceptions:

-   Getting lost in `secpol.msc` options.
-   Enabling auditing but not knowing which events are most important for CP (Logon, Policy Change, Privilege Use).
-   Disabling critical services needed for scoring or functionality defined in the README.
-   Configuring firewall rules for only one profile (e.g., Private) and leaving others open.
-   Creating overly broad firewall rules (Allow Any/Any).
-   Forgetting to check if Defender is actually running and definitions are recent (if possible).
-   Uninstalling software required by the README.

### Discussion Points for Review:

-   Ask cadets where they would go to ensure failed login attempts are logged (Audit Policy).
-   Ask how to prevent standard users from shutting down the system (User Rights Assignment).
-   Scenario: "The README says a web server must be accessible from the local network. How do you configure the firewall?" (Allow inbound TCP port 80/443, potentially restricted to local subnet).
-   Ask how to check if the Telnet service is running and how to disable it if it's not required.
-   Discuss the risks of leaving Remote Registry service enabled.
-   Ask where to verify if Windows Defender's real-time protection is active.

*(Detailed answers and explanations should reference the actual quiz solution file: `../Quizzes/Solutions/Windows_System_Hardening_Quiz_Solution.md`)*

---
*Mentor notes for internal team use. Emphasize practical application and README awareness.*
