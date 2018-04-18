run () {
	choice=$(compgen -c | fzf --print-query --reverse --multi)
	exitstatus=$?

	local choices
	[[ -n "$choice" ]] && readarray -t choices <<< "$choice"

	if  [[ exitstatus -eq 1 ]]; then
		for i in "${choices[@]}"
		do
			nohup bash -c "$i" &> /dev/null &
		done
	elif [[ exitstatus -eq 0 ]]; then
		for i in "${choices[@]:1:${#choices}}"
		do
			bash -c "$i" &> /dev/null &
		done
	fi
	xdotool search --onlyvisible --name "runfuzzy" windowunmap
}

while true
do
	run
done
