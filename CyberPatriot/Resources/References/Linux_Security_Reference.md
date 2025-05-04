# Linux Security Reference Sheet

## User Management

- List users: `cat /etc/passwd`
- List groups: `cat /etc/group`
- Add user: `sudo adduser username`
- Delete user: `sudo deluser username`
- Check sudoers: `sudo cat /etc/sudoers`

## File Permissions

- List permissions: `ls -l`
- Change permissions: `chmod 640 file`
- Change owner: `chown user:group file`
- Find world-writable: `find / -perm -2 -type f 2>/dev/null`

## Service Management

- List services: `systemctl list-units --type=service`
- Start/stop service: `sudo systemctl start|stop servicename`
- Check status: `sudo systemctl status servicename`

## Firewall

- UFW status: `sudo ufw status`
- Enable UFW: `sudo ufw enable`
- Allow SSH: `sudo ufw allow 22/tcp`
- iptables rules: `sudo iptables -L -n -v`

## Forensics

- List cron jobs: `crontab -l`, `sudo cat /etc/crontab`
- Check running processes: `ps aux`
- Search for SUID files: `find / -perm -4000 2>/dev/null`
- Check logs: `sudo less /var/log/auth.log`

*This sheet is unique and designed for CyberPatriot competition use.*
