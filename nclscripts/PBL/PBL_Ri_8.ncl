
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
;---------------------------------------------------------------------
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
 csv_filename = "./PBL_ALLNARR_Ri_8.csv"
 header = [/"ntime(UTC)"+",ACM2(No-nudge)"+",ACM2"+",ACM2(NARR)"+",ACM2*"+",YSU*"+",MYJ*"+",YSU*(NARR)"+",MYJ*(NARR)"/]
system("rm -rf" + csv_filename)
write_table(csv_filename, "w", header, "%s")
time=wrf_user_getvar(f2, "times", -1)
 do i=0,192,1  ;timestamp
  times=time(i)
  Ricrit=0.25
  ;time = wrf_user_getvar(f2, "times",i)
  

height7 = wrf_user_getvar(f7, "height", i)
  ; baseheight = f7->HGT(i,0,locY,locX)
   baseheight7 = height7(0,locY,locX)
   t7 = wrf_user_getvar(f7, "tk", i)
   qv7=wrf_user_getvar(f7, "QVAPOR", i)
   vt7=wrf_virtual_temp(t7, qv7)
 ua7=wrf_user_getvar(f7, "ua", i)
   va7=wrf_user_getvar(f7, "va", i)
   ws7=sqrt(ua7^2+va7^2)

   vts7=vt7(0,locY,locX)        ;lowest level virtual potential temperature
   wss7=ws7(0,locY,locX)        ;lowest level wind speed , fixed value


   th7 = wrf_user_getvar(f7, "th", i)
  ;print(height)
   print(baseheight7)
    th_base7 = th7(0,locY,locX)
    th_crite7 = th_base7+1.5   ;one of the popular mixing height definitions 
   ;do j=1,4000,1

thv7=th7*(1.0+0.61*qv7)
thvs7=thv7(0,locY,locX)

     interheight7= baseheight7+1
    th_plane7 = wrf_user_intrp3d(th7,height7, "h", interheight7, 0., False)
      th_point7 = th_plane7(locY,locX)
 ws_plane7= wrf_user_intrp3d(ws7, height7, "h", interheight7, 0., False)
     vt_plane7=wrf_user_intrp3d(vt7, height7, "h", interheight7, 0., False)
    ws_point7=ws_plane7(locY,locX)
    vt_point7=vt_plane7(locY,locX)
   thv_plane7=wrf_user_intrp3d(thv7, height7, "h", interheight7, 0., False)
    thv_point7=thv_plane7(locY,locX)


Ri7=9.8/thvs7*(thv_point7-thvs7)*(interheight7-baseheight7)/((ws_point7-wss7)^2)


;print(Ri7)

     

      do while (Ri7.lt.Ricrit)
       interheight7 =interheight7+1
       th_plane7 = wrf_user_intrp3d(th7,height7, "h", interheight7, 0., False)
       th_point7 = th_plane7(locY,locX)

        ws_plane7= wrf_user_intrp3d(ws7, height7, "h", interheight7, 0., False)
     vt_plane7=wrf_user_intrp3d(vt7, height7, "h", interheight7, 0., False)
    ws_point7=ws_plane7(locY,locX)
    vt_point7=vt_plane7(locY,locX)
  thv_plane7=wrf_user_intrp3d(thv7, height7, "h", interheight7, 0., False)
    thv_point7=thv_plane7(locY,locX)


Ri7=9.8/thvs7*(thv_point7-thvs7)*(interheight7-baseheight7)/((ws_point7-wss7)^2)
print(interheight7)
print(Ri7)
      end do


    
;alist=[/time,baseheight,interheight,th_point/]
;format = "%s,%g,%g,%g"
alist=[/times,interheight7/]
format = "%s,%g"
write_table(csv_filename, "a", alist, format)
  ; end do
 ; delete(time)
    
     delete (th_point7)
      delete(ws_point7)
    delete(vt_point7)
    delete(thv_point7)
    delete(Ri7)
    delete(height7)
    delete (baseheight7)
 end do
;plot = gsn_csm_contour(wks,th_point(heightt(0:192,0:43),times(0:192)),res)
end















