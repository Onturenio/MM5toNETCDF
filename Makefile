#	Top-level Makefile for MM5toNETCDF conversion program

#	Macros, these should be generic for all machines

.IGNORE:

AR	=	ar ru
CD	=	cd
LN	=	ln -s
MAKE	=	make -i -f Makefile
RM	=	/bin/rm -f
RM_LIST	=	*.o *.f core .tmpfile mm5tonetcdf.exe ../mm5tonetcdf.exe
RM_LIST2=	*.o *.f core .tmpfile make.mm5tonetcdf.out mm5tonetcdf.namelist mm5tonetcdf.print.out

#	Targets for supported architectures

default:
	uname -a > .tmpfile
	grep CRAY .tmpfile ; \
	if [ $$? = 0 ]; then echo "Compiling for CRAY" ; 		\
		( $(CD) src ; $(MAKE) all				\
		"RM		= $(RM)" 	"RM_LIST	= $(RM_LIST)"	\
		"LN		= $(LN)" 	"MACH		= linux"		\
		"MAKE		= $(MAKE)"	"CPP		= /opt/ctl/bin/cpp" \
		"CPPFLAGS	= -I. -C -P -DRECLENBYTE"	\
		"FC		= ifort" 		"FCFLAGS	= -I. -f free"		\
		"LDOPTIONS      = " 		"CFLAGS         = "		\
		"LOCAL_LIBRARIES= " ) ; \
	else \
		grep OSF .tmpfile ; \
	if [ $$? = 0 ]; then echo "Compiling for Compaq" ; 		\
		( $(CD) src ; $(MAKE) all 				\
		"RM		= $(RM)" 	"RM_LIST	= $(RM_LIST)"	\
		"LN		= $(LN)" 	"MACH		= DEC"		\
		"MAKE		= $(MAKE)"	"CPP		= /usr/bin/cpp" \
		"CPPFLAGS	= -I. -C -P "			\
		"FC		= f90"		"FCFLAGS	= -I. -free -convert big_endian -fpe"	\
		"LDOPTIONS      = "		"CFLAGS         = "		\
		"LOCAL_LIBRARIES= " ) ; \
	else \
		grep IRIX .tmpfile ; \
	if [ $$? = 0 ]; then echo "Compiling for SGI" ; 		\
		( $(CD) src ; $(MAKE) all				\
		"RM		= $(RM)" 	"RM_LIST	= $(RM_LIST)"	\
		"LN		= $(LN)" 	"MACH		= linux" 		\
		"MAKE		= $(MAKE)"	"CPP		= /lib/cpp"	\
	 	"CPPFLAGS	= -I. -C -P "			\
		"FC		= f90" 		"FCFLAGS	= -I. -n32 -freeform"	\
		"LDOPTIONS      = -n32"		"CFLAGS         = -I. -n32"	\
		"LOCAL_LIBRARIES= " ) ; \
	else \
		grep HP .tmpfile ; \
	if [ $$? = 0 ]; then echo "Compiling for HP" ; 			\
		( $(CD) src ; $(MAKE) all				\
		"RM		= $(RM)" 	"RM_LIST	= $(RM_LIST)"	\
		"LN		= $(LN)" 	"MACH		= linux"		\
		"MAKE		= $(MAKE)"	"CPP		= /opt/langtools/lbin/cpp" \
		"CPPFLAGS= -I. -C -P -DRECLENBYTE"		\
		"FC		= f90" 		"FCFLAGS	= -I. -O +langlvl=90 +source=free"	\
		"LDOPTIONS	= " 		"CFLAGS		= -Aa"		\
		"LOCAL_LIBRARIES= " ) ; \
	else \
		grep SUN .tmpfile ; \
	if [ $$? = 0 ]; then echo "Compiling for SUN" ; 		\
		( $(CD) src ; $(MAKE) all				\
		"RM		= $(RM)" 	"RM_LIST	= $(RM_LIST)"	\
		"LN		= $(LN)" 	"MACH		= linux"		\
		"MAKE		= $(MAKE)"	"CPP		= /usr/ccs/lib/cpp" \
		"CPPFLAGS=-I. -C -P -DRECLENBYTE"		\
		"FC		= f90" 		"FCFLAGS	= -I. -free"		\
		"LDOPTIONS	= "    		"CFLAGS		= -I."		\
		"LOCAL_LIBRARIES= " ) ; \
	else \
		grep AIX .tmpfile ; \
	if [ $$? = 0 ]; then echo "Compiling for IBM" ;			\
		( $(CD) src ; $(MAKE) all				\
		"RM		= $(RM)" 	"RM_LIST	= $(RM_LIST)"	\
		"LN		= $(LN)" 	"MACH		= linux"		\
		"MAKE		= $(MAKE)"	"CPP		= /usr/lib/cpp" \
		"CPPFLAGS	= -I. -C -P -DRECLENBYTE"	\
		"FC		= xlf_r"		"FCFLAGS	= -I. -O -qmaxmem=-1 -qfree=f90" \
    "LDOPTIONS	= -bmaxstack:512000000 -bmaxdata:2000000000 -qarch=pwr6 -qnosave -qstrict -qextname" "CFLAGS= -I."		\
		"LOCAL_LIBRARIES= -L/sw/aix61/netcdf-4.2/lib -lnetcdf" ) ; \
	else \
		grep Linux .tmpfile ; \
	if [ $$? = 0 ]; then echo "Compiling for Linux" ;		\
		( $(CD) src ; $(MAKE) all				\
		"RM		= $(RM)" 	"RM_LIST	= $(RM_LIST)"	\
		"LN		= $(LN)" 	"MACH		= linux"		\
		"MAKE		= $(MAKE)"	"CPP		= /lib/cpp"	\
		"CPPFLAGS	= -I. -C -traditional -DRECLENBYTE"	\
		"FC		= pgf90"	"FCFLAGS	= -I. -Mfree -O2 -tp p6 -pc 32 -byteswapio"\
		"LDOPTIONS	= " 		"CFLAGS		= -I."		\
		"LOCAL_LIBRARIES= " ) ; \
	else echo "Do not know how to compile for the `cat .tmpfile` machine." \
		fi ; \
		fi ; \
		fi ; \
		fi ; \
		fi ; \
		fi ; \
		fi ; \
	fi ; \
		( $(RM) mm5tonetcdf.exe ; $(LN) src/mm5tonetcdf.exe . ) ;

