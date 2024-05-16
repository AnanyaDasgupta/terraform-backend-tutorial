#!/bin/bash

# Update package lists
sudo apt update -y

# Install Nginx
sudo apt install nginx -y

# Enable and start Nginx service
sudo systemctl enable nginx
sudo systemctl start nginx
