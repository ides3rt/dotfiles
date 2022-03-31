#!/usr/bin/env bash

{ [[ -z $PS1 ]] || shopt -q restricted_shell ;} && return

enable -n let unalias alias
shopt -u expand_aliases

if [[ $UID -ne 0 && -z $TMUX ]]; then
	[[ $(tmux a || tmux new) == '[exited]' ]] && exit 0
fi &>/dev/null

set +o monitor -o noclobber -o vi
shopt -s autocd cdspell checkhash direxpand dirspell \
	dotglob extglob globasciiranges globstar histappend \
	lithist no_empty_cmd_completion progcomp_alias xpg_echo

stty -ixon -ixoff
bind "\C-l":clear-display

bind "TAB":menu-complete
bind '"\e[Z"':menu-complete-backward

_prompt_parser() {
	local main fail darkgrey='\e[1;90m' red='\e[31m' reset='\e[0m'

	if ((UID)); then
		main=$reset fail=$red
	else
		main=$red fail=$reset
	fi

	PS1="\[$reset\]" PS2="\[$reset\]  "

	if git rev-parse --is-inside-work-tree &>/dev/null; then
		local branch=$(< "$(git rev-parse --git-dir)"/HEAD) \
			status=$(git status -s 2>/dev/null)

		[[ -n $DISPLAY ]] && local symbol=" "
		PS1+="\[$darkgrey\]${symbol}Branch '${branch##*/}' has"

		if [[ -z $status ]]; then
			local i pace upsteam commits

			while read; do
				(( i++ )) && break
			done <<< "$(git status 2>/dev/null)"

			case $REPLY in
				*up\ to\ date*|*nothing\ to\ commit*|'')
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
			local line changes modified removed deleted renamed added \
				untracked ccount mcount rcount dcount ncount acount ucount

			while read line; do
				case $line in
					'M  '*)
						changes=", $(( ++ccount )) change(s) to be committed" ;;

					'M '*)
						modified=", $(( ++mcount )) modified file(s)" ;;

					'D  '*)
						removed=", $(( ++rcount )) removed file(s)" ;;

					'D '*)
						deleted=", $(( ++dcount )) deleted file(s)" ;;

					'R  '*)
						renamed=", $(( ++ncount )) renamed file(s)" ;;

					'A  '*)
						added=", $(( ++acount )) new file(s)" ;;

					'?? '*)
						untracked=", $(( ++ucount )) untracked file(s)" ;;
				esac
			done <<< "$status"

			PS1+="$changes$modified$removed$deleted$renamed$added$untracked.\[$reset\]\n"
			PS1=${PS1/has,/has}
		fi

		diff() { git --no-pager diff "$@"; }
		reset() { git reset "$@"; }
	else
		diff() { command diff --color=auto --tabsize=4 "$@"; }
		unset -f reset
	fi

	if (( $1 != 0 )); then
		local i exit="$1 "

		PS1+="\[$fail\]$exit\[$reset\]"
		for (( i = 0; i != ${#exit}; i++ )); {
			PS2+=' '
		}
	fi

	PS1+="\[$main\]"
	PS1+='\$'
	PS1+="\[$reset\] "
}

PROMPT_COMMAND='_prompt_parser $?'
PS0='\[\e[0m\]'

for file in "$XDG_CONFIG_HOME"/bash/functions \
	/usr/share/bash-completion/bash_completion
{
	[[ -f $file && -r $file ]] && . "$file"
}
