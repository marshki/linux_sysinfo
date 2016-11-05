#!/bin/bash
# Debian 8 
# Run as root!

### Back that thing up in case shit gets cray ###
cp -rv /etc/apt/sources.list /etc/apt/sources.list.bak

### Grab Google pub key, then add Chrome & Talk to /etc/apt/sources.list ###

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -

echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
echo "deb http://dl.google.com/linux/talkplugin/deb/ stable main" >> /etc/apt/sources.list.d/google.list

### Add Java pub key, then add to /etc/apt/sources.list ###
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886

echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main"  >> /etc/apt/sources.list.d/java-8-debian.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list.d/java-8-debian.list

echo debconf shared/accepted-oracle-license-v1-1 select true | \
debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | \
debconf-set-selections 

### Update the repos ###
apt-get update

### Now, add the software and a few other essentials ###
apt-get install -y google-chrome-stable google-talkplugin oracle-java8-installer flashplugin-nonfree pinta ttf-mscorefonts-installer

### Comment out line number 3 in two Google files to avoid the duplicate apt-get upgrade error ###
sed -i '3 s/^/#/' /etc/apt/sources.list.d/google-chrome.list
sed -i '3 s/^/#/' /etc/apt/sources.list.d/google-talkplugin.list

### Now, bring everythin up-to-date ###
apt-get update && apt-get upgrade -y 

