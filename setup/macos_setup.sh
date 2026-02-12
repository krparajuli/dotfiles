#!/bin/bash

# macOS Development Environment Setup Script
# This script installs and configures your development environment

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    log_error "This script is for macOS only!"
    exit 1
fi

echo "=================================================="
echo "  macOS Development Environment Setup"
echo "=================================================="
echo ""

# ============================================
# PART 1: COLLECT USER INPUTS
# ============================================

log_info "Collecting required information..."
echo ""

# Git configuration
read -p "Enter your Git name (e.g., John Doe): " GIT_NAME
read -p "Enter your Git email (e.g., john@example.com): " GIT_EMAIL

echo ""
log_info "Great! Now let's choose which additional applications to install."
echo ""

# ============================================
# PART 2: OPTIONAL APPLICATIONS
# ============================================

echo "Select applications to install (enter comma-separated numbers, or 'all' for everything):"
echo ""
echo "Development Tools:"
echo "  1.  Visual Studio Code"
echo "  2.  Neovim"
echo "  3.  Helix"
echo "  4.  Zed"
echo "  5.  Node.js & npm"
echo "  6.  Python 3"
echo "  7.  JetBrains Toolbox"
echo ""
echo "Terminal & Shell Tools:"
echo "  8.  Oh My Zsh"
echo "  9.  Starship (shell prompt)"
echo "  10. tmux"
echo "  11. fzf (fuzzy finder)"
echo "  12. bat (better cat)"
echo "  13. eza (better ls)"
echo "  14. zoxide (smarter cd)"
echo "  15. ripgrep (better grep)"
echo "  16. fd (better find)"
echo "  17. btop (system monitor)"
echo ""
echo "Development Utilities:"
echo "  18. Postman"
echo "  19. Insomnia"
echo "  20. TablePlus"
echo "  21. DBeaver"
echo "  22. Wireshark"
echo "  23. HTTPie"
echo "  24. jq (JSON processor)"
echo "  25. yq (YAML processor)"
echo ""
echo "Productivity & Communication:"
echo "  26. Raycast"
echo "  27. Alfred"
echo "  28. Obsidian"
echo "  29. Notion"
echo "  30. Slack"
echo "  31. Discord"
echo "  32. Zoom"
echo "  33. Rectangle (window manager)"
echo "  34. Magnet"
echo ""
echo "Browsers:"
echo "  35. Firefox"
echo "  36. Google Chrome"
echo "  37. Arc Browser"
echo ""
echo "Cloud & DevOps:"
echo "  38. AWS CLI"
echo "  39. Terraform"
echo "  40. kubectl"
echo "  41. Helm"
echo "  42. k9s"
echo ""
echo "Media & Design:"
echo "  43. VLC"
echo "  44. GIMP"
echo "  45. Inkscape"
echo "  46. OBS Studio"
echo "  47. Audacity"
echo ""
echo "Utilities:"
echo "  48. Karabiner-Elements"
echo "  49. iTerm2"
echo "  50. Alacritty"
echo "  51. The Unarchiver"
echo "  52. AppCleaner"
echo "  53. Maccy (clipboard manager)"
echo "  54. CopyQ"
echo "  55. 1Password"
echo ""
echo "Security & Privacy:"
echo "  56. Little Snitch"
echo "  57. Mullvad VPN"
echo "  58. Tailscale"
echo ""
echo "Recording & Automation:"
echo "  59. asciinema"
echo ""

read -p "Your selection (e.g., 1,5,8,13 or 'all' or 'none'): " SELECTION

# Parse selection
declare -A INSTALL_FLAGS
if [[ "$SELECTION" == "all" ]]; then
    for i in {1..59}; do
        INSTALL_FLAGS[$i]=1
    done
elif [[ "$SELECTION" == "none" ]]; then
    log_info "Skipping optional applications"
else
    IFS=',' read -ra NUMBERS <<< "$SELECTION"
    for num in "${NUMBERS[@]}"; do
        num=$(echo "$num" | tr -d ' ')
        if [[ "$num" =~ ^[0-9]+$ ]] && [ "$num" -ge 1 ] && [ "$num" -le 59 ]; then
            INSTALL_FLAGS[$num]=1
        fi
    done
fi

echo ""
log_info "Starting installation..."
echo ""

# ============================================
# PART 3: CORE INSTALLATIONS
# ============================================

log_info "Installing Homebrew..."
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Activate Homebrew
    echo >> /Users/kal/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/kal/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    log_success "Homebrew installed"
else
    log_success "Homebrew already installed"
fi

log_info "Installing core tools..."
brew install git
brew install bitwarden
brew install bitwarden-cli
brew install stow
brew install gh
brew install --cask brave-browser
brew install --cask claude
brew install --cask claude-code
brew install --cask docker
brew install --cask ghostty
brew install --cask libreoffice
brew install vagrant
brew install --cask vagrant-vmware-utility
log_success "Core tools installed"

