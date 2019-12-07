
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
fils2 = systemfunc("ls /home/xsun/xsun/Borah/work/run_NAMACMMODIS/wrfout_d04*")  ;ACM2*
fils4 = systemfunc("ls /home/xsun/xsun/Borah/work/run_NARRYSUMODIS/wrfout_d04*")   ;YSU*(NARR)
fils5 = systemfunc("ls /home/xsun/xsun/Borah/work/run_NARRMYJMODIS/wrfout_d04*")   ;MYJ*(NARR)
f0 = addfile("/home/xsun/xsun/Borah/soft/WRFV3/run/wrfout_d04_2014-09-21_00:00:000.nc","r")  ;ACM2(no-nudge)
f1 = addfile("/home/xsun/xsun/Borah/work/run_NAMNG/nuisttar/wrfout_d04_2014-09-21_00:00:00.nc","r") ; ACM2
f2 = addfiles(fils2,"r")
ListSetType(f2,"cat")
f4 = addfiles(fils4,"r")
ListSetType(f4,"cat")
f5 = addfiles(fils5,"r")
ListSetType(f5,"cat")
f3 = addfile("/home/xsun/xsun/Borah/work/run_NARR/wrfout_d04_2014-09-21_00:00:00.nc","r")
fils6= systemfunc("ls /home/xsun/xsun/Borah/work/run_NAMYSUMODIS/wrfout_d04*") ; YSU*
fils7= systemfunc(" ls /home/xsun/xsun/Borah/work/run_NAMMYJMODIS/wrfout_d04*")  ;MYJ*
f6 = addfiles(fils6,"r")
ListSetType(f6,"cat")
f7 = addfiles(fils7,"r")
ListSetType(f7,"cat")
;----------------------------------------------------------------------------
  lat = 45.713560
  lon = -119.406023
  llres = True
  llres@ReturnInt = True ; Return integer values
  locij = wrf_user_ll_to_ij(f1, lon, lat, llres)
  locij = locij -1
  locX = locij(0)
  locY = locij(1)

  ustar0 = wrf_user_getvar(f0, "UST", -1)
  ustar1 = wrf_user_getvar(f1, "UST", -1)
  ustar2 = wrf_user_getvar(f2, "UST", -1)
  
  ustar3 = wrf_user_getvar(f3, "UST", -1)
  ustar4 = wrf_user_getvar(f4, "UST", -1)
  ustar5 = wrf_user_getvar(f5, "UST", -1)
  ustar6 = wrf_user_getvar(f6, "UST", -1)
  ustar7 = wrf_user_getvar(f7, "UST", -1)
  
  
   ustar0_point = ustar0(:, locY, locX)
   ustar1_point = ustar1(:, locY, locX)
   ustar2_point = ustar2(:, locY, locX)
    ustar3_point = ustar3(:, locY, locX)
    ustar4_point = ustar4(:, locY, locX)
   ustar5_point = ustar5(:, locY, locX)
  ustar6_point = ustar6(:, locY, locX)
   ustar7_point = ustar7(:, locY, locX)
;------------------------------------------------------------------------------
  timess = wrf_times_c(f1->Times,0)

  ntimes = dimsizes(timess)-5
  times = timess -8 ; LST time

;  print(times)
  copy_VarAtts(timess, times)


;-------Write header to CSV file
header = [/"ntime"+",ACM2(No-nudge)"+",ACM2"+",ACM2(NARR)"+",ACM2*"+",YSU*"+",MYJ*"+",YSU*(NARR)"+",MYJ*(NARR)"/]
csv_filename = "wrfoutUST_d04_ALLNARR.csv"
system("rm -rf" + csv_filename)
write_table(csv_filename,"w",header,"%s")
alist = [/timess,ustar0_point,ustar1_point,ustar3_point,ustar2_point,ustar6_point,ustar7_point,ustar4_point,ustar5_point/]
format = "%g,%g,%g,%g,%g,%g,%g,%g,%g"
 write_table(csv_filename,"a", alist,format)
end
