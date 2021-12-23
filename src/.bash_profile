#!/usr/bin/env bash

# Set default permissions to `drwx------` and `-rw-------`
umask 077

# Source environment variables
if [[ -d "$HOME/.config/env.d" ]]; then
	for File in $HOME/.config/env.d/*.conf; {
		[[ -f $File && -r $File ]] && . $File
	}
	unset -v File
fi

# INPUTRC
export INPUTRC="$XDG_CONFIG_HOME/bash/inputrc"

# Users' bash(1) completion
export BASH_COMPLETION_USER_FILE="$XDG_CONFIG_HOME/bash-completion/bash_completion"

# History
export HISTCONTROL=ignoredups:erasedups # Who like dups anyway
export HISTFILE=/dev/null # Same effect as HISTFILE=
export HISTFILESIZE=0 # This make history session only
export HISTSIZE=999

if ((UID)) && [[ -z $SSH_TTY && $SHELL == *bash* ]]; then
	# My GitHub SSH
	if eval `ssh-agent -s`; then
		ssh-add $HOME/.ssh/GitHub
	fi &>/dev/null

	# TTY
	if [[ -z $DISPLAY ]] && clear; then
		# Run xinit(1) when in tty1
		if ((XDG_VTNR == 1)); then
			exec xinit Xorg -- :0 vt$XDG_VTNR
		fi &>/dev/null
	fi
fi

# Just source BASHRC
BASHRC="$HOME/.bashrc"
[[ -f $BASHRC && -r $BASHRC ]] && . $BASHRC
unset -v BASHRC
