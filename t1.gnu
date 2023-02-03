set title "Temperature depending on the station"
set xlabel "ID Station"
set ylabel "MOY temperature"
set xrange [6900:]
set yrange [-30:50]
unset key
set terminal png size 1000,500
set output '1.png'
plot "1.txt" using 1:2 with lines
