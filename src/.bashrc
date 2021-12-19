#!/usr/bin/env bash

# If running restricted or non interactive, don't do anything
{ [[ $- != *i* ]] || shopt -q restricted_shell ;} && return

# Disable builtin
enable -n let

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
	local White='\e[1;97m' Red='\e[1;91m' \
		Grey='\e[1;37m' Reset='\e[0m'

	# Define colors for root and normal user
	if ((UID)); then
		local Main="$White" Fail="$Red"
	else
		local Main="$Red" Fail="$White"
	fi

	# Reset
	PS1= PS2='   '

	if git rev-parse --is-inside-work-tree &>/dev/null; then
		local Branch=$(< "$(git rev-parse --git-dir)/HEAD") \
			Status=$(git status --short)

		[[ -n $DISPLAY ]] && local Icons='  '
		PS1+="\[$Grey\]${Icons}Branch \\\`${Branch##*/}\\\` has "

		if [[ -z $Status ]]; then
			printf -v Commits "%'d" "$(git rev-list --count HEAD)"
			PS1+="$Commits commit(s) cleaned.\[$Reset\]"
			unset -v Commits
		else
			while read Curline; do
				case "$Curline" in
					M*)
						((MCount++))
						local Modified="$MCount modified file(s)" ;;
					'??'*)
						((UCount++))
						local Untracked=", $UCount untracked file(s)" ;;
				esac
			done <<< "$Status"

			PS1+="${Modified}${Untracked}.\[$Reset\]"
			unset -v MCount UCount Curline
		fi
		PS1+='\n'
		alias diff='git diff'
	else
		alias diff='diff --color=auto --tabsize=4'
	fi

	# Status
	(($1 == 0)) || local X="$1 "
	((X)) && PS1+="\[$Fail\]$X\[$Reset\]"

	# Typical PS1
	PS1+="\[$Main\]->\[$Reset\] "

	# PS2
	if ((X)); then
		local Count=0
		while ((Count != ${#X})); do
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
