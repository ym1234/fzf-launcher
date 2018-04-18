func () {
	local file="$(find ~/Books/ -type f -iname '*.pdf' | fzf --reverse --multi --preview 'pdftotext -l 10 {} -')"
	local files
	[[ -n "$file" ]] && readarray -t files <<< "$file"

	nohup zathura "${files[@]}" &> /dev/null &
	xdotool search --onlyvisible --name "pdf.shfuzzy" windowunmap
}

while true
do
	func
done
