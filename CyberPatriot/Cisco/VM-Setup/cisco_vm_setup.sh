#!/bin/bash
# CyberPatriot Cisco Packet Tracer VM Setup Script (Instructor Template)
# This script installs Packet Tracer and sets up a practice environment.
# Customize as needed for your training lab.

set -e

echo "[*] Installing Cisco Packet Tracer (manual step required)..."
echo "1. Download Packet Tracer from https://www.netacad.com/"
echo "2. Run the installer for your OS."
echo "3. Place scenario files in ~/CyberPatriot/Cisco/PacketTracer_Scenarios/"

echo "[*] Creating practice workspace directory..."
mkdir -p ~/CyberPatriot/Cisco/PacketTracer_Scenarios

echo "[*] Setup complete. Open Packet Tracer and load a scenario to begin training."
