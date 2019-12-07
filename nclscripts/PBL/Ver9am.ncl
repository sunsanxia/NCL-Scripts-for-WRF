
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
;  QVAPOR = wrf_user_getvar(f2, "QVAPOR", -1)
;height = wrf_user_getvar(f2, "z", -1)
;QVAPOR = wrf_user_getvar(f1, "QVAPOR", -1)
;height = wrf_user_getvar(f1, "z", -1)
; QVAPOR = wrf_user_getvar(f3, "QVAPOR", -1)
; height = wrf_user_getvar(f3, "z", -1)
;QVAPOR = wrf_user_getvar(f4, "QVAPOR", -1)
;height = wrf_user_getvar(f4, "z", -1)
 ;QVAPOR = wrf_user_getvar(f5, "QVAPOR", -1)
 ;height = wrf_user_getvar(f5, "z", -1)
 
 ;height = wrf_user_getvar(f6, "z", -1)
 ;HGT = f3->HGT(44,locY,locX)  ; HGT at 54 times
 ;ZNWW = f1->ZNW(0,:) ;eta whole levels
 csv_filename = "./Ver9am.csv"
 header = [/"Height"+",ACM2(No-nudge)"+",ACM2"+",ACM2(NARR)"+",ACM2*"+",YSU*"+",MYJ*"/]
system("rm -rf" + csv_filename)
write_table(csv_filename, "w", header, "%s")
time=wrf_user_getvar(f2, "times", -1)
;n1=11
n1=41
n2=65
n3=89
n4=113
n5=137
n6= 161
n7= 185
q0 = wrf_user_getvar(f0, "QVAPOR", -1)
q01 = q0(n1,:,:,:)
q02= q0(n2,:,:,:)
q03= q0(n3,:,:,:)
q04= q0(n4,:,:,:)
q05= q0(n5,:,:,:)
q06= q0(n6,:,:,:)
q07= q0(n7,:,:,:)


q1 = wrf_user_getvar(f1, "QVAPOR", -1)
q11 = q1(n1,:,:,:)
q12= q1(n2,:,:,:)
q13= q1(n3,:,:,:)
q14= q1(n4,:,:,:)
q15= q1(n5,:,:,:)
q16= q1(n6,:,:,:)
q17= q1(n7,:,:,:)

q2 = wrf_user_getvar(f2, "QVAPOR", -1)
q21 = q2(n1,:,:,:)
q22= q2(n2,:,:,:)
q23= q2(n3,:,:,:)
q24= q2(n4,:,:,:)
q25= q2(n5,:,:,:)
q26= q2(n6,:,:,:)
q27= q2(n7,:,:,:)

q3 = wrf_user_getvar(f3, "QVAPOR", -1)
q31 = q3(n1,:,:,:)
q32= q3(n2,:,:,:)
q33= q3(n3,:,:,:)
q34= q3(n4,:,:,:)
q35= q3(n5,:,:,:)
q36= q3(n6,:,:,:)
q37= q3(n7,:,:,:)

q4 = wrf_user_getvar(f4, "QVAPOR", -1)
q41 = q4(n1,:,:,:)
q42= q4(n2,:,:,:)
q43= q4(n3,:,:,:)
q44= q4(n4,:,:,:)
q45= q4(n5,:,:,:)
q46= q4(n6,:,:,:)
q47= q4(n7,:,:,:)

q5 = wrf_user_getvar(f5, "QVAPOR", -1)
q51 = q5(n1,:,:,:)
q52= q5(n2,:,:,:)
q53= q5(n3,:,:,:)
q54= q5(n4,:,:,:)
q55= q5(n5,:,:,:)
q56= q5(n6,:,:,:)
q57= q5(n7,:,:,:)



printVarSummary(q01)
p0 = wrf_user_getvar(f0, "pressure", -1)


hgt_ALL = wrf_user_getvar(f0,"HGT", -1)
heightn1=wrf_user_getvar(f0, "height", n1)
heightn2=wrf_user_getvar(f0, "height", n2)
heightn3=wrf_user_getvar(f0, "height", n3)
heightn4=wrf_user_getvar(f0, "height", n4)
heightn5=wrf_user_getvar(f0, "height", n5)
heightn6=wrf_user_getvar(f0, "height", n6)
heightn7=wrf_user_getvar(f0, "height", n7)

heightn11=wrf_user_getvar(f1, "height", n1)
heightn12=wrf_user_getvar(f1, "height", n2)
heightn13=wrf_user_getvar(f1, "height", n3)
heightn14=wrf_user_getvar(f1, "height", n4)
heightn15=wrf_user_getvar(f1, "height", n5)
heightn16=wrf_user_getvar(f1, "height", n6)
heightn17=wrf_user_getvar(f1, "height", n7)

