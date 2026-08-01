[[ $- != *i* ]] && return
alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='[\u@\h \W]\$ '

export EDITOR=nvim

export GOPATH=$HOME/.go
export PATH=$HOME/.local/bin:$GOPATH/bin:$HOME/.cargo/bin:$PATH
export WINEPREFIX=$HOME/Games/Wines/Staging

# export NO_AT_BRIDGE=1
export $(envsubst <$HOME/.sercrets)
