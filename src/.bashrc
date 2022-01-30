#!/usr/bin/env bash

# If running restricted or non interactive, don't do anything
{ [[ $- != *i* ]] || shopt -q restricted_shell ;} && return

# Disable builtin
enable -n let

# Tmux
if ! [[ $TMUX ]] && ((UID)); then
	[[ $(tmux a -t default || tmux new -s default) == *exited* ]] && exit 0
fi 2>/dev/null

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
	local DarkGrey='\e[1;90m' Green='\e[32m' Reset='\e[0m'

	# Define colors for root and normal user
	if ((UID)); then
		local Main="$Reset" Fail='\e[31m'
	else
		local Main='\e[3;31m' Fail='\e[97m'
	fi

	# Reset
	PS1="\[$Reset\]" PS2='\[\e[3m\]  '

	if git rev-parse --is-inside-work-tree &>/dev/null; then
		local Branch=$(< "$(git rev-parse --git-dir)"/HEAD) Status=$(git status -s)

		[[ -n $DISPLAY ]] && local Symbol="\[$DarkGrey\] "
		PS1+="$Symbol\[$DarkGrey\]Branch '${Branch##*/}' has"

		if [[ -z $Status ]]; then
			local Secondline Count F1 F2 F3 Pace F5 Upsteam F6 F7 Commits

			while read Secondline; do
				((Count++)) && break
			done <<< "$(git status)"

			case "$Secondline" in
				*'up to date'*|*'nothing to commit'*|'')
					printf -v Commits "%'d" "$(git rev-list --count HEAD 2>/dev/null)"
					PS1+=" $Commits commit(s) cleaned.\[$Reset\]\n" ;;

				*behind*)
					read F1 F2 F3 Pace Upsteam F6 Commits _ <<< "$Secondline"
					printf -v Commits "%'d" "$Commits"
					PS1+=" $Commits commit(s) $Pace $Upsteam.\[$Reset\]\n" ;;

				*ahead*)
					read F1 F2 F3 Pace F5 Upsteam F7 Commits _ <<< "$Secondline"
					printf -v Commits "%'d" "$Commits"
					PS1+=" $Commits commit(s) $Pace of $Upsteam.\[$Reset\]\n" ;;
			esac
		else
			local Curline CCount MCount NCount RCount DCount ACount UCount

			while read Curline; do
				case "$Curline" in
					'M  '*)
						local Changes=" $(( CCount + 1 )) change(s) to be committed" ;;
					'M '*)
						local Modified=", $(( MCount + 1 )) modified file(s)" ;;
					'R  '*)
						local Renamed=", $(( NCount + 1 )) renamed file(s)" ;;
					'D  '*)
						local Removed=", $(( RCount + 1 )) removed file(s)" ;;
					'D '*)
						local Deleted=", $(( DCount + 1 )) deleted file(s)" ;;
					'A  '*)
						local Added=", $(( ACount + 1 )) new file(s)" ;;
					'?? '*)
						local Untracked=", $(( UCount + 1 )) untracked file(s)" ;;
				esac
			done <<< "$Status"

			PS1+="$Changes$Modified$Renamed$Removed$Deleted$Added$Untracked.\[$Reset\]\n"
			PS1="${PS1/has,/has}"
		fi

		# Aliases that I only want when working on git
		alias diff='git --no-pager diff'
		alias reset='git reset'
		alias top='cd "$(git rev-parse --show-toplevel)"'
	else
		# diff(1) with colors is a lots easier to read. Also, set tab size to 4
		alias diff='diff --color=auto --tabsize=4'

		unalias reset top &>/dev/null
	fi

	# Status
	if (( $1 != 0 )); then
		local Count X="$1 "

		PS1+="\[$Fail\]$X\[$Reset\]"
		for (( Count = 0; Count != ${#X}; Count++ )); {
			PS2+=' '
		}
	fi

	# Typical PS1
	PS1+="\[$Main\]"
	PS1+='\$'
	PS1+="\[$Reset\] "
}

PROMPT_COMMAND='PROMPT_PARSER $?'
PS0='\[\e[0m\]'

Make() { [[ -f $1 && -r $1 ]] && . "$1" ;}

# Aliases
Make "$XDG_CONFIG_HOME"/bash/aliases

# Functions
Make "$XDG_CONFIG_HOME"/bash/functions

# BASH Completion
Make /usr/share/bash-completion/bash_completion

# Unset
unset -f Make
