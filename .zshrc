
# Init
echo ""
echo ""
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

cfonts " untemi #!" -a left -f tiny -g "#f7768e","#7aa2f7" --transition-gradient -s

autoload -Uz compinit
autoload edit-command-line; zle -N edit-command-line
fpath=($HOME/.local/share/zsh-plugins/zsh-completions/src/ $fpath)
zstyle ":completion:*" menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
compinit
_comp_options+=(globdots)
compdef -d trash
setopt autocd
stty stop undef	
setopt interactive_comments

# Disabling vi sorry i had to
bindkey -e
unset VICMD

# Plugins
source "$HOME/.local/share/zsh-plugins/sudo-prefix.zsh"
source "$HOME/.local/share/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$HOME/.local/share/zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/.local/share/zsh-plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"

# Alias
alias ls="exa --icons -A --group-directories-first"
alias ll="eza -Al --color=always --group-directories-first"
alias tree="eza --color=always --icons --tree"
alias grep="rg"
alias gtop="sudo intel_gpu_top"
alias pmu="sudo pacman -Syu"
alias c="clear"
alias myip="curl ip.me"
alias cd="z"
alias lspkg="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias clipdown="yt-dlp -S 'res:1080' -o ~/Videos/Clips/"
alias rm="trash"
alias apt-get="apt"
alias lf="lfub"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME'
alias neofetch="fastfetch -c neofetch.jsonc"
alias seofetch="echo && neofetch --sixel Downloads/千本桜.jpg --logo-width 44"
alias wsong="yt-dlp --audio-format mp3 -x"
alias goclean="\rm /tmp/go-build* -r"
alias vpup="sudo wg-quick up UnArch"
alias vpdown="sudo wg-quick down UnArch"
alias vp1up="sudo wg-quick up UnArch1"
alias vp1down="sudo wg-quick down UnArch1"

# Functions
keyb() {
  xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
}

godoc() {
  curl curl -s cht.sh/go/{$1}
}

apt(){
  echo "Bro we are not on Debian or Ubuntu or a shitty distro"
  sleep 3
  echo "Wait are you fucking DUMB ???"
  sleep 2
  echo "THIS IS ARCH YOU DUMBASS"
  sleep 1
  echo "ok Fuck off"
  sleep 2
  exit
}

ya() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd "$cwd"
	fi
	\rm -f -- "$tmp"
}

function osc7-pwd() {
    emulate -L zsh # also sets localoptions for us
    setopt extendedglob
    local LC_ALL=C
    printf '\e]7;file://%s%s\e\' $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}
}

function chpwd-osc7-pwd() {
    (( ZSH_SUBSHELL )) || osc7-pwd
}
add-zsh-hook -Uz chpwd chpwd-osc7-pwd

# Keybinds
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[s' sudo-command-line
bindkey '^[e' edit-command-line 
