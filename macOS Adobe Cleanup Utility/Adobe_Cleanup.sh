#!/bin/bash

# PROJECT: Adobe Legacy Application Cleanup
# AUTHOR: Rick
# LOGIC: Iterative removal of specific Adobe version directories to reclaim disk space.

# DISCLAIMER: This script is for testing and educational purposes only. I hold no responsibility for any system issues or broken functionality. Use at your own risk.

# List of Adobe apps and folders to target
ADOBE_APPS=(
    "/Applications/Adobe InDesign 2024/Adobe InDesign 2024.app"
    "/Applications/Adobe InDesign 2021/Adobe InDesign 2021.app"
    "/Applications/Adobe InDesign 2022/Adobe InDesign 2022.app"
    "/Applications/Adobe InDesign 2023/Adobe InDesign 2023.app"
    "/Applications/Adobe InDesign 2025/Adobe InDesign 2025.app"
    "/Applications/Adobe Illustrator 2024/Adobe Illustrator.app"
    "/Applications/Adobe Illustrator 2023/Adobe Illustrator.app"
    "/Applications/Adobe Illustrator 2022/Adobe Illustrator.app"
    "/Applications/Adobe Illustrator 2025/Adobe Illustrator.app"
    "/Applications/Adobe Media Encoder 2022/Adobe Media Encoder 2022.app"
    "/Applications/Adobe Media Encoder 2024/Adobe Media Encoder 2024.app"
    "/Applications/Adobe Media Encoder 2025/Adobe Media Encoder 2025.app"
    "/Applications/Adobe Photoshop 2022/Adobe Photoshop 2022.app"
    "/Applications/Adobe Photoshop 2021/Adobe Photoshop 2021.app"
    "/Applications/Adobe Photoshop 2023/Adobe Photoshop 2023.app"
    "/Applications/Adobe Photoshop 2024/Adobe Photoshop 2024.app"
    "/Applications/Adobe Photoshop 2025/Adobe Photoshop 2025.app"
    "/Applications/Adobe Premiere Pro 2023/Adobe Premiere Pro 2023.app"
    "/Applications/Adobe Premiere Pro 2024/Adobe Premiere Pro 2024.app"
    "/Applications/Adobe Premiere Pro 2025/Adobe Premiere Pro 2025.app"
    "/Applications/Adobe Audition 2023/Adobe Audition 2023.app"
    "/Applications/Adobe Audition 2024/Adobe Audition 2024.app"
    "/Applications/Adobe Audition 2025/Adobe Audition 2025.app"
    "/Applications/Adobe After Effects 2022/Adobe After Effects 2022.app"
    "/Applications/Adobe After Effects 2023/Adobe After Effects 2023.app"
    "/Applications/Adobe After Effects 2024/Adobe After Effects 2024.app"
    "/Applications/Adobe After Effects 2025/Adobe After Effects 2025.app"
    "/Applications/Adobe Bridge 2024/Adobe Bridge 2024.app"
    "/Applications/Adobe Bridge 2023/Adobe Bridge 2023.app"
    "/Applications/Adobe Bridge 2025/Adobe Bridge 2025.app"
)

COUNT=0

# Function to delete files or directories
delete_item() {
    local path=$1
    if [ -d "$path" ] || [ -f "$path" ]; then
        rm -rf "$path"
        echo "SUCCESS: Deleted $path"
        ((COUNT++))
    else
        echo "INFO: Not found - $path"
    fi
}

echo "--- Adobe Cleanup Started: $(date) ---"

# Loop through the list and delete each item
for app in "${ADOBE_APPS[@]}"; do
    delete_item "$app"
done

echo "--- Cleanup Complete: $COUNT items removed ---"
exit 0
