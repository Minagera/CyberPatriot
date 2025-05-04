# Windows Security Reference Sheet

## Common Commands

- List users: `net user`
- List groups: `net localgroup`
- Show running services: `Get-Service`
- Check firewall status: `Get-NetFirewallProfile`
- List scheduled tasks: `schtasks /query`
- View event logs: `Event Viewer` or `Get-WinEvent`

## Registry Keys

- User Run keys: `HKLM\Software\Microsoft\Windows\CurrentVersion\Run`
- Security policies: `HKLM\System\CurrentControlSet\Control\Lsa`
- UAC settings: `HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System`

## Group Policy Paths

- Local Security Policy: `secpol.msc`
- Group Policy Editor: `gpedit.msc`
- Audit Policy: `Computer Configuration > Windows Settings > Security Settings > Local Policies > Audit Policy`

## Troubleshooting Tips

- Use `sfc /scannow` to check system files
- Use `gpresult /h report.html` to review applied policies
- Use `netstat -ano` to check open ports and connections

*This sheet is unique and designed for CyberPatriot competition use.*
