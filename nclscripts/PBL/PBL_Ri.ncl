
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
 csv_filename = "./PBL_ALLNARR_Ri.csv"
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


   height1 = wrf_user_getvar(f1, "height", i)
  ; baseheight = f1->HGT(i,0,locY,locX)
   baseheight1 = height1(0,locY,locX)
   t1 = wrf_user_getvar(f1, "tk", i)
   qv1=wrf_user_getvar(f1, "QVAPOR", i)
   vt1=wrf_virtual_temp(t1, qv1)
 ua1=wrf_user_getvar(f1, "ua", i)
   va1=wrf_user_getvar(f1, "va", i)
   ws1=sqrt(ua1^2+va1^2)

   vts1=vt1(0,locY,locX)        ;lowest level virtual potential temperature
   wss1=ws1(0,locY,locX)        ;lowest level wind speed , fixed value

   th1 = wrf_user_getvar(f1, "th", i)
  ;print(height)
   print(baseheight1)
    th_base1 = th1(0,locY,locX)
    th_crite1 = th_base1+1.5   ;one of the popular mixing height definitions 
   ;do j=1,4000,1
thv1=th1*(1.0+0.61*qv1)
thvs1=thv1(0,locY,locX)



     interheight1= baseheight1+1
      ws_plane1= wrf_user_intrp3d(ws1, height1, "h", interheight1, 0., False)
     vt_plane1=wrf_user_intrp3d(vt1, height1, "h", interheight1, 0., False)
    ws_point1=ws_plane1(locY,locX)
    vt_point1=vt_plane1(locY,locX)
thv_plane1=wrf_user_intrp3d(thv1, height1, "h", interheight1, 0., False)
    thv_point1=thv_plane1(locY,locX)


Ri1=9.8/thvs1*(thv_point1-thvs1)*(interheight1-baseheight1)/((ws_point1-wss1)^2)

    th_plane1 = wrf_user_intrp3d(th1,height1, "h", interheight1, 0., False)
    th_point1 = th_plane1(locY,locX)


   
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


   ;time = wrf_user_getvar(f2, "times",i)
   height3 = wrf_user_getvar(f3, "height", i)
  ; baseheight = f3->HGT(i,0,locY,locX)
   baseheight3 = height3(0,locY,locX)
t3 = wrf_user_getvar(f3, "tk", i)
   qv3=wrf_user_getvar(f3, "QVAPOR", i)
   vt3=wrf_virtual_temp(t3, qv3)
 ua3=wrf_user_getvar(f3, "ua", i)
   va3=wrf_user_getvar(f3, "va", i)
   ws3=sqrt(ua3^2+va3^2)

   vts3=vt3(0,locY,locX)        ;lowest level virtual potential temperature
   wss3=ws3(0,locY,locX)        ;lowest level wind speed , fixed value

   th3 = wrf_user_getvar(f3, "th", i)
  ;print(height)
   print(baseheight3)
    th_base3 = th3(0,locY,locX)
    th_crite3 = th_base3+1.5   ;one of the popular mixing height definitions '
       ;do j=1,4000,1
thv3=th3*(1.0+0.61*qv3)
thvs3=thv3(0,locY,locX)


     interheight3= baseheight3+1
    th_plane3 = wrf_user_intrp3d(th3,height3, "h", interheight3, 0., False)
     th_point3 = th_plane3(locY,locX)
ws_plane3= wrf_user_intrp3d(ws3, height3, "h", interheight3, 0., False)
     vt_plane3=wrf_user_intrp3d(vt3, height3, "h", interheight3, 0., False)
    ws_point3=ws_plane3(locY,locX)
    vt_point3=vt_plane3(locY,locX)

thv_plane3=wrf_user_intrp3d(thv3, height3, "h", interheight3, 0., False)
    thv_point3=thv_plane3(locY,locX)


