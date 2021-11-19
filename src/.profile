#!/bin/sh

# Set default permissions to `drwx------` and `-rw-------`.
umask 077

# Check if file exist and readable or not.
Check(){
	[ -f "$1" -a -r "$1" ] && . $1
}

# Source files
Setup(){
	if [ -d "$HOME/.config/$1" ]; then
		for File in $HOME/.config/$1/?*; do
			Check $File
		done
	fi
}

# Source environment variables.
Setup env.d

# Source config depend on shell.
case `readlink /proc/$$/exe` in
	*/bash)
		# Just source bash() config.
		Setup bash

		# Likely will be in your distro's main repo.
		Check /usr/share/bash-completion/bash_completion

		# You can clone it at https://github.com/hkbakke/bash-insulter.
		# Change /usr/local/share/bash.command-not-found to where you put it.
		Check /usr/local/share/bash.command-not-found ;;

	*/zsh)
		# I never use zsh() in my life, I only have it 'cause maybe I'll use it.
		Setup zsh

		# It's works with zsh()
		Check /usr/local/share/bash.command-not-found ;;

esac
unset File Setup Check

# Don't do anyting if `/' is mount as `ro`.
if [ `id -u` -ne 0 ] && findmnt / | grep -o 'rw,' >/dev/null 2>&1; then

	# My GitHub SSH.
	if ! [ "$SSH_AGENT_PID" ] && eval `ssh-agent -s`; then
		case "$USER" in
			ides3rt)
				ssh-add $HOME/.ssh/GitHub ;;
		esac
		trap 'kill $SSH_AGENT_PID' EXIT
	fi

	# Auto exec xinit() when in tty1.
	if [ -z "$DISPLAY" -a "$XDG_VTNR" -eq 1 ]; then
		# exec() is unrequire, but it's a good thing.
		exec xinit Xorg -- :0 vt$XDG_VTNR
	fi
fi
