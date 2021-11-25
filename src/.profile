#!/bin/sh

# Set default permissions to `drwx------` and `-rw-------`.
umask 077

# Source config.
check() { [ -f "$1" -a -r "$1" ] && . $1 ;}
setup() {
	[ -d "$1" ] && for File in $1/?*; do check $File; done
	unset -v File
}

# Source environment variables.
setup $HOME/.config/env.d

# Detect current shell.
if [ "$BASH" ]; then
	# Just source bash(1) config.
	setup $XDG_CONFIG_HOME/bash
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
