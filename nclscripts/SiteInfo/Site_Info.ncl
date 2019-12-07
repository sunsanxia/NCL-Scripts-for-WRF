
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
f01 = addfile("/home/xsun/model/xsun/work/run_NAMYSU/wrfout_d04_2014-09-27_00:00:00.nc","r")
f02 = addfile("/home/xsun/model/xsun/work/run_NAMYSUMODIS/wrfout_d04_2014-09-27_00:00:00.nc","r")

;----------------------------------------------------------------------------
  lat = 45.713560
  lon = -119.406023
  llres = True
  n=5  ;timestamp
  llres@ReturnInt = True ; Return integer values
  locij = wrf_user_ll_to_ij(f01, lon, lat, llres)
  locij = locij -1
  locX = locij(0)
  locY = locij(1)
  Lu01 = wrf_user_getvar(f01, "LU_INDEX", -1)  ;read in the first timestamp
  Lu01_point =Lu01(5,locY, locX)
  print(Lu01_point)
  Veg01 = wrf_user_getvar(f01, "IVGTYP", -1)
  Veg01_point =Veg01(5,locY, locX)
  Soil01 = wrf_user_getvar(f01, "ISLTYP", -1)
  Soil01_point =Soil01(5,locY, locX)
  
    Lu02 = wrf_user_getvar(f02, "LU_INDEX", -1)
  Lu02_point =Lu02(5,locY, locX)
  Veg02 = wrf_user_getvar(f02, "IVGTYP", -1)
  Veg02_point =Veg02(5,locY, locX)
  Soil02 = wrf_user_getvar(f02, "ISLTYP", -1)
  Soil02_point =Soil02(5,locY, locX)

;------------------------------------------------------------------------------
  timess = wrf_user_getvar(f01, "times", -1)

  ntimes = dimsizes(timess)-5
  ;times = timess -8 ; LST time

print(timess)
 ; copy_VarAtts(timess, times)
 
time_point = timess(5)
;------Write header to CSV file
header = [/"time_UTC"+",LU_USGS"+",Veg_USGS"+",Soil_USGS"+",LU_MODIS"+",Veg_MODIS"+",Soil_MODIS"/]
csv_filename = "SiteInfo.csv"
;system("rm -rf" + csv_filename)
write_table(csv_filename,"a",header,"%s")
alist = [/time_point,Lu01_point,Veg01_point,Soil01_point,Lu02_point,Veg02_point,Soil02_point/]
format = "%s,%g,%g,%g,%g,%g,%g"
 write_table(csv_filename,"a", alist,format)
end
