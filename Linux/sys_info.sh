


#!/bin/bash

output=$HOME/research2/sys_info.txt


#mkdir ~/research2 2>/dev/null 
if [ ! -d $HOME/research2 ]
then
mkdir $HOME/research2
fi

if [ -f $output ]
then
rm $output
fi


echo "A Quick System Audit Script" >> $output
echo -e "The date is: $(date)" >> $output
echo "MAchine Type Info:" >> $output
echo $MACHTYPE >> $output
echo -e "Uname info: $(uname) \n" >> $output
echo -e "IP Info: $(ip addr | head -9 | tail -1) \n" >> $output
echo "Hostname: $(hostname)" >> $output
​
echo "DNS Servers: "
cat /etc/resolv.conf
​
echo "Memory Info:"
free
​
echo -e "\nCPU Info:"
lscpu
​
echo -e "\nDisk Usage:"
df -H | head -2
​
echo -e "\nWho is logged in: \n $(who) \n"
​
​
echo -e "\nExec Files:" >> $output
find /home -type f -perm 777 >> $output
​
echo -e "\nTop 10 Processes" >> $output
ps aux -m | awk {'print $1, $2, $3, $4, $11'} | head >> $output
​




files=("/etc/shadow" "/etc/passwd")

for x in ${files[@]}
do
ls -l $x
done

