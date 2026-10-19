# macOS Adobe Legacy Application Cleanup Utility

## Overview
This repository contains a Bash-based automation script designed for the systematic removal of legacy Adobe Creative Cloud applications. In enterprise environments, Adobe updates often leave behind older versions (e.g., 2021, 2022) which consume significant disk space and create software version confusion. This utility streamlines the decommissioning process via MDM custom scripting.

**READ BEFORE USE** This utility will remove all the versions below the 2026. Carefully check all the Adobe versions in the script.

## Key Features
* **Multi-Version Targeting**: Specifically identifies and removes application directories for Photoshop, InDesign, Illustrator, Premiere Pro, and more across multiple years (2021-2025).
* **Safe Execution Logic**: Utilises a verification function to check for the existence of a directory or file before attempting removal, preventing unnecessary error logs in MDM consoles.
* **Infrastructure Optimization**: Designed to be used in conjunction with deployment tools like **RemoteUpdateManager (RUM)** to ensure only the desired versions remain active on the endpoint.
* **Audit-Ready Logging**: Provides a clear summary of the number of items successfully removed for easy reporting.

---

## Deployment & Testing
This script is intended for use as a **Custom Script** or **One-time Action** in your MDM (Kandji, Jamf, or Intune).

### **Instructions**
1. **Selection**: Identify the specific versions you wish to decommission by editing the `ADOBE_APPS` array.
2. **MDM Deployment**: 
   * Create a new Custom Script.
   * Paste the contents of `Adobe_Cleanup.sh`.
   * Target the script to run as **Root**.
3. **Integration**: For a complete lifecycle management solution, ensure this is paired with my macOS-Adobe-RUM-Deploy: https://github.com/RickGua90/kandji-custom-scripts/tree/main/macOS%20Adobe%20RUM%20Deploy utility to keep the remaining versions updated.

### **Testing Protocols**
Before a global rollout, validate the cleanup on a dedicated testing group to ensure no active production versions are targeted. Refer to my guide here for group management:

**Guide: Create or Delete a Blueprint for Testing** https://github.com/RickGua90/How_To_Do_It

---

## Disclaimer
**READ BEFORE USE**: This script performs permanent file deletion. Always verify the application paths before execution. I hold no responsibility for the accidental removal of active production software.
