#!/bin/bash
awk -F, 'BEGIN{x=0; y=0} {x+=$18; y+=1} END{print "RATING_AVG", x/y}' /home/datamove/hotels.csv
awk -F, '{ if(tolower($7)!="country") sum[tolower($7)]+= 1} END { for(i in sum) { print "HOTELNUMBER",i,sum[i] }}' /home/datamove/hotels.csv
awk -F, '/hilton/ {tolower($2); country1[tolower($7)]+= $12; count1[tolower($7)]+= 1} /holiday inn/ {tolower($2); country2[tolower($7)]+= $12; count2[tolower($7)]+= 1}  END { for(i in country1) { print "CLEANLINESS", i, country2[i]/count2[i], country1[i]/count1[i]}}'  /home/datamove/hotels.csv

gnuplot
set terminal png size 300,400
set datafile separator comma
f(x) = m*x +b
fit f(x) '/home/datamove/hotels.csv' using 12:18 via m,b
set output 'w_vs_h_fit.png'
plot '/home/datamove/hotels.csv' using 12:18 title 'Height vs. Weight' with points, f(x) title 'fit'
