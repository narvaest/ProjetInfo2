set title "Pressure depending on the station"
set xlabel "ID Station"
set ylabel "MOY pressure"
set xrange [6000:100000]
set yrange [90000:110000]
unset key
set terminal png size 500,500
set output '1.png'
plot "testetet.txt" using 1:2:(($4-$3)/2) w errorbars
