# macOS Adobe Remote Update Manager (RUM) Deployment

## Overview
This repository provides a specialised Zsh deployment script for macOS, designed to automate the installation of the **Adobe Remote Update Manager (RUM)**. By utilising MDM "Installable Resources" (such as Kandji), this script enables silent, background patch management for Adobe Creative Cloud applications across a managed fleet.

## Key Features
* **Architecture Awareness**: Automatically detects hardware profiles (**Apple Silicon** vs. **Intel**) to ensure the correct binary is deployed from staged disk images.
* **Zero-Touch Execution**: Utilises background mounting (`hdiutil -nobrowse`) to install the utility without user interruption or visible desktop icons.
* **Infrastructure Security**: Applies `root:wheel` ownership and `755` permissions to the binary in `/usr/local/bin` to prevent unauthorised tampering.

---

## Deployment & Testing
This script is designed to function as a **Post-install script** within an MDM Installable Resource. 

### **Step-by-Step Configuration**

1.  **Prepare the Resource**:
    * Create a ZIP archive named **`AdobeRUM.zip`** containing both `RUM_Silicon.dmg` and `RUM_Intel.dmg`.
    * You can find the AdobeRUM.zip i used here: https://github.com/RickGua90/Windows_Installers_exe
2.  **Create the Library Item**:
    * Navigate to your MDM Library and create a new **Custom Apps**.
    * Upload the **`AdobeRUM.zip`** file.
    * Set the **Unzip Location** to **`/tmp`**.
3.  **Implement the Script**:
    * Copy the contents of **`AdobeRUM_Mac_Deploy.zsh`** from this repository.
    * Paste the code into the **Post-install Script** field.
4.  **Assign and Execute**:
    * Assign the resource to your dedicated testing blueprints.
    * The MDM will automatically download the ZIP, unzip it to **`/tmp`**, and execute the script to finalise the binary placement.

### **Testing Protocols**
Before a global rollout, validate the deployment using a dedicated testing library. For detailed instructions on establishing a secure testing environment and managing groups, refer to the following documentation:

**Guide: Create or Delete a Blueprint for Testing** https://github.com/RickGua90/How_To/blob/main/How_to_Create_Blueprints_IRU_Kandji.pdf

---

## Disclaimer
**READ BEFORE USE**: These scripts are provided for educational and infrastructure management purposes. I hold no responsibility for system instability or broken functionality. Always validate deployments on a subset of test devices before production execution.
