[[ $- != *i* ]] && return
alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='[\u@\h \W]\$ '

export LIBVA_DRIVER_NAME=i965

export PATH=$HOME/.local/bin:$HOME/.go/bin:$HOME/.cargo/bin:$PATH
export GOPATH=$HOME/.go
export npm_config_prefix=$HOME/.local
export WINEPREFIX=$HOME/Games/Wines/Staging

export EDITOR=nvim
