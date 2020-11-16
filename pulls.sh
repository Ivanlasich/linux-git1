#!/bin/bash

curl 'https://api.github.com/repos/datamove/linux-git2/pulls?state=all&page=1&per_page=100' -o "pulls1.json"
curl 'https://api.github.com/repos/datamove/linux-git2/pulls?state=all&page=2&per_page=100' -o "pulls2.json"
jq -s '.[0] + .[1]' pulls1.json pulls2.json > pulls.json


jq '.[].user.login' pulls.json > file1.txt

LOGIN="\"$1\""
answ1=0
answ2=0
INDEX=0
EARLIEST=0;

for LINE in $(cat $"file1.txt")
do
        INDEX=$(($INDEX + 1));
        if [[ $LINE == $LOGIN ]]
        then
                EARLIEST=$INDEX;
                answ1=$(($answ1+1));
        fi
done
echo "PULLS $answ1"

jq '.[].number' pulls.json > file2.txt


INDEX=0
for LINE in $(cat $"file2.txt")
do
        INDEX=$(($INDEX + 1));
        if [[ $INDEX == $EARLIEST ]]
        then
                answ2=$LINE;
        fi
done
echo "EARLIEST $answ2"

jq '.[].merged_at' pulls.json > file3.txt

INDEX=0
for LINE in $(cat $"file3.txt")
do
        INDEX=$(($INDEX + 1));
        if [[ $INDEX == $EARLIEST ]]
        then
                if [ $LINE != 'null' ]
                then
                        answ3=1;
                else
                        answ3=0;
                fi
        fi
done
echo "MERGED $answ3"

rm file*
rm pulls1.json
rm pulls2.json
rm pulls.json
