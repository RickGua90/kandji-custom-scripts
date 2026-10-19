# macOS Endpoint Maintenance & Patch Automation

## Overview
This repository contains a comprehensive **Zsh** maintenance script designed for enterprise macOS management. It automates critical system hygiene tasks, captures hardware health telemetry, and ensures software patch compliance. By scheduling this script via an MDM (such as Kandji), administrators can ensure workstations remain performant and secure without manual intervention.

## Key Features
* **Automated Patch Management**: Targets macOS system updates, Safari security patches, and native Apple applications.
* **Adobe RUM Integration**: Detects and utilises the **Adobe Remote Update Manager** binary to silently trigger Creative Cloud updates.
* **Storage Optimization**: Reclaims significant disk space by thinning APFS local snapshots and clearing high-impact application caches (Teams, Chrome, Safari).
* **Hardware Telemetry**: Logs SMART disk status and battery health conditions to assist with proactive hardware lifecycle management.
* **User Notification**: Uses `osascript` to provide a non-intrusive desktop notification upon completion, reporting the exact storage reclaimed.

---

## Technical Details & Logic
The script is designed to run in the **System context** (Root) while intelligently identifying the active console user to target the correct Library paths and home directories.

### **Execution Phases**
1. **Targeted Cleanup**: Safely clears caches for high-impact applications using Zsh null-globbing to prevent script termination on empty directories.
2. **Health Check**: Queries `diskutil` and `system_profiler` for hardware status.
3. **APFS Thinning**: Uses `tmutil` to reclaim space held by local Time Machine snapshots.
4. **Unified Updates**: Triggers `softwareupdate` and `RemoteUpdateManager` concurrently to minimize background process time.

## Deployment & Testing
This script is designed to be deployed as a **Custom Script** within an MDM library.

1. **Prerequisite**: This script requires the Adobe RUM binary to be present at `/usr/local/bin/`. You can deploy this using my unified architecture-aware installer found here: https://github.com/RickGua90/kandji-custom-scripts/tree/main/macOS%20Adobe%20RUM%20Deploy
2. **Configuration**:
   * Create a new **Custom Script** in your MDM.
   * Paste the contents of `scripts/Maintenance_Automator.zsh`.
   * Set the execution frequency (e.g., Weekly or on a specific maintenance schedule).

### **Testing Protocols**
Before a global rollout, validate the deployment using a dedicated testing group. For detailed instructions on establishing a secure testing environment, refer to the following documentation:

**Guide: Create or Delete a Blueprint for Testing** https://github.com/RickGua90/How_To_Do_It

---

## Disclaimer
**READ BEFORE USE**: These scripts are provided for educational and infrastructure management purposes. I hold no responsibility for system instability or broken functionality. Always validate deployments on a subset of test devices before production execution.
