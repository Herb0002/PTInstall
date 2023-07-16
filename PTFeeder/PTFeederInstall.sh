#!/bin/bash

# Set installation directory for PTFeeder
INSTALL_DIR="/home/profittrailer/PTFeeder"

# Check if PTFeeder directory exists
if [ -d "$INSTALL_DIR" ]; then
    echo "PTFeeder is already installed."
    read -p "Do you want to install another instance of PTFeeder? (Y/N) " answer
    if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
        echo "Skipping PTFeeder installation."
        exit 0
    fi
else
    echo "Starting the installation script for PTFeeder."

    echo "Installing PTFeeder"

    # Check if PTFeeder directory exists, create it if it doesn't
    mkdir -p "$INSTALL_DIR"

    # Get latest PTFeeder version download URL
    RELEASE_URL=$(curl -s https://api.github.com/repos/mehtadone/PTFeeder/releases/latest | grep browser_download_url | cut -d '"' -f 4)

    # Download and install PTFeeder to installation directory
    wget $RELEASE_URL -O $INSTALL_DIR/ptfeeder.zip
    unzip $INSTALL_DIR/ptfeeder.zip -d $INSTALL_DIR
    rm $INSTALL_DIR/ptfeeder.zip

    # Get latest PTFeeder version tag for writing into file
    LATEST_VERSION=$(curl -s https://api.github.com/repos/mehtadone/PTFeeder/releases/latest | grep tag_name | cut -d '"' -f 4)

    # Write installed version to file
    echo "$LATEST_VERSION" > $INSTALL_DIR/PTFeederversion.txt

    echo "PTFeeder version $LATEST_VERSION has been downloaded and installed successfully!"
fi

echo "Starting PTFeeder installation"

# Prompt user for number of PTFeeders to install
while true; do
    read -p "Enter the number of PTFeeders you want to install: " num_installations
    if [[ $num_installations =~ ^[0-9]+$ ]]; then
        break
    else
        echo "Invalid number! Please enter a valid number."
    fi
done

# Loop through the number of installations
for ((i=1; i<=num_installations; i++)); do

    # Prompt user for folder name
    while true; do
        read -p "Enter the name for the PTFeeder folder $i: " folder_name
        if [[ $folder_name =~ ^[a-zA-Z0-9._-]+$ ]]; then
            break
        else
            echo "Invalid folder name! Please enter a valid name."
        fi
    done

    # Create PTFeeder folder in installation directory with the given name
    mkdir -p "/home/profittrailer/PTBots/${folder_name}"

    # Copy the content of the PTFeeder folder to the installation directory
    cp -r $INSTALL_DIR/pt-feeder/* "/home/profittrailer/PTBots/${folder_name}"

    # Create ManagedFeeder.txt file and write folder name to it
    echo "${folder_name}" >> "$INSTALL_DIR/ManagedFeeder.txt"

    echo "PTFeeder $i has been installed to /home/profittrailer/PTBots/${folder_name} and the folder name has been written to the ManagedFeeder.txt file!"
done
