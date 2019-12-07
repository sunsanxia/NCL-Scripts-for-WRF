
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
;---------------------------------------------------------------------

;f1 = addfile("/home/xsun/model/xsun/soft/WRFV3/run_NAMYSUNEW/wrfinput_d04.nc","r")  ;modify the cnmaxlevel too, MODIS is 20 and USGS is 24
file0= systemfunc("ls /home/xsun/xsun/Borah/work/run_NAMMODIS/wrfout_d02*")  ;USGS data ACM2
f0 = addfiles(file0, "r")
fils1 = systemfunc("ls /home/xsun/xsun/Borah/work/run_NAMACMMODIS/wrfout_d02*")
fils2 = systemfunc("ls /home/xsun/xsun/Borah/work/run_NAMYSUMODIS/wrfout_d02*")
fils3 = systemfunc("ls /home/xsun/xsun/Borah/work/run_NAMMYJMODIS/wrfout_d02*")
f1= addfiles(fils1, "r")
f2= addfiles(fils2, "r")
f3= addfiles(fils3, "r")
f4=addfile("/home/xsun/xsun/Borah/work/run_NARR/d0102Rerun/wrfout_d02_2014-09-21_00:00:00.nc","r") ;ACM2(NARR)
fils5=systemfunc("ls /home/xsun/xsun/Borah/work/run_NARRYSUMODIS/wrfout_d02*") ;YSU*(NARR)
fils6=systemfunc("ls /home/xsun/xsun/Borah/work/run_NARRMYJMODIS/wrfout_d02*")   ;MYJ(NARR)

f5= addfiles(fils5, "r")
f6= addfiles(fils6, "r")
;------overlay to countours on map ----------------------------------------------------------------------
  

;------------------------------------------------------------------------------
;landuse = f1->LU_INDEX(0,:,:)
time = wrf_user_getvar(f0, "times", -1)

ILW0 = wrf_user_getvar(f0, "GLW", -1)
ShortRadi0 = wrf_user_getvar(f0, "SWDOWN", -1)
EMISS0= wrf_user_getvar(f0, "EMISS", -1)
TSK0=wrf_user_getvar(f0, "TSK", -1)
ALBEDO0=wrf_user_getvar(f0, "ALBEDO", -1)
Radi0 = ILW0+ShortRadi0*(1-ALBEDO0)-EMISS0*5.67*0.00000001*(TSK0^4)
copy_VarAtts(ILW0, Radi0)
Ave_Radi0 = dim_avg_n(Radi0,(/1,2/))
Ave_Radi00= dim_avg_n(ILW0, (/1,2/))
Ave_Radi01=dim_avg_n(ShortRadi0, (/1,2/))
;Ave_LonRadi0 = dim_avg_n(LongRadi0,(/1,2/))
;Ave_ShorRadi0 = dim_avg_n(ShortRadi0,(/1,2/))

ILW1 = wrf_user_getvar(f1, "GLW", -1)
ShortRadi1 = wrf_user_getvar(f1, "SWDOWN", -1)
EMISS1= wrf_user_getvar(f1, "EMISS", -1)
TSK1=wrf_user_getvar(f1, "TSK", -1)
ALBEDO1=wrf_user_getvar(f1, "ALBEDO", -1)
Radi1 = ILW1+ShortRadi1*(1-ALBEDO1)-EMISS1*5.67*0.00000001*(TSK1^4)
copy_VarAtts(ILW1, Radi1)
Ave_Radi1 = dim_avg_n(Radi1,(/1,2/))
Ave_Radi10= dim_avg_n(ILW1, (/1,2/))
Ave_Radi11=dim_avg_n(ShortRadi1, (/1,2/))

ILW2 = wrf_user_getvar(f2, "GLW", -1)
ShortRadi2 = wrf_user_getvar(f2, "SWDOWN", -1)
EMISS2= wrf_user_getvar(f2, "EMISS", -1)
TSK2=wrf_user_getvar(f2, "TSK", -1)
ALBEDO2=wrf_user_getvar(f2, "ALBEDO", -1)
Radi2 = ILW2+ShortRadi2*(1-ALBEDO2)-EMISS2*5.67*0.00000001*(TSK2^4)
copy_VarAtts(ILW2, Radi2)
Ave_Radi2 = dim_avg_n(Radi2,(/1,2/))
Ave_Radi20= dim_avg_n(ILW2, (/1,2/))
Ave_Radi21=dim_avg_n(ShortRadi2, (/1,2/))

