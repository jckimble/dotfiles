#
# ~/.bashrc
#
export GOPATH=$(go env GOPATH)
export PATH=$PATH:$GOPATH/bin
export TERM=screen-256color
export PASSWORD_STORE_X_SELECTION=primary
# If not running interactively, don't do anything
[[ $- != *i* ]] && return
if [ "${BUILD_DATE}" != "unknown" -a "${BUILD_DATE}" != "" ]; then
	echo "Container Built ${BUILD_DATE} At ${BUILD_TIME}"
fi
which lab >/dev/null 2>&1
[[ $? == 0 ]] && alias git=lab
alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
alias docker=podman
retry(){
$@
if [ ! $? -eq 0 ]; then
retry $@
fi;
}
sc(){
find . -iname \*.$1 -exec aspell --mode=html check '{}' \;
}
mcd(){
	mkdir -p "$@"
	builtin cd "$@"
}
cd(){
	if [ -f './bin/activate' ];then
		if [ "`type -t deactivate`" == "function" ];then
		deactivate
		fi
	fi;
	builtin cd "$@"
	[ -f './.env' ] && . .env
	if [ -f './bin/activate' ];then
		. ./bin/activate
		if [ -f './requirements.txt' ];then
			pip install -qr requirements.txt
		fi
	fi;
}
funny(){
	fortune -o | cowthink | lolcat -p 1
}
[ -f './.env' ] && . .env
export EDITOR=vim
