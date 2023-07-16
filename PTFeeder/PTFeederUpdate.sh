#!/bin/bash

# Check if PTFeeder directory exists
if [ -d "/home/profittrailer/PTFeeder" ]; then

    echo "PTFeeder directory exists, updating..."
    
    # Store the URL of the API endpoint in a variable
    PTFU_url="https://api.github.com/repos/mehtadone/PTFeeder/releases/latest"

    # Get latest PTFeeder version
    PTFU_version=$(curl -s https://api.github.com/repos/mehtadone/PTFeeder/releases/latest | grep tag_name | cut -d '"' -f 4)

    # Write the found new version to the file PTFNew.txt
    echo "$PTFU_version" > /home/profittrailer/PTFeeder/PTFNew.txt

    # Read the version stored in /home/profittrailer/PTFeeder/PTFeederversion.txt
    PTFU_installed_version=$(cat /home/profittrailer/PTFeeder/PTFeederversion.txt)

    # Compare the two versions
    if [ "$PTFU_version" == "$PTFU_installed_version" ]; then
        echo "The latest version of PTFeeder ($PTFU_version) is already installed."
    else
        echo "A new version of PTFeeder is available: $PTFU_version"
        echo "Downloading PTFeeder..."
        
        # Find the process ID associated with pt-feeder.dll
        pid=$(ps aux | grep "dotnet pt-feeder.dll" | grep -v "grep" | awk '{print $2}')

        # Check if a process ID was found
        if [ -n "$pid" ]; then
            # Kill the process
            kill $pid
            echo "pt-feeder process with ID $pid terminated."
        else
            echo "No pt-feeder process found."
        fi

        # Create the directory /home/profittrailer/PTFeeder/PTFUpdate if it doesn't exist
        mkdir -p /home/profittrailer/PTFeeder/PTFUpdate

        # Create a temporary directory
        temp_dir=$(mktemp -d)

        RELEASE_URL=$(curl -s https://api.github.com/repos/mehtadone/PTFeeder/releases/latest | grep browser_download_url | cut -d '"' -f 4)
        RELEASE_NAME=$(basename $RELEASE_URL)
        wget $RELEASE_URL -P "$temp_dir"
        unzip "$temp_dir/$RELEASE_NAME" -d "$temp_dir"


        # Copy the PTFeeder folder to the /home/profittrailer/PTFeeder/PTFUpdate directory
        cp -r "$temp_dir/pt-feeder" "/home/profittrailer/PTFeeder/PTFUpdate"

        # Delete the "config" and "database" folders from the PTFeeder folder
        rm -rf "/home/profittrailer/PTFeeder/PTFUpdate/pt-feeder/config"
        rm -rf "/home/profittrailer/PTFeeder/PTFUpdate/pt-feeder/database"

        # Update the version stored in /home/profittrailer/PTFeeder/PTFeederversion.txt
        echo "$PTFU_version" > /home/profittrailer/PTFeeder/PTFeederversion.txt

        # Open the file /home/profittrailer/PTFeeder/ManagedFeeder.txt and copy the names into a variable
        managed_feeders=$(cat /home/profittrailer/PTFeeder/ManagedFeeder.txt)

        # Go into each folder under /home/profittrailer/PTBots listed in ManagedFeeder.txt and copy the new PTFeeder folder there
        for feeder in $managed_feeders
        do
            echo "Copying PTFeeder to $feeder..."
            cp -r "/home/profittrailer/PTFeeder/PTFUpdate/pt-feeder" "/home/profittrailer/PTBots/$feeder/"
            echo "$PTFU_version" > "/home/profittrailer/PTBots/$feeder/PTFeederversion.txt"
        done

        echo "PTFeeder has been updated to version $PTFU_version."
    fi
else
    echo "PTFeeder directory does not exist. Please run the installation script."
fi
