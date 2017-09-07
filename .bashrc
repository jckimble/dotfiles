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
  export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
fi
# Set GPG TTY
export GPG_TTY=$(tty)
# Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null
# If not running interactively, don't do anything
[[ $- != *i* ]] && return
if [[ -z "$TMUX" ]]; then
	tmux && exit
fi;
alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
pacaur2(){
git clone https://aur.archlinux.org/$1.git
cd $1
makepkg -si
}
dockerclean(){
docker ps --filter status=dead --filter status=exited -aq | xargs -r docker rm -v
docker images --no-trunc | grep '<none>' | awk '{ print $3 }' | xargs -r docker rmi
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
devserv(){
browser-sync start --proxy 127.0.0.1:7000 --files . 1>/dev/null 2>&1 &
php -S 127.0.0.1:7000
}
fuckgo(){
	go get `go build . 2>&1 | cut -d \" -f2 | grep -v GO`
}
cd(){
	builtin cd "$@"
	[ -f './.env' ] && . .env
}
[ -f './.env' ] && . .env
sudo sysctl -w vm.max_map_count=262144 > /dev/null 2>&1
export KUBERNETES_PROVIDER=vagrant
export VAGRANT_DEFAULT_PROVIDER=virtualbox
export PATH=$PATH:$HOME/.config/composer/vendor/bin
