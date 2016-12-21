#
# ~/.bashrc
#
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
