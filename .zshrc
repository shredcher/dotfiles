# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Disable the default Oh My Zsh theme to use Starship
ZSH_THEME=""

# Enhanced plugin list
plugins=(
    git 
    zsh-autosuggestions 
    zsh-syntax-highlighting 
    zsh-completions 
    web-search 
    eza
    extract
    colored-man-pages
    command-not-found
    history-substring-search
)

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Advanced completion system
autoload -Uz compinit && compinit
autoload zmv # Enable mass file renaming

# Aliases
alias update='sudo pacman -Suy'
alias c='clear'
alias h='history'

# Enhanced eza aliases
alias ls='eza --color=auto --icons'
alias ll='eza -alF --color=auto --icons'
alias la='eza -a --color=auto --icons'
alias l='eza -F --color=auto --icons'
alias lt='eza --tree --color=auto --icons'
alias lg='eza --git-ignore --color=auto --icons'

# Development aliases
alias ca="conda activate"
alias cap="conda activate primary"
alias e="exit"
alias n="nvim"
alias gc="git clone"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# rust alias
alias car="cargo run -q"

# Directory navigation
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS

# History improvements
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt SHARE_HISTORY

# Enable completion caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Faster completion
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-ip true

# Advanced completion configuration
zstyle ':completion:*' menu select interactive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^R' history-incremental-search-backward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# Lazy load conda
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

# Path configurations
export PATH=$HOME/.local/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"

# Source cargo environment
. "$HOME/.cargo/env"

# Initialize starship prompt
eval "$(starship init zsh)"
