#!/usr/bin/env bash

# Set default permissions to 'drwx------' and '-rw-------'.
umask 077

# Source environment variables.
if [[ -d $HOME/.config/env.d ]]; then
	for file in "$HOME"/.config/env.d/*.conf; {
		[[ -f $file && -r $file ]] && . "$file"
	}
	unset -v file
fi

# Readline.
export INPUTRC=$XDG_CONFIG_HOME/bash/inputrc

# User's bash(1) completions.
export BASH_COMPLETION_USER_FILE=$XDG_CONFIG_HOME/bash-completion/bash_completion

# Ignore '.' and '..' on tab-completion.
export FIGNORE=.:..

# History.
export HISTCONTROL=ignoreboth:erasedups
export HISTFILE=/dev/null
export HISTFILESIZE=0
export HISTSIZE=1000

if [[ $UID -ne 0 && -z $SSH_TTY ]]; then
	# GitHub SSH.
	eval `ssh-agent -s` && ssh-add "$HOME"/.ssh/GitHub

	# Start xinit(1) when in TTY1.
	if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
		exec xinit X -- vt$XDG_VTNR
	fi
fi &>/dev/null

# Source ~/.bashrc.
bashrc=$HOME/.bashrc
[[ -f $bashrc && -r $bashrc ]] && . "$bashrc"
unset -v bashrc
