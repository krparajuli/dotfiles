#!/usr/bin/env sh

sudo apt update -y
sudo apt upgrade -y

# Install python and ansible
sudo apt install python3 curl git
curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py
python3 /tmp/get-pip.py --user
python3 -m pip install --user ansible

# Clone dotfiles
mkdir ~/MyApplications
cd ~/MyApplications
git clone https://github.com/krparajuli/dotfiles

# Ansible get playbook
ansible-playbook ~/MyApplications/dotfiles/playbook/all.yaml