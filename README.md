PTFeeder and PTManager Installer Scripts
This project contains a collection of Bash scripts for installing and managing PTFeeder and PTManager on your server. PTFeeder is an add-on for the ProfitTrailer trading bot that provides dynamic settings based on market conditions. PTManager is a web interface that allows you to manage your ProfitTrailer and PTFeeder instances.

Requirements
A server with a Unix-based operating system.
Curl and wget installed.
ProfitTrailer and PTManager licenses.
Installation
Clone the repository to your server: git clone <repository-url>
Change into the directory of the cloned repository: cd <repository-name>
Run the Index script: ./Index.sh
Follow the instructions in the menu.
Script Overview
Index.sh: This is the main script that you should run. It displays a menu with various options, such as installing PTFeeder, installing PTManager, and running updates.

PTFeederInstall.sh: This script installs PTFeeder on your server. It downloads the latest version of PTFeeder, unpacks the files, and copies them to the specified directory.

PTFeederUpdate.sh: This script updates your PTFeeder installation to the latest version. It stops PTFeeder, downloads the latest version, replaces the old files, and restarts PTFeeder.

start_PTManager.sh and stop_PTManager.sh: These scripts start and stop the PTManager service, respectively.

Help and Feedback
If you need help or want to provide feedback, please open an issue in this repository or contact me at Discord - Herb0002
