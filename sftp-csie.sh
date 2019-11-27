#!/bin/bash

cmd=''
id=$(cat ~/.ssh-csie.conf)
if [[ $# -eq 1 ]]; then
	# specific workstation
	first_letter=$(echo $1 | cut -c 1)
	if [ $first_letter == 'b' ] || [ $first_letter == 'o' ] || [ $first_letter == 'l' ]; then
		# specific bsd or oasis or linux
		cmd="sftp $id@$1.csie.ntu.edu.tw"
	else
		# linux
		cmd="sftp $id@linux$1.csie.ntu.edu.tw"
	fi
else
	# auto search for the best workstation
	echo 'Searching for the best workstation ...'
	DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
	machines=$(python3 ${DIR}/sort_server.py)
	echo The best three workstations: $(echo "$machines" | head -n 3)
	choose=$(echo "$machines" | head -n 1)
	cmd="sftp $id@linux$choose.csie.ntu.edu.tw"
fi

echo $cmd
$cmd
