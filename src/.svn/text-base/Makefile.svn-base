#	Lower level Makefile for MM5toGrADS conversion program

#       Suffix rules and commands
#######################
FIX01 =
#######################

.IGNORE:

.SUFFIXES:      .F .f .i .o

.F.o:
		$(RM) $@ 
		$(CPP) $(CPPFLAGS) -D$(MACH) $(FIX01) $*.F > $*.f
		$(FC) -c $*.f $(FCFLAGS) 
		$(RM) $*.f

.F.f:
		$(RM) $@
		$(CPP) $(CPPFLAGS) -D$(MACH) $(FIX01) $*.F > $*.f

.f.o:
		$(RM) $@
		$(FC) -c $*.f $(FCFLAGS) $(FIX01) 
		$(RM) $*.f

OBJS	=	calcclfr.o calcdbz.o calcpt.o calcrh.o calcrho.o calctd.o calcthe.o \
		calcvordiv.o calcv10comp.o mm5tonetcdf.o interp.o lninterp.o nhgeosig.o \
		tdlninterp.o vect.o seaprsnh.o dircomp.o pvp.o integrat.o \
		pvs.o advec.o fillit.o writeout.o 

SRC	=	$(OBJS:.o=.f)

cray dec hp ibm sgi sun default:
		@echo "you need to be up a directory to make mm5tonetcdf.exe"

all:: 		mm5tonetcdf.exe 

mm5tonetcdf.exe:	$(OBJS) 
		$(FC) -o $@  $(OBJS) $(LOCAL_LIBRARIES) $(LDOPTIONS)

code:		$(SRC) 

# -------------------------------------------------------------------------
# DO NOT DELETE THIS LINE -- make depend depends on it.

clean:
		$(RM) $(RM_LIST)
