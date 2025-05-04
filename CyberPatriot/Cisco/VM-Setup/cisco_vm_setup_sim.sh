#!/bin/bash
# CyberPatriot Cisco Packet Tracer Scenario Generator (Simulation Only)
# For instructor use. Generates a unique set of configuration tasks for Packet Tracer.

echo "=== CyberPatriot Cisco Packet Tracer Scenario Generator ==="
echo "This script generates a unique set of configuration tasks for Packet Tracer practice."
echo

# Generate random scenario elements (example, not real device config)
HOSTNAMES=("Alpha" "Bravo" "Charlie" "Delta")
ROLES=("Edge Router" "Core Switch" "DMZ Firewall" "Access Point")
PASSWORDS=("Cyb3rP@t!" "Tr@1nM0r3" "Secur3Net" "P@cket2024")

echo "Scenario:"
echo "- Configure the following devices:"
for i in {0..2}; do
  echo "  * ${HOSTNAMES[$i]} (${ROLES[$i]})"
done
echo "- Set enable secret to: ${PASSWORDS[0]}"
echo "- Configure SSH only (disable Telnet)"
echo "- Assign VLANs and basic ACLs as described in the README"
echo "- Save your configuration and export the .pkt file for review"

echo
echo "This scenario is unique and for CyberPatriot training only."
