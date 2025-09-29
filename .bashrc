
# ~/.bashrc: executed by bash(1) for non-login shells.
# See /usr/share/doc/bash/examples/startup-files (in the package bash-doc) for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# Configure history settings
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# Check and update the window size after each command
shopt -s checkwinsize

# Set a fancy prompt
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# Uncomment for a colored prompt (if the terminal supports it)
# force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# Set the title for xterm
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Enable color support for ls and add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Colored GCC warnings and errors
# export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Additional ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long-running commands
# Usage: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Include user-defined aliases from ~/.bash_aliases, if present
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Enable programmable completion features
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# Add ~/.local/bin to the PATH
PATH="$HOME/.local/bin:$PATH"

PATH="$HOME/.local/bin:$PATH"

# Basic Git aliases
alias gs='git status -uno'
alias gss='git status'
alias ga='git add'
alias gas='git add -u'
alias gax='git add . && git reset -- "*service.js"'
alias gc='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gd='git diff'
alias gds='git diff --staged'
alias gco='git checkout'
alias gcon='git checkout -b'
alias gb='git branch'
alias gl='git log --oneline --graph --decorate'
alias grs='git restore --staged'
alias grsu='git restore --staged utils/env.service.js'

# Shortcut for fetching and pulling
alias gfp='git fetch && git pull'

# Show modified files in last commit
alias glm='git log --name-only --pretty=format: --diff-filter=M | sed "/^$/d"'

# Git stash shortcuts
alias gst='git stash'
alias gsta='git stash apply'
alias gstp='git stash pop'
alias gstl='git stash list'

# Git reset hard - use with caution!
alias grh='git reset --hard'

# Git commit amend with no edit
alias gca='git commit --amend --no-edit'

# Git push force with lease (safer than force push)
alias gpf='git push --force-with-lease'

# Cleans up branchs already merged into target
alias clean='clean_stage_func() { git fetch -ap && git pull && git branch -d $(git branch --merged="$1" | grep -v "$1") && git status; }; clean_stage_func'

# Show current branch name
alias gcb='git rev-parse --abbrev-ref HEAD'

# List all branches sorted by last modified
alias gbb='git for-each-ref --sort="-authordate" --format="%(authordate)%09%(objectname:short)%09%(refname)" refs/heads | sed -e "s-refs/heads/--"'

# Undo last commit
alias gundo='git reset HEAD~'

# Interactive rebase with the given number of latest commits
alias gri='f() { git rebase -i HEAD~$1; }; f'

# Show verbose output about tags, branches, or remotes
alias gtv='git tag | sort -V'
alias gbv='git branch -v'
alias grv='git remote -v'

# alias just for the simplehuman repo to go home to the main dir of the project
alias home='cd ~/Development/Simplehuman/simplehuman-IoT-backend-AWS/ && clear'

# Fixing issue where bash cannot find aws sam 
alias sam="/c/Program\ Files/Amazon/AWSSAMCLI/bin/sam.cmd"

# Node 
alias ni='node index'

alias reload_bash='source ~/.bashrc'

