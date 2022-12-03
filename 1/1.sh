#!/bin/bash
max=(0 0 0)
declare -i sum=0
updateMax () {
    for i in {0..2};
    do
        if (( $sum > ${max[$i]} ));
        then
            for ((j = 2 ; j > $i ; j--))
            do
                max[$j]=${max[$j-1]}
            done
            max[$i]=$sum
            break
        fi
    done
}
while read -r line || [[ -n "$line" ]]; do
    if [[ $line == "" ]];
    then
        updateMax
        sum=0
    else
        sum+=$line
    fi 
done
updateMax
echo ${max[0]}
sum=0
for i in ${max[@]};
do
    sum+=$i
done
echo $sum