#!/bin/sh

# Set default permissions to 'drwx------' and '-rw-------'.
umask 077

# Check If file exist and readable or not.
Check() {
	[ -f "$1" -a -r "$1" ] && . $1
}

# Source Environment Variables.
Check $HOME/.env

# Source files
SetUp() {
	for File in $HOME/.config/$1/?*; do
		Check $File
	done
}

# Source config depend on shell.
case `readlink /proc/$$/exe` in
	*/bash)
		SetUp bash ;;
	*/zsh)
		SetUp zsh ;;
esac

unset File SetUp Check

# My GitHub SSH.
if [ -z "$SSH_AGENT_PID" ]; then
	if eval "$(ssh-agent -s)"; then
		case "$USER" in
			ides3rt)
				ssh-add $HOME/.ssh/GitHub ;;
			*) ;;
		esac
fi	fi

# Automatic `startx` when in tty1.
if [ -z "$DISPLAY" -a "$(tty)" = '/dev/tty1' ]; then
	exec startx $HOME/.config/X11/xinitrc
fi
