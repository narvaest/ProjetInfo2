#!/usr/local/bin/gnuplot -persist
# set terminal pngcairo  transparent enhanced font "arial,10" fontscale 1.0 size 600, 400 
# set output 'pm3d.1.png'
set border 4095 front lt black linewidth 1.000 dashtype solid
set samples 25, 25
set isosamples 20, 20
set style data lines
set title "pm3d demo. Radial sinc function. Default options." 
set xlabel "x" 
set xrange [ -15.0000 : 15.0000 ] noreverse nowriteback
set x2range [ * : * ] noreverse writeback
set ylabel "y" 
set yrange [ -15.0000 : 15.0000 ] noreverse nowriteback
set y2range [ * : * ] noreverse writeback
set zrange [ -0.250000 : 1.00000 ] noreverse nowriteback
set cbrange [ * : * ] noreverse writeback
set rrange [ * : * ] noreverse writeback
set pm3d implicit at s
set colorbox vertical origin screen 0.9, 0.2 size screen 0.05, 0.6 front  noinvert bdefault
NO_ANIMATION = 1
splot sin(sqrt(x**2+y**2))/sqrt(x**2+y**2)
