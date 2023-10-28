#!/bin/bash

# Ensure all required scripts are executable
for script in \
    PTManager/update_PTManager.sh \
    PTManager/install_PTManager.sh \
    PTManager/configure_PTManager.sh \
    PTManager/stop_PTManager.sh \
    PTManager/start_PTManager.sh \
    Caddy/install_caddy.sh \
    Caddy/edit_caddy.sh \
    PTFeeder/PTFeederUpdate.sh \
    PTFeeder/PTFeederInstall.sh \
    Requirements/PTF_install_required_software.sh \
    Requirements/PTM_install_required_software.sh
do
    if [[ -f $script && ! -x $script ]]; then
        sudo chmod +x $script
    fi
done

echo "What do you want to do?"
echo "1. Install PTManager"
echo "2. Update PTManager"
echo "3. Install PTFeeder"
echo "4. Update PTFeeder"
echo "5. Install Caddy"
echo "6. Edit Caddy"
read -p "Enter your choices (separated by spaces, e.g. '1 2 3 4 5 6'): " choices

install_caddy=false
install_ptmanager=false
for choice in $choices; do
    case $choice in
        1)
            ./Requirements/PTM_install_required_software.sh
            # Call the script to install PTManager
            ./PTManager/install_PTManager.sh

            # Configure PTManager
            ./PTManager/configure_PTManager.sh

            install_ptmanager=true
            ;;
        2)
            # Update PTManager
            ./PTManager/update_PTManager.sh
            ;;
        3)
            # Install PTFeeder
            ./Requirements/PTF_install_required_software.sh
            ./PTFeeder/PTFeederInstall.sh
            ;;
        4)
            # Update PTFeeder
            ./PTFeeder/PTFeederUpdate.sh
            ;;
        5)
            # Install Caddy
            ./Caddy/install_caddy.sh
            install_caddy=true
            ;;
        6)
            # Edit Caddy
            ./Caddy/edit_caddy.sh
            ;;
        *)
            echo "Invalid choice. Please enter 1, 2, 3, 4, 5, or 6."
            ;;
    esac
done

# If PTManager was installed, start it appropriately after all installations are done
if [ "$install_ptmanager" = true ]; then
    if [ "$install_caddy" = true ]; then
        ./PTManager/start_PTManager.sh "yes"
    else
        ./PTManager/start_PTManager.sh "no"
    fi
fi
