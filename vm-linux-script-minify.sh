#!/bin/bash -x
#################  clean.sh  #####################
# Minifying the vm file system for transport
# Each of these commands shuts down, prunes, and removes all files
# Not necessary to the vm so it is as small as possible
# Happy hunting!
echo "stopping services..."

service apache2 stop
service jenkins stop
service jira stop
service mailhog stop
service mongodb stop
service mysql stop
service seeker stop
service tomcat8 stop

echo "cleaning Docker..."
docker container prune -a
docker image prune -a
docker volume prune
docker system prune -a

echo "cleaning apt-get..."
apt-get autoclean
apt-get autoremove
apt-get clean all
rm /var/lib/apt/lists/*

echo "remove swap..."
swapoff -a
free -m
rm /swapfile
rm -fr /var/backups/*
rm -fr /var/log/journal/*

for xxx in /var/log/* ; do cat < /dev/null > $xxx; done
for xxx in /var/log/*/* ; do cat < /dev/null > $xxx; done
for xxx in /var/log/*/*/* ; do cat < /dev/null > $xxx; done

echo "zeroing partitions..."
dd if=/dev/zero of=/0bits bs=4096K
rm /0bits

echo "ready to shut down..."
