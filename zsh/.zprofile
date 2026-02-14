# Use .zprofile for:
# PATH modifications
# Environment variables (JAVA_HOME, etc.)
# One-time startup programs
#
# Use .zshrc for: Aliases (alias ll='ls -la')
# Shell functions
# Prompt configuration (PS1)
# Shell options (setopt commands)
# Key bindings
# Auto-completions

# Rust
. "$HOME/.cargo/env" 

# Golang
export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Python
source $HOME/.Applications/PyVenv/bin/activate

# direnv
source <(direnv hook zsh)

# IMPORTS
IMPORTS_DIR="$HOME/.config/zsh_imports"

# KUBECONFIGS
for i in "$HOME"/.kube/*; do
  case "$(basename "$i")" in
    cache|cache.yaml) continue ;;   # files to exclude
  esac
  export KUBECONFIG="$i:$KUBECONFIG"
done