# Configure Git
log_info "Configuring Git..."
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global init.defaultBranch main
log_success "Git configured"

# Create config directory
mkdir -p "$HOME/CONFIG"

# ============================================
# PART 4: RUST/CARGO
# ============================================

log_info "Installing Rust and Cargo..."
if ! command -v cargo &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    log_success "Rust installed"
else
    log_success "Rust already installed"
fi

# ============================================
# PART 5: GOLANG
# ============================================

log_info "Installing Go..."
brew install go

# Configure Go environment
mkdir -p "$HOME/go"
cat <<EOF >> ~/.zprofile

# Go configuration
export GOPATH="\${HOME}/.go"
export GOROOT="\$(brew --prefix golang)/libexec"
export PATH=\$PATH:\$GOPATH/bin
export PATH=\$PATH:\$GOROOT/bin
EOF

# Source the profile to get Go in current session
source ~/.zprofile

# Install Go tools
log_info "Installing Go development tools..."
go install golang.org/x/tools/cmd/godoc@latest
go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install golang.org/x/tools/cmd/goimports@latest
log_success "Go installed and configured"

# ============================================
# PART 6: OPTIONAL APPLICATIONS
# ============================================

# Development Tools
[[ ${INSTALL_FLAGS[1]} ]] && { log_info "Installing VS Code..."; brew install --cask visual-studio-code; }
[[ ${INSTALL_FLAGS[2]} ]] && { log_info "Installing Neovim..."; brew install neovim; }
[[ ${INSTALL_FLAGS[3]} ]] && { log_info "Installing Helix..."; brew install helix; }
[[ ${INSTALL_FLAGS[4]} ]] && { log_info "Installing Zed..."; brew install --cask zed; }
[[ ${INSTALL_FLAGS[5]} ]] && { log_info "Installing Node.js..."; brew install node; }
[[ ${INSTALL_FLAGS[6]} ]] && { log_info "Installing Python3..."; brew install python3; }
[[ ${INSTALL_FLAGS[7]} ]] && { log_info "Installing JetBrains Toolbox..."; brew install --cask jetbrains-toolbox; }

# Terminal & Shell Tools
if [[ ${INSTALL_FLAGS[8]} ]]; then
    log_info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi
[[ ${INSTALL_FLAGS[9]} ]] && { log_info "Installing Starship..."; brew install starship; }
[[ ${INSTALL_FLAGS[10]} ]] && { log_info "Installing tmux..."; brew install tmux; }
[[ ${INSTALL_FLAGS[11]} ]] && { log_info "Installing fzf..."; brew install fzf; }
[[ ${INSTALL_FLAGS[12]} ]] && { log_info "Installing bat..."; brew install bat; }
[[ ${INSTALL_FLAGS[13]} ]] && { log_info "Installing eza..."; brew install eza; }
[[ ${INSTALL_FLAGS[14]} ]] && { log_info "Installing zoxide..."; brew install zoxide; }
[[ ${INSTALL_FLAGS[15]} ]] && { log_info "Installing ripgrep..."; brew install ripgrep; }
[[ ${INSTALL_FLAGS[16]} ]] && { log_info "Installing fd..."; brew install fd; }
[[ ${INSTALL_FLAGS[17]} ]] && { log_info "Installing btop..."; brew install btop; }

# Development Utilities
[[ ${INSTALL_FLAGS[18]} ]] && { log_info "Installing Postman..."; brew install --cask postman; }
[[ ${INSTALL_FLAGS[19]} ]] && { log_info "Installing Insomnia..."; brew install --cask insomnia; }
[[ ${INSTALL_FLAGS[20]} ]] && { log_info "Installing TablePlus..."; brew install --cask tableplus; }
[[ ${INSTALL_FLAGS[21]} ]] && { log_info "Installing DBeaver..."; brew install --cask dbeaver-community; }
[[ ${INSTALL_FLAGS[22]} ]] && { log_info "Installing Wireshark..."; brew install --cask wireshark; }
[[ ${INSTALL_FLAGS[23]} ]] && { log_info "Installing HTTPie..."; brew install httpie; }
[[ ${INSTALL_FLAGS[24]} ]] && { log_info "Installing jq..."; brew install jq; }
[[ ${INSTALL_FLAGS[25]} ]] && { log_info "Installing yq..."; brew install yq; }

