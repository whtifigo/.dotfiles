###############
### General ###
###############

# Correct wrong spellings
setopt correct

# Load colors
autoload -U colors && colors
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
   eval $COLOR='$fg_no_bold[${(L)COLOR}]'
   eval BOLD_$COLOR='$fg_bold[${(L)COLOR}]'
done
eval NC='$reset_color'

##################
### Completion ###
##################

# Load and initialise completion system
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d "$XDG_CACHE_HOME/zsh/.zshcompdump-$ZSH_VERSION"
_comp_options+=(globdots)

##########################
### Zap Plugin Manager ###
##########################

[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-syntax-highlighting"
plug "hlissner/zsh-autopair"
plug "zsh-users/zsh-history-substring-search"
plug "MichaelAquilina/zsh-you-should-use"
plug "zap-zsh/completions"
plug "zap-zsh/sudo"
plug "web-search"
plug "zap-zsh/fzf"
plug "zap-zsh/web-search"
plug "jeffreytse/zsh-vi-mode"

########################
### Matcha's Scripts ###
########################

# Add homebrew to PATH
# if [[ $USER == "matda-co" ]]; then
# 	export PATH="$HOME/sgoinfre/homebrew/bin:$PATH"
# 	export PATH="$HOME/sgoinfre/passunca/homebrew/bin:$PATH"
# 	export PATH="$HOME/sgoinfre/passunca/homebrew/sbin:$PATH"
# 	export PATH="$HOME/sgoinfre/rust/build/x86_64-unknown-linux-gnu/stage0/bin:$PATH"
# elif [[ $USER == "zedr0" ]]; then
# 	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# fi

source $HOME/.brewconfig.zsh

########################
### Matcha's Aliases ###
########################

# Compiling
alias ccw='cc -Wall -Wextra -Werror -g'

# 42 Norm Check
alias nn='norminette'

# Neovim
alias v='nvim'
alias clear_nvim='rm -rf ~/.local/share/nvim'
 
# git
alias ga='git add'
alias gst='git status'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gco='git checkout'
alias gcb='git checkout -b'
alias glgg='git log --graph --oneline --decorate'
alias glgs='git log --graph --oneline --decorate | head -n 7'
alias gm='git merge --stat --log'

# kitty at 42
if [[ $USER == "matda-co" ]]; then
	alias kitty=~/.local/kitty.app/bin/kitty
fi
alias k='kitty --start-as=fullscreen'
alias icat='kitty +kitten icat'
alias kdiff='kitty +kitten diff'

# Glow Markdown Renderer
alias glow=~/bin/glow/glow


############################
### Load Starship Prompt ###
############################

if command -v starship > /dev/null 2>&1; then
    eval "$(starship init zsh)"
else
    ZSH_THEME="refined"
fi

#####################################
### Clear google-chrome Singleton* ###
#####################################
if [[ $USER == "passunca" ]]; then
  rm -rf ~/.config/google-chrome/Singleton*
fi

if ! systemctl status docker | grep running &> /dev/null; then
		echo "[Francinette] Starting Docker..."
		sleep 1
		exec "/bin/zsh"
fi
if ! docker image ls | grep francinette-image &> /dev/null; then
		echo "[Francinette] Loading the docker container"
		docker load < /home/matda-co/francinette-image/francinette.tar
		exec "/bin/zsh"
fi
if ! docker ps | grep "francinette-image" &> /dev/null; then
	if docker run -d -i -v /home:/home -v /goinfre:/goinfre -v /sgoinfre:/sgoinfre -v /home/matda-co/francinette-image/logs:/francinette/logs-t --name run-paco francinette-image /bin/bash 2>&1 | grep "already" &> /dev/null; then
		docker start run-paco
	fi
fi
alias francinette=/home/matda-co/francinette-image/run.sh

alias paco=/home/matda-co/francinette-image/run.sh
