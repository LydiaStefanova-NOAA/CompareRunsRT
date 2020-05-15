program compare_models
  use param
  use netcdf

  implicit none
  integer                            :: i,ikind,iexp,itile,varid
  character (len = 300)              :: filename(nexp,ntile),expname(nexp),varname,path(nexp),diffname
  character (len = 1)                :: tilenum
  real,dimension(nexp,ntile,nx,ny)   :: dataA, maskA, maskIN
  integer,dimension(nexp,0:nkind-1)  :: countA, countAB
  real,dimension(nexp,0:nkind-1)     :: minA, maxA, meanA
  real,dimension(nexp,0:nkind-1)     :: minAB, maxAB, meanAB,rmsAB,pnuAB,pndAB

  !path(1)="/scratch1/NCEPDEV/stmp2/Lydia.B.Stefanova/fromHPSS/forRegTest/IPD/phyf840.tile"
  !path(2)="/scratch1/NCEPDEV/stmp2/Lydia.B.Stefanova/fromHPSS/forRegTest/CCPP/phyf840.tile"
  !path(3)="/scratch1/NCEPDEV/stmp2/Lydia.B.Stefanova/fromHPSS/forRegTest/CCPP/phyf840.tile"
  !expname(1)="IPD"
  !expname(2)="CCPP"
  !expname(3)="CCPP"
  
  do iexp=1,nexp
     call getarg(iexp,path(iexp))
     call getarg(nexp+iexp,expname(iexp))
     print *,iexp,domask
  end do
     do itile = 1, ntile
        write(tilenum,"(I1)") itile
        do iexp = 1, nexp
           if (domask.eq.1) then
              filename(iexp,itile)=trim(path(iexp))//tilenum//".nc"
              call readbyname  (filename(iexp,itile), maskIN(iexp,itile,:,:)  , "land",varid)
           else
              filename(iexp,itile)=trim(path(iexp))
           end if
        print *,iexp,itile,filename(iexp,itile)
        end do
     end do

  print *,varmin,varmax
  do varid = varmin, varmax
     do itile = 1, ntile
        do iexp = 1, nexp
           call readbynumber  (filename(iexp,itile)  , dataA(iexp,itile,:,:), varname, varid)
        end do
     end do

     if (domask.eq.1) then
        maskA=maskIN
     else
        maskA=0
     endif

     where (abs(dataA).gt.1e15)
        maskA=3              !mask out cases of NAN in data
     end where
    
     do ikind = 0, nkind-1
        do iexp=1,nexp
           call statsalone(dataA(iexp,:,:,:), maskA(iexp,:,:,:),ikind, &
                           countA(iexp, ikind), minA(iexp,ikind), maxA(iexp,ikind), meanA(iexp,ikind))
           call statscross(dataA(iexp,:,:,:), maskA(iexp,:,:,:),&
                           dataA(nexp,:,:,:), maskA(nexp,:,:,:), ikind, & 
                           countAB(iexp, ikind), minAB(iexp,ikind), maxAB(iexp,ikind), meanAB(iexp,ikind), &
                           pnuAB(iexp, ikind), pndAB(iexp,ikind), rmsAB (iexp,ikind))
        end do
     end do

!===OUTPUT TO SCREEN
!23456789123456789123456789123456789123456789 
     print *,"========================="
     print 10,varid,varname
     print *,"-------------------------"
     print *," "
     print 100,"STYP","VALD"," MIN"," MAX","MEAN"," RMS","SRMS"," %UP"," %DN"
     print *," "
     do ikind = 0, nkind-1 
        do iexp=1,nexp
           print 1000,trim(expname(iexp)),&
                      ikind,countA(iexp,ikind),minA(iexp,ikind),maxA(iexp,ikind), meanA(iexp,ikind)
        end do
        do iexp=1,nexp-1
           !diffname=trim(expname(iexp))//" vs "//trim(expname(nexp))
           write(diffname,'(a4, a4, a4)')trim(expname(iexp))," vs ",trim(expname(nexp))
           print 1000,diffname,&
                      ikind,countAB(iexp,ikind),minAB(iexp,ikind),maxAB(iexp,ikind),meanAB(iexp,ikind),&
                      rmsAB(iexp,ikind),rmsAB(iexp,ikind)/abs(meanA(nexp,ikind)),&
                      pnuAB(iexp,ikind)*100,pndAB(iexp,ikind)*100
        end do
        print *," "
     end do
  end do
 10   format (i3,4x,a30)
 100  format (14x,a4,8x,a4,8(9x,a4,x))
 1000 format (a12,4x,i2,4x,i8,4(4x,e10.3),3(4x,f10.3))

end program compare_models 