# Productivity & Communication
[[ ${INSTALL_FLAGS[26]} ]] && { log_info "Installing Raycast..."; brew install --cask raycast; }
[[ ${INSTALL_FLAGS[27]} ]] && { log_info "Installing Alfred..."; brew install --cask alfred; }
[[ ${INSTALL_FLAGS[28]} ]] && { log_info "Installing Obsidian..."; brew install --cask obsidian; }
[[ ${INSTALL_FLAGS[29]} ]] && { log_info "Installing Notion..."; brew install --cask notion; }
[[ ${INSTALL_FLAGS[30]} ]] && { log_info "Installing Slack..."; brew install --cask slack; }
[[ ${INSTALL_FLAGS[31]} ]] && { log_info "Installing Discord..."; brew install --cask discord; }
[[ ${INSTALL_FLAGS[32]} ]] && { log_info "Installing Zoom..."; brew install --cask zoom; }
[[ ${INSTALL_FLAGS[33]} ]] && { log_info "Installing Rectangle..."; brew install --cask rectangle; }
[[ ${INSTALL_FLAGS[34]} ]] && { log_info "Installing Magnet..."; brew install --cask magnet; }

# Browsers
[[ ${INSTALL_FLAGS[35]} ]] && { log_info "Installing Firefox..."; brew install --cask firefox; }
[[ ${INSTALL_FLAGS[36]} ]] && { log_info "Installing Chrome..."; brew install --cask google-chrome; }
[[ ${INSTALL_FLAGS[37]} ]] && { log_info "Installing Arc..."; brew install --cask arc; }

# Cloud & DevOps
[[ ${INSTALL_FLAGS[38]} ]] && { log_info "Installing AWS CLI..."; brew install awscli; }
[[ ${INSTALL_FLAGS[39]} ]] && { log_info "Installing Terraform..."; brew install terraform; }
[[ ${INSTALL_FLAGS[40]} ]] && { log_info "Installing kubectl..."; brew install kubectl; }
[[ ${INSTALL_FLAGS[41]} ]] && { log_info "Installing Helm..."; brew install helm; }
[[ ${INSTALL_FLAGS[42]} ]] && { log_info "Installing k9s..."; brew install k9s; }

# Media & Design
[[ ${INSTALL_FLAGS[43]} ]] && { log_info "Installing VLC..."; brew install --cask vlc; }
[[ ${INSTALL_FLAGS[44]} ]] && { log_info "Installing GIMP..."; brew install --cask gimp; }
[[ ${INSTALL_FLAGS[45]} ]] && { log_info "Installing Inkscape..."; brew install --cask inkscape; }
[[ ${INSTALL_FLAGS[46]} ]] && { log_info "Installing OBS Studio..."; brew install --cask obs; }
[[ ${INSTALL_FLAGS[47]} ]] && { log_info "Installing Audacity..."; brew install --cask audacity; }

# Utilities
[[ ${INSTALL_FLAGS[48]} ]] && { log_info "Installing Karabiner-Elements..."; brew install --cask karabiner-elements; }
[[ ${INSTALL_FLAGS[49]} ]] && { log_info "Installing iTerm2..."; brew install --cask iterm2; }
[[ ${INSTALL_FLAGS[50]} ]] && { log_info "Installing Alacritty..."; brew install --cask alacritty; }
[[ ${INSTALL_FLAGS[51]} ]] && { log_info "Installing The Unarchiver..."; brew install --cask the-unarchiver; }
[[ ${INSTALL_FLAGS[52]} ]] && { log_info "Installing AppCleaner..."; brew install --cask appcleaner; }
[[ ${INSTALL_FLAGS[53]} ]] && { log_info "Installing Maccy..."; brew install --cask maccy; }
[[ ${INSTALL_FLAGS[54]} ]] && { log_info "Installing CopyQ..."; brew install --cask copyq; }
[[ ${INSTALL_FLAGS[55]} ]] && { log_info "Installing 1Password..."; brew install --cask 1password; }

# Security & Privacy
[[ ${INSTALL_FLAGS[56]} ]] && { log_info "Installing Little Snitch..."; brew install --cask little-snitch; }
[[ ${INSTALL_FLAGS[57]} ]] && { log_info "Installing Mullvad VPN..."; brew install --cask mullvadvpn; }
[[ ${INSTALL_FLAGS[58]} ]] && { log_info "Installing Tailscale..."; brew install --cask tailscale; }

# Recording & Automation
[[ ${INSTALL_FLAGS[59]} ]] && { log_info "Installing asciinema..."; brew install asciinema; }

# ============================================
# PART 7: CLEANUP & FINAL STEPS
# ============================================

log_info "Cleaning up..."
brew cleanup

echo ""
echo "=================================================="
log_success "Installation complete!"
echo "=================================================="
echo ""
echo "Summary:"
echo "  - Homebrew installed and configured"
echo "  - Git configured with:"
echo "      Name: $GIT_NAME"
echo "      Email: $GIT_EMAIL"
echo "  - Core development tools installed"
echo "  - Rust/Cargo installed"
echo "  - Go installed with development tools"
echo "  - Selected applications installed"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zprofile"
echo "  2. Configure your preferred shell tools"
echo "  3. Set up your dotfiles using stow"
echo ""
log_info "Enjoy your new development environment!"
