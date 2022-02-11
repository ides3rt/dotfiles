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

# Make Ctrl+S and Ctrl+Q work correctly
stty -ixon -ixoff

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
	local DarkGrey='\e[1;90m' Reset='\e[0m'

	# Reset
	PS1="\[$Reset\]" PS2='\[\e[3m\]  '

	if git rev-parse --is-inside-work-tree &>/dev/null; then
		local Branch=$(< "$(git rev-parse --git-dir)"/HEAD) Status=$(git status -s)

		[[ -n $DISPLAY ]] && local Symbol="\[$DarkGrey\] "
		PS1+="$Symbol\[$DarkGrey\]Branch '${Branch##*/}' has"

		if [[ -z $Status ]]; then
			local Secondline Count F1 F2 F3 Pace F5 Upsteam F6 F7 Commits

			while read Secondline; do
				(( Count++ )) && break
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
			local Curline CCount MCount RCount DCount NCount ACount UCount

			while read Curline; do
				case "$Curline" in
					'M  '*)
						(( CCount++ ))
						local Changes=", $CCount change(s) to be committed" ;;

					'M '*)
						(( MCount++ ))
						local Modified=", $MCount modified file(s)" ;;

					'D  '*)
						(( RCount++ ))
						local Removed=", $RCount removed file(s)" ;;

					'D '*)
						(( DCount++ ))
						local Deleted=", $DCount deleted file(s)" ;;

					'R  '*)
						(( NCount++ ))
						local Renamed=", $NCount renamed file(s)" ;;

					'A  '*)
						(( ACount++ ))
						local Added=", $ACount new file(s)" ;;

					'?? '*)
						(( UCount++ ))
						local Untracked=", $UCount untracked file(s)" ;;
				esac
			done <<< "$Status"

			PS1+="$Changes$Modified$Removed$Deleted$Renamed$Added$Untracked.\[$Reset\]\n"
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

		PS1+="\[\e[31m\]$X\[$Reset\]"
		for (( Count = 0; Count != ${#X}; Count++ )); {
			PS2+=' '
		}
	fi

	# Typical PS1
	PS1+='\[\e[0m\]\$ '
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
