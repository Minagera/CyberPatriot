#!/bin/bash
# User Management Template Script for CyberPatriot

# Add a new user
# sudo useradd -m -s /bin/bash username
# sudo passwd username

# Remove unauthorized user
# sudo userdel -r baduser

# Set password policy (example)
# sudo apt install libpam-pwquality
# sudo sed -i '/pam_pwquality.so/ s/$/ minlen=10 ucredit=-1 lcredit=-1 dcredit=-1/' /etc/pam.d/common-password

# Lock an account
# sudo passwd -l username

echo "User management tasks completed."
