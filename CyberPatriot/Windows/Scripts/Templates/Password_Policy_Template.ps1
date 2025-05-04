# Password Policy Audit/Set Template for CyberPatriot

Write-Host "=== Password Policy Audit ==="
net accounts

# To set password policy (requires admin rights)
# Example: Set minimum password length to 12, max age to 90 days, enforce history, min age 1 day
# Uncomment and modify as needed

# net accounts /minpwlen:12 /maxpwage:90 /uniquepw:5 /minpwage:1

Write-Host "=== End of Password Policy Audit ==="
