unset grid
unset key
unset label
set view map
unset surface
unset contour
set clabel '%8.3g'
set datafile separator whitespace
set size ratio 1 1,1
set xtics 30 norangelimit
set ytics 30 norangelimit
set xlabel "Phi" 
set xrange [ -180.000 : 180.000 ] noreverse nowriteback
set ylabel "Psi" 
set yrange [ -180.000 : 180.000 ] noreverse nowriteback
set cblabel "Energy (kcal/mol)" 
set cblabel  offset character 5, 0, 0 font "" textcolor lt -1 rotate by -270
set cbrange [ * : * ] noreverse nowriteback
set zero 1e-08
set pm3d implicit at s
set pm3d scansautomatic
set pm3d interpolate 20,20 flush begin noftriangles nohidden3d corners2color mean
set palette positive nops_allcF maxcolors 0 gamma 1.5 color model RGB 
set palette rgbformulae 7, 5, 15
set title 'alanine ramachandran phi-psi'
splot 'minimized.dihedrals.txt' u ($1):($2):($3)
pause mouse
set term postscript portrait enhanced color "Times-Roman" 16
set out "chm2.eps"
rep