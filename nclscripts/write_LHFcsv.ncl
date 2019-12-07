
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
f04 = addfile("/home/xsun/model/xsun/soft/WRFV3/run/wrfout_d04_2014-09-21_00:00:000.nc","r")
f03 = addfile("/home/xsun/model/xsun/soft/WRFV3/run/wrfout_d03_2014-09-21_00:00:000.nc","r")
f02 = addfile("/home/xsun/model/xsun/soft/WRFV3/run/wrfout_d02_2014-09-21_00:00:00.nc","r")
f1 = addfile("/mnt/datadrive/xsun/work/run_NAMNG/nuisttar/wrfout_d04_2014-09-21_00:00:00.nc","r")
f13 = addfile("/mnt/datadrive/xsun/work/run_NAMNG/wrfout_d03_2014-09-21_00:00:00.nc","r")
f14= addfile("/mnt/datadrive/xsun/work/run_NAMNG/nuisttar/wrfout_d04_2014-09-21_00:00:00.nc","r")
f12=addfile("/mnt/datadrive/xsun/work/run_NAMNG/d0102Rerun/wrfout_d02_2014-09-21_00:00:00.nc","r")
fils24 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMMODIS/wrfout_d04*")
f24 = addfiles(fils24,"r")
fils23 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMMODIS/wrfout_d03*")
f23 = addfiles(fils23,"r")
fils22 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMMODIS/wrfout_d02*")
f22 = addfiles(fils22,"r")
fils44 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMYSU/wrfout_d04*")
fils43 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMYSU/wrfout_d03*")
fils42 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMYSU/wrfout_d02*")
fils54 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMMYJ/wrfout_d04*")
fils53 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMMYJ/wrfout_d03*")
fils52 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMMYJ/wrfout_d02*")
f44 = addfiles(fils44,"r")
ListSetType(f44,"cat")
f43 = addfiles(fils43,"r")
ListSetType(f43,"cat")
f42 = addfiles(fils42,"r")
ListSetType(f42,"cat")
f54 = addfiles(fils54,"r")
ListSetType(f54,"cat")
f53 = addfiles(fils53,"r")
ListSetType(f53,"cat")
f52 = addfiles(fils52,"r")
ListSetType(f52,"cat")
f34 = addfile("/mnt/datadrive/xsun/work/run_NARR/wrfout_d04_2014-09-21_00:00:00.nc","r")
f33 = addfile("/mnt/datadrive/xsun/work/run_NARR/wrfout_d03_2014-09-21_00:00:00.nc","r")
f32 = addfile("/mnt/datadrive/xsun/work/run_NARR/d0102Rerun/wrfout_d02_2014-09-21_00:00:00.nc","r")
;----------------------------------------------------------------------------
  lat = 45.713560
  lon = -119.406023
  llres = True
  llres@ReturnInt = True ; Return integer values
  locij = wrf_user_ll_to_ij(f1, lon, lat, llres)
  locij = locij -1
  locX = locij(0)
  locY = locij(1)
  ustar04 = wrf_user_getvar(f04, "LH", -1)
  ustar04_point =ustar04(:, locY, locX)
  ustar03 = wrf_user_getvar(f03, "LH", -1)
  ustar03_point =ustar03(:, locY, locX)
  ustar02 = wrf_user_getvar(f02, "LH", -1)
  ustar02_point =ustar02(:, locY, locX)
ustar14 = wrf_user_getvar(f14, "LH", -1)
  ustar14_point =ustar14(:, locY, locX)
  ustar13 = wrf_user_getvar(f13, "LH", -1)
  ustar13_point =ustar13(:, locY, locX)
  ustar12 = wrf_user_getvar(f12, "LH", -1)
  ustar12_point =ustar12(:, locY, locX)
 ustar24 = f24[:]->LH
 ustar24_point = ustar24(:, locY, locX)
 ustar23 = f23[:]->LH
 ustar23_point = ustar23(:, locY, locX)
 ustar22 = f22[:]->LH
 ustar22_point = ustar22(:, locY, locX)
 ustar34 = wrf_user_getvar(f34, "LH", -1)
  ustar34_point =ustar34(:, locY, locX)
  ustar33 = wrf_user_getvar(f33, "LH", -1)
  ustar33_point =ustar33(:, locY, locX)
  ustar32 = wrf_user_getvar(f32, "LH", -1)
  ustar32_point =ustar32(:, locY, locX)
 ustar44 = f44[:]->LH
 ustar44_point = ustar44(:, locY, locX)
 ustar43 = f43[:]->LH
 ustar43_point = ustar43(:, locY, locX)
 ustar42 = f42[:]->LH
 ustar42_point = ustar42(:, locY, locX)
 ustar54 = f54[:]->LH
 ustar54_point = ustar54(:, locY, locX)
 ustar53 = f53[:]->LH
 ustar53_point = ustar53(:, locY, locX)
 ustar52 = f52[:]->LH
 ustar52_point = ustar52(:, locY, locX)
;------------------------------------------------------------------------------
  timess = wrf_times_c(f1->Times,0)

  ntimes = dimsizes(timess)-5
  times = timess -8 ; LST time

;  print(times)
  copy_VarAtts(timess, times)


;-------Write header to CSV file
header = [/"ntime"+",d02NAM-ACM2(No-nudge)LHF"+",d03NAM-ACM2(No-nudge)LHF"+",d04NAM-ACM2(No-nudge)LHF"+",d02NAM-ACM2LHF"+",d03NAM-ACM2LHF"+",d04NAM-ACM2LHF"+",d02NAM-ACM2*LHF"+",d03NAM-ACM2*LHF"+",d04NAM-ACM2*LHF"+",d02NARR-ACM2*LHF"+",d03NARR-ACM2*LHF"+",d04NARR-ACM2*LHF"+",d02NAM-YSU*LHF"+",d03NAM-YSU*LHF"+",d04NAM-YSU*LHF"+",d02NAM-MYJ*LHF"+",d03NAM-MYJ*LHF"+",d04NAM-MYJ*LHF"/]
csv_filename = "wrfoutLHF.csv"
system("rm -rf" + csv_filename)
write_table(csv_filename,"w",header,"%s")
alist = [/timess,ustar02_point,ustar03_point,ustar04_point,ustar12_point,ustar13_point,ustar14_point,ustar22_point,ustar23_point,ustar24_point,ustar32_point,ustar33_point,ustar34_point,ustar42_point,ustar43_point,ustar44_point,ustar52_point,ustar53_point,ustar54_point/]
format = "%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g"
 write_table(csv_filename,"a", alist,format)
end
