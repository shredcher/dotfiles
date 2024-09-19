# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Disable the default Oh My Zsh theme to use Starship
ZSH_THEME=""

# Disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT="true"

# Plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting fzf zsh-completions)

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# User configuration
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Aliases
alias zshconfig="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"

# Custom aliases
alias zshconfig="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"
alias update='sudo apt update && sudo apt upgrade -y'
alias c='clear'
alias h='history'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias car="cargo run -q"
alias ca="conda activate"
alias e="exit"
alias n="nvim"
alias gc="git clone"


# Enable command-not-found if available
if [ -f /etc/zsh_command_not_found ]; then
    . /etc/zsh_command_not_found
fi

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


# FZF configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


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


# Add Docker Desktop to PATH
# export PATH=$PATH:/opt/docker-desktop/bin

# Starship prompt initialization
eval "$(starship init zsh)"
