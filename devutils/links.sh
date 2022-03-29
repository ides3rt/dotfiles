#!/usr/bin/env bash

progrm=${0##*/}

panic() {
	printf '%s\n' "$progrm: $2" 1>&2
	(( $1 > 0 )) && exit $1
}

(( $# > 0 )) && panic 2 "needn't arguments..."

check_n_link() {
	if [[ ! -e $1 ]]; then
		panic 0 "${1/$HOME/\~}: doesn't exist..."
	elif [[ -e $2 ]]; then
		panic 0 "${2/$HOME/\~}: already existed..."
	elif [[ ! -L $2 ]]; then
		ln -sv "$1" "$2"
	fi
}

base=${PWD%/*}/src
[[ -d $base ]] || panic 1 "$base: doesn't exist..."

check_n_link "$base"/.bash_profile "$HOME"/.bash_profile
check_n_link "$base"/.bashrc "$HOME"/.bashrc
check_n_link "$base"/.bash_logout "$HOME"/.bash_logout

check_n_link "$base"/.config/alacritty "$HOME"/.config/alacritty
check_n_link "$base"/.config/aria2 "$HOME"/.config/aria2
check_n_link "$base"/.config/bash "$HOME"/.config/bash
check_n_link "$base"/.config/bash-completion "$HOME"/.config/bash-completion
check_n_link "$base"/.config/bspwm "$HOME"/.config/bspwm
check_n_link "$base"/.config/dunst "$HOME"/.config/dunst
check_n_link "$base"/.config/env.d "$HOME"/.config/env.d
check_n_link "$base"/.config/gtk-3.0 "$HOME"/.config/gtk-3.0
check_n_link "$base"/.config/nvim "$HOME"/.config/nvim
check_n_link "$base"/.config/picom "$HOME"/.config/picom
check_n_link "$base"/.config/rofi "$HOME"/.config/rofi
check_n_link "$base"/.config/sxhkd "$HOME"/.config/sxhkd
check_n_link "$base"/.config/tmux "$HOME"/.config/tmux
check_n_link "$base"/.config/wget "$HOME"/.config/wget
check_n_link "$base"/.config/X11 "$HOME"/.config/X11

if [[ ! -d ${XDG_DATA_HOME:=$HOME/.local/share}/icons ]]; then
	mkdir -p "$XDG_DATA_HOME"/icons
fi
check_n_link "$base"/.local/share/icons/default "$XDG_DATA_HOME"/icons/default
