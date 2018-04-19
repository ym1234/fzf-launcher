format_xdg_data_dirs() {
    printf "%s" "$XDG_DATA_DIRS" | xargs -d : -I'{}' printf "%s/applications/\\n" "{}"
}

drun () {
    [ -z "$XDG_DATA_DIRS" ] && XDG_DATA_DIRS="/usr/share:$HOME/.local/share"
    # shellcheck disable=SC2046
	find $(format_xdg_data_dirs) -iname "*.desktop" | fzf --reverse --multi --preview  'cat {}' | while read -r command
	do
		[ -z "$command" ] && continue

		# shellcheck disable=SC2091
		$(grep -E '^Exec' "$command" | tail -1 | sed 's/^Exec=//' | sed 's/%.//' | sed 's/^"//g' | sed 's/" *$//g') > /dev/null 2>&1 &
	done
	xdotool search --onlyvisible --name "drun.shfuzzy" windowunmap
}

while true
do
	drun
done
