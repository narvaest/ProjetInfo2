set title "Temperature depending on the station"
set xlabel "ID Station"
set ylabel "MOY temperature"
set xrange [6800:90000]
set yrange [-30:50]
unset key
set terminal png size 500,500
set output '1.png'
plot "1.txt" using 1:2 with lines