Ri3=9.8/thvs3*(thv_point3-thvs3)*(interheight3-baseheight3)/((ws_point3-wss3)^2)



   height4 = wrf_user_getvar(f4, "height", i)
  ; baseheight = f4->HGT(i,0,locY,locX)
   baseheight4 = height4(0,locY,locX)
   t4 = wrf_user_getvar(f4, "tk", i)
   qv4=wrf_user_getvar(f4, "QVAPOR", i)
   vt4=wrf_virtual_temp(t4, qv4)
 ua4=wrf_user_getvar(f4, "ua", i)
   va4=wrf_user_getvar(f4, "va", i)
   ws4=sqrt(ua4^2+va4^2)

   vts4=vt4(0,locY,locX)        ;lowest level virtual potential temperature
   wss4=ws4(0,locY,locX)        ;lowest level wind speed , fixed value

   th4 = wrf_user_getvar(f4, "th", i)
  ;print(height)
   print(baseheight4)
    th_base4 = th4(0,locY,locX)
    th_crite4 = th_base4+1.5   ;one of the popular mixing height definitions 
   ;do j=1,4000,1

thv4=th4*(1.0+0.61*qv4)
thvs4=thv4(0,locY,locX)

     interheight4= baseheight4+1
    th_plane4 = wrf_user_intrp3d(th4,height4, "h", interheight4, 0., False)
    th_point4 = th_plane4(locY,locX)
ws_plane4= wrf_user_intrp3d(ws4, height4, "h", interheight4, 0., False)
     vt_plane4=wrf_user_intrp3d(vt4, height4, "h", interheight4, 0., False)
    ws_point4=ws_plane4(locY,locX)
    vt_point4=vt_plane4(locY,locX)


thv_plane4=wrf_user_intrp3d(thv4, height4, "h", interheight4, 0., False)
    thv_point4=thv_plane4(locY,locX)


Ri4=9.8/thvs4*(thv_point4-thvs4)*(interheight4-baseheight4)/((ws_point4-wss4)^2)
   
   height5 = wrf_user_getvar(f5, "height", i)
  ; baseheight = f5->HGT(i,0,locY,locX)
   baseheight5 = height5(0,locY,locX)
t5 = wrf_user_getvar(f5, "tk", i)
   qv5=wrf_user_getvar(f5, "QVAPOR", i)
   vt5=wrf_virtual_temp(t5, qv5)
 ua5=wrf_user_getvar(f5, "ua", i)
   va5=wrf_user_getvar(f5, "va", i)
   ws5=sqrt(ua5^2+va5^2)

   vts5=vt5(0,locY,locX)        ;lowest level virtual potential temperature
   wss5=ws5(0,locY,locX)        ;lowest level wind speed , fixed value

   th5 = wrf_user_getvar(f5, "th", i)
  ;print(height)
   print(baseheight5)
    th_base5 = th5(0,locY,locX)
    th_crite5 = th_base5+1.5   ;one of the popular mixing height definitions 
   ;do j=1,4000,1

   thv5=th5*(1.0+0.61*qv5)
thvs5=thv5(0,locY,locX)

     interheight5= baseheight5+1
    th_plane5 = wrf_user_intrp3d(th5,height5, "h", interheight5, 0., False)
      th_point5 = th_plane5(locY,locX)
      ws_plane5= wrf_user_intrp3d(ws5, height5, "h", interheight5, 0., False)
     vt_plane5=wrf_user_intrp3d(vt5, height5, "h", interheight5, 0., False)
    ws_point5=ws_plane5(locY,locX)
    vt_point5=vt_plane5(locY,locX)

thv_plane5=wrf_user_intrp3d(thv5, height5, "h", interheight5, 0., False)
    thv_point5=thv_plane5(locY,locX)


