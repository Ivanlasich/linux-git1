#! /usr/bin/gnuplot
set terminal png size 300,400
set datafile separator comma
f(x) = m*x + b
fit f(x) '/home/datamove/hotels.csv' using 18:(12 > 0 ? 12 : 1/0) via m, b
set output 'w_vs_h_fit.png'
plot '/home/datamove/hotels.csv' using 18:(12 > 0 ? 12 : 1/0) title 'Height vs. Weight' with points, f(x) title 'fit'
