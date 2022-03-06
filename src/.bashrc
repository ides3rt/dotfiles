#!/usr/bin/env bash

# If running restricted or non interactive, don't do anything.
{ [[ $- != *i* ]] || shopt -q restricted_shell ;} && return

# Disable builtins.
enable -n let unalias alias
shopt -u expand_aliases

# Auto launch tmux(1).
if [[ $DISPLAY && ! $TMUX ]] && ((UID)); then
	[[ $(tmux a -t default || tmux new -s default) == *exited* ]] && exit 0
fi 2>/dev/null

# Set values for shell options.
set +o monitor -o noclobber -o vi

# (Sh)ell (opt)ions.
shopt -s autocd cdspell checkhash direxpand dirspell \
	dotglob extglob globasciiranges globstar histappend \
	lithist no_empty_cmd_completion progcomp_alias xpg_echo

# Make Ctrl+S and Ctrl+Q work correctly.
stty -ixon -ixoff

# Enable menu completion.
bind "TAB":menu-complete
bind '"\e[Z"':menu-complete-backward

# Use 'clear-screen' instead for non-recursive clear.
bind "\C-l":clear-display

PROMPT_PARSER() {
	# Colors.
	local DarkGrey='\e[1;90m' Red='\e[31m' Reset='\e[0m'

	# Define colors for normal user and root.
	if ((UID)); then
		local Main="$Reset" Fail="$Red"
	else
		local Main="$Red" Fail="$Reset"
	fi

	# Reset.
	PS1="\[$Reset\]" PS2="\[$Reset\]  "

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

		diff() { git --no-pager diff "$@"; }
		reset() { git reset "$@"; }
		top() { cd "$(git rev-parse --show-toplevel)"; }

	else

		diff() { command diff --color=auto --tabsize=4 "$@"; }
		unset -f reset top

	fi

	# Status.
	if (( $1 != 0 )); then
		local Count X="$1 "

		PS1+="\[$Fail\]$X\[$Reset\]"
		for (( Count = 0; Count != ${#X}; Count++ )); {
			PS2+=' '
		}
	fi

	# Typical PS1.
	PS1+="\[$Main\]"
	PS1+='\$'
	PS1+="\[$Reset\] "
}

PROMPT_COMMAND='PROMPT_PARSER $?'
PS0='\[\e[0m\]'

Make() { [[ -f $1 && -r $1 ]] && . "$1"; }

# Functions.
Make "$XDG_CONFIG_HOME"/bash/functions

# bash(1) completions.
Make /usr/share/bash-completion/bash_completion

# Unset.
unset -f Make
