
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
fils24 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMACMMODIS/wrfout_d04*")
f24 = addfiles(fils24,"r")
fils23 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMACMMODIS/wrfout_d03*")
f23 = addfiles(fils23,"r")
fils22 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMACMMODIS/wrfout_d02*")
f22 = addfiles(fils22,"r")
fils44 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMYSUMODIS/wrfout_d04*")
fils43 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMYSUMODIS/wrfout_d03*")
fils42 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMYSUMODIS/wrfout_d02*")
fils54 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMMYJMODIS/wrfout_d04*")
fils53 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMMYJMODIS/wrfout_d03*")
fils52 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMMYJMODIS/wrfout_d02*")
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
  PBLHar04 = wrf_user_getvar(f04, "PBLH", -1)
  PBLHar04_point =PBLHar04(:, locY, locX)
  PBLHar03 = wrf_user_getvar(f03, "PBLH", -1)
  PBLHar03_point =PBLHar03(:, locY, locX)
  PBLHar02 = wrf_user_getvar(f02, "PBLH", -1)
  PBLHar02_point =PBLHar02(:, locY, locX)
PBLHar14 = wrf_user_getvar(f14, "PBLH", -1)
  PBLHar14_point =PBLHar14(:, locY, locX)
  PBLHar13 = wrf_user_getvar(f13, "PBLH", -1)
  PBLHar13_point =PBLHar13(:, locY, locX)
  PBLHar12 = wrf_user_getvar(f12, "PBLH", -1)
  PBLHar12_point =PBLHar12(:, locY, locX)
 PBLHar24 = f24[:]->PBLH
 PBLHar24_point = PBLHar24(:, locY, locX)
 PBLHar23 = f23[:]->PBLH
 PBLHar23_point = PBLHar23(:, locY, locX)
 PBLHar22 = f22[:]->PBLH
 PBLHar22_point = PBLHar22(:, locY, locX)
 PBLHar34 = wrf_user_getvar(f34, "PBLH", -1)
  PBLHar34_point =PBLHar34(:, locY, locX)
  PBLHar33 = wrf_user_getvar(f33, "PBLH", -1)
  PBLHar33_point =PBLHar33(:, locY, locX)
  PBLHar32 = wrf_user_getvar(f32, "PBLH", -1)
  PBLHar32_point =PBLHar32(:, locY, locX)
 PBLHar44 = f44[:]->PBLH
 PBLHar44_point = PBLHar44(:, locY, locX)
 PBLHar43 = f43[:]->PBLH
 PBLHar43_point = PBLHar43(:, locY, locX)
 PBLHar42 = f42[:]->PBLH
 PBLHar42_point = PBLHar42(:, locY, locX)
 PBLHar54 = f54[:]->PBLH
 PBLHar54_point = PBLHar54(:, locY, locX)
 PBLHar53 = f53[:]->PBLH
 PBLHar53_point = PBLHar53(:, locY, locX)
 PBLHar52 = f52[:]->PBLH
 PBLHar52_point = PBLHar52(:, locY, locX)
;------------------------------------------------------------------------------
  ;timess = wrf_times_c(f1->Times,0)
 
 ; ntimes = dimsizes(timess)-5
  ;times = timess -8 ; LST time

;  print(times)
  ;copy_VarAtts(timess, times)
timess = wrf_user_getvar(f44, "times", -1)

;-------Write header to CSV file
header = [/"ntime(UTC)"+",d02NAM-ACM2(No-nudge)PBLH"+",d03NAM-ACM2(No-nudge)PBLH"+",d04NAM-ACM2(No-nudge)PBLH"+",d02NAM-ACM2PBLH"+",d03NAM-ACM2PBLH"+",d04NAM-ACM2PBLH"+",d02NAM-ACM2*PBLH"+",d03NAM-ACM2*PBLH"+",d04NAM-ACM2*PBLH"+",d02NARR-ACM2*PBLH"+",d03NARR-ACM2*PBLH"+",d04NARR-ACM2*PBLH"+",d02NAM-YSU*PBLH"+",d03NAM-YSU*PBLH"+",d04NAM-YSU*PBLH"+",d02NAM-MYJ*PBLH"+",d03NAM-MYJ*PBLH"+",d04NAM-MYJ*PBLH"/]
csv_filename = "./wrfoutPBLH.csv"
system("rm -rf" + csv_filename)
write_table(csv_filename,"w",header,"%s")
alist = [/timess,PBLHar02_point,PBLHar03_point,PBLHar04_point,PBLHar12_point,PBLHar13_point,PBLHar14_point,PBLHar22_point,PBLHar23_point,PBLHar24_point,PBLHar32_point,PBLHar33_point,PBLHar34_point,PBLHar42_point,PBLHar43_point,PBLHar44_point,PBLHar52_point,PBLHar53_point,PBLHar54_point/]
format = "%s,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g"
 write_table(csv_filename,"a", alist,format)
end
