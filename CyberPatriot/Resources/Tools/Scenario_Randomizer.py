"""
CyberPatriot Scenario Randomizer
Randomizes usernames, passwords, and service states for practice images.
"""

import random

usernames = ["sysadmin", "cadet", "analyst", "guest", "testuser", "operator"]
services = ["ssh", "ftp", "telnet", "apache2", "mysql", "vsftpd", "cron"]
passwords = ["CyberP@tr1ot!", "Secure2024!", "LinuxRocks!", "WinDefend!", "NetW0rk!"]

def randomize_users():
    print("Randomized Users:")
    for _ in range(3):
        print(f"- {random.choice(usernames)} : {random.choice(passwords)}")

def randomize_services():
    print("Randomized Service States:")
    for svc in random.sample(services, 4):
        state = random.choice(["enabled", "disabled"])
        print(f"- {svc}: {state}")

if __name__ == "__main__":
    print("=== CyberPatriot Scenario Randomizer ===")
    randomize_users()
    randomize_services()
    print("Randomization complete. Use these values to create new practice scenarios.")
