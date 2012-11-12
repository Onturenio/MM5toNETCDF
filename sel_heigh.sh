#!/bin/sh
set -ex

dirwork=/home/guest/TURKIA/MM5toEXT
dirin=/disco2/SALIDAS_TURKIA
dirout=/disco2/SALIDAS_TURKIA/SOME_LEVELS

hs='40 80 120 160'  ## alturas en metros desde el suelo

nlevels=26  ## niveles sigma 

year1=2003
year2=2004

vars='U V DIR T PRS RHO TH RH'

dominios='2'

for dom in $dominios;do

  file_sigmah=$dirin/files/MMEXT_SIGMAH_ERA-TURK_10kmD${dom}_C435421

  for h in $hs;do

    $dirwork/programs/sel_levels.x<<EOF
    $file_sigmah
    $nlevels
    $h
    kk$h-lev1
    kk$h-lev2
    kk$h-pesos1
    kk$h-pesos2
EOF

  done

for var in $vars;do
for year in $(seq $year1 $year2);do
 
  filein=$dirin/$var/MMEXT_TURK_D${dom}_10km_ERA40_C435421_${var}.${year}
  
  for h in $hs;do

    $dirwork/programs/sel_levels_filein.x<<EOF
    $filein
    $nlevels
    kk$h-lev1
    kk$h-lev2
    kk$h-file1
    kk$h-file2
EOF

    cdo mul kk$h-file1 kk$h-pesos1 kk1
    cdo mul kk$h-file2 kk$h-pesos2 kk2
    cdo add kk1 kk2 kk
    cdo setlevel,$h kk kkok

    mkdir -p $dirout/$var/$h
    mv kkok $dirout/$var/$h/MMEXT_TURK_D${dom}_10km_ERA40_C435421_${var}_h${h}m.${year}

  done

rm kk*-file* kk1 kk2 kk 

done
done

rm kk*

done









