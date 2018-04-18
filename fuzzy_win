xdotool search --onlyvisible --name "$1fuzzy" windowunmap \
  || xdotool search --name "$1fuzzy" windowmap \
  || termite -t "$1fuzzy" --geometry 1366x200 -e "bash -c $1"
