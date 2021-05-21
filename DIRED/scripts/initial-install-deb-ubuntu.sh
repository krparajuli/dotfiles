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

# Shell customizations with oh-my-zsh and other plugins
# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
source ~/.zshrc
# Get powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i 's/ZSH_THEME.*/ZSH_THEME=\"powerlevel10k\/powerlevel10k\"/g' ~/.zshrc
# Get zsh-autosuggestions plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions


# Install powerlevel10k terminal customizations
mkdir $HOME/.local/share/fonts
cd $HOME/.local/share/fonts
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
fc-cache -f -v

# Install powerlevel10k
mkdir ~/.Applications
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.Applications/powerlevel10k
echo 'source ~/.Applications/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc

# Disable CapsLock and set it to ESC and long press to Ctrl
apt install xcape   # check ~/.config/autostart for configs

# Network tools
apt install net-tools

# Neovim as default
apt install neovim
cp /usr/bin/vim /usr/bin/ovim
rm /usr/bin/vim
ln -s /usr/bin/nvim /usr/bin/vim
