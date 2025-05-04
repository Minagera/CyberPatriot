# Linux Command Reference

## User and Group Management

- List users:  
  `cut -d: -f1 /etc/passwd`
- Add user:  
  `sudo adduser username`
- Delete user:  
  `sudo deluser username`
- Add user to group:  
  `sudo usermod -aG groupname username`
- List group members:  
  `getent group groupname`

## Passwords and Policies

- Change password:  
  `passwd username`
- Check password aging:  
  `chage -l username`
- Set password expiration:  
  `sudo chage -M 90 username`

## Service Management

- List running services:  
  `systemctl list-units --type=service --state=running`
- Stop service:  
  `sudo systemctl stop servicename`
- Disable service:  
  `sudo systemctl disable servicename`

## Firewall

- Check UFW status:  
  `sudo ufw status`
- Enable UFW:  
  `sudo ufw enable`
- Allow SSH:  
  `sudo ufw allow ssh`

## File Permissions

- List permissions:  
  `ls -l`
- Change permissions:  
  `chmod 600 filename`
- Change owner:  
  `sudo chown user:group filename`
- Find world-writable files:  
  `find / -type f -perm -o+w 2>/dev/null`

## System Updates

- Update package list:  
  `sudo apt update`
- Upgrade packages:  
  `sudo apt upgrade`

## Useful Bash

- Find SUID files:  
  `find / -perm -4000 -type f 2>/dev/null`
- List open ports:  
  `sudo netstat -tulnp`
- Check cron jobs:  
  `crontab -l`

*Add more commands as you learn them!*
