#!/bin/bash

echo "Installing caddy"

echo "Stopping PT Manager..."
/home/profittrailer/PTInstall/PTManager/stop_PTManager.sh

# Check if Apache2 is installed
if [ -x "$(command -v apache2)" ]; then
    while true; do
        echo -e "\033[31mWARNING: Apache2 is currently installed and needs to be removed before installing Caddy.\033[0m"
        echo -e "\033[31mBy proceeding, you agree to stop and remove Apache2 from your system.\033[0m"
        echo -e "\033[31mDo you want to proceed? (Type 'Y' or 'N'):\033[0m"
        read answer

        if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
            sudo systemctl stop apache2
            sudo apt-get remove -y apache2
            sudo apt-get purge -y apache2
            sudo apt-get autoremove -y
            break
        elif [[ "$answer" == "n" || "$answer" == "N" ]]; then
            echo "Skipping caddy installation"
            exit 0
        else
            echo "Invalid input. Please type 'Y' or 'N'."
        fi
    done
fi
        
# Check if Caddy is not installed
if ! [ -x "$(command -v caddy)" ]; then
  sudo apt update
  sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https curl

  # Download and install the Caddy GPG key
  curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg

  # Add the Caddy repository
  echo "deb [signed-by=/usr/share/keyrings/caddy-stable-archive-keyring.gpg] https://dl.cloudsmith.io/public/caddy/stable/deb/ubuntu $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/caddy-stable.list

  # Update package list and install Caddy
  sudo apt update
  sudo apt install -y caddy

  # Check if Caddy installation was successful
  if ! [ -x "$(command -v caddy)" ]; then
    echo "Caddy installation failed. Please check the logs and try again."
    exit 1
  fi
else
  echo "Caddy is already installed."
fi

# Open ports 80 and 443
echo "Opening ports 80 and 443..."
sudo ufw allow 80
sudo ufw allow 443

# Ask for domain name
read -p "Enter your domain name (e.g. example.com): " domain_name

# Ask for email address
read -p "Enter your email address (e.g. email@example.com): " email_address

# Create the Caddyfile if it does not exist
caddyfile_path="/etc/caddy/Caddyfile"

if [ ! -f "$caddyfile_path" ]; then
    sudo touch "$caddyfile_path"
fi

# Add the configuration to the Caddyfile
sudo bash -c "cat > $caddyfile_path << EOL
$domain_name {
    reverse_proxy $domain_name:8080
    tls $email_address
}
EOL"

# The latest version of PTManager
latest_version="$(cat /home/profittrailer/PTManager/version.txt)"

# Path to application.properties
application_properties_path="/home/profittrailer/PTManager/ptmanager-$latest_version/application.properties"

# Add the required content to application.properties without overwriting existing content
sudo bash -c "echo -e '\n# Caddy settings\nserver.caddy.enabled=true\nserver.caddy.domain=$domain_name\n' >> $application_properties_path"

# Restart Caddy to apply changes
sudo systemctl restart caddy

# Wait for 30 seconds to allow Caddy to restart
sleep 30

echo "Caddy configuration updated with domain name and email address."
echo "application.properties updated with Caddy settings and domain name."
