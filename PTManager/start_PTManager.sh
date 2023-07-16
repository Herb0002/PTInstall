#!/bin/bash

# Parameter $1 represents if caddy is installed (yes/no)

# The latest version of PTManager
latest_version="$(cat /home/profittrailer/PTManager/version.txt)"

# Extract the domain name from the application.properties file
domain_name=$(grep 'server.caddy.domain' /home/profittrailer/PTManager/ptmanager-$latest_version/application.properties | cut -d'=' -f2)

# Go to the directory /home/profittrailer/PTManager/ptmanager-$latest_version
cd /home/profittrailer/PTManager/ptmanager-$latest_version

# Start PT Manager with PM2
pm2 start pm2-PTManager.json
pm2 save
pm2 startup

# Print a message indicating that we are waiting for PT Manager to start
echo "Waiting for PT Manager startup"

# Wait for 30 seconds to allow PT Manager to start
sleep 30

tail -100 ~/.pm2/logs/pt-manager-out.log | grep --color=always 'Random' | sed -e 's/\(.*Random.*\)/\o033[33m\1\o033[0m/'

# Get the server's public IP address
IP=$(curl -s http://whatismyip.akamai.com/)

# Print a message indicating that the manager can be opened
if [[ $1 == "yes" ]]; then
    echo -e "You can open your manager with \033[4;34mhttp://$IP:8080\033[0m or access it securely at \033[4;34mhttps://$domain_name\033[0m"
else
    echo -e "You can open your manager with \033[4;34mhttp://$IP:8080\033[0m"
fi
