func () {
	greenclip print | fzf --reverse | xclip -in -selection clipboard
	xdotool search --onlyvisible --name "clipboardfuzzy" windowunmap
}

while true
do
	func
done
