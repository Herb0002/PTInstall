PTManager and PTFeeder Installer for Linux
This repository contains scripts to install and update PTManager and PTFeeder on Linux systems (tested with Ubuntu 22.04).

Features Included:
PTManager Installation Requirements ✅
PTManager Fresh Install + Config Guide ✅
PTFeeder Installation Requirements ✅
PTFeeder Fresh Install + Config Guide ✅
Caddy Install + Config Guide for Auto SSL ✅
PTManager + PTFeeder Updater ✅
Guide to Install PT Manager on Linux
Open the terminal on your Linux system.

Add the Profittrailer user:

Copy code
sudo adduser Profittrailer
Grant sudo permissions:

Copy code
sudo usermod -aG sudo Profittrailer
Note: You can also run as root user. In this case, you need to create the /home/Profittrailer directory yourself:

arduino
Copy code
mkdir /home/Profittrailer
Change to the home directory by typing the following command and pressing Enter:

bash
Copy code
cd /home/Profittrailer
Clone this repository into your /home/Profittrailer directory:

bash
Copy code
git clone [Your Repository URL]
Change to the cloned directory:

bash
Copy code
cd [Directory Name]
Make the installation script executable by typing the following command and pressing Enter:

bash
Copy code
chmod +x PTinstall.sh
Run the installation/update script by typing the following command and pressing Enter:

Copy code
sudo ./PTinstall.sh
Wait for the installation to complete. At the end of the script, you will receive a random key and the link to log in to PT Manager.

Congratulations! You have successfully installed PT Manager on your Linux system.
