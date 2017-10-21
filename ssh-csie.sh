id=`cat ~/.ssh-csie-config`

machines=''
get_server_status(){
	url="https://monitor.csie.ntu.edu.tw/status.html"
	status_table=`curl -s $url | grep td`

	# Get machine names.
	machine=`echo "$status_table" | \
		grep 'center' | \
		egrep -o '>.+<' | sed 's/>//' | sed 's/<//' | \
		cat`
	readarray machine_arr <<< "$machine"

	# Get machine scores.
	#   normal: 0
	#   low:    1
	#   medium: 3
	#   high:   5
	status=`echo "$status_table" | \
		egrep -o 'class=".+"' | \
		sed 's/class="//' | sed 's/"//' | \
		sed 's/normal/0/' | \
		sed 's/low/1/' | \
		sed 's/medium/3/' | \
		sed 's/high/5/' | \
		cat`
	readarray status_arr <<< "$status"

	# Calculate score based on different colors on the cell in the table
	for ((i = 0; i < 19; i++))
	do
		score[$i]=0
		for ((j = i*9; j < (i+1)*9; j++))
		do
			score[$i]=$((score[$i] + status_arr[$j]))
		done
	done

	# for ((i = 0; i < 19; i++))
	# do
	# 	echo ${machine_arr[$i]}: ${score[$i]}
	# done

	# 0 - bsd1
	# 1 - linux1
	# 2 - linux2
	# 3 - linux3
	# 4 - linux4
	# 5 - linux5
	# 6 - linux6
	# 7 - linux7
	# 8 - linux8
	# 9 - linux9
	# 10 - linux10
	# 11 - linux11
	# 12 - linux12
	# 13 - linux13
	# 14 - linux14
	# 15 - linux15
	# 16 - oasis1 (*)
	# 17 - oasis2 (*)
	# 18 - oasis3 (*)

	beg_id=1
	end_id=16

	min_1_id=$beg_id
	min_2_id=$beg_id
	min_3_id=$beg_id

	# find the minimal workstation
	for ((i = $beg_id; i < end_id; i++)); do
		if [ "${score[$i]}" -lt "${score[$min_1_id]}" ]; then
			min_1_id=$i
		fi
	done

	# find the 2nd minimal workstation
	if [ "$min_1_id" -eq "$beg_id" ]; then
		min_2_id=1
	fi
	for ((i = $beg_id; i < end_id; i++)); do
		if [ "$i" -eq "$min_1_id" ]; then
			continue
		fi
		if [ "${score[$i]}" -lt "${score[$min_2_id]}" ]; then
			min_2_id=$i
		fi
	done

	# find the 3rd minimal workstation
	if [ "$min_1_id" -lt "$(($beg_id+2))" ] || [ "$min_2_id" -lt "$(($beg_id+2))" ]; then
		min_2_id=2
	fi
	for ((i = $beg_id; i < end_id; i++)); do
		if [ "$i" -eq "$min_1_id" ] || [ "$i" -eq "$min_2_id" ]; then
			continue
		fi
		if [ "${score[$i]}" -lt "${score[$min_3_id]}" ]; then
			min_3_id=$i
		fi
	done

	machines=`echo ${machine_arr[$min_1_id]}; echo ${machine_arr[$min_2_id]}; echo ${machine_arr[$min_3_id]}`
}

echo 'Searching for the best workstation ...'
get_server_status
echo The best three workstations: $machines

choose=`echo "$machines" | head -n 1`
cmd="ssh $id@$choose.csie.ntu.edu.tw"
echo ""
echo $cmd
ssh $id@$choose.csie.ntu.edu.tw
