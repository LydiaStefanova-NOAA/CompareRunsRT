# CompareRunsRT
Purpose: Compare two or three runs obtained from the regression test system
(Currently set up to run on Hera)

Edit these lines in script "runcompare.sh"

nexp=3    # number of experiments (if nexp=2, expname3 and rootpaht3 can be left blank)

expname1="IPD"

expname2="CCPP"

expname3="CCP2"

rootpath1="/scratch1/NCEPDEV/stmp2/Lydia.B.Stefanova/fromHPSS/forRegTest/IPD/"   # path to output of exp1

rootpath2="/scratch1/NCEPDEV/stmp2/Lydia.B.Stefanova/fromHPSS/forRegTest/CCPP/"  # path to output of exp2

rootpath3="/scratch1/NCEPDEV/stmp2/Lydia.B.Stefanova/fromHPSS/forRegTest/CCPP/"  # path to output of exp3

domain="atm"; file="phyf"; extn="840.tile"    # use this for atmospheric phyf840.tile$NTILE.nc  files

\#domain="ocn"; file="ocn"; extn="_2013_04_01_03.nc"  # use this for oceanic ocn_2013_04_01_03.nc files
\#domain="ice"; file="ice"; extn="h_06h.2013-04-11-00000.nc"  # use this for ice iceh_06h.2013-04-11-00000.nc files
  
  executing the script will: 
    1) update the parameters in param.F90
    2) create a Makefile
    3) compile (using that Makefile) and create an executable "runcompare"
    4) run the executable with the experiment names/paths specified above for the chosen component (ocn/ice/atm)