heightn21=wrf_user_getvar(f2, "height", n1)
heightn22=wrf_user_getvar(f2, "height", n2)
heightn23=wrf_user_getvar(f2, "height", n3)
heightn24=wrf_user_getvar(f2, "height", n4)
heightn25=wrf_user_getvar(f2, "height", n5)
heightn26=wrf_user_getvar(f2, "height", n6)
heightn27=wrf_user_getvar(f2, "height", n7)

heightn31=wrf_user_getvar(f3, "height", n1)
heightn32=wrf_user_getvar(f3, "height", n2)
heightn33=wrf_user_getvar(f3, "height", n3)
heightn34=wrf_user_getvar(f3, "height", n4)
heightn35=wrf_user_getvar(f3, "height", n5)
heightn36=wrf_user_getvar(f3, "height", n6)
heightn37=wrf_user_getvar(f3, "height", n7)

heightn41=wrf_user_getvar(f4, "height", n1)
heightn42=wrf_user_getvar(f4, "height", n2)
heightn43=wrf_user_getvar(f4, "height", n3)
heightn44=wrf_user_getvar(f4, "height", n4)
heightn45=wrf_user_getvar(f4, "height", n5)
heightn46=wrf_user_getvar(f4, "height", n6)
heightn47=wrf_user_getvar(f4, "height", n7)

heightn51=wrf_user_getvar(f5, "height", n1)
heightn52=wrf_user_getvar(f5, "height", n2)
heightn53=wrf_user_getvar(f5, "height", n3)
heightn54=wrf_user_getvar(f5, "height", n4)
heightn55=wrf_user_getvar(f5, "height", n5)
heightn56=wrf_user_getvar(f5, "height", n6)
heightn57=wrf_user_getvar(f5, "height", n7)

hgt=hgt_ALL(0,locY,locX)
;q0_point = q0(:,:,locY,locX)


do i=1,6000,1
    print(i)
q01_level = wrf_user_intrp3d(q01, heightn1, "h", hgt, 0., False)
q02_level= wrf_user_intrp3d(q02, heightn2, "h", hgt, 0., False)
q03_level= wrf_user_intrp3d(q03, heightn3, "h", hgt, 0., False)
q04_level= wrf_user_intrp3d(q04, heightn4, "h", hgt, 0., False)
q05_level= wrf_user_intrp3d(q05, heightn5, "h", hgt, 0., False)
q06_level= wrf_user_intrp3d(q06, heightn6, "h", hgt, 0., False)
q07_level= wrf_user_intrp3d(q07, heightn7, "h", hgt, 0., False)

q01_point=q01_level(locY,locX)
q02_point=q02_level(locY,locX)
q03_point=q03_level(locY,locX)
q04_point=q04_level(locY,locX)

q05_point=q05_level(locY,locX)
q06_point=q06_level(locY,locX)

q07_point=q07_level(locY,locX)

avgq0 = (q01_point+q02_point+q03_point+q04_point+q05_point+q06_point+q07_point)*1000/7


q11_level = wrf_user_intrp3d(q11, heightn11, "h", hgt, 0., False)
q12_level= wrf_user_intrp3d(q12, heightn12, "h", hgt, 0., False)
q13_level= wrf_user_intrp3d(q13, heightn13, "h", hgt, 0., False)
q14_level= wrf_user_intrp3d(q14, heightn14, "h", hgt, 0., False)
q15_level= wrf_user_intrp3d(q15, heightn15, "h", hgt, 0., False)
q16_level= wrf_user_intrp3d(q16, heightn16, "h", hgt, 0., False)
q17_level= wrf_user_intrp3d(q17, heightn17, "h", hgt, 0., False)

q11_point=q11_level(locY,locX)
q12_point=q12_level(locY,locX)
q13_point=q13_level(locY,locX)
q14_point=q14_level(locY,locX)

q15_point=q15_level(locY,locX)
q16_point=q16_level(locY,locX)

q17_point=q17_level(locY,locX)

avgq1 = (q11_point+q12_point+q13_point+q14_point+q15_point+q16_point+q17_point)*1000/7