Ri5=9.8/thvs5*(thv_point5-thvs5)*(interheight5-baseheight5)/((ws_point5-wss5)^2)


      height6 = wrf_user_getvar(f6, "height", i)
  ; baseheight = f6->HGT(i,0,locY,locX)
   baseheight6 = height6(0,locY,locX)
   t6 = wrf_user_getvar(f6, "tk", i)
   qv6=wrf_user_getvar(f6, "QVAPOR", i)
   vt6=wrf_virtual_temp(t6, qv6)
 ua6=wrf_user_getvar(f6, "ua", i)
   va6=wrf_user_getvar(f6, "va", i)
   ws6=sqrt(ua6^2+va6^2)

   vts6=vt6(0,locY,locX)        ;lowest level virtual potential temperature
   wss6=ws6(0,locY,locX)        ;lowest level wind speed , fixed value

   th6 = wrf_user_getvar(f6, "th", i)
  ;print(height)
   print(baseheight6)
    th_base6 = th6(0,locY,locX)
    th_crite6 = th_base6+1.5   ;one of the popular mixing height definitions 
   ;do j=1,4000,1
thv6=th6*(1.0+0.61*qv6)
thvs6=thv6(0,locY,locX)

     interheight6= baseheight6+1
    th_plane6 = wrf_user_intrp3d(th6,height6, "h", interheight6, 0., False)
      th_point6 = th_plane6(locY,locX)
      ws_plane6= wrf_user_intrp3d(ws6, height6, "h", interheight6, 0., False)
     vt_plane6=wrf_user_intrp3d(vt6, height6, "h", interheight6, 0., False)
    ws_point6=ws_plane6(locY,locX)
    vt_point6=vt_plane6(locY,locX)
    thv_plane6=wrf_user_intrp3d(thv6, height6, "h", interheight6, 0., False)
    thv_point6=thv_plane6(locY,locX)


Ri6=9.8/thvs6*(thv_point6-thvs6)*(interheight6-baseheight6)/((ws_point6-wss6)^2)


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
print(thv_point7)
print(thvs7)
print(interheight7)
print(baseheight7)
print(ws_point7)
print(wss7)
print(Ri7)

;print(Ri7)

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


      do while (Ri1.lt.Ricrit)
       interheight1 =interheight1+1
       th_plane1 = wrf_user_intrp3d(th1,height1, "h", interheight1, 0., False)
       th_point1 = th_plane1(locY,locX)

       ws_plane1= wrf_user_intrp3d(ws1, height1, "h", interheight1, 0., False)
     vt_plane1=wrf_user_intrp3d(vt1, height1, "h", interheight1, 0., False)
    ws_point1=ws_plane1(locY,locX)
    vt_point1=vt_plane1(locY,locX)


thv_plane1=wrf_user_intrp3d(thv1, height1, "h", interheight1, 0., False)
    thv_point1=thv_plane1(locY,locX)


Ri1=9.8/thvs1*(thv_point1-thvs1)*(interheight1-baseheight1)/((ws_point1-wss1)^2)
      end do


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

      end do

      do while (Ri3.lt.Ricrit)
       interheight3 =interheight3+1
       th_plane3 = wrf_user_intrp3d(th3,height3, "h", interheight3, 0., False)
       th_point3 = th_plane3(locY,locX)

       ws_plane3= wrf_user_intrp3d(ws3, height3, "h", interheight3, 0., False)
     vt_plane3=wrf_user_intrp3d(vt3, height3, "h", interheight3, 0., False)
    ws_point3=ws_plane3(locY,locX)
    vt_point3=vt_plane3(locY,locX)


thv_plane3=wrf_user_intrp3d(thv3, height3, "h", interheight3, 0., False)
    thv_point3=thv_plane3(locY,locX)


Ri3=9.8/thvs3*(thv_point3-thvs3)*(interheight3-baseheight3)/((ws_point3-wss3)^2)


      end do

      do while (Ri4.lt.Ricrit)
       interheight4 =interheight4+1
       th_plane4 = wrf_user_intrp3d(th4,height4, "h", interheight4, 0., False)
       th_point4 = th_plane4(locY,locX)

       ws_plane4= wrf_user_intrp3d(ws4, height4, "h", interheight4, 0., False)
     vt_plane4=wrf_user_intrp3d(vt4, height4, "h", interheight4, 0., False)
    ws_point4=ws_plane4(locY,locX)
    vt_point4=vt_plane4(locY,locX)
    thv_plane4=wrf_user_intrp3d(thv4, height4, "h", interheight4, 0., False)
    thv_point4=thv_plane4(locY,locX)


