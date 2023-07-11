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

sudo adduser Profittrailer
Grant sudo permissions:


sudo usermod -aG sudo Profittrailer
Note: You can also run as root user. In this case, you need to create the /home/Profittrailer directory yourself:


mkdir /home/Profittrailer
Change to the home directory by typing the following command and pressing Enter:


cd /home/Profittrailer
Clone this repository into your /home/Profittrailer directory:


git clone https://github.com/Herb0002/PTInstall
Change to the cloned directory:


cd /home/Profittrailer/PTInstall
Make the installation script executable by typing the following command and pressing Enter:


chmod +x PTinstall.sh
Run the installation/update script by typing the following command and pressing Enter:


sudo ./PTinstall.sh
Wait for the installation to complete. At the end of the script, you will receive a random key and the link to log in to PT Manager.

Congratulations! You have successfully installed PT Manager on your Linux system.
