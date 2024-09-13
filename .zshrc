# Enable zsh profiling for performance analysis
zmodload zsh/zprof

# History settings
HISTSIZE=2000
SAVEHIST=2000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY_TIME

# Zsh-specific window size check (replacement for bash's checkwinsize)
function resize() {
  eval "$(/usr/bin/env - PATH="$PATH" which resize)"
}
trap resize WINCH

# Enable caching for faster command lookup
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh_cache

# Lazy-load completions for faster startup
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Use zinit for plugin management
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Load essential plugins
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice wait lucid
zinit light zsh-users/zsh-completions

# Load fzf for file finding (if installed)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Color support for ls and grep
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Aliases
alias l='ls --color'
alias ls='ls --color'
alias ll='ls -alF'
alias la='ls -A'
alias vi='nvim'
alias c='clear'
alias car='cargo run'
alias ca='conda activate'
alias cap='conda activate primary'

# Alert alias for long running commands
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Source bash aliases if exists
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Conda initialization (only if needed)
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

# Add Cargo to PATH
. "$HOME/.cargo/env"

# Disable unused features
unsetopt CASE_GLOB
setopt NO_BEEP

# Initialize Starship prompt
eval "$(starship init zsh)"

# Environment variables
export PATH=$HOME/.local/bin:$PATH

# Rust-related environment variables
export RUSTC_WRAPPER=""
export RUST_BACKTRACE=1

# Editor-related environment variables
export EDITOR="code"
export VISUAL="code"

# Ensure local bin directories are in PATH
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Add Cursor editor to PATH if it exists
if [ -d "$HOME/.cursor/bin" ]; then
    export PATH="$HOME/.cursor/bin:$PATH"
fi

# Add any other custom environment variables or PATH additions here

# Function to reload zsh configuration
function reload_zsh() {
    source ~/.zshrc
    echo "ZSH config reloaded!"
}

# Load any local customizations
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi
