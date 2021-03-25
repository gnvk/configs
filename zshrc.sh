#!/bin/zsh

export ZSH="$HOME/.oh-my-zsh"
ZSH_HIGHLIGHT_MAXLENGTH=300
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_TMUX_AUTOSTART=true

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS=true

plugins=(
    colored-man-pages
    fzf
    tmux
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

### User configuration

# Environment
fd() {
    if [ -z "$1" ]; then
        echo "Usage: fd <dir>"
        return
    fi
    depth=0
    while :
    do
        result=$(find . -type d -mindepth $depth -maxdepth $depth -not -path '*/\.*' -name "$1" -print -quit 2>/dev/null)
        if [[ -n "$result" ]]; then
            echo "Changed directory to $result"
            cd "$result"
            break
        fi
        anything=$(find . -type d -mindepth $depth -maxdepth $depth -not -path '*/\.*' -print -quit 2>/dev/null)
        if [[ -z "$anything" ]]; then
            echo "Couldn't find '$1' in this directory hierarchy."
            break
        fi
        depth=$((depth+1))
    done
}
alias ll="ls -lah"
alias look="find . -name"
alias ports="lsof -PiTCP -sTCP:LISTEN"
export PATH="$PATH:/usr/local/sbin:/opt/local/bin:/opt/local/sbin"
export PATH="$PATH:$HOME/Dev/configs"

# Git
alias gs='git status'
alias gc='git checkout'
alias gl='git log --decorate --date=short --pretty=format:"%C(auto)%h %C(cyan)%ad%Creset %Cgreen%cN %C(auto)%d%Creset %s" --graph'
alias gl5='git --no-pager log -n 5 --decorate --date=short --pretty=format:"%C(auto)%h %C(cyan)%ad%Creset %Cgreen%cN %C(auto)%d%Creset %s" --graph'
alias gg='gl --grep'

# Go
export GOPATH="$HOME/Dev/go"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:/usr/local/go/bin:/usr/local/kubebuilder/bin"

# Kubernetes
alias k='kubectl'
alias kpod='k get pods '
alias kpodt='kpod --sort-by=.status.startTime '
alias kpoda='kpods --all-namespaces '
alias kjob='k get jobs '
alias kjobt='kjob --sort-by=.status.startTime '
alias kdesc='k describe '
alias kns='k config set-context $(k config current-context) --namespace '
alias kcontext='k config use-context '
source <(kubectl completion zsh)

# Powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Python
export PATH="$PATH:$HOME/.pyenv/bin"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
venv() {
    if (( $# == 0 )) then
        dir="${PWD##*/}"
    else
        dir=$1
    fi
    pyenv activate "$dir"
}
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Web dev
export PATH="$PATH:$HOME/.npm-global/bin"

# Terminal
precmd() {
    # Rename tmux window to the current dir's basename
    if [ "$PWD" != "$LPWD" ];
    then
        LPWD="$PWD"
        if [ "$PWD" = "$HOME" ]; then name="~"; else name="${PWD//*\//}"; fi
        tmux rename-window "$name"; fi
    }
HISTSIZE=10000000
setopt HIST_IGNORE_ALL_DUPS
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TERM=xterm-256color

# OS specific
case $(uname -s) in
    Linux*)     source "$HOME/.zshrc.linux";;
    Darwin*)    source "$HOME/.zshrc.mac";;
esac

# Custom
if [ -f "$HOME/.zshrc.custom" ]; then
    source "$HOME/.zshrc.custom"
fi
