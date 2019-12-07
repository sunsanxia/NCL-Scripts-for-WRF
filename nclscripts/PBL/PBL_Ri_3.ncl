
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
 csv_filename = "./PBL_ALLNARR_Ri_3.csv"
 header = [/"ntime(UTC)"+",ACM2(No-nudge)"+",ACM2"+",ACM2(NARR)"+",ACM2*"+",YSU*"+",MYJ*"+",YSU*(NARR)"+",MYJ*(NARR)"/]
system("rm -rf" + csv_filename)
write_table(csv_filename, "w", header, "%s")
time=wrf_user_getvar(f2, "times", -1)
 do i=0,192,1  ;timestamp
  times=time(i)
  Ricrit=0.25
  ;time = wrf_user_getvar(f2, "times",i)
  

   
   height2 = wrf_user_getvar(f2, "height", i)
  ; baseheight = f2->HGT(i,0,locY,locX)
   baseheight2 = height2(0,locY,locX)


   th2 = wrf_user_getvar(f2, "th", i)
  ;print(height)
   print(baseheight2)
    th_base2 = th2(0,locY,locX)
    th_crite2 = th_base2+1.5   ;one of the popular mixing height definitions 
   ;do j=1,4000,1

t2 = wrf_user_getvar(f2, "tk", i)
   qv2=wrf_user_getvar(f2, "QVAPOR", i)
   vt2=wrf_virtual_temp(t2, qv2)
 ua2=wrf_user_getvar(f2, "ua", i)
   va2=wrf_user_getvar(f2, "va", i)
   ws2=sqrt(ua2^2+va2^2)

   vts2=vt2(0,locY,locX)        ;lowest level virtual potential temperature
   wss2=ws2(0,locY,locX)        ;lowest level wind speed , fixed value
thv2=th2*(1.0+0.61*qv2)
thvs2=thv2(0,locY,locX)

     interheight2= baseheight2+1
    th_plane2 = wrf_user_intrp3d(th2,height2, "h", interheight2, 0., False)
    th_point2 = th_plane2(locY,locX)

ws_plane2= wrf_user_intrp3d(ws2, height2, "h", interheight2, 0., False)
     vt_plane2=wrf_user_intrp3d(vt2, height2, "h", interheight2, 0., False)
    ws_point2=ws_plane2(locY,locX)
    vt_point2=vt_plane2(locY,locX)
thv_plane2=wrf_user_intrp3d(thv2, height2, "h", interheight2, 0., False)
    thv_point2=thv_plane2(locY,locX)


Ri2=9.8/thvs2*(thv_point2-thvs2)*(interheight2-baseheight2)/((ws_point2-wss2)^2)


   
;print(Ri7)

     

      do while (Ri2.lt.Ricrit)
       interheight2 =interheight2+1
       th_plane2 = wrf_user_intrp3d(th2,height2, "h", interheight2, 0., False)
       th_point2 = th_plane2(locY,locX)

       ws_plane2= wrf_user_intrp3d(ws2, height2, "h", interheight2, 0., False)
     vt_plane2=wrf_user_intrp3d(vt2, height2, "h", interheight2, 0., False)
    ws_point2=ws_plane2(locY,locX)
    vt_point2=vt_plane2(locY,locX)


thv_plane2=wrf_user_intrp3d(thv2, height2, "h", interheight2, 0., False)
    thv_point2=thv_plane2(locY,locX)


Ri2=9.8/thvs2*(thv_point2-thvs2)*(interheight2-baseheight2)/((ws_point2-wss2)^2)
print(interheight2)
print(Ri2)

      end do

;alist=[/time,baseheight,interheight,th_point/]
;format = "%s,%g,%g,%g"
alist=[/times,interheight2/]
format = "%s,%g"
write_table(csv_filename, "a", alist, format)
  ; end do
 ; delete(time)
    
    delete (th_point2)
     delete(ws_point2)
    delete(vt_point2)
    delete(thv_point2)
    delete(Ri2)
    delete(height2)
    delete (baseheight2)

    
 end do
;plot = gsn_csm_contour(wks,th_point(heightt(0:192,0:43),times(0:192)),res)
end















