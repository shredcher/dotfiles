# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Disable the default Oh My Zsh theme to use Starship
ZSH_THEME=""

# Plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions)

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Aliases
alias update='sudo apt update && sudo apt upgrade -y'
alias c='clear'
alias h='history'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ca="conda activate"
alias cap="conda activate primary"
alias e="exit"
alias n="nvim"
alias gc="git clone"

# rust alias
alias car="cargo run -q"

# Enable completion caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# # Faster completion
# zstyle ':completion:*' accept-exact '*(N)'
# zstyle ':completion:*' use-ip true

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Enable menu selection for completion
zstyle ':completion:*' menu select=interactive

# History settings
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt APPEND_HISTORY


# Conda initialization (lazy-loaded)
conda_init() {
  __conda_setup="$('/home/shred/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/home/shred/anaconda3/etc/profile.d/conda.sh" ]; then
          . "/home/shred/anaconda3/etc/profile.d/conda.sh"
      else
          export PATH="/home/shred/anaconda3/bin:$PATH"
      fi
  fi
  unset __conda_setup
}

# Lazy-load conda
conda() {
  unfunction "$0"
  conda_init
  $0 "$@"
}


. "$HOME/.cargo/env"


eval "$(starship init zsh)"


export PATH=$HOME/.local/bin:$PATH
