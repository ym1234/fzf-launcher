drun () {
	local choice=$(find /usr/share/applications/ ~/.local/share/applications/ -iname "*.desktop" | fzf --reverse --multi --preview  'cat {}')
	local choices
	[[ -n "$choice" ]] && readarray -t choices <<< "$choice"

	for i in "${choices[@]}"
	do
		$(grep '^Exec' "$i" | tail -1 | sed 's/^Exec=//' | sed 's/%.//' | sed 's/^"//g' | sed 's/" *$//g') &
	done
	xdotool search --onlyvisible --name "drun.shfuzzy" windowunmap
}

while true
do
	drun
done
