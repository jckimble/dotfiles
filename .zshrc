# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jckimble/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
PROMPT='%(?.%F{green}.%F{red})%#%f '
RPROMPT='%B%F{cyan}%1~%f%b'
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

setopt CORRECT_ALL

alias ls='ls --color=auto'

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

function retry(){
	if ! "$@"; then
		sleep 1
		echo "Retrying $@"
		retry "$@"
	fi
}

function funny(){
	fortune -o | cowthink | lolcat -p 1
}

export TERM=screen-256color
export EDITOR=vim

if [ "${BUILD_DATE}" != "unknown" ] && [ "${BUILD_DATE}" != "" ]; then
	echo "Container Built ${BUILD_DATE} At ${BUILD_TIME}"
fi

case $- in *i*)
  if [ -z "$TMUX" ]; then exec tmux; fi;;
esac
