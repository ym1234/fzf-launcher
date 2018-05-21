func () {
	find ~/Books/ -type f -iname '*.pdf' | fzf --reverse --multi --preview 'pdftotext -l 5 {} -' | while read -r book
	do
		[ -z "$book" ] && continue

		nohup zathura "$book" > /dev/null 2>&1 &
	done

	xdotool getactivewindow windowunmap
}

while true
do
	func
done
