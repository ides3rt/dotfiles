#!/bin/sh

## NOTE: .profile is only for posix-shell

# Set default permissions to 'drwx------' and '-rw-------'
umask 077 # Default is 022, less privacy, but more convenient

# Check If file exist and readable or not
Check() {
	[ -f "$1" -a -r "$1" ] && . $1
}

# Source files
SetUp() {
	for File in $HOME/.config/$1/?*; do
		Check $File
	done
}

# Source Environment Variables.
Check $HOME/.env

# Source config depend on shell.
case `readlink /proc/$$/exe` in
	*/bash)
		# Just source BASH's config
		SetUp bash

		# Prop' in your distro's main repo
		Check /usr/share/bash-completion/bash_completion

		# You can clone at https://github.com/hkbakke/bash-insulter
		# Change /usr/share/bash.command-not-found to where you put it
		Check /usr/share/bash.command-not-found ;;

	*/zsh)
		# I never use ZSH in my life I only set incase oneday I will use it
		SetUp zsh ;;
esac

# Unless you edit my config you don't need this anymore so unset it
unset File SetUp Check

# My GitHub SSH.
if [ -z "$SSH_AGENT_PID" ]; then # Only spawn SSH-AGENT if it never spawn before
	if eval `ssh-agent -s`; then # If `eval` success then do ssh-add
		case "$USER" in
			ides3rt) # If me(ides3rt) login then add my github's ssh
				ssh-add $HOME/.ssh/GitHub ;;

			*) ;;
		esac
fi	fi

# Automatic `startx` when in tty1. It's conflict with your favorite DM
if [ -z "$DISPLAY" -a "$(tty)" = '/dev/tty1' ]; then
	# You don't need to specify /path/to/xinitrc if you use default location
	exec startx $HOME/.config/X11/xinitrc # `exec` is unrequire, but it's a good thing
fi
