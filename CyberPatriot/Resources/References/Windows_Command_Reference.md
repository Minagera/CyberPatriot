# Windows Command Reference

## User and Group Management

- List users:  
  `net user`
- List groups:  
  `net localgroup`
- Add user:  
  `net user username password /add`
- Delete user:  
  `net user username /delete`
- Add user to group:  
  `net localgroup groupname username /add`
- Remove user from group:  
  `net localgroup groupname username /delete`

## Security Policies

- View password policy:  
  `net accounts`
- Set password policy:  
  `net accounts /minpwlen:12 /maxpwage:90 /uniquepw:5 /minpwage:1`

## Service Management

- List services:  
  `Get-Service`
- Stop service:  
  `Stop-Service -Name ServiceName`
- Disable service:  
  `Set-Service -Name ServiceName -StartupType Disabled`

## Firewall

- Check firewall status:  
  `Get-NetFirewallProfile | Format-Table Name, Enabled`
- Enable firewall:  
  `Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True`

## System Updates

- Check for updates:  
  `Get-WindowsUpdateLog`
- Install updates (PowerShell):  
  `Install-WindowsUpdate -AcceptAll -AutoReboot` (requires PSWindowsUpdate module)

## Defender

- Run full scan:  
  `Start-MpScan -ScanType FullScan`
- Update definitions:  
  `Update-MpSignature`

## Useful PowerShell

- List startup programs:  
  `Get-CimInstance Win32_StartupCommand | Select-Object Name, Command, User`
- List scheduled tasks:  
  `Get-ScheduledTask | Where-Object {$_.State -eq "Ready" -or $_.State -eq "Running"}`

*Add more commands as you learn them!*
