#!/usr/bin/env bash

# If running restricted or non interactive, don't do anything
{ [[ $- != *i* ]] || shopt -q restricted_shell ;} && return

# set()
set -o interactive-comments -o vi -o braceexpand \
	-o hashall -o histexpand +o monitor

# shopt()
shopt -s autocd cdspell checkwinsize cmdhist \
	dirspell dotglob expand_aliases extglob extquote \
	force_fignore histappend hostcomplete \
	interactive_comments lithist no_empty_cmd_completion \
	progcomp progcomp_alias promptvars xpg_echo

# Use `clear-screen` instead for non-recursive clear
bind "\C-l":clear-display

# ZSH like menu completion
bind "TAB":menu-complete
bind '"\e[Z":menu-complete-backward'

# VI keys
bind "\C-b":beginning-of-line
bind "\C-e":end-of-line

PROMPT_PARSER() {
	# Colors
	local Red='\e[1;91m'
	local White='\e[1;97m'
	local Reset='\e[0m'

	# Define colors for root and normal user
	if ((UID)); then
		local Main="$White"; local Fail="$Red"
	else
		local Main="$Red"; local Fail="$White"
	fi

	# PS1
	PS1="\[$Main\]->\[$Reset\] "

	# Status
	(($1 == 0)) || local Status="$1 "
	((Status)) && printf "${Fail}${Status}${Reset}"

	# Show current git branch
	if git rev-parse --is-inside-work-tree &>/dev/null; then
		read Branch < "$(git rev-parse --show-toplevel)/.git/HEAD"
		local Count=$((COLUMNS - ${#Status}))
		PS1+="\[$(tput sc; printf '%*s' $Count "(${Branch##*/})"; tput rc)\]"
		unset -v Branch
	fi

	# PS2
	PS2='   '
	if ((Status)); then
		local Count=0
		while ((Count != ${#Status})); do
			PS2+=' '; ((Count++))
		done
	fi
}

PROMPT_COMMAND='PROMPT_PARSER $?'

Make() { [[ -f $1 && -r $1 ]] && . $1 ;}

# Aliases
Make "$XDG_CONFIG_HOME/bash/aliases"

# Functions
Make "$XDG_CONFIG_HOME/bash/functions"

# BASH Completion
Make /usr/share/bash-completion/bash_completion

# Motivation
Motivation="$HOME/.local/share/quotes"
if [[ -f $Motivation ]]; then
	while read; do
		[[ -n $REPLY ]] && printf '%s\n' "$REPLY"
	done < $Motivation | shuf -n 1
fi

# Unset
unset Make Motivation
