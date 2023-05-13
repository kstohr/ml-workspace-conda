#!/bin/bash

# This script is used to create ssh keys 

# install ssh server 
apt-get update && apt install openssh-server

# check it is running 
echo systemctl status ssh

echo "Hello! Please enter your user name:"

read user_name

echo "Press enter to generate default RSA key:"

echo "Run the following command, and accept defaults:"
echo "ssh-keygen -t rsa -b 4096 -C \"${user_name}\""

echo "Copy the following key, and paste it into the SSH Key page on the Gitlab repo (skip the line starting with +, as that is just the command being executed)"

set -x # echo all commands
cat ~/.ssh/id_rsa.pub
