#!/bin/sh

# Basic python
apt install -y git curl python3 

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
apt install python3-distutils python3-apt python3-testresources
export PATH=$PATH:$HOME/.local/bin
python3 get-pip.py
apt install ubuntu-restricted-extras chrome-gnome-shell

# Shell stuff
apt install -y zsh tmux
chsh -s $(which zsh)

# Editors and Optimizations
apt install -y vim 

# TLDR manual and borpages
apt install -y gcc g++  make cmake
apt install -y ruby-full tldr
gem install bropages


# Install find and locate
apt install -y findutils mlocate

# Install powerlevel10k terminal customizations
mkdir $HOME/.local/share/fonts
cd $HOME/.local/share/fonts
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
fc-cache -f -v

mkdir ~/.Applications
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.Applications/powerlevel10k
echo 'source ~/.Applications/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc


