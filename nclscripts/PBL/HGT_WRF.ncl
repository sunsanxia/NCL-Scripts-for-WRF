
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

  

  HGTar04 = wrf_user_getvar(f04, "HGT", -1)
  HGTar04_point =HGTar04(:, locY4, locX4)
  HGTar03 = wrf_user_getvar(f03, "HGT", -1)
  HGTar03_point =HGTar03(:, locY3, locX3)
  HGTar02 = wrf_user_getvar(f02, "HGT", -1)
  HGTar02_point =HGTar02(:, locY3, locX3)
HGTar14 = wrf_user_getvar(f14, "HGT", -1)
  HGTar14_point =HGTar14(:, locY4, locX4)
  HGTar13 = wrf_user_getvar(f13, "HGT", -1)
  HGTar13_point =HGTar13(:, locY3, locX3)
  HGTar12 = wrf_user_getvar(f12, "HGT", -1)
  HGTar12_point =HGTar12(:, locY2, locX2)
 HGTar24 = f24[:]->HGT
 HGTar24_point = HGTar24(:, locY4, locX4)
 HGTar23 = f23[:]->HGT
 HGTar23_point = HGTar23(:, locY3, locX3)
 HGTar22 = f22[:]->HGT
 HGTar22_point = HGTar22(:, locY2, locX2)
 HGTar34 = wrf_user_getvar(f34, "HGT", -1)
  HGTar34_point =HGTar34(:, locY4, locX4)
  HGTar33 = wrf_user_getvar(f33, "HGT", -1)
  HGTar33_point =HGTar33(:, locY3, locX3)
  HGTar32 = wrf_user_getvar(f32, "HGT", -1)
  HGTar32_point =HGTar32(:, locY2, locX2)
 HGTar44 = f44[:]->HGT
 HGTar44_point = HGTar44(:, locY4, locX4)
 HGTar43 = f43[:]->HGT
 HGTar43_point = HGTar43(:, locY3, locX3)
 HGTar42 = f42[:]->HGT
 HGTar42_point = HGTar42(:, locY2, locX2)
 HGTar54 = f54[:]->HGT
 HGTar54_point = HGTar54(:, locY4, locX4)
 HGTar53 = f53[:]->HGT
 HGTar53_point = HGTar53(:, locY3, locX3)
 HGTar52 = f52[:]->HGT
 HGTar52_point = HGTar52(:, locY2, locX2)
;------------------------------------------------------------------------------
  ;timess = wrf_times_c(f1->Times,0)
 
 ; ntimes = dimsizes(timess)-5
  ;times = timess -8 ; LST time

;  print(times)
  ;copy_VarAtts(timess, times)
timess = wrf_user_getvar(f44, "times", -1)

;-------Write header to CSV file
header = [/"ntime(UTC)"+",d02NAM-ACM2(No-nudge)HGT"+",d03NAM-ACM2(No-nudge)HGT"+",d04NAM-ACM2(No-nudge)HGT"+",d02NAM-ACM2HGT"+",d03NAM-ACM2HGT"+",d04NAM-ACM2HGT"+",d02NAM-ACM2*HGT"+",d03NAM-ACM2*HGT"+",d04NAM-ACM2*HGT"+",d02NARR-ACM2*HGT"+",d03NARR-ACM2*HGT"+",d04NARR-ACM2*HGT"+",d02NAM-YSU*HGT"+",d03NAM-YSU*HGT"+",d04NAM-YSU*HGT"+",d02NAM-MYJ*HGT"+",d03NAM-MYJ*HGT"+",d04NAM-MYJ*HGT"/]
csv_filename = "./wrfoutHGT.csv"
system("rm -rf" + csv_filename)
write_table(csv_filename,"w",header,"%s")
alist = [/timess,HGTar02_point,HGTar03_point,HGTar04_point,HGTar12_point,HGTar13_point,HGTar14_point,HGTar22_point,HGTar23_point,HGTar24_point,HGTar32_point,HGTar33_point,HGTar34_point,HGTar42_point,HGTar43_point,HGTar44_point,HGTar52_point,HGTar53_point,HGTar54_point/]
format = "%s,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g"
 write_table(csv_filename,"a", alist,format)
end
