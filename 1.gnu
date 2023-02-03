set title "Pressure depending on the station"
set xlabel "ID Station"
set ylabel "Moy pressure"
set xrange [95:130]
set yrange [30:90]
unset key
set terminal png size 500,500
set output '1.png'
plot "testetet.txt" using 1:2:(($4-$3)/2) w errorbars
