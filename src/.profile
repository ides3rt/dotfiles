#!/bin/sh

# Set default permissions to `drwx------` and `-rw-------`.
umask 077

# Source config.
check() { [ -f "$1" -a -r "$1" ] && . $1 ;}
setup() {
	local Dir="${XDG_CONFIG_HOME:-$HOME/.config}"
	[ -d "$Dir/$1" ] && for File in $Dir/$1/?*; do check $File; done
	unset -v File
}

# Source environment variables.
setup env.d

# Detect current shell.
case `readlink /proc/$$/exe` in
	*/bash)
		# Just source bash(1) config.
		setup bash
		check /usr/share/bash-completion/bash_completion ;;

	*/zsh)
		# Just source zsh(1) config.
		setup zsh ;;

esac
unset -f setup check

if [ $UID -ne 0 ]; then
	# My GitHub SSH.
	if [ -z "$SSH_AGENT_PID" ] && eval `ssh-agent -s`; then
		ssh-add $HOME/.ssh/GitHub ;;
		trap 'eval `ssh-agent -k`' EXIT
	fi

	# Run xinit(1) when in tty1.
	if [ -z "$DISPLAY" -a "$XDG_VTNR" -eq 1 ]; then
		exec xinit Xorg -- :0 vt$XDG_VTNR
	fi
fi
