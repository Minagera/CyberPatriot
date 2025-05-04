# Advanced ACL Configuration Guide

This guide covers advanced access control list (ACL) techniques for CyberPatriot competitions.

## 1. Standard ACL Example (Restrict Management Access)

```plaintext
access-list 10 permit 10.10.10.0 0.0.0.255
access-list 10 deny any
line vty 0 4
access-class 10 in
```

## 2. Extended ACL Example (Block Unwanted Services)

```plaintext
access-list 110 deny tcp any any eq telnet
access-list 110 deny tcp any any eq 23
access-list 110 permit ip any any
interface g0/0
ip access-group 110 in
```

## 3. Verify ACLs

```plaintext
show access-lists
show run | include access-list
show ip interface g0/0
```

## 4. Tips

- Always apply the most restrictive rule first.
- Document all ACLs and their purpose.
- Test connectivity after applying ACLs.

---
