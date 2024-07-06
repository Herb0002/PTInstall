PTFeeder and PTManager Installer Scripts
This project contains a collection of Bash scripts for installing and managing PTFeeder and PTManager on your server. PTFeeder is an add-on for the ProfitTrailer trading bot that provides dynamic settings based on market conditions. PTManager is a web interface that allows you to manage your ProfitTrailer and PTFeeder instances.

Requirements
A server with a Unix-based operating system. ( i have tested it with ubuntu 22.04 )
ProfitTrailer licenses.

Guide to Install PT Manager on Linux
Open the terminal on your Linux system.

Create a new user named profittrailer:
```
sudo adduser profittrailer
```
Grant profittrailer user sudo permissions:
```
sudo usermod -aG sudo profittrailer
```
Switch to the profittrailer user:
```
su - profittrailer
```
Note: You can also run the installation as the root user, but this is not recommended for security reasons.

Switch to the profittrailer user's home directory:
```
cd /home/profittrailer
```
Download the latest version of the installation scripts from GitHub, wie the git clone command:
```
git clone https://github.com/Herb0002/PTInstall.git
```
Note: The git clone command requires that git is installed on your system. If git is not installed, you can install it with the following command:
```
sudo apt-get install git
```
Navigate to the downloaded directory with the cd command: 
```
cd /home/profittrailer/PTInstall
```

Make the main installation script (Index.sh) executable:
```
chmod +x Index.sh
```
Run the installation/update script:
```
./Index.sh
```

Wait for the installation to complete. At the end of the script execution, you will receive a random key and a link to log in to PT Manager.

If you need help or want to provide feedback, please open an issue in this repository or contact me at Discord - Herb0002

Congratulations! You have successfully installed PT Manager on your Linux system.
