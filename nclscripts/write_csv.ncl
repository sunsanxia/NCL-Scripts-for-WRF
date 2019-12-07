
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
    locij2 = wrf_user_ll_to_ij(f02, lon, lat, llres)
  locij2 = locij2 -1
  locX2 = locij2(0)
  locY2 = locij2(1)

   locij3 = wrf_user_ll_to_ij(f03, lon, lat, llres)
  locij3 = locij3 -1
  locX3 = locij3(0)
  locY3 = locij3(1)

   locij4 = wrf_user_ll_to_ij(f04, lon, lat, llres)
  locij4 = locij4 -1
  locX4 = locij4(0)
  locY4 = locij4(1)

  HFXar04 = wrf_user_getvar(f04, "HFX", -1)
  HFXar04_point =HFXar04(:, locY4, locX4)
  HFXar03 = wrf_user_getvar(f03, "HFX", -1)
  HFXar03_point =HFXar03(:, locY3, locX3)
  HFXar02 = wrf_user_getvar(f02, "HFX", -1)
  HFXar02_point =HFXar02(:, locY2, locX2)
HFXar14 = wrf_user_getvar(f14, "HFX", -1)
  HFXar14_point =HFXar14(:, locY4, locX4)
  HFXar13 = wrf_user_getvar(f13, "HFX", -1)
  HFXar13_point =HFXar13(:, locY3, locX3)
  HFXar12 = wrf_user_getvar(f12, "HFX", -1)
  HFXar12_point =HFXar12(:, locY2, locX2)
 HFXar24 = f24[:]->HFX
 HFXar24_point = HFXar24(:, locY4, locX4)
 HFXar23 = f23[:]->HFX
 HFXar23_point = HFXar23(:, locY3, locX3)
 HFXar22 = f22[:]->HFX
 HFXar22_point = HFXar22(:, locY2, locX2)
 HFXar34 = wrf_user_getvar(f34, "HFX", -1)
  HFXar34_point =HFXar34(:, locY4, locX4)
  HFXar33 = wrf_user_getvar(f33, "HFX", -1)
  HFXar33_point =HFXar33(:, locY3, locX3)
  HFXar32 = wrf_user_getvar(f32, "HFX", -1)
  HFXar32_point =HFXar32(:, locY2, locX2)
 HFXar44 = f44[:]->HFX
 HFXar44_point = HFXar44(:, locY4, locX4)
 HFXar43 = f43[:]->HFX
 HFXar43_point = HFXar43(:, locY3, locX3)
 HFXar42 = f42[:]->HFX
 HFXar42_point = HFXar42(:, locY2, locX2)
 HFXar54 = f54[:]->HFX
 HFXar54_point = HFXar54(:, locY4, locX4)
 HFXar53 = f53[:]->HFX
 HFXar53_point = HFXar53(:, locY3, locX3)
 HFXar52 = f52[:]->HFX
 HFXar52_point = HFXar52(:, locY2, locX2)
;------------------------------------------------------------------------------
  ;timess = wrf_times_c(f1->Times,0)
 
 ; ntimes = dimsizes(timess)-5
  ;times = timess -8 ; LST time

;  print(times)
  ;copy_VarAtts(timess, times)
timess = wrf_user_getvar(f44, "times", -1)

;-------Write header to CSV file
header = [/"ntime(UTC)"+",d02NAM-ACM2(No-nudge)HFX"+",d03NAM-ACM2(No-nudge)HFX"+",d04NAM-ACM2(No-nudge)HFX"+",d02NAM-ACM2HFX"+",d03NAM-ACM2HFX"+",d04NAM-ACM2HFX"+",d02NAM-ACM2*HFX"+",d03NAM-ACM2*HFX"+",d04NAM-ACM2*HFX"+",d02NARR-ACM2*HFX"+",d03NARR-ACM2*HFX"+",d04NARR-ACM2*HFX"+",d02NAM-YSU*HFX"+",d03NAM-YSU*HFX"+",d04NAM-YSU*HFX"+",d02NAM-MYJ*HFX"+",d03NAM-MYJ*HFX"+",d04NAM-MYJ*HFX"/]
csv_filename = "./Flux/wrfoutHFX_New.csv"
system("rm -rf" + csv_filename)
write_table(csv_filename,"w",header,"%s")
alist = [/timess,HFXar02_point,HFXar03_point,HFXar04_point,HFXar12_point,HFXar13_point,HFXar14_point,HFXar22_point,HFXar23_point,HFXar24_point,HFXar32_point,HFXar33_point,HFXar34_point,HFXar42_point,HFXar43_point,HFXar44_point,HFXar52_point,HFXar53_point,HFXar54_point/]
format = "%s,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g"
 write_table(csv_filename,"a", alist,format)
end
