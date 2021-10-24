#!/bin/sh

# Set default permissions to 'drwx------' and '-rw-------'.
umask 077

# Source 'Environment variables'.
[ -f "$HOME/.env" ] && . $HOME/.env

# Source config depend on shell.
case `readlink /proc/$$/exe` in
  '/usr/bin/bash')
    . $HOME/.config/bash/source ;;
  '/usr/bin/zsh')
    . $HOME/.config/zsh/source ;;
esac

# My GitHub SSH.
if [ -z "$SSH_AGENT_PID" ]; then
  if eval "$(ssh-agent -s)"; then
    case "$USER" in
      'ides3rt')
        ssh-add $HOME/.ssh/GitHub ;;
      *) ;;
    esac
fi fi

# Automatic `startx` when in tty1.
if [ -z "$DISPLAY" -a "$(tty)" = '/dev/tty1' ]; then
  exec startx $HOME/.config/X11/xinitrc
fi
