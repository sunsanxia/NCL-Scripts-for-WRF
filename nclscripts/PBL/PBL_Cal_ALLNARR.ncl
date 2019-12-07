
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
 csv_filename = "./PBL_ALLNARR.csv"
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
   ;do j=1,4000,1
     interheight0= baseheight0+1
    th_plane0 = wrf_user_intrp3d(th0,height0, "h", interheight0, 0., False)
th_point0 = th_plane0(locY,locX)


   height1 = wrf_user_getvar(f1, "height", i)
  ; baseheight = f1->HGT(i,0,locY,locX)
   baseheight1 = height1(0,locY,locX)
   th1 = wrf_user_getvar(f1, "th", i)
  ;print(height)
   print(baseheight1)
    th_base1 = th1(0,locY,locX)
    th_crite1 = th_base1+1.5   ;one of the popular mixing height definitions 
   ;do j=1,4000,1
     interheight1= baseheight1+1
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
     interheight2= baseheight2+1
    th_plane2 = wrf_user_intrp3d(th2,height2, "h", interheight2, 0., False)
    th_point2 = th_plane2(locY,locX)

   ;time = wrf_user_getvar(f2, "times",i)
   height3 = wrf_user_getvar(f3, "height", i)
  ; baseheight = f3->HGT(i,0,locY,locX)
   baseheight3 = height3(0,locY,locX)
   th3 = wrf_user_getvar(f3, "th", i)
  ;print(height)
   print(baseheight3)
    th_base3 = th3(0,locY,locX)
    th_crite3 = th_base3+1.5   ;one of the popular mixing height definitions 
   ;do j=1,4000,1
     interheight3= baseheight3+1
    th_plane3 = wrf_user_intrp3d(th3,height3, "h", interheight3, 0., False)
     th_point3 = th_plane3(locY,locX)




   height4 = wrf_user_getvar(f4, "height", i)
  ; baseheight = f4->HGT(i,0,locY,locX)
   baseheight4 = height4(0,locY,locX)
   th4 = wrf_user_getvar(f4, "th", i)
  ;print(height)
   print(baseheight4)
    th_base4 = th4(0,locY,locX)
    th_crite4 = th_base4+1.5   ;one of the popular mixing height definitions 
   ;do j=1,4000,1
     interheight4= baseheight4+1
    th_plane4 = wrf_user_intrp3d(th4,height4, "h", interheight4, 0., False)
    th_point4 = th_plane4(locY,locX)

   
   height5 = wrf_user_getvar(f5, "height", i)
  ; baseheight = f5->HGT(i,0,locY,locX)
   baseheight5 = height5(0,locY,locX)
   th5 = wrf_user_getvar(f5, "th", i)
  ;print(height)
   print(baseheight5)
    th_base5 = th5(0,locY,locX)
    th_crite5 = th_base5+1.5   ;one of the popular mixing height definitions 
   ;do j=1,4000,1
     interheight5= baseheight5+1
    th_plane5 = wrf_user_intrp3d(th5,height5, "h", interheight5, 0., False)
      th_point5 = th_plane5(locY,locX)

      height6 = wrf_user_getvar(f6, "height", i)
  ; baseheight = f6->HGT(i,0,locY,locX)
   baseheight6 = height6(0,locY,locX)
   th6 = wrf_user_getvar(f6, "th", i)
  ;print(height)
   print(baseheight6)
    th_base6 = th6(0,locY,locX)
    th_crite6 = th_base6+1.5   ;one of the popular mixing height definitions 
   ;do j=1,4000,1
     interheight6= baseheight6+1
    th_plane6 = wrf_user_intrp3d(th6,height6, "h", interheight6, 0., False)
      th_point6 = th_plane6(locY,locX)


height7 = wrf_user_getvar(f7, "height", i)
  ; baseheight = f7->HGT(i,0,locY,locX)
   baseheight7 = height7(0,locY,locX)
   th7 = wrf_user_getvar(f7, "th", i)
  ;print(height)
   print(baseheight7)
    th_base7 = th7(0,locY,locX)
    th_crite7 = th_base7+1.5   ;one of the popular mixing height definitions 
   ;do j=1,4000,1
     interheight7= baseheight7+1
    th_plane7 = wrf_user_intrp3d(th7,height7, "h", interheight7, 0., False)
      th_point7 = th_plane7(locY,locX)



     do while (th_point0.lt.th_crite0)
       interheight0 =interheight0+1
       th_plane0 = wrf_user_intrp3d(th0,height0, "h", interheight0, 0., False)
       th_point0 = th_plane0(locY,locX)
      end do


      do while (th_point1.lt.th_crite1)
       interheight1 =interheight1+1
       th_plane1 = wrf_user_intrp3d(th1,height1, "h", interheight1, 0., False)
       th_point1 = th_plane1(locY,locX)
      end do


      do while (th_point2.lt.th_crite2)
       interheight2 =interheight2+1
       th_plane2 = wrf_user_intrp3d(th2,height2, "h", interheight2, 0., False)
       th_point2 = th_plane2(locY,locX)
      end do

      do while (th_point3.lt.th_crite3)
       interheight3 =interheight3+1
       th_plane3 = wrf_user_intrp3d(th3,height3, "h", interheight3, 0., False)
       th_point3 = th_plane3(locY,locX)
      end do

      do while (th_point4.lt.th_crite4)
       interheight4 =interheight4+1
       th_plane4 = wrf_user_intrp3d(th4,height4, "h", interheight4, 0., False)
       th_point4 = th_plane4(locY,locX)
      end do

      do while (th_point5.lt.th_crite5)
       interheight5 =interheight5+1
       th_plane5 = wrf_user_intrp3d(th5,height5, "h", interheight5, 0., False)
       th_point5 = th_plane5(locY,locX)
      end do

      do while (th_point6.lt.th_crite6)
       interheight6 =interheight6+1
       th_plane6 = wrf_user_intrp3d(th6,height6, "h", interheight6, 0., False)
       th_point6 = th_plane6(locY,locX)
      end do

      do while (th_point7.lt.th_crite7)
       interheight7 =interheight7+1
       th_plane7 = wrf_user_intrp3d(th7,height7, "h", interheight7, 0., False)
       th_point7 = th_plane7(locY,locX)
      end do


    print(interheight3)
    print(th_point3)

;alist=[/time,baseheight,interheight,th_point/]
;format = "%s,%g,%g,%g"
alist=[/times,interheight0,interheight1,interheight3,interheight2,interheight6, interheight7,interheight4,interheight5/]
format = "%s,%g,%g,%g,%g,%g,%g,%g,%g"
write_table(csv_filename, "a", alist, format)
  ; end do
 ; delete(time)
    delete (th_point0)
    delete(height0)
    delete (baseheight0)

    delete (th_point1)
    delete(height1)
    delete (baseheight1)

    delete (th_point2)
    delete(height2)
    delete (baseheight2)

    delete (th_point3)
    delete(height3)
    delete (baseheight3)

    delete (th_point4)
    delete(height4)
    delete (baseheight4)

    delete (th_point5)
    delete(height5)
    delete (baseheight5)

     delete (th_point6)
    delete(height6)
    delete (baseheight6)

     delete (th_point7)
    delete(height7)
    delete (baseheight7)
 end do
;plot = gsn_csm_contour(wks,th_point(heightt(0:192,0:43),times(0:192)),res)
end















