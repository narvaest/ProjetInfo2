set title "Temperature depending on the station"
set xlabel "ID Station"
set ylabel "MOY temperature"
set xrange [6000:100000]
set yrange [-30:50]
unset key
set terminal png size 500,500
set output '1.png'
plot "testetet.txt" using 1:2:(($4-$3)/2) w errorbars
