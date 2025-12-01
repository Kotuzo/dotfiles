# ========================
# Zsh Configuration (~/.zshrc)
# ========================

# ------------------------
# Powerlevel10k Instant Prompt (MUST be near the top)
# ------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------------------
# Conda initialization (generalized)
# ------------------------
if command -v conda &>/dev/null; then
    __conda_setup="$(conda shell.zsh hook 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    elif [ -f "$(conda info --base)/etc/profile.d/conda.sh" ]; then
        . "$(conda info --base)/etc/profile.d/conda.sh"
    else
        export PATH="$(conda info --base)/bin:$PATH"
    fi
    unset __conda_setup
fi

# ------------------------
# Powerlevel10k theme & config
# ------------------------
# Load theme first, then user config
[[ -f /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme ]] && \
    source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# ------------------------
# Zsh plugins
# ------------------------
[[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ------------------------
# Aliases & convenience tools
# ------------------------
alias ls="eza --icons=always"
alias ll="ls -lah"
alias make="gmake"
alias cd="z"  # zoxide shortcut
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# fzf key bindings (if installed)
[[ -x "$(command -v fzf)" ]] && source <(fzf --zsh)

# ------------------------
# Zoxide initialization
# ------------------------
eval "$(zoxide init zsh)"

# ------------------------
# Colors
# ------------------------
autoload -U colors && colors

# ------------------------
# History configuration
# ------------------------
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ------------------------
# Secrets / API Keys
# ------------------------
# Load secrets from a secure file (not committed)
[[ -f ~/.secrets ]] && source ~/.secrets

# ========================
# End of .zshrc
# ========================