Ri4=9.8/thvs4*(thv_point4-thvs4)*(interheight4-baseheight4)/((ws_point4-wss4)^2)
      end do

      do while (Ri5.lt.Ricrit)
       interheight5 =interheight5+1
       th_plane5 = wrf_user_intrp3d(th5,height5, "h", interheight5, 0., False)
       th_point5 = th_plane5(locY,locX)

        ws_plane5= wrf_user_intrp3d(ws5, height5, "h", interheight5, 0., False)
     vt_plane5=wrf_user_intrp3d(vt5, height5, "h", interheight5, 0., False)
    ws_point5=ws_plane5(locY,locX)
    vt_point5=vt_plane5(locY,locX)

thv_plane5=wrf_user_intrp3d(thv5, height5, "h", interheight5, 0., False)
    thv_point5=thv_plane5(locY,locX)


Ri5=9.8/thvs5*(thv_point5-thvs5)*(interheight5-baseheight5)/((ws_point5-wss5)^2)
      end do

      do while (Ri6.lt.Ricrit)
       interheight6 =interheight6+1
       th_plane6 = wrf_user_intrp3d(th6,height6, "h", interheight6, 0., False)
       th_point6 = th_plane6(locY,locX)

        ws_plane6= wrf_user_intrp3d(ws6, height6, "h", interheight6, 0., False)
     vt_plane6=wrf_user_intrp3d(vt6, height6, "h", interheight6, 0., False)
    ws_point6=ws_plane6(locY,locX)
    vt_point6=vt_plane6(locY,locX)
  thv_plane6=wrf_user_intrp3d(thv6, height6, "h", interheight6, 0., False)
    thv_point6=thv_plane6(locY,locX)


Ri6=9.8/thvs6*(thv_point6-thvs6)*(interheight6-baseheight6)/((ws_point6-wss6)^2)

      end do

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
      end do


    print(interheight0)
    print(th_point3)

;alist=[/time,baseheight,interheight,th_point/]
;format = "%s,%g,%g,%g"
alist=[/times,interheight0,interheight1,interheight3,interheight2,interheight6, interheight7,interheight4,interheight5/]
format = "%s,%g,%g,%g,%g,%g,%g,%g,%g"
write_table(csv_filename, "a", alist, format)
  ; end do
 ; delete(time)
    delete (th_point0)
    delete(ws_point0)
    delete(vt_point0)
    delete(Ri0)
    delete(height0)
    delete (baseheight0)

    delete (th_point1)
     delete(ws_point1)
    delete(vt_point1)
    delete(Ri1)
    delete(height1)
    delete (baseheight1)

    delete (th_point2)
     delete(ws_point2)
    delete(vt_point2)
    delete(Ri2)
    delete(height2)
    delete (baseheight2)

    delete (th_point3)
     delete(ws_point3)
    delete(vt_point3)
    delete(Ri3)
    delete(height3)
    delete (baseheight3)

    delete (th_point4)
     delete(ws_point4)
    delete(vt_point4)
    delete(Ri4)
    delete(height4)
    delete (baseheight4)

    delete (th_point5)
     delete(ws_point5)
    delete(vt_point5)
    delete(Ri5)
    delete(height5)
    delete (baseheight5)

     delete (th_point6)
      delete(ws_point6)
    delete(vt_point6)
    delete(Ri6)
    delete(height6)
    delete (baseheight6)

     delete (th_point7)
      delete(ws_point7)
    delete(vt_point7)
    delete(Ri7)
    delete(height7)
    delete (baseheight7)
 end do
;plot = gsn_csm_contour(wks,th_point(heightt(0:192,0:43),times(0:192)),res)
end















