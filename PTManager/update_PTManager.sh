#!/bin/bash

# The URL to the GitHub API for the repository
url="https://api.github.com/repos/profittrailerbv/ProfitTrailerManager/releases/latest"

# Get the latest version from GitHub
latest_version="$(curl -sSL "$url" | grep -oP '"tag_name": "\K(.*)(?=")')"

# Get the current version of PT Manager
current_version="$(cat /home/profittrailer/PTManager/version.txt)"

# Check if the latest version is already installed
if [ "$latest_version" == "$current_version" ]; then
    echo "The latest version is already installed."
else
    # Stop PT Manager
    cd /home/profittrailer/PTManager/ptmanager-$current_version
    echo "Stopping PT Manager..."
    pm2 stop pm2*
    pm2 delete pm2*
    pm2 save

    # The URL to the release ZIP file
    url="https://github.com/profittrailerbv/ProfitTrailerManager/releases/download/$latest_version/ptmanager-$latest_version.zip"

    # The directory to store the downloaded ZIP file and extracted files
    temp_dir="$(mktemp -d)"

    # Download the ZIP file and save it to the temporary directory
    zip_filename="$(basename "$url")"
    curl -sSL "$url" -o "$temp_dir/$zip_filename"

    # Extract the ZIP file
    cd "$temp_dir" || exit
    unzip -j "$zip_filename" "*/ProfitTrailerManager.jar"

    # Replace the existing jar file with the new one
    echo "Replacing jar file..."
    cp -f "ProfitTrailerManager.jar" "/home/profittrailer/PTManager/ptmanager-$current_version/"

    # Extract pm2-PTManager.json from the ZIP file
    unzip -j "$zip_filename" "*/pm2-PTManager.json"
    # Move the extracted pm2-PTManager.json to the PTManager directory
    mv "pm2-PTManager.json" "/home/profittrailer/PTManager/ptmanager-$current_version/"

    # Rename the directory to the current version
    echo "Renaming directory..."
    mv "/home/profittrailer/PTManager/ptmanager-$current_version" "/home/profittrailer/PTManager/ptmanager-$latest_version"

    # Make the jar file executable
    echo "Making jar file executable..."
    chmod +x "/home/profittrailer/PTManager/ptmanager-$latest_version/ProfitTrailerManager.jar"

    # Write the version number to a file
    echo "$latest_version" > "/home/profittrailer/PTManager/version.txt"

    # Start PT Manager with PM2
    echo "Starting PT Manager with PM2..."
    cd "/home/profittrailer/PTManager/ptmanager-$latest_version"
    pm2 start pm2*
    pm2 save
    pm2 startup

    # Print a message indicating that we are waiting for PT Manager to start
    echo "Waiting for PT Manager startup"

    # Wait for 15 seconds to allow PT Manager to start
    sleep 15

    echo "PTManager update finished to version $latest_version"
fi
