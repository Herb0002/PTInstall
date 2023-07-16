#!/bin/bash

# This script installs PTManager

# Create PTManager directory in /home/profittrailer
mkdir -p /home/profittrailer/PTManager

# The directory to save the files to
target_dir="/home/profittrailer/PTManager"

# The URL to the GitHub API for the repository
url="https://api.github.com/repos/profittrailerbv/ProfitTrailerManager/releases/latest"

# Get the latest version from GitHub
latest_version="$(curl -sSL "$url" | grep -oP '"tag_name": "\K(.*)(?=")')"

# The URL to the release ZIP file
url="https://github.com/profittrailerbv/ProfitTrailerManager/releases/download/$latest_version/ptmanager-$latest_version.zip"

# Make sure the target directory exists
mkdir -p "$target_dir"

# The directory to store the downloaded ZIP file and extracted files
temp_dir="$(mktemp -d)"

# Download the ZIP file and save it to the temporary directory
zip_filename="$(basename "$url")"
curl -sSL "$url" -o "$temp_dir/$zip_filename"

# Extract the ZIP file
cd "$temp_dir" || exit
unzip "$zip_filename"

# Copy all extracted files to the target directory
cp -R "$temp_dir/." "$target_dir"

# Make the jar file executable
chmod +x "$target_dir/ptmanager-$latest_version/ProfitTrailerManager.jar"

# Write the version number to a file
echo "$latest_version" > "$target_dir/version.txt"
