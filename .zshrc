ZSH=$HOME/.oh-my-zsh
ZSH_THEME="sorin"
CASE_SENSITIVE="true"

plugins=(git svn debian perl pip vi-mode)

setopt append_history
source $ZSH/oh-my-zsh.sh

if [ -f ~/.alias ]; then
    . ~/.alias
fi

if [ `which fortune` ]; then
    echo ""
    fortune
    echo ""
fi
