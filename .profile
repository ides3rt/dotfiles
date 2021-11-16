#!/bin/sh

## NOTE: .profile is only for posix-shell

# Set default permissions to 'drwx------' and '-rw-------'
umask 077

# Check If file exist and readable or not
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

# Source Environment Variables.
Setup env.d

# Source config depend on shell.
case `readlink /proc/$$/exe` in
	*/bash)
		# Just source BASH's config
		Setup bash

		# Likely going to be in your distro's main repo
		Check /usr/share/bash-completion/bash_completion

		# You can clone at https://github.com/hkbakke/bash-insulter
		# Change /usr/local/share/bash.command-not-found to where you put it
		Check /usr/local/share/bash.command-not-found ;;

	*/zsh)
		# I never use ZSH in my life I only set incase oneday I will use it
		Setup zsh ;;
esac

# Unless you edit my config you don't need this anymore so unset it
unset File Setup Check

# Doesn't do anyting if '/' is mount as `ro`
if [ $USER != root ] && findmnt / | grep -o 'rw,' >/dev/null 2>&1; then

	# My GitHub SSH.
	if [ -z "$SSH_AGENT_PID" ] && eval `ssh-agent -s`; then

		case "$USER" in
			ides3rt)
				ssh-add $HOME/.ssh/GitHub ;;
		esac

		trap 'kill $SSH_AGENT_PID' EXIT
	fi

	# Automatic `startx` when in tty1
	if [ -z "$DISPLAY" -a "$XDG_VTNR" -eq 1 ]; then
		# `exec` is unrequire, but it's a good thing
		exec startx $HOME/.config/X11/xinitrc
	fi
fi
