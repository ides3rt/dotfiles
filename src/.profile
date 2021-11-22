#!/bin/sh

# Set default permissions to `drwx------` and `-rw-------`.
umask 077

# Check if file exist and readable or not.
check(){ [ -f "$1" -a -r "$1" ] && . $1 ;}

# Source files
setup(){
	if [ -d "$HOME/.config/$1" ]; then
		for File in $HOME/.config/$1/?*; do
			check $File
		done
	fi
	unset File
}

# Source environment variables.
setup env.d

# Source config depend on shell.
case `readlink /proc/$$/exe` in
	*/bash)
		# Just source BASH config.
		setup bash

		# Likely will be in your distro's main repo.
		check /usr/share/bash-completion/bash_completion

		# You can clone it at https://github.com/hkbakke/bash-insulter.
		# Change /usr/local/share/bash.command-not-found to where you put it.
		check /usr/local/share/bash.command-not-found ;;

	*/zsh)
		# I never use ZSH in my life, lol.
		setup zsh

		# It alse works with ZSH
		check /usr/local/share/bash.command-not-found ;;
esac
unset setup check

[ "$USER" = root ] || {
	# My GitHub SSH.
	if [ -z "$SSH_AGENT_PID" ] && eval `ssh-agent`; then
		case "$USER" in
			ides3rt)
				ssh-add $HOME/.ssh/GitHub ;;
		esac
		trap 'eval `ssh-agent -k`' EXIT
	fi

	# Auto exec xinit(1) when in tty1.
	if [ -z "$DISPLAY" -a "$XDG_VTNR" -eq 1 ]; then
		# exec() is unrequire, but it's a good thing.
		exec xinit Xorg -- :0 vt$XDG_VTNR
	fi
}
