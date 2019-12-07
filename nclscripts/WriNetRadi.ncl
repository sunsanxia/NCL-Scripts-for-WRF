
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
;---------------------------------------------------------------------
fils2 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMACMMODIS/wrfout_d04*")
fils4 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMYSUMODIS/wrfout_d04*")
fils5 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMMYJMODIS/wrfout_d04*")
f0 = addfile("/home/xsun/model/xsun/soft/WRFV3/run/wrfout_d04_2014-09-21_00:00:000.nc","r")
f1 = addfile("/mnt/datadrive/xsun/work/run_NAMNG/nuisttar/wrfout_d04_2014-09-21_00:00:00.nc","r")
f2 = addfiles(fils2,"r")
ListSetType(f2,"cat")
f3 = addfile("/mnt/datadrive/xsun/work/run_NARR/wrfout_d04_2014-09-21_00:00:00.nc","r")
f4 = addfiles(fils4,"r")
ListSetType(f4,"cat")
f5 = addfiles(fils5,"r")
ListSetType(f5,"cat")
;obsname =  "/home/xsun/model/xsun/work/obs20142.csv"
;obsvars = asciiread(obsname,-1,"string")
;delim = ","
;obsvar = tofloat(str_get_field(obsvars(1::), 8, delim))
;obsvar@_FillValue = 999
;----------------------------------------------------------------------------
  lat = 45.713560
  lon = -119.406023
  llres = True
  llres@ReturnInt = True ; Return integer values
  locij = wrf_user_ll_to_ij(f1, lon, lat, llres)
  locij = locij -1
  locX = locij(0)
  locY = locij(1)
 print(locX)
print(locY)
 position1 = wrf_user_getvar(f0, "XLAT", -1)
 position2 = wrf_user_getvar(f0, "XLONG", -1)
print(position1(2,locY,locX));
print(position2(2,locY,locX));

;------------------------------------------------------------------------------
  ustar00 = wrf_user_getvar(f0, "OLR", -1)
  ustar00_point =ustar00(:, locY, locX) 
 ustar10 = wrf_user_getvar(f1, "OLR", -1)
  ustar10_point =ustar10(:, locY, locX)
  ustar20 = f2[:]->OLR
  ustar20_point = ustar20(:, locY, locX)
  ustar30 = wrf_user_getvar(f3,"OLR", -1)
  ustar30_point = ustar30(:, locY, locX);
  ustar40 = f4[:]->OLR
ustar50 = f5[:]->OLR
ustar40_point = ustar40(:, locY, locX)
ustar50_point = ustar50(:, locY, locX)

 ustar01 = wrf_user_getvar(f0, "ALBEDO", -1)
  ustar01_point =ustar01(:, locY, locX) 
 ustar11 = wrf_user_getvar(f1, "ALBEDO", -1)
  ustar11_point =ustar11(:, locY, locX)
  ustar21 = f2[:]->ALBEDO
  ustar21_point = ustar21(:, locY, locX)
  ustar31 = wrf_user_getvar(f3,"ALBEDO", -1)
  ustar31_point = ustar31(:, locY, locX);
  ustar41 = f4[:]->ALBEDO
ustar51 = f5[:]->ALBEDO
ustar41_point = ustar41(:, locY, locX)
ustar51_point = ustar51(:, locY, locX)

 ustar02 = wrf_user_getvar(f0, "SWDOWN", -1)
  ustar02_point =ustar02(:, locY, locX) 
 ustar12 = wrf_user_getvar(f1, "SWDOWN", -1)
  ustar12_point =ustar12(:, locY, locX)
  ustar22 = f2[:]->SWDOWN
  ustar22_point = ustar22(:, locY, locX)
  ustar32 = wrf_user_getvar(f3,"SWDOWN", -1)
  ustar32_point = ustar32(:, locY, locX);
  ustar42 = f4[:]->SWDOWN
ustar52 = f5[:]->SWDOWN
ustar42_point = ustar42(:, locY, locX)
ustar52_point = ustar52(:, locY, locX)

 ustar03 = wrf_user_getvar(f0, "GLW", -1)
  ustar03_point =ustar03(:, locY, locX) 
 ustar13 = wrf_user_getvar(f1, "GLW", -1)
  ustar13_point =ustar13(:, locY, locX)
  ustar23 = f2[:]->GLW
  ustar23_point = ustar23(:, locY, locX)
  ustar33 = wrf_user_getvar(f3,"GLW", -1)
  ustar33_point = ustar33(:, locY, locX);
  ustar43 = f4[:]->GLW
ustar53 = f5[:]->GLW
ustar43_point = ustar43(:, locY, locX)
ustar53_point = ustar53(:, locY, locX)

ustar0_point = ustar03_point - ustar00_point +(1- ustar01_point)*ustar02_point
ustar1_point = ustar13_point - ustar10_point +(1- ustar11_point)*ustar12_point
ustar2_point = ustar23_point - ustar20_point +(1- ustar21_point)*ustar22_point
ustar3_point = ustar33_point - ustar30_point +(1- ustar31_point)*ustar32_point
ustar4_point = ustar43_point - ustar40_point +(1- ustar41_point)*ustar42_point
ustar5_point = ustar53_point - ustar50_point +(1- ustar51_point)*ustar52_point
;Rn = GLW-OLR+(1-ALBEDO)*SWDOWN  ;netradiation
;------------------------------------------------------------------------------


;-----------------------------------------------------------------


;-----------


wtimes = wrf_user_getvar(f0, "times", -1)

header =[/"time(UTC)"+",ACM2(No-nudge)"+",ACM2"+",ACM2(NARR)"+",ACM2*"+",YSU*"+",MYJ*"/]
csv_filename = "./Flux/NetRadi.csv"
system("rm -rf" + csv_filename)
write_table(csv_filename, "w", header, "%s")
alist=[/wtimes,ustar0_point,ustar1_point,ustar2_point,ustar3_point,ustar4_point,ustar5_point/]
format = "%s,%g,%g,%g,%g,%g,%g"
write_table(csv_filename, "a", alist, format)

;draw(plot)
;frame(wks)

end















