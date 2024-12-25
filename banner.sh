#!/bin/bash
# Create an SSH banner
sudo echo "*****************************************************************" > /etc/issue.net
sudo echo "* Warning: Unauthorized access to this system is prohibited. *" >> /etc/issue.net
sudo echo "* All activity is monitored and reported.                      *" >> /etc/issue.net
sudo echo "*****************************************************************" >> /etc/issue.net

# Configure SSH to use the banner
sudo sed -i 's/^#Banner none/Banner \/etc\/issue.net/' /etc/ssh/sshd_config

# Restart SSH service
sudo systemctl restart sshd
