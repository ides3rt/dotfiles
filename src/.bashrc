#!/usr/bin/env bash

# If running restricted or non interactive, don't do anything.
{ [[ $- != *i* ]] || shopt -q restricted_shell ;} && return

# Disable builtins.
enable -n let unalias alias
shopt -u expand_aliases

# Auto launch tmux(1).
if [[ $UID -ne 0 && -z $TMUX ]]; then
	[[ $(tmux a || tmux new) == '[exited]' ]] && exit 0
fi &>/dev/null

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
	local darkgrey='\e[1;90m' red='\e[31m' reset='\e[0m'

	# Define colors for normal user and root.
	if ((UID)); then
		local main=$reset fail=$red
	else
		local main=$red fail=$reset
	fi

	# Reset.
	PS1="\[$reset\]" PS2="\[$reset\]  "

	if git rev-parse --is-inside-work-tree &>/dev/null; then
		local branch=$(< "$(git rev-parse --git-dir)"/HEAD) \
			status=$(git status -s 2>/dev/null)

		[[ -n $DISPLAY ]] && local symbol=" "
		PS1+="\[$darkgrey\]${symbol}Branch '${branch##*/}' has"

		if [[ -z $status ]]; then
			local count pace upsteam commits

			while read; do
				(( count++ )) && break
			done <<< "$(git status 2>/dev/null)"

			case $REPLY in
				*'up to date'*|*'nothing to commit'*|'')
					printf -v commits "%'d" "$(git rev-list --count HEAD 2>/dev/null)"
					PS1+=" $commits commit(s) cleaned.\[$reset\]\n" ;;

				*behind*)
					read _ _ _ pace upsteam _ commits _ <<< "$REPLY"
					printf -v commits "%'d" "$commits"
					PS1+=" $commits commit(s) $pace $upsteam.\[$reset\]\n" ;;

				*ahead*)
					read _ _ _ pace _ upsteam _ commits _ <<< "$REPLY"
					printf -v commits "%'d" "$commits"
					PS1+=" $commits commit(s) $pace of $upsteam.\[$reset\]\n" ;;
			esac
		else
			local line ccount mcount rcount dcount ncount acount ucount

			while read line; do
				case $line in
					'M  '*)
						(( ccount++ ))
						local changes=", $ccount change(s) to be committed" ;;

					'M '*)
						(( mcount++ ))
						local modified=", $mcount modified file(s)" ;;

					'D  '*)
						(( rcount++ ))
						local removed=", $rcount removed file(s)" ;;

					'D '*)
						(( dcount++ ))
						local deleted=", $dcount deleted file(s)" ;;

					'R  '*)
						(( ncount++ ))
						local renamed=", $ncount renamed file(s)" ;;

					'A  '*)
						(( acount++ ))
						local added=", $acount new file(s)" ;;

					'?? '*)
						(( ucount++ ))
						local untracked=", $ucount untracked file(s)" ;;
				esac
			done <<< "$status"

			PS1+="$changes$modified$removed$deleted$renamed$added$untracked.\[$reset\]\n"
			PS1=${PS1/has,/has}
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
		local count exit="$1 "

		PS1+="\[$fail\]$exit\[$reset\]"
		for (( count = 0; count != ${#exit}; count++ )); {
			PS2+=' '
		}
	fi

	# Typical PS1.
	PS1+="\[$main\]"
	PS1+='\$'
	PS1+="\[$reset\] "
}

PROMPT_COMMAND='PROMPT_PARSER $?'
PS0='\[\e[0m\]'

check() { [[ -f $1 && -r $1 ]] && . "$1"; }

# Functions.
check "$XDG_CONFIG_HOME"/bash/functions

# bash(1) completions.
check /usr/share/bash-completion/bash_completion

# Unset.
unset -f check
