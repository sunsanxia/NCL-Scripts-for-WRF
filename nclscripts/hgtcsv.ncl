
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
;cat files in to a single file name
f1 = addfile("/mnt/datadrive/xsun/work/run_NAMNG/nuisttar/wrfout_d04_2014-09-21_00:00:00.nc","r")

lat=45.713560
lon=-119.406023
llres= True
 llres@ReturnInt = True ; Return integer values
  locij = wrf_user_ll_to_ij(f1, lon, lat, llres)
  locij = locij -1
  locX = locij(0)
  locY = locij(1)
  ;get var from wrfout
hgt=wrf_user_getvar(f1,"height",-1)
times=wrf_user_getvar(f1,"times",-1)
;timess = wrf_times_c(f1[:]->Times,0)
;uu= wrf_user_getvar(f1,"uvmet10",-1)
csv_filename = "wrfout.csv"
time_filename="time.csv"
blist=[/times/]
bformat="%s"
write_table(time_filename, "a", blist, bformat)
do i=0,dimsizes(times)-1
hgt_point=hgt(i,:,locY,locX)
times_point=times(i)
;uu_point=uu(:,locY,locX)

;write into csv
alist=[/times_point,hgt_point/]
format= "%s,%g"
write_table(csv_filename,"a",alist,format)
end do
end
