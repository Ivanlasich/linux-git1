#!/bin/bash

awk -F, 'BEGIN{x=0; y=0} {if($18>=0){x+=$18; y+=1}} END{print "RATING_AVG", x/y}' /home/datamove/hotels.csv
awk -F, '{ if(tolower($7)!="country") sum[tolower($7)]+= 1} END { for(i in sum) { print "HOTELNUMBER",i,sum[i] }}' /home/datamove/hotels.csv
awk -F, '/hilton/ {tolower($2); country1[tolower($7)]+= $12; count1[tolower($7)]+= 1} /holiday inn/ {tolower($2); country2[tolower($7)]+= $12; count2[tolower($7)]+= 1}  END { for(i in country1) { print "CLEANLINESS", i, country2[i]/count2[i], country1[i]/count1[i]}}'  /home/datamove/hotels.csv

./processs.sh



