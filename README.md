PTFeeder and PTManager Installer Scripts
This project contains a collection of Bash scripts for installing and managing PTFeeder and PTManager on your server. PTFeeder is an add-on for the ProfitTrailer trading bot that provides dynamic settings based on market conditions. PTManager is a web interface that allows you to manage your ProfitTrailer and PTFeeder instances.

Requirements
A server with a Unix-based operating system.
ProfitTrailer licenses.

Script Overview
Index.sh: This is the main script that you should run. It displays a menu with various options, such as installing PTFeeder, installing PTManager, and running updates.

PTFeederInstall.sh: This script installs PTFeeder on your server. It downloads the latest version of PTFeeder, unpacks the files, and copies them to the specified directory.

PTFeederUpdate.sh: This script updates your PTFeeder installation to the latest version. It stops PTFeeder, downloads the latest version, replaces the old files, and restarts PTFeeder.

start_PTManager.sh and stop_PTManager.sh: These scripts start and stop the PTManager service, respectively.

Help and Feedback
If you need help or want to provide feedback, please open an issue in this repository or contact me at Discord - Herb0002





Guide to Install PT Manager on Linux
Open the terminal on your Linux system.

Create a new user named profittrailer:
sudo adduser profittrailer

Grant profittrailer user sudo permissions:
sudo usermod -aG sudo profittrailer

Switch to the profittrailer user:
su - profittrailer

Note: You can also run the installation as the root user, but this is not recommended for security reasons.

Switch to the profittrailer user's home directory:
cd /home/profittrailer

Download the latest version of the installation scripts from GitHub, wie the git clone command:
git clone https://github.com/Herb0002/PTInstall.git

Note: The git clone command requires that git is installed on your system. If git is not installed, you can install it with the following command:
sudo apt-get install git

Make the main installation script (Index.sh) executable:
chmod +x Index.sh

Run the installation/update script:
sudo ./Index.sh

Wait for the installation to complete. At the end of the script execution, you will receive a random key and a link to log in to PT Manager.

Congratulations! You have successfully installed PT Manager on your Linux system.
