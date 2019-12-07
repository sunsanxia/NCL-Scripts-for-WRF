
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
;---------------------------------------------------------------------

;f1 = addfile("/home/xsun/model/xsun/soft/WRFV3/run_NAMYSUNEW/wrfinput_d04.nc","r")  ;modify the cnmaxlevel too, MODIS is 20 and USGS is 24
file0= systemfunc("ls /mnt/datadrive/xsun/work/run_NAMMODIS/wrfout_d02*")  ;USGS data
f0 = addfiles(file0, "r")
fils1 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMACMMODIS/wrfout_d02*")
fils2 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMYSUMODIS/wrfout_d02*")
fils3 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMMYJMODIS/wrfout_d02*")
f1= addfiles(fils1, "r")
f2= addfiles(fils2, "r")
f3= addfiles(fils3, "r")
;------overlay to countours on map ----------------------------------------------------------------------
  

;------------------------------------------------------------------------------
;landuse = f1->LU_INDEX(0,:,:)
time = wrf_user_getvar(f0, "times", -1)

LongRadi0 = wrf_user_getvar(f0, "TSK", -1)
;ShortRadi0 = wrf_user_getvar(f0, "SWDOWN", -1)
;Radi0 = LongRadi0+ShortRadi0
;copy_VarAtts(LongRadi0, Radi0)
;Ave_Radi0 = dim_avg_n(Radi0,(/1,2/))
Ave_LonRadi0 = dim_avg_n(LongRadi0,(/1,2/))
;Ave_ShorRadi0 = dim_avg_n(ShortRadi0,(/1,2/))

LongRadi1 = wrf_user_getvar(f1, "TSK", -1)
;ShortRadi1 = wrf_user_getvar(f1, "SWDOWN", -1)
;Radi1 = LongRadi1+ShortRadi1
;copy_VarAtts(LongRadi1, Radi1)
;Ave_Radi1 = dim_avg_n(Radi1,(/1,2/))
Ave_LonRadi1 = dim_avg_n(LongRadi1,(/1,2/))
;Ave_ShorRadi1 = dim_avg_n(ShortRadi1,(/1,2/))

LongRadi2 = wrf_user_getvar(f2, "TSK", -1)
;ShortRadi2 = wrf_user_getvar(f2, "SWDOWN", -1)
;Radi2 = LongRadi2+ShortRadi2
;copy_VarAtts(LongRadi2, Radi2)
;Ave_Radi2 = dim_avg_n(Radi2,(/1,2/))
Ave_LonRadi2 = dim_avg_n(LongRadi2,(/1,2/))
;Ave_ShorRadi2 = dim_avg_n(ShortRadi2,(/1,2/))

LongRadi3 = wrf_user_getvar(f3, "TSK", -1)
;ShortRadi3 = wrf_user_getvar(f3, "SWDOWN", -1)
;Radi3 = LongRadi3+ShortRadi3
;copy_VarAtts(LongRadi3, Radi3)
;Ave_Radi3 = dim_avg_n(Radi3,(/1,2/))
Ave_LonRadi3 = dim_avg_n(LongRadi3,(/1,2/))
;Ave_ShorRadi3 = dim_avg_n(ShortRadi3,(/1,2/))

;diff0 =Ave_Radi1-Ave_Radi0
;diff2= Ave_Radi1-Ave_Radi2
;diff3= Ave_Radi1-Ave_Radi3

diff0 =Ave_LonRadi1-Ave_LonRadi0
diff2= Ave_LonRadi1-Ave_LonRadi2
diff3= Ave_LonRadi1-Ave_LonRadi3
diff32= Ave_LonRadi2-Ave_LonRadi3

;diff0 =Ave_ShorRadi1-Ave_ShorRadi0
;diff2= Ave_ShorRadi1-Ave_ShorRadi2
;diff3= Ave_ShorRadi1-Ave_ShorRadi3

;print(Ave_Radi0)

header=[/"time"+",ACM*-ACM"+",ACM*-YSU"+",ACM*-MYJ"+",YSU*-MYJ*"/]
csv_filename = "Diff_TSK.csv"
system("rm -rf" + csv_filename)
write_table(csv_filename, "w", header, "%s")
alist = [/time,diff0,diff2,diff3,diff32/]
format="%s,%g,%g,%g,%g"
write_table(csv_filename, "a", alist, format)
end















