#!/bin/bash
clear
printf "[CLEANER] Starting ...\n"
mkdir cache
printf "[CLEANER] Step set to: $1 \n"
uuid=$(uuidgen)
filename="cache/$uuid.txt"
thetext="0000000000"
i=1
n=$(($1))
for (( i=1; i<=$n; i++ ))
do
    printf "[CLEANER] Creating contect step: $i\033[0K\r"
    thetext+="$thetext"
done
printf $thetext >> $filename
filelength=${#thetext}
printf "[CLEANER] File size in bytes: %'d\n" $filelength
printf "[CLEANER] Processing ...\n"
{ 
    while true 
    do
        uuid=$(uuidgen)
        cp $filename "cache/$uuid.txt"
        if [ $? -ne 0 ]
        then
            printf "[CLEANER] Cannot process further no space more !\n"
            printf "[CLEANER] Deleting cache ...\n"
            rm -rf cache
            printf "[CLEANER] Cache deleted !\n"
            break
        fi
        printf "[CLEANER] Space to process: $(df -kh . | tail -n1 | awk '{print $4}')\033[0K\r"

        #printf $thetext >> $filename
    done
} || 
{
    echo "[CLEANER] Space to process: Error\n"
}
printf "[CLEANER] Done. Bye.\n"
