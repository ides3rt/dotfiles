#!/bin/sh

# Set default permissions to `drwx------` and `-rw-------`
umask 077

# Source config
check() { test -f "$1" -a -r "$1" && . $1 ;}

# Source environment variables
if test -d "$HOME/.config/env.d"; then
	for File in $HOME/.config/env.d/*.conf; do
		check $File
	done
	unset -v File
fi

# Detect current shell
if test "$BASH_VERSION"; then
	# INPUTRC
	INPUTRC="$XDG_CONFIG_HOME/bash/inputrc"

	# User's bash(1) completion
	BASH_COMPLETION_USER_FILE="$XDG_CONFIG_HOME/bash-completion/bash_completion"

	# History
	HISTCONTROL=ignoredups:erasedups # Who like dups anyway
	HISTFILE=/dev/null # Same effect as HISTFILE=
	HISTFILESIZE=0 # This make history session only
	HISTSIZE=999

	# Just source bash(1) config
	check $HOME/.bashrc || check $XDG_CONFIG_HOME/bash/config

	# bash(1) completion
	check /usr/share/bash-completion/bash_completion
fi
unset -f check

if test $UID -ne 0 -a -z "$SSH_TTY"; then
	# My GitHub SSH
	if test -z "$SSH_AGENT_PID" && eval `ssh-agent -s`; then
		ssh-add $HOME/.ssh/GitHub
		trap 'eval `ssh-agent -k`' EXIT
	fi >/dev/null 2>&1

	# TTY
	if test -z "$DISPLAY" && clear; then
		# Start searX instance
		if ! pgrep searx-run; then
			searx-run &
		fi >/dev/null 2>&1

		# Run xinit(1) when in tty1
		if test "$XDG_VTNR" -eq 1; then
			exec xinit Xorg -- :0 vt$XDG_VTNR
		fi >/dev/null 2>&1
	fi

	# Quotes
	while read Curline; do
		test -n "$Curline" && printf '%s\n' "$Curline"
	done < $HOME/.local/share/quotes | shuf -n 1
fi
