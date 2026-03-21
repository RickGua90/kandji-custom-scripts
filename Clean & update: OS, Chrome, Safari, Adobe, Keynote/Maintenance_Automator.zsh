#!/bin/zsh

# PROJECT: macOS Endpoint Health & Patch Automation
# AUTHOR: Rick
# LOGIC: Automated cache clearing, hardware telemetry, and unified patch management.

# DISCLAIMER: This script is for testing and educational purposes only. I hold no responsibility for any system issues or broken functionality. Use at your own risk.

# --- Function to execute maintenance and capture output ---
run_maintenance() {
    # 0. Context & Variable Initialization
    # Identifying the active console user to target specific Library paths
    CONSOLE_USER=$(stat -f%Su /dev/console)
    USER_ID=$(id -u "$CONSOLE_USER")
    USER_HOME=$(dscl . -read /Users/"$CONSOLE_USER" NFSHomeDirectory | awk '{print $2}')
    RUM_PATH="/usr/local/bin/RemoteUpdateManager"
    
    # Capture starting disk space (in KB)
    START_KB=$(df -k / | awk 'NR==2 {print $4}')

    echo "--- LOG START: $(date) ---"
    echo "Device: $(hostname) | User: $CONSOLE_USER"
    
    # 1. Targeted Cleanup
    # (N) prevents "no matches found" errors in Zsh if a directory is already empty
    echo "[1/4] Cleaning Application Caches..."
    rm -rf "$USER_HOME"/Library/Caches/*(N)
    rm -rf "$USER_HOME"/Library/Application\ Support/Microsoft/Teams/{Cache,Code\ Cache,Logs,tmp}(N)
    rm -rf "$USER_HOME"/Library/Application\ Support/Google/Chrome/Default/{Cache,Application\ Cache}(N)
    rm -rf "$USER_HOME"/Library/Safari/{LocalStorage,TemplateIcons,Favicon\ Cache,History.db}(N)
    echo "System and Browser caches cleared."

    # 2. Hardware Health Telemetry
    # Capturing SMART and Battery status
    echo "[2/4] Running Health Telemetry..."
    DISK_STATUS=$(diskutil info / | grep "SMART Status" | awk '{print $3}')
    BATT_STATUS=$(system_profiler SPPowerDataType | grep "Condition" | awk '{print $2}')
    echo "STATUS: Disk=$DISK_STATUS | Battery=$BATT_STATUS"

    # 3. Storage Reclaim (APFS Snapshots)
    echo "[3/4] Thinning APFS snapshots..."
    tmutil thinlocalsnapshots / 20000000000 4 && echo "Snapshots thinned."

    # 4. Unified Patch Management (macOS, App Store, & Adobe)
    echo "[4/4] Initiating Updates..."
    
    # macOS/Safari Security Updates
    echo "Triggering macOS and Safari updates..."
    softwareupdate --install --all --quiet & 

    # Keynote Update (Native App Store)
    echo "Checking for Keynote updates..."
    softwareupdate --install "Keynote" & 

    # Adobe Updates via the RemoteUpdateManager (RUM) binary
    if [[ -f "$RUM_PATH" ]]; then
        echo "RemoteUpdateManager found. Updating Adobe apps..."
        "$RUM_PATH" --action=install &
    else
        echo "RemoteUpdateManager not found at $RUM_PATH. Check deployment status."
        # Fallback to restart the Adobe installer service if RUM is missing
        launchctl kickstart -k system/com.adobe.acc.installer 2>/dev/null
    fi

    # 5. Final Space Calculation & Reporting
    END_KB=$(df -k / | awk 'NR==2 {print $4}')
    RECLAIMED_KB=$((END_KB - START_KB))
    
    [[ "$RECLAIMED_KB" -lt 0 ]] && RECLAIMED_KB=0
    RECLAIMED_GB=$(echo "scale=2; $RECLAIMED_KB / 1048576" | bc)

    echo "--- SUMMARY ---"
    echo "TOTAL RECLAIMED: ${RECLAIMED_GB} GB"
    echo "--- LOG END ---"

    # Send non-intrusive notification to the active user's desktop
    launchctl asuser "$USER_ID" sudo -u "$CONSOLE_USER" osascript -e "display notification \"Maintenance complete. ${RECLAIMED_GB} GB reclaimed.\" with title \"IT Support Maintenance\""
}

# Execute function and redirect all output (stdout/stderr) to the MDM log
run_maintenance 2>&1

exit 0
