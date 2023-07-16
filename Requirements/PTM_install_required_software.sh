#!/bin/bash

# Install required software
sudo apt-get install -y software-properties-common
sudo apt update

# Optional, on some systems this is missing
sudo apt-get install -y apt-transport-https ca-certificates

# Check if Java 8 is already installed
if ! command -v java &> /dev/null
then
    # Download Java 8
    wget -O /tmp/openjdk8.tar.gz https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u362-b09/OpenJDK8U-jdk_x64_linux_hotspot_8u362b09.tar.gz

    # Extract Java 8 to /opt directory
    sudo tar xzf /tmp/openjdk8.tar.gz -C /opt/

    # Set Java 8 as default
    sudo update-alternatives --install /usr/bin/java java /opt/jdk8u362-b09/bin/java 100
    sudo update-alternatives --install /usr/bin/javac javac /opt/jdk8u362-b09/bin/javac 100
fi

# Check if Node.js 14.x is already installed
if ! command -v node &> /dev/null
then
    # Install Node.js 14.x
    curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
    sudo apt-get install -y nodejs
fi

# Check if curl is already installed
if ! command -v curl &> /dev/null
then
    # Install curl
    sudo apt-get install -y curl
fi

# Check if npm is already installed
if ! command -v npm &> /dev/null
then
    # Install npm
    sudo apt-get install -y npm
fi

# Check if PM2 is already installed
if ! command -v pm2 &> /dev/null
then
    # Install PM2
    sudo npm install pm2@latest -g
fi

# Check if unzip is already installed
if ! command -v unzip &> /dev/null; then
    echo "unzip is not installed. Installing..."
    sudo apt-get install unzip -y
fi
