# Set-LocalPasswordPolicy.ps1
# Enforces strong password policy for CyberPatriot competition

# Set minimum password length
net accounts /minpwlen:12

# Set maximum password age (days)
net accounts /maxpwage:90

# Enforce password history
net accounts /uniquepw:5

# Enable password complexity (requires registry edit)
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
Set-ItemProperty -Path $regPath -Name "PasswordComplexity" -Value 1

Write-Host "Password policy applied. Please verify in Local Security Policy."
