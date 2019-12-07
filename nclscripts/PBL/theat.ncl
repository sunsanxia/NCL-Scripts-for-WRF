
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
;---------------------------------------------------------------------
fils2 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMMODIS/wrfout_d04*")
fils5 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMYSU/wrfout_d04*")
fils6 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMMYJ/wrfout_d04*")
f1 = addfile("/mnt/datadrive/xsun/work/run_NAMNG/nuisttar/wrfout_d04_2014-09-21_00:00:00.nc","r")
f2 = addfiles(fils2,"r")
ListSetType(f2,"cat")
f3 = addfile("/mnt/datadrive/xsun/work/run_NARR/wrfout_d04_2014-09-21_00:00:00.nc","r")
f4= addfile("/home/xsun/model/xsun/soft/WRFV3/run/wrfout_d04_2014-09-21_00:00:000.nc","r")
f5= addfiles(fils5,"r")
ListSetType(f5,"cat")
f6 = addfiles(fils6,"r")
ListSetType(f6,"cat")
;----------------------------------------------------------------------------
  lat1 = 45.713560
  lon1 = -119.406023
  llres = True
  llres@ReturnInt = True ; Return integer values
  locij = wrf_user_ll_to_ij(f1, lon1, lat1, llres)
  locij = locij -1
  locX = locij(0)
  locY = locij(1)
 XLAT=f1->XLAT(0,locY,locX)
XLONG=f1->XLONG(0,locY,locX)
 print(locX)
print(locY)
print(XLAT)
print(XLONG)

;------------------------------------------------------------------------------
;  th = wrf_user_getvar(f2, "th", -1)
;height = wrf_user_getvar(f2, "z", -1)
;th = wrf_user_getvar(f1, "th", -1)
;height = wrf_user_getvar(f1, "z", -1)
; th = wrf_user_getvar(f3, "th", -1)
; height = wrf_user_getvar(f3, "z", -1)
;th = wrf_user_getvar(f4, "th", -1)
;height = wrf_user_getvar(f4, "z", -1)
 ;th = wrf_user_getvar(f5, "th", -1)
 ;height = wrf_user_getvar(f5, "z", -1)
 
 ;height = wrf_user_getvar(f6, "z", -1)
 ;HGT = f3->HGT(44,locY,locX)  ; HGT at 54 times
 ;ZNWW = f1->ZNW(0,:) ;eta whole levels
 csv_filename = "./Theat.csv"
 header = [/"ntime(UTC)"+",ACM2(No-nudge)"+",ACM2"+",ACM2(NARR)"+",ACM2*"+",YSU*"+",MYJ*"/]
system("rm -rf" + csv_filename)
write_table(csv_filename, "w", header, "%s")
 do i=0,192,1  ;timestamp
  time = wrf_user_getvar(f3, "times",-1)
 times = time(i)
;times = time(i,0,locY,locX)
  printVarSummary(time)
   height = wrf_user_getvar(f3, "height", i)
  ; baseheight = f3->HGT(i,0,locY,locX)
   baseheight = height(0,locY,locX)
   th = wrf_user_getvar(f3, "th", i)
  ;print(height)
   print(baseheight)
    th_base = th(0,locY,locX)
    th_crite = th_base+1.5   ;one of the popular mixing height definitions 
   ;do j=1,4000,1
     interheight= baseheight+1
    th_plane = wrf_user_intrp3d(th,height, "h", interheight, 0., False)
     th_point = th_plane(locY,locX)
     do while (th_point.lt.th_crite)
       interheight =interheight+1
       th_plane = wrf_user_intrp3d(th,height, "h", interheight, 0., False)
       th_point = th_plane(locY,locX)
      end do

    print(interheight)
    print(th_point)

;alist=[/time,baseheight,interheight,th_point/]
;format = "%s,%g,%g,%g"
;time = wrf_user_getvar(f3, "times",i)

alist=[/times,baseheight,interheight,th_base,th_point/]
format = "%s,%g,%g,%g,%g"
write_table(csv_filename, "a", alist, format)
  ; end do
    delete (th_point)
    delete(height)
    delete (baseheight)
 end do
;plot = gsn_csm_contour(wks,th_point(heightt(0:192,0:43),times(0:192)),res)
end















