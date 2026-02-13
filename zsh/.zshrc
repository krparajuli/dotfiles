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

HISTFILE=~/.zsh_history    # Where to save history
HISTSIZE=20000             # Lines to keep in memory
SAVEHIST=200000             # Lines to save to file

# Optional useful settings:
setopt HIST_IGNORE_DUPS    # Don't save duplicate commands
setopt HIST_IGNORE_SPACE   # Don't save commands starting with space
setopt SHARE_HISTORY       # Share history between sessions
setopt APPEND_HISTORY      # Append rather than overwrite

# Claude Ask queries in terminal
c() {
  echo $@
  claude -p --model claude-haiku-4-5-20251001 -- "$@"
}

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/kal/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# Kubernetes CLI completion
source <(kubectl completion zsh)
alias k=kubectl
complete -o default -F __start_kubectl k

# IMPORTS
IMPORTS_DIR="$HOME/.config/zsh_imports"
[ -d $IMPORTS_DIR ] && for file in $IMPORTS_DIR/*; do
  source "$file"
done

