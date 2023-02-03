# set terminal pngcairo  transparent enhanced font "arial,10" fontscale 1.0 size 600, 400 
# set output 'moisture.png'
set border 4095 front lt black linewidth 1.000 dashtype solid
set samples 25, 25
set isosamples 20, 20
set style data lines
set title "Height" 
set xlabel "Latitude" 
set xrange [ -70 : 70 ] noreverse nowriteback
set x2range [ * : * ] noreverse writeback
set ylabel "Longitude" 
set yrange [ -70: 140 ] noreverse nowriteback
set y2range [ * : * ] noreverse writeback
set zrange [ 0 : 101 ] noreverse nowriteback
set cbrange [ * : * ] noreverse writeback
set rrange [ * : * ] noreverse writeback
set pm3d implicit at s
set colorbox vertical origin screen 0.9, 0.2 size screen 0.05, 0.6 front  noinvert bdefault
NO_ANIMATION = 1
splot "sortmoisture.txt" using 3:4:2