q21_level = wrf_user_intrp3d(q21, heightn21, "h", hgt, 0., False)
q22_level= wrf_user_intrp3d(q22, heightn22, "h", hgt, 0., False)
q23_level= wrf_user_intrp3d(q23, heightn23, "h", hgt, 0., False)
q24_level= wrf_user_intrp3d(q24, heightn24, "h", hgt, 0., False)
q25_level= wrf_user_intrp3d(q25, heightn25, "h", hgt, 0., False)
q26_level= wrf_user_intrp3d(q26, heightn26, "h", hgt, 0., False)
q27_level= wrf_user_intrp3d(q27, heightn27, "h", hgt, 0., False)

q21_point=q21_level(locY,locX)
q22_point=q22_level(locY,locX)
q23_point=q23_level(locY,locX)
q24_point=q24_level(locY,locX)

q25_point=q25_level(locY,locX)
q26_point=q26_level(locY,locX)

q27_point=q27_level(locY,locX)

avgq2 = (q21_point+q22_point+q23_point+q24_point+q25_point+q26_point+q27_point)*1000/7

q31_level = wrf_user_intrp3d(q31, heightn31, "h", hgt, 0., False)
q32_level= wrf_user_intrp3d(q32, heightn32, "h", hgt, 0., False)
q33_level= wrf_user_intrp3d(q33, heightn33, "h", hgt, 0., False)
q34_level= wrf_user_intrp3d(q34, heightn34, "h", hgt, 0., False)
q35_level= wrf_user_intrp3d(q35, heightn35, "h", hgt, 0., False)
q36_level= wrf_user_intrp3d(q36, heightn36, "h", hgt, 0., False)
q37_level= wrf_user_intrp3d(q37, heightn37, "h", hgt, 0., False)

q31_point=q31_level(locY,locX)
q32_point=q32_level(locY,locX)
q33_point=q33_level(locY,locX)
q34_point=q34_level(locY,locX)

q35_point=q35_level(locY,locX)
q36_point=q36_level(locY,locX)

q37_point=q37_level(locY,locX)

avgq3 = (q31_point+q32_point+q33_point+q34_point+q35_point+q36_point+q37_point)*1000/7

q41_level = wrf_user_intrp3d(q41, heightn41, "h", hgt, 0., False)
q42_level= wrf_user_intrp3d(q42, heightn42, "h", hgt, 0., False)
q43_level= wrf_user_intrp3d(q43, heightn43, "h", hgt, 0., False)
q44_level= wrf_user_intrp3d(q44, heightn44, "h", hgt, 0., False)
q45_level= wrf_user_intrp3d(q45, heightn45, "h", hgt, 0., False)
q46_level= wrf_user_intrp3d(q46, heightn46, "h", hgt, 0., False)
q47_level= wrf_user_intrp3d(q47, heightn47, "h", hgt, 0., False)

q41_point=q41_level(locY,locX)
q42_point=q42_level(locY,locX)
q43_point=q43_level(locY,locX)
q44_point=q44_level(locY,locX)

q45_point=q45_level(locY,locX)
q46_point=q46_level(locY,locX)

q47_point=q47_level(locY,locX)

avgq4 = (q41_point+q42_point+q43_point+q44_point+q45_point+q46_point+q47_point)*1000/7

q51_level = wrf_user_intrp3d(q51, heightn1, "h", hgt, 0., False)
q52_level= wrf_user_intrp3d(q52, heightn2, "h", hgt, 0., False)
q53_level= wrf_user_intrp3d(q53, heightn3, "h", hgt, 0., False)
q54_level= wrf_user_intrp3d(q54, heightn4, "h", hgt, 0., False)
q55_level= wrf_user_intrp3d(q55, heightn5, "h", hgt, 0., False)
q56_level= wrf_user_intrp3d(q56, heightn6, "h", hgt, 0., False)
q57_level= wrf_user_intrp3d(q57, heightn7, "h", hgt, 0., False)

q51_point=q51_level(locY,locX)
q52_point=q52_level(locY,locX)
q53_point=q53_level(locY,locX)
q54_point=q54_level(locY,locX)

q55_point=q55_level(locY,locX)
q56_point=q56_level(locY,locX)

q57_point=q57_level(locY,locX)

avgq5 = (q51_point+q52_point+q53_point+q54_point+q55_point+q56_point+q57_point)*1000/7

;avgq0 = dim_avg_n(q0_point((11,22),:), 0)

print(avgq0)
;alist=[/time,baseheight,interheight,QVAPOR_point/]
;format = "%s,%g,%g,%g"
alist=[/hgt,avgq0,avgq1,avgq2,avgq3,avgq4,avgq5/]
format = "%g,%g,%g,%g,%g,%g,%g"
write_table(csv_filename, "a", alist, format)

hgt=hgt+1
end do
end















