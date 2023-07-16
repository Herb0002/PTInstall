#!/bin/bash

# The latest version of PTManager
latest_version="$(cat /home/profittrailer/PTManager/version.txt)"

# The directory for PTManager
target_dir="/home/profittrailer/PTManager"

# Change the port number in the application.properties file
sed -i 's/server.port=10000/server.port=8080/' "$target_dir/ptmanager-$latest_version/application.properties"

# Create PTBots directory in /home/profittrailer
mkdir -p /home/profittrailer/PTBots

# Change the bots directory in the application.properties file
sed -i "s#server.bots.directory=/var/opt#server.bots.directory=/home/profittrailer/PTBots#" "$target_dir/ptmanager-$latest_version/application.properties"

# Open the file application.properties
file_path="$target_dir/ptmanager-$latest_version/application.properties"

# Remove any existing lines that contain default.startup.xmx=
sed -i '/^default\.startup\.xmx=/d' $file_path

# Ask the user for the RAM size for the bot
while true; do
    echo "Reserve RAM for each bot choice value and press enter:"
    echo "Enter '1' for 512 MB"
    echo "Enter '2' for 768 MB"
    echo "Enter '3' for 1024 MB"
    echo "Enter '4' to enter a custom value"
    echo "Enter '5' for more information about RAM allocation"

    # Read the user input and validate it
    read -r choice
    case $choice in
        1)
            ram_size="512m"
            break
            ;;
        2)
            ram_size="768m"
            break
            ;;
        3)
            ram_size="1024m"
            break
            ;;
        4)
            read -rp "Enter the RAM size in MB (e.g. '2048'): " custom_ram_size
            ram_size="${custom_ram_size}m"
            break
            ;;
        5)
            echo -e "\nReserving RAM for each bot enhances its performance. The number of trading pairs a bot handles can impact its memory requirements. More active strategies or strategies dealing with more pairs might need more RAM. Generally, 512 MB should suffice for a small bot and 1024 MB for a bot dealing with many pairs."
            ;;
        *)
            echo "Invalid choice. Please enter a valid option (1-5)."
            ;;
    esac
done

# Insert the RAM size into the application.properties file on a new line
echo -e "\ndefault.startup.xmx=$ram_size" >> $file_path

# Print the new value to the console
echo "The value '$ram_size' has been written to application.properties."
