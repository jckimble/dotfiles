#
# ~/.bashrc
#
export GOPATH=$(go env GOPATH)
export PATH=$PATH:$GOPATH/bin
export TERM=screen-256color
export PASSWORD_STORE_X_SELECTION=primary
#Start gpg-agent if not already running
if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
	gpg-connect-agent /bye >/dev/null 2>&1
fi;
# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK=$(gpgconf --list-dir agent-ssh-socket)
fi
# Set GPG TTY
export GPG_TTY=$(tty)
# Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
# If not running interactively, don't do anything
[[ $- != *i* ]] && return
which lab >/dev/null 2>&1
[[ $? == 0 ]] && alias git=lab
alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
dockerclean(){
docker ps --filter status=created --filter status=dead --filter status=exited -aq | xargs -r docker rm -v
docker images --no-trunc | grep '<none>' | awk '{ print $3 }' | xargs -r docker rmi
docker volume ls -qf dangling=true | xargs -r docker volume rm
}
retry(){
$@
if [ ! $? -eq 0 ]; then
retry $@
fi;
}
sc(){
find . -iname \*.php -exec aspell --mode=html check '{}' \;
}
cd(){
	builtin cd "$@"
	[ -f './.env' ] && . .env
}
funny(){
	fortune -o | cowthink | lolcat -p 1
}
[ -f './.env' ] && . .env
export EDITOR=vim
