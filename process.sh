#!/bin/bash

awk -F, 'BEGIN{x=0; y=0} {if($18>=0){x+=$18; y+=1}} END{print "RATING_AVG", x/y}' /home/datamove/hotels.csv
awk -F, '{ if(tolower($7)!="country") sum[tolower($7)]+= 1} END { for(i in sum) { print "HOTELNUMBER",i,sum[i] }}' /home/datamove/hotels.csv
awk -F, '/hilton/ {tolower($2); country1[tolower($7)]+= $12; count1[tolower($7)]+= 1} /holiday inn/ {tolower($2); country2[tolower($7)]+= $12; count2[tolower($7)]+= 1} END { for(i in country1) { print "CLEANLINESS", i, country2[i]/count2[i], country1[i]/count1[i]}}'  /home/datamove/hotels.csv

gnuplot -e "set terminal png size 300, 400;
	    set output 'new_plot.png';
	    set datafile separator comma;
	    f(x) = m * x + b;
	    fit f(x) '/home/datamove/hotels.csv' using 18:(\$12 > 0 ? \$12 : 1/0) via m, b;
	    plot '/home/datamove/hotels.csv' using 18:(\$12 > 0 ? \$12 : 1/0) title 'x vs y' with points, f(x) title 'fit';
            exit();"



