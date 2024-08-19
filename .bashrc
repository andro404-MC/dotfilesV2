#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export PATH=$HOME/.local/bin:$HOME/.local/bin:$HOME/.go/bin:$HOME/.cargo/bin:$PATH
