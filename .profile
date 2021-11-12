#!/bin/sh

## NOTE: .profile is only for posix-shell

# Set default permissions to 'drwx------' and '-rw-------'
umask 077 # Default is 022, less privacy, but more convenient

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
case "$(readlink /proc/$$/exe)" in
	*/bash)
		# Just source BASH's config
		Setup bash

		# Prop' in your distro's main repo
		Check /usr/share/bash-completion/bash_completion

		# You can clone at https://github.com/hkbakke/bash-insulter
		# Change /usr/share/bash.command-not-found to where you put it
		Check /usr/local/share/bash.command-not-found ;;

	*/zsh)
		# I never use ZSH in my life I only set incase oneday I will use it
		Setup zsh ;;
esac

# Unless you edit my config you don't need this anymore so unset it
unset File Setup Check

# Don't do anyting if root is mount as ro
if [ -n "$(findmnt / | awk '{print $4}' | grep -Eo '^rw,')" ]; then
	# My GitHub SSH.
	if [ -z "$SSH_AGENT_PID" -a $UID != 0 ]; then # Only spawn SSH-AGENT if it never spawn before
		if eval `ssh-agent -s`; then # If `eval` success then do ssh-add
			case "$USER" in
				ides3rt) # If me login then add my GitHub's SSH
					ssh-add $HOME/.ssh/GitHub ;;

				*) ;;
			esac
			trap 'kill $SSH_AGENT_PID' EXIT
	fi	fi

	# Automatic `startx` when in tty1. It's conflict with your favorite DM
	if [ -z "$DISPLAY" -a "$(tty)" = '/dev/tty1' -a $UID != 0 ]; then
		# You don't need to specify /path/to/xinitrc if you use default location
		exec startx $HOME/.config/X11/xinitrc # `exec` is unrequire, but it's a good thing
	fi
fi
