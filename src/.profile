#!/bin/sh

# Set default permissions to `drwx------` and `-rw-------`.
umask 077

# 256-colors
export TERM=xterm-256color

# Source config.
check() { [ -f "$1" -a -r "$1" ] && . $1 ;}

# Source environment variables.
if [ -d "${ENV_DIR:=$HOME/.config/env.d}" ]; then
	for File in $ENV_DIR/?*; do
		check $File
	done
	unset -v File
fi
unset -v ENV_DIR

# Detect current shell.
if [ "$BASH_VERSION" ]; then

	# INPUTRC
	INPUTRC="$XDG_CONFIG_HOME/bash/inputrc"

	# Just source bash(1) config.
	source $XDG_CONFIG_HOME/bash/config

	# History
	HISTCONTROL=ignoredups:erasedups # Who like dups anyway
	HISTFILE=/dev/null # Same effect as HISTFILE=
	HISTFILESIZE=0 # This make history session only
	HISTSIZE=999

	# User's bash(1) completion.
	BASH_COMPLETION_USER_FILE="$XDG_CONFIG_HOME/bash-completion/bash_completion"

	# bash(1) completion.
	check /usr/share/bash-completion/bash_completion

fi
unset -f setup check

# Outdated stuff
unset -v TERMCAP MANPATH

if [ $UID -ne 0 ]; then
	# My GitHub SSH.
	if [ -z "$SSH_AGENT_PID" ] && eval `ssh-agent -s`; then
		ssh-add $HOME/.ssh/GitHub
		trap 'eval `ssh-agent -k`' EXIT
	fi

	# Run xinit(1) when in tty1.
	if [ -z "$DISPLAY" -a "$XDG_VTNR" -eq 1 ]; then
		exec xinit Xorg -- :0 vt$XDG_VTNR
	fi
fi