intel:
	"Compiling for Linux with INTEL compiler" ;		\
		( $(CD) src ; $(MAKE) all				\
		"RM		= $(RM)" 	"RM_LIST	= $(RM_LIST)"	\
		"LN		= $(LN)" 	"MACH		= linux"		\
		"MAKE		= $(MAKE)"	"CPP		= /lib/cpp"	\
		"CPPFLAGS	= -C -traditional -DRECLENBYTE -Drecl -static -I/usr/include"	\
		"FC		= ifort"	"FCFLAGS	= -I/usr/include -FR -pc 32 -convert big_endian -O3 -static -L/usr/lib64/ -lnetcdf"\
		"LDOPTIONS	= -O3 -static -L/usr/lib64/ -lnetcdf" 		"CFLAGS		= -O3 -I/usr/include -static"		\
		"LOCAL_LIBRARIES=/usr/lib64/crt1.o" ) ; \
		( $(RM) mm5tonetcdf.exe ; $(LN) src/mm5tonetcdf.exe . ) ;

gfortran:
	"Compiling for Linux with gfortran compiler" ;		\
		( $(CD) src ; $(MAKE) all				\
		"RM		= $(RM)" 	"RM_LIST	= $(RM_LIST)"	\
		"LN		= $(LN)" 	"MACH		= linux"		\
		"MAKE		= $(MAKE)"	"CPP		= /lib/cpp"	\
		"CPPFLAGS	= -C -traditional -DRECLENBYTE -Drecl -I/usr/local/include -static"	\
		"FC		= gfortran"	\
		"FCFLAGS	= -I/usr/include -ffree-form -ffree-line-length-none -fconvert=big-endian -O3 -L/usr/lib64 -lnetcdff"\
		"LDOPTIONS	= -O3 -L/usr/lib64 -lnetcdff" \
		"CFLAGS		= -O3 -I/usr/include"		\
		"LOCAL_LIBRARIES=" ) ; \
		( $(RM) mm5tonetcdf.exe ; $(LN) src/mm5tonetcdf.exe . ) ;

IBM:
	"Compiling for IBM Power6" ;		\
		( $(CD) src ; $(MAKE) all				\
		"RM		= $(RM)" 	"RM_LIST	= $(RM_LIST)"	\
		"LN		= $(LN)" 	"MACH		= linux"		\
		"MAKE		= $(MAKE)"	"CPP		= /lib/cpp"	\
		"CPPFLAGS	= -C -P -DRECLENBYTE"	\
		"FC		= xlf90_r"	"FCFLAGS	= -L/sw/aix61/netcdf-4.2/lib -lnetcdf -lhdf5_hl -lhdf5 -lm -lz -L/sw/aix61/hdf5-1.8.8/lib -L/sw/aix53/zlib-1.2.6/lib -L/sw/aix53/szip-2.1/lib -lsz -I/sw/aix61/netcdf-4.2/include -O -qmaxmem=-1 -qfree=f90 -qextname"\
    "LDOPTIONS	=-bmaxstack:512000000 -bmaxdata:2000000000 -qarch=pwr6 -qnosave -qstrict -qextname -L/sw/aix61/netcdf-4.2/lib -lnetcdff -lnetcdf -L/sw/aix61/netcdf-4.2/lib -lnetcdf -lhdf5_hl -lhdf5 -lm -lz -L/sw/aix61/hdf5-1.8.8/lib -L/sw/aix53/zlib-1.2.6/lib -L/sw/aix53/szip-2.1/lib -lsz" "CFLAGS= " \
		"LOCAL_LIBRARIES=" ) ; \
		( $(RM) mm5tonetcdf.exe ; $(LN) src/mm5tonetcdf.exe . ) ;

code:
	( $(CD) src ; $(MAKE) code					\
	"MAKE			=	$(MAKE)"			\
	"CPP			=	/usr/bin/cpp"			\
	"CPPFLAGS		=	-I. -C -P -DDEC"		)

clean:
	( $(CD) src   ; $(MAKE) clean "CD = $(CD)" "RM = $(RM)" "RM_LIST = $(RM_LIST)" )
	$(RM) $(RM_LIST2)
