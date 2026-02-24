# ~/.zshrc - macOS/Zsh configuration

# ─── Homebrew ────────────────────────────────────────────────

eval "$(/opt/homebrew/bin/brew shellenv)"

# ─── History ─────────────────────────────────────────────────

HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# ─── Completion ──────────────────────────────────────────────

autoload -Uz compinit && compinit

# ─── macOS Aliases ───────────────────────────────────────────

alias ls='ls -G'
alias grep='grep --color=auto'

# ─── Prompt ──────────────────────────────────────────────────

autoload -Uz colors && colors
PROMPT='%F{green}%n@%m%f:%F{blue}%~%f$ '

# ─── Source Shared Config ────────────────────────────────────

[ -f ~/.shell_common ] && source ~/.shell_common
