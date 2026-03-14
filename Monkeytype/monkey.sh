#!/bin/bash
RANDOM=$$

game() {
	echo "Enter words which are displayed on the screen and in the end press enter"

	dis=""
	inpt=""
	DFM="database_for_monkey.txt"
	nowd=13
	nowid=100

	i=1
	while [ $i -le $nowd ]; do
	    n=$((RANDOM % $nowid))
	    if [ -z "$dis" ]; then
		dis="$(sed -n "${n}p" "$DFM")"
	    else
    		dis="$dis $(sed -n "${n}p" "$DFM")"
	    fi

	    ((i++))
	done

	echo ""
	echo "Type below sentence:"
	echo "${dis}"

	SECONDS=0
	read -p "Enter a sentence: " sentence
	time_type=$SECONDS

	inpt=$sentence

	total=${#dis}
	inpt_len=${#inpt}

	if [ $total -le $inpt_len ]; then
		len=$total
	else
		len=$inpt_len
	fi
	k=0
	points=0

	while [ $k -lt $len ]; do
		char1="${dis:$k:1}"
		char2="${inpt:$k:1}"

		if [ "$char1" = "$char2" ]; then
			((points++))
		fi

		((k++))
	done

	accuracy=$(echo "scale=2; ($points*100)/$inpt_len" | bc)
	echo "Accuracy: $accuracy%"

	wpm=$(echo "scale=2; ($inpt_len*60)/$total" | bc)
	echo "WPM: $wpm"
	}

	while true; do
		game
		echo "Continue the test!! (YES(Y)/NO(N)): "
		read game_state
		if [ $game_state == 'N' ]
		then
		    break
		fi
	done
