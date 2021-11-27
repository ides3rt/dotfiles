#!/bin/sh

# Set default permissions to `drwx------` and `-rw-------`.
umask 077

# 256-colors
export TERM=xterm-256color

# Source config.
check() { test -f "$1" -a -r "$1" && . $1 ;}

# Source environment variables.
if test -d "${ENV_DIR:=$HOME/.config/env.d}"; then
	for File in $ENV_DIR/?*; do
		check $File
	done
fi
unset -v File ENV_DIR

# Detect current shell.
if test "$BASH_VERSION"; then

	BASH_DIR="$XDG_CONFIG_HOME/bash"

	# INPUTRC
	INPUTRC="$BASH_DIR/inputrc"

	# User's bash(1) completion.
	BASH_COMPLETION_USER_FILE="$XDG_CONFIG_HOME/bash-completion/bash_completion"

	# History
	HISTCONTROL=ignoredups:erasedups # Who like dups anyway
	HISTFILE=/dev/null # Same effect as HISTFILE=
	HISTFILESIZE=0 # This make history session only
	HISTSIZE=999

	# Just source bash(1) config.
	check $HOME/.bashrc || check $BASH_DIR/config

	# bash(1) completion.
	check /usr/share/bash-completion/bash_completion
	unset -v BASH_DIR

fi
unset -f setup check

# Quotes staff
if test -n "$DISPLAY"; then
	while read CurLine; do
		test -n "$CurLine" && printf '%s\n' "$CurLine"
	done < $HOME/.local/share/quotes | shuf -n 1
else
	clear
fi

# Outdated stuff
unset -v TERMCAP MANPATH

if test $UID -ne 0 -a -z "$SSH_TTY"; then
	# My GitHub SSH.
	if [ -z "$SSH_AGENT_PID" ] && eval `ssh-agent -s`; then
		ssh-add $HOME/.ssh/GitHub
		trap 'eval `ssh-agent -k`' EXIT
	fi

	# Run xinit(1) when in tty1.
	if test -z "$DISPLAY" -a "$XDG_VTNR" -eq 1; then
		exec xinit Xorg -- :0 vt$XDG_VTNR
	fi
fi