ILW3 = wrf_user_getvar(f3, "GLW", -1)
ShortRadi3 = wrf_user_getvar(f3, "SWDOWN", -1)
EMISS3= wrf_user_getvar(f3, "EMISS", -1)
TSK3=wrf_user_getvar(f3, "TSK", -1)
ALBEDO3=wrf_user_getvar(f3, "ALBEDO", -1)
Radi3 = ILW3+ShortRadi3*(1-ALBEDO3)-EMISS3*5.67*0.00000001*(TSK3^4)
copy_VarAtts(ILW3, Radi3)
Ave_Radi3 = dim_avg_n(Radi3,(/1,2/))
Ave_Radi30= dim_avg_n(ILW3, (/1,2/))
Ave_Radi31=dim_avg_n(ShortRadi3, (/1,2/))

ILW4 = wrf_user_getvar(f4, "GLW", -1)
ShortRadi4 = wrf_user_getvar(f4, "SWDOWN", -1)
EMISS4= wrf_user_getvar(f4, "EMISS", -1)
TSK4=wrf_user_getvar(f4, "TSK", -1)
ALBEDO4=wrf_user_getvar(f4, "ALBEDO", -1)
Radi4 = ILW4+ShortRadi4*(1-ALBEDO4)-EMISS0*5.67*0.00000001*(TSK4^4)
copy_VarAtts(ILW4, Radi4)
Ave_Radi4 = dim_avg_n(Radi4,(/1,2/))
Ave_Radi40= dim_avg_n(ILW4, (/1,2/))
Ave_Radi41=dim_avg_n(ShortRadi4, (/1,2/))

ILW5 = wrf_user_getvar(f5, "GLW", -1)
ShortRadi5 = wrf_user_getvar(f5, "SWDOWN", -1)
EMISS5= wrf_user_getvar(f5, "EMISS", -1)
TSK5=wrf_user_getvar(f5, "TSK", -1)
ALBEDO5=wrf_user_getvar(f5, "ALBEDO", -1)
Radi5 = ILW5+ShortRadi5*(1-ALBEDO5)-EMISS5*5.67*0.00000001*(TSK5^4)
copy_VarAtts(ILW5, Radi5)
Ave_Radi5 = dim_avg_n(Radi5,(/1,2/))
Ave_Radi50= dim_avg_n(ILW5, (/1,2/))
Ave_Radi51=dim_avg_n(ShortRadi5, (/1,2/))

ILW6 = wrf_user_getvar(f6, "GLW", -1)
ShortRadi6 = wrf_user_getvar(f6, "SWDOWN", -1)
EMISS6= wrf_user_getvar(f6, "EMISS", -1)
TSK6=wrf_user_getvar(f6, "TSK", -1)
ALBEDO6=wrf_user_getvar(f6, "ALBEDO", -1)
Radi6 = ILW6+ShortRadi6*(1-ALBEDO6)-EMISS6*5.67*0.00000001*(TSK6^4)
copy_VarAtts(ILW6, Radi6)
Ave_Radi6 = dim_avg_n(Radi6,(/1,2/))
Ave_Radi60= dim_avg_n(ILW6, (/1,2/))
Ave_Radi61=dim_avg_n(ShortRadi6, (/1,2/))

diff0 =Ave_Radi1-Ave_Radi0
diff2= Ave_Radi1-Ave_Radi2
diff3= Ave_Radi1-Ave_Radi3
diff4=Ave_Radi0-Ave_Radi4
diff5=Ave_Radi2-Ave_Radi5
diff6=Ave_Radi3-Ave_Radi6




;diff0 =Ave_LonRadi1-Ave_LonRadi0
;diff2= Ave_LonRadi1-Ave_LonRadi2
;diff3= Ave_LonRadi1-Ave_LonRadi3

;diff0 =Ave_ShorRadi1-Ave_ShorRadi0
;diff2= Ave_ShorRadi1-Ave_ShorRadi2
;diff3= Ave_ShorRadi1-Ave_ShorRadi3

print(Ave_Radi0)

header=[/"time"+",ACM*-ACM"+",ACM*-YSU"+",ACM*-MYJ"+",ACM-ACM(NARR)"+",YSU*-YSU*(NARR)"+",MYJ*-MYJ*(NARR)"/]
csv_filename = "Diff_Rn_ALLNARR.csv"
system("rm -rf" + csv_filename)
write_table(csv_filename, "w", header, "%s")
alist = [/time,diff0,diff2,diff3,diff4,diff5,diff6/]
format="%s,%g,%g,%g,%g,%g,%g"
write_table(csv_filename, "a", alist, format)
end















