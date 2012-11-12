# "infilename" is the input file to the MM5tonetCDF program
#  (include full path if file is not in current directory)
#
# "outfilename" is the name of the output from the MM5tonetCDF program
#  (include full path if you do not want the files to be placed in
#   current directory)
# outfilename will be used for both the .ctl and .dat file
# In the case below the files test.ctl and test.dat will be created


file=/disk/CLIMA/MM5-PORTUGAL/2007-2007-PORTUGAL-435421/Run435421_PORTUGAL_parallel/MMOUT_DOMAIN3

infilename=$file
outfilename=${file}.nc

echo 'Input: '$infilename ' Output '$outfilename

###############################################################
###############################################################
#####                                                     #####
#####             END OF USER MODIFICATIONS               #####
#####                                                     #####
###############################################################
###############################################################

#------------------  SET THE SYMBOLIC LINKS  -----------------#
echo ....setting links to data....
rm -f fort.10
rm -f fort.80
rm -f fort.81
ln -s ${infilename} fort.10

#------------------  RUN THE PROGRAM  ------------------------#
echo ....running....
/home/jimenez/MM5toNETCDF/mm5tonetcdf.exe

mv output.nc ${outfilename}


#-----------------  CLEAN UP  --------------------------------#
rm -f fort.10
rm -f fort.80
rm -f fort.81

cd /home/jimenez/MM5toNETCDF
echo ....Program finished....
