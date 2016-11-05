#!/bin/bash
#Debian 8 
#Need to update gpg key, etc., but a good template 
#Run as root!

#Back that thing up in case shit gets cray
cp -rv /etc/apt/sources.list /etc/apt/sources.list.bak

#Grab Google pub key, then add Chrome & Talk to /etc/apt/sources.list 
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
echo "deb http://dl.google.com/linux/talkplugin/deb/ stable main" >> /etc/apt/sources.list.d/google.list

#Grab Spotify pub key, then add to /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59 
echo "deb http://repository.spotify.com stable non-free" >> /etc/apt/sources.list.d/spotify.list

#Accept Java license, etc. and then add Oracle Java 7 PPA
echo debconf shared/accepted-oracle-license-v1-1 select true | \
debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | \
debconf-set-selections 
add-apt-repository ppa:webupd8team/java

#Add Pidgin chat PPA
add-apt-repository -y ppa:pidgin-developers/ppa

#Add Pinta draw PPA
add-apt-repository -y ppa:pinta-maintainers/pinta-stable

#Add VLC multi-media PPA
add-apt-repository -y ppa:videolan/stable-daily

#Update the repos
apt-get update

#Now, add the software and a few other essentials 
apt-get install -y flashplugin-installer google-chrome-stable google-talkplugin oracle-java7-installer pidgin pinta spotify-client vlc ttf-mscorefonts-installer

#Comment out line number 3 in two Google files to avoid the duplicate apt-get upgrade error   
sed -i '3 s/^/#/' /etc/apt/sources.list.d/google-chrome.list
sed -i '3 s/^/#/' /etc/apt/sources.list.d/google-talkplugin.list

#Upgrade stuff
apt-get upgrade -y

