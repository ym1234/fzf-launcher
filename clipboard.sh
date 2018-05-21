func () {
	greenclip print | fzf --reverse | xclip -in -selection clipboard
	xdotool getactivewindow windowunmap
}

while true
do
	func
done
