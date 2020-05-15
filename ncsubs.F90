  subroutine check(status)
    use netcdf
    use param
    integer, intent ( in) :: status
    if(status /= nf90_noerr) then
      print *, trim(nf90_strerror(status))
      stop "Stopped"
    end if
  end subroutine check

  subroutine readlatlon(filename,lat,lon,varlat,varlon)
    use netcdf
    use param
    character(len=*),intent(in)       :: filename,varlat,varlon
    real,intent(out)                  :: lon(nx),lat(ny)
    integer                           :: ncid, varid
    call check( nf90_open(filename, nf90_nowrite, ncid) )
    call check( nf90_inq_varid(ncid, varlon, varid) )
    call check( nf90_get_var(ncid, varid, lon))
    call check( nf90_inq_varid(ncid, varlat, varid) )
    call check( nf90_get_var(ncid, varid, lat))
    call check( nf90_close(ncid) )
  end subroutine readlatlon

  subroutine readbynumber(filename,array,varname,varid)
    use netcdf
    use param
    integer,intent(in)                :: varid
    character(len=*),intent(in)       :: filename
    real,intent(out) :: array(nx,ny)
    character(len=30)                 :: varname
    integer                           :: ncid
    call check( nf90_open(filename, nf90_nowrite, ncid) )
    call check (nf90_inquire_variable(ncid, varid, varname))
    call check( nf90_get_var(ncid, varid, array))
    call check( nf90_close(ncid) )
  end subroutine readbynumber

  subroutine readbyname(filename,array,varname,varid)
    use netcdf
    use param
    character(len=*),intent(in)       :: filename,varname
    real,intent(out) :: array(nx,ny)
    integer                           :: ncid, varid
    call check ( nf90_open(filename, nf90_nowrite, ncid))
    call check ( nf90_inq_varid(ncid, varname, varid))
    call check ( nf90_get_var(ncid, varid, array))
    call check ( nf90_close(ncid) )

  end subroutine readbyname

  subroutine weights (wgt,lat)
    use param
    real,intent(in)      :: lat(ny)
    real,intent(out)     :: wgt(ny)
    real                 :: pi
    pi  = acos (-1.)
    wgt = cos(lat*pi/180.)
  end subroutine weights
