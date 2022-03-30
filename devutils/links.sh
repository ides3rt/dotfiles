#!/usr/bin/env bash

progrm=${0##*/}

panic() {
	printf '%s\n' "$progrm: $2" 1>&2
	(( $1 > 0 )) && exit $1
}

(( $# > 0 )) && panic 1 "needn't arguments..."

base=$(realpath "$0") base=${base%/*/*}/src
[[ -d $base ]] || panic 1 "$base: doesn't exist..."

[[ -d $HOME/.config ]] || mkdir -p "$HOME"/.config

if [[ ! -d $HOME/.local/share/icons ]]; then
	mkdir -p "$HOME"/.local/share/icons
fi

for file in "$base"/.bash* "$base"/.config/* \
	"$base"/.local/share/icons/default
{
	dest=$HOME/${file#$base/}

	if [[ ! -e $file ]]; then
		panic 0 "$file: doesn't exist..."

	elif [[ -e $dest ]]; then
		panic 0 "${dest/$HOME/\~}: already existed..."

	else
		find "$dest" -xtype l -delete
		ln -sv "$file" "$dest"
	fi
}
