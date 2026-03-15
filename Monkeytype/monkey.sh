#!/bin/bash

compare_arrays() {
	local -n inp=$1
	local -n opt=$2
	total_points=0
	len_inp=0
	len_opt=0
	local i=0

	while [ $i -lt ${#inp[@]} ]; do
		w1="${inp[$i]}"
		w2="${opt[$i]}"
		local l1=${#w1}
		local l2=${#w2}
		((len_inp += l1))
		((len_opt += l2))

		if [ $l1 -le $l2 ]; then
			local l=$l1
		else
			local l=$l2
		fi

		local j=0
		while [ $j -lt $l ]; do
			c1="${w1:$j:1}"
			c2="${w2:$j:1}"

			if [ "$c1" = "$c2" ]; then
				((total_points++))
			fi
			((j++))
		done
		((i++))
	done

}

game() {
	echo "Enter words which are displayed on the screen and in the end press enter"

	while true; do
		read -p "Choose gamemode (1 min Timed(t)/Word(w)): " mode
		if [ "$mode" = 't' ]; then
			time=60
			break
		elif [ "$mode" = 'w' ]; then
			time=600
			break
		fi
	done

	dis=()
	dis_str=""
	inpt=()
	inpt_str=""
	while true; do
		read -p "Difficulty (Easy(e)/Medium(m)/Hard(h)): " diff
		if [ "$diff" = 'e' ]; then
			DFM="database_for_monkey.txt"
			break
		elif [ "$diff" = 'm' ]; then
			DFM="database_for_monkey_med.txt"
			break
		elif [ "$diff" = 'h' ]; then
			DFM="database_for_monkey_hard.txt"
			break
		fi
	done

	nowd=70
	nowid=260

	i=1
	while [ $i -le $nowd ]; do

	    n=$((RANDOM % $nowid + 1))
	    word="$(sed -n "${n}p" "$DFM")"
	    dis+=("$word")

	    ((i++))
	done
	dis_str="${dis[*]}"

	echo ""
	echo "Type below sentence:"
	echo "${dis[@]}"


	sentence=""
	pos=0
	i=0
	j=0
	SECONDS=0

	while IFS= read -r -s -n1 char; do
		if [ $mode == 't' ]; then
			if [ $SECONDS -ge 60 ]; then
				time_type=$SECONDS
				echo ""
				break
			fi
		fi

		if [[ -z "$char" ]]; then
			time_type=$SECONDS
			echo ""
			break
		fi

		if [[ "$char" == $'\x7f' ]]; then
			if [ ${#sentence} -gt 0 ]; then
				sentence="${sentence%?}"
				if [ $i -eq 0 ]; then
					((j--))
					i=$((lastno + 1))
				fi
				((i--))
				echo -ne "\b \b"
			fi

		elif [[ "$char" == " " ]]; then
			sentence+=" "
			echo -n " "
			((j++))
			lastno=$i
			i=0
			if [ $mode == 'w' ]; then
				if [ $j -ge $nowd ]; then
					time_type=$SECONDS
					break
				fi
			fi

		else
			sentence+="$char"
			exp="${dis[$j]:$i:1}"
			if [ "$char" = "$exp" ]; then
				tput setaf 2
			else
				tput setaf 1
			fi
			echo -n "$char"
			tput sgr0
			((i++))
		fi
	done
	inpt=($sentence)
	compare_arrays inpt dis
	if [ $len_inp -eq 0 ]; then
		echo "Entered nothing"
	else
		accuracy=$(echo "scale=2; ($total_points*100)/$len_inp" | bc)
		echo "Accuracy: $accuracy%"

		wpm=$(echo "scale=2; ($len_inp*12)/$time_type" | bc)
		echo "WPM: $wpm"
	fi
	}

	while true; do
		game
		while true; do
			read -p "Continue the test!! (YES(Y)/NO(N)): " game_state

			if [ "$game_state" = 'Y' ]; then
		    		break
			elif [ "$game_state" = "N" ]; then
				break
			fi
		done
		if [ "$game_state" = "N" ]; then
			break
		fi
	done
