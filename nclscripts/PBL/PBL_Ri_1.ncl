
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
 csv_filename = "./PBL_ALLNARR_Ri_1.csv"
 header = [/"ntime(UTC)"+",ACM2(No-nudge)"+",ACM2"+",ACM2(NARR)"+",ACM2*"+",YSU*"+",MYJ*"+",YSU*(NARR)"+",MYJ*(NARR)"/]
system("rm -rf" + csv_filename)
write_table(csv_filename, "w", header, "%s")
time=wrf_user_getvar(f2, "times", -1)
 do i=0,192,1  ;timestamp
  times=time(i)
  ;time = wrf_user_getvar(f2, "times",i)
   height0 = wrf_user_getvar(f0, "height", i)
  ; baseheight = f0->HGT(i,0,locY,locX)
   baseheight0 = height0(0,locY,locX)
   
  
   th0 = wrf_user_getvar(f0, "th", i)
  ;print(height)
   print(baseheight0)
    th_base0 = th0(0,locY,locX)
    th_crite0 = th_base0+1.5   ;one of the popular mixing height definitions 


     t0 = wrf_user_getvar(f0, "tk", i)
   qv0=wrf_user_getvar(f0, "QVAPOR", i)
   vt0=wrf_virtual_temp(t0, qv0) ;virtual tempereatre
 ua0=wrf_user_getvar(f0, "ua", i)
   va0=wrf_user_getvar(f0, "va", i)
   ws0=sqrt(ua0^2+va0^2)
   thv0=th0*(1.0+0.61*qv0)   ;virtual potential tempereatre

   vts0=vt0(0,locY,locX)        ;lowest level virtual potential temperature
   wss0=ws0(0,locY,locX)        ;lowest level wind speed , fixed value
   thvs0=thv0(0,locY,locX)
   print(wss0)

   ;do j=1,4000,1
     interheight0= baseheight0+1
     ws_plane0= wrf_user_intrp3d(ws0, height0, "h", interheight0, 0., False)
     vt_plane0=wrf_user_intrp3d(vt0, height0, "h", interheight0, 0., False)
    ws_point0=ws_plane0(locY,locX)
    vt_point0=vt_plane0(locY,locX)
    thv_plane0=wrf_user_intrp3d(thv0, height0, "h", interheight0, 0., False)
    thv_point0=thv_plane0(locY,locX)


Ri0=9.8/thvs0*(thv_point0-thvs0)*(interheight0-baseheight0)/((ws_point0-wss0)^2)
Ricrit=0.25
    th_plane0 = wrf_user_intrp3d(th0,height0, "h", interheight0, 0., False)
th_point0 = th_plane0(locY,locX)


  

     do while (Ri0.lt.Ricrit)
        interheight0 =interheight0+1
       ws_plane0= wrf_user_intrp3d(ws0, height0, "h", interheight0, 0., False)
     vt_plane0=wrf_user_intrp3d(vt0, height0, "h", interheight0, 0., False)
    ws_point0=ws_plane0(locY,locX)
    vt_point0=vt_plane0(locY,locX)


thv_plane0=wrf_user_intrp3d(thv0, height0, "h", interheight0, 0., False)
    thv_point0=thv_plane0(locY,locX)


Ri0=9.8/thvs0*(thv_point0-thvs0)*(interheight0-baseheight0)/((ws_point0-wss0)^2)
Ricrit=0.25
;print(thv_point0)
;;print(thvs0)
print(interheight0)
print(Ri0)
      end do


alist=[/times,interheight0/]
format = "%s,%g"
write_table(csv_filename, "a", alist, format)
  ; end do
 ; delete(time)
    delete (th_point0)
    delete(ws_point0)
    delete(vt_point0)
    delete(thv_point0)
    delete(Ri0)
    delete(height0)
    delete (baseheight0)

    
 end do
;plot = gsn_csm_contour(wks,th_point(heightt(0:192,0:43),times(0:192)),res)
end















