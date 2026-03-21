#!/bin/zsh

# PROJECT: Adobe RUM Deployment
# AUTHOR: Rick
# LOGIC: Post-install execution for Kandji IRU
 
# DISCLAIMER: This script is for testing and educational purposes only. I hold no responsibility for any system issues or broken functionality. Use at your own risk.

TARGET="/usr/local/bin/RemoteUpdateManager"
mkdir -p /usr/local/bin

# 1. Move to where Kandji unzipped the files
cd /tmp

# 2. Detect architecture and find the DMG
ARCH=$(uname -m)
echo "Architecture detected: $ARCH"

if [[ "$ARCH" == "arm64" ]]; then
    DMG_FILE=$(ls /tmp/*.dmg | grep -iE "Silicon|ARM" | head -n 1)
else
    DMG_FILE=$(ls /tmp/*.dmg | grep -ivE "Silicon|ARM" | head -n 1)
fi

# 3. Mount and Copy
if [[ -f "$DMG_FILE" ]]; then
    mount_output=$(hdiutil attach -nobrowse -plist "$DMG_FILE")
    mount_point=$(echo "$mount_output" | grep -A 1 "mount-point" | grep "string" | sed 's/<[^>]*>//g' | xargs)
    
    cp "$mount_point/RemoteUpdateManager" "$TARGET"
    hdiutil detach "$mount_point" -quiet
    
    # 4. Finalise Permissions
    chmod 755 "$TARGET"
    chown root:wheel "$TARGET"
    echo "RemoteUpdateManager is now at $TARGET"
else
    echo "ERROR: DMG file not found in /tmp"
    exit 1
fi
