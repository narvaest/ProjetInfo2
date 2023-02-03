set title "Date, pressure" font ",20"
set key left box
set samples 50
set style data points
set xlabel "Date"
set ylabel "moy pressure"
set terminal png size 500,500
set output '2.png'

plot "testetet.txt" using 2:3 with lines
