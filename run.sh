posix_list_commands() {
	COMMANDS=$(printf "%s" "$PATH" | xargs -d : -I {} find {} -maxdepth 1 \
		-executable -type f -printf '%P\n' 2> /dev/null)
	printf "%s\\n" "$COMMANDS" | sort -u
}

bash_list_commands() {
	compgen -c
}

zsh_list_commands() {
	# shellcheck disable=SC2154
    printf "%s\\n" "${(k)commands[@]}"
}

run () {
	# Checking BASH_VERSION and ZSH_VERSION isn't fool-proof since
	# some smart-ass might set it in the environment. For "mugh speed"
	# it's probably good enough though.
	[ -n "$BASH_VERSION" ] && func="bash_list_commands"
	[ -n "$ZSH_VERSION"  ] && func="zsh_list_commands"
	[ -z "$func" ] && func="posix_list_commands"

	$func | fzf --print-query --reverse --multi | sort -u | while read -r command
	do
		[ -z "$command" ] && continue

		# SHELL should be set but explicitely set it just in case
		[ -z "$SHELL" ] && SHELL="/bin/sh"
		nohup "$SHELL" -c "$command" > /dev/null 2>&1 &
	done

	xdotool search --onlyvisible --name "run.shfuzzy" windowunmap
}

while true
do
	run
done
