#!/usr/bin/env bash

# Set default permissions to 'drwx------' and '-rw-------'.
# You may use 027 as a alternative (022 is the default).
umask 077

if [[ -d $HOME/.config/env.d ]]; then
	for file in "$HOME"/.config/env.d/*.conf; {
		[[ -f $file && -r $file ]] && . "$file"
	}
	unset -v file
fi

export INPUTRC=$XDG_CONFIG_HOME/bash/inputrc
export BASH_COMPLETION_USER_FILE=$XDG_CONFIG_HOME/bash-completion/bash_completion
export FIGNORE=.:..
export HISTCONTROL=ignoreboth:erasedups
export HISTFILE=/dev/null
export HISTFILESIZE=0
export HISTSIZE=1000

if [[ $UID -ne 0 && -z $SSH_TTY ]]; then
	eval `ssh-agent -s` && ssh-add "$HOME"/.ssh/GitHub

	if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
		exec xinit X -- vt$XDG_VTNR
	fi
fi &>/dev/null

bashrc=$HOME/.bashrc
[[ -f $bashrc && -r $bashrc ]] && . "$bashrc"
unset -v bashrc
