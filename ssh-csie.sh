echo 'Searching for the best workstation ...'
machines=`bash ./get_server_status.sh`
echo -n "The best three workstation: "
echo $machines

choose=`echo "$machines" | head -n 1`
cmd="ssh b04902053@$choose.csie.ntu.edu.tw"
echo ""
echo $cmd
ssh b04902053@$choose.csie.ntu.edu.tw
