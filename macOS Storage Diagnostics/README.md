# macOS Storage & Diagnostics

## Overview
This repository contains a specialized Bash diagnostic tool for enterprise macOS environments. It is designed to provide visibility into disk space distribution. By identifying "storage" in hidden system directories (such as `/private/var` and `/Library`), administrators can make data-driven decisions on cleanup policies.

## Key Features
* **Root-Level Mapping**: Rapidly identifies the top 15 largest directories on the primary system volume.
* **System Library Audit**: Scans global Application Support and Cache folders to find bloated software logs or redundant data.
* **Hidden Directory Visibility**: Inspects the `/private/var` path, a common location for system logs, temporary files, and virtual memory swap files.
* **Snapshot Detection**: Interrogates `tmutil` to identify if APFS local snapshots are preventing the OS from reclaiming disk space.

---

## Deployment & Execution
This script is intended for use as an **On-Demand Diagnostic** through an MDM solution (such as Kandji).

### **Instructions**
1. **MDM Implementation**:
   * Create a new **Custom Script** in your library.
   * Paste the contents of `Storage_Audit.sh`.
   * Ensure the script is set to run as **Root** to allow access to system-protected directories.
2. **Analysis**:
   * Review the MDM logs (stdout) to identify specific paths requiring remediation.
3. **Integration**:
   * For automated cleanup based on these results, refer to my utility: Clean & update: OS, Chrome, Safari, Adobe, Keynote: https://github.com/RickGua90/kandji-custom-scripts/tree/main/Clean%20%26%20update%3A%20OS%2C%20Chrome%2C%20Safari%2C%20Adobe%2C%20Keynote

### **Testing Protocols**
Before implementing automated cleanup based on these results, refer to the following documentation for establishing safe testing groups:

Guide: Create or Delete a Blueprint for Testing https://github.com/RickGua90/How_To/blob/main/How_to_Create_Blueprints_IRU_Kandji.pdf

---

## Disclaimer
**READ BEFORE USE**: This script is for diagnostic purposes only and does not delete data. Running `du` (disk usage) on a full drive may take several minutes to complete depending on the hardware architecture.
