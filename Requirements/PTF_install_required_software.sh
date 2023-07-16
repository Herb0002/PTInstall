#!/bin/bash

echo "Installing required software for PTFeeder"

# Update package lists
sudo apt update

# Install required packages
sudo apt install -y apt-transport-https ca-certificates wget software-properties-common

# Add the Microsoft package source, product key and package repository
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

# Update the package lists again
sudo apt update

# Install the .NET SDK 7.0
sudo apt install -y dotnet-sdk-7.0

echo "Required software for PTFeeder installed successfully"