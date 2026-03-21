#!/bin/bash

# PROJECT: macOS Storage & Diagnostics
# AUTHOR: Rick
# LOGIC: Deep-dive directory analysis to identify high-capacity storage consumers.

# DISCLAIMER: This script is for testing and educational purposes only. I hold no responsibility for any system issues or broken functionality. Use at your own risk.

echo "--- 1. TOP 15 ROOT DIRECTORIES ---"
# This scans the very top level of the hard drive
/usr/bin/du -sh /* 2>/dev/null | /usr/bin/sort -rh | /usr/bin/head -n 15

echo "--- 2. SYSTEM LIBRARY SCAN ---"
# This checks the system-wide Application Support (TOP 10) and Caches (TOP 5)
/usr/bin/du -sh /Library/Application\ Support/* 2>/dev/null | /usr/bin/sort -rh | /usr/bin/head -n 10
/usr/bin/du -sh /Library/Caches/* 2>/dev/null | /usr/bin/sort -rh | /usr/bin/head -n 5

echo "--- 3. PRIVATE VAR SCAN TOP 10---"
# This is a common hiding place for hidden logs and temp files
/usr/bin/du -sh /private/var/* 2>/dev/null | /usr/bin/sort -rh | /usr/bin/head -n 10

echo "--- 4. LOCAL SNAPSHOTS ---"
# This checks if Time Machine is holding onto 'deleted' data
/usr/bin/tmutil listlocalsnapshots /
