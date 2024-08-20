#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export LIBVA_DRIVER_NAME=i965
export MESA_LOADER_DRIVER_OVERRIDE=crocus

export PATH=$HOME/.local/bin:$HOME/.local/bin:$HOME/.go/bin:$HOME/.cargo/bin:$PATH
export GOPATH=$HOME/.go
export npm_config_prefix=$HOME/.local
export WINEPREFIX=$HOME/Games/Wines/Staging

export GTK_CSD=0
export LD_PRELOAD=/usr/lib/libgtk3-nocsd.so.0

export BAT_PAGER=
export EDITOR=nvim
