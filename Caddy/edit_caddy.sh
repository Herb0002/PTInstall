#!/bin/bash

# 1. Stop ProfitTrailer Manager using the existing script
/home/profittrailer/PTInstall/PTManager/stop_PTManager.sh

# 2. Prompt the user for the new domain name
read -p "Enter your new domain name (e.g., example.com): " new_domain

# 3. Prompt the user for the new email address
read -p "Enter your new email address (e.g., email@example.com): " new_email

# 4. Update /etc/caddy/Caddyfile
caddyfile_path="/etc/caddy/Caddyfile"
sudo bash -c "cat > $caddyfile_path << EOL
$new_domain {
    reverse_proxy $new_domain:8080
    tls $new_email
}
EOL"

# 5. Update application.properties
application_properties_path="/home/profittrailer/PTManager/ptmanager-$latest_version/application.properties"
latest_version="$(cat /home/profittrailer/PTManager/version.txt)"
sudo bash -c "sed -i 's/^server.caddy.domain=.*/server.caddy.domain=$new_domain/' $application_properties_path"

# 6. Restart Caddy
sudo systemctl restart caddy

# 7. Start ProfitTrailer Manager using the existing script
/home/profittrailer/PTInstall/PTManager/start_PTManager.sh "yes"