url="https://monitor.csie.ntu.edu.tw/status.html"
curl -s $url | grep td > ./status_table.html

# normal: 0
# low:    1
# medium: 3
# high:   5

# Calculate score based on different colors on the cell in the table
for ((i = 0; i < 19; i++))
do
	machine_id=$(((i+1)*10))

	machine[$i]=`cat ./status_table.html | \
		head -n $machine_id | tail -n 10 | \
		grep 'center' | \
		egrep -o '>.+<' | sed 's/>//' | sed 's/<//' | \
		cat`

	status=`cat ./status_table.html | \
		head -n $machine_id | tail -n 10 | \
		egrep -o 'class=".+"' | \
		sed 's/class="//' | sed 's/"//' | \
		sed 's/normal/0/' | \
		sed 's/low/1/' | \
		sed 's/medium/3/' | \
		sed 's/high/5/' | \
		cat`

	score[$i]=0
	for ((j = 1; j < 11; j++))
	do
		status_num=`echo $status | sed 's/ /\n/g' | head -n $j | tail -n 1`
		score[$i]=$((score[$i] + status_num))
	done
done
rm -f ./status_table.html

# for ((i = 0; i < 19; i++))
# do
# 	echo ${machine[$i]}: ${score[$i]}
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

min_1_id=1
min_2_id=1
min_3_id=1

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

echo ${machine[$min_1_id]}
echo ${machine[$min_2_id]}
echo ${machine[$min_3_id]}
