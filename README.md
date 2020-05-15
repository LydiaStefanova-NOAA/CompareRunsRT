# CompareRunsRT: 
Compare two or three runs obtained from the regression test system. Everything that needs to be edited for a new run is in "runcompare.sh"

NB: Currently set up to run on Hera. To run on a different system, make sure that the correct intel and netcdf modules are loaded 
  
To run comparisons, edit these lines in script "runcompare.sh"

(If loading different intel and netcdf modules, change CDF=/apps/netcdf/4.7.0/intel/18.0.5.274 accordingly)

nexp=3    # number of experiments (if nexp=2, expname3 and rootpath3 can be left blank)  

expname1="IPD"   # Best if <5 characters (used for labeling)
expname2="CCPP"  # Best if <5 characters (used for labeling)
expname3="CCP2"  # Best if <5 characters (used for labeling)

rootpath1="/scratch1/NCEPDEV/stmp2/Lydia.B.Stefanova/fromHPSS/forRegTest/IPD/"   # path to output of exp1
rootpath2="/scratch1/NCEPDEV/stmp2/Lydia.B.Stefanova/fromHPSS/forRegTest/CCPP/"  # path to output of exp2
rootpath3="/scratch1/NCEPDEV/stmp2/Lydia.B.Stefanova/fromHPSS/forRegTest/CCPP/"  # path to output of exp3

domain="atm"; file="phyf"; extn="840.tile"    # use this for atmospheric phyf840.tile$NTILE.nc  files  
\#domain="ocn"; file="ocn"; extn="_2013_04_01_03.nc"  # use this for oceanic ocn_2013_04_01_03.nc files  
\#domain="ice"; file="ice"; extn="h_06h.2013-04-11-00000.nc"  # use this for ice iceh_06h.2013-04-11-00000.nc files  
  


Executing the script will:   
    1) update the parameters in param.F90  
    2) create a Makefile  
    3) compile (using that Makefile) and create an executable "runcompare"  
    4) run the executable with the experiment names/paths specified above for the chosen component (ocn/ice/atm)  
