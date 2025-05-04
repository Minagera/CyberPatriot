# CyberPatriot Baselining Directory Structure

## Linux Baseline Example

```
linux_baseline/
├── etc/
│   ├── passwd
│   ├── group
│   └── ssh/
│       └── sshd_config
│   └── pam.d/
│       └── common-password
├── packages.txt
├── enabled-services.txt
├── passwd.txt
├── group.txt
├── suid_sgid_files.txt
├── world_writable_files.txt
```

## Windows Baseline Example

```
windows_baseline/
├── run.reg
├── services.reg
├── users.txt
├── groups.txt
├── group_<groupname>.txt
├── firewall.wfw
├── tasks.txt
```
