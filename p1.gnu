set title "Pressure depending on the station"
set xlabel "ID Station"
set ylabel "MOY pressure"
set xrange [6900:]
set yrange [90000:110000]
unset key
set terminal png size 1000,500
set output '1.png'
plot "1.txt" using 1:2 w l
