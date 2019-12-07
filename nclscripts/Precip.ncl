
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
;obsname =  "/home/xsun/model/xsun/work/obs20142.csv"
;obsvars = asciiread(obsname,-1,"string")
;delim = ","
;obsvar = tofloat(str_get_field(obsvars(1::), 8, delim))
;obsvar@_FillValue = 999
;----------------------------------------------------------------------------
  lat = 45.713560
  lon = -119.406023
  llres = True
  llres@ReturnInt = True ; Return integer values
  locij = wrf_user_ll_to_ij(f1, lon, lat, llres)
  locij = locij -1
  locX = locij(0)
  locY = locij(1)
 print(locX)
print(locY)
 position1 = wrf_user_getvar(f0, "XLAT", -1)
 position2 = wrf_user_getvar(f0, "XLONG", -1)
print(position1(2,locY,locX));
print(position2(2,locY,locX));

;------------------------------------------------------------------------------
  ustar00 = wrf_user_getvar(f0, "RAINNC", -1)
ustar01 = wrf_user_getvar(f0, "RAINC", -1)  
ustar0=ustar00+ustar01
ustar0_point =ustar0(:, locY, locX) 
 ustar10 = wrf_user_getvar(f1, "RAINNC", -1)
ustar11 = wrf_user_getvar(f1, "RAINC", -1)
  ustar1=ustar10+ustar11
  ustar1_point =ustar1(:, locY, locX)
  ustar20 = f2[:]->RAINNC
 ustar21 = f2[:]->RAINC
 ustar2=ustar20+ustar21
  ustar2_point = ustar2(:, locY, locX)
  ustar30 = wrf_user_getvar(f3,"RAINNC", -1)
ustar31 = wrf_user_getvar(f3,"RAINC", -1)
ustar3=ustar30+ustar31
  ustar3_point = ustar3(:, locY, locX);
  ustar40 = f4[:]->RAINNC
  ustar41 = f4[:]->RAINC
 ustar4=ustar40+ustar41
ustar50 = f5[:]->RAINNC
ustar51 = f5[:]->RAINC
ustar5=ustar50+ustar51
ustar4_point = ustar4(:, locY, locX)
ustar5_point = ustar5(:, locY, locX)
;------------------------------------------------------------------------------
 timess = wrf_times_c(f1->Times,0)

  ntimes = dimsizes(timess)-5
  times = timess -8  ;LST time

 ; print(times)
  copy_VarAtts(timess, times)
;----creat array to save paramers----------------------------------------------
    ustar = new ((/6,193/),float)
ustar(5, 0:192) = ustar0_point
  ustar(4, 0:192) = ustar1_point
  ustar(3, 0:192) = ustar3_point
  ustar(2, 0:192) = ustar2_point
  ustar(1, 0:192) = ustar4_point
  ustar(0, 0:192) = ustar5_point   
;ustar(6, 0:192) = obsvar(:)
 

;-----------------------------------------------------------------
wks = gsn_open_wks("eps", "./Flux/PrecipLST")  
;wks = gsn_open_wks("x11", "Modles Performance")
;--------set resources
  res = True
 res@xyExplicitLegendLabels = (/"MYJ*","YSU*","ACM2*","ACM2(NARR)","ACM2","ACM2(No-nudge)"/)
  ;res@xyLineColors = (/"grey","blue","red","green","chocolate2","lightseagreen","black"/)
  res@xyLineColors = (/"lightseagreen","chocolate2","green","red","blue","grey"/)
  res@xyLineThicknessF = 3
  res@tiYAxisString = "Total Precipitation (mm)"
  res@tiYAxisFont = 21
  res@tiYAxisFontHeightF = 0.012
 ; res@trYMinF = 0.0
 ; res@trYMaxF = 150
  res@trXMinF = times(47) ;44
  res@trXMaxF = times(184) ;188
  res@gsnMaximize = True
  res@gsnDraw = False
  res@gsnFrame = False
  res@vpWidthF = 0.8
  res@vpHeightF = 0.3
  res@pmLegendDisplayMode = "Always"
  res@lgLabelFontHeightF = 0.01
  res@pmLegendWidthF = 0.04
  res@pmLegendHeightF = 0.09
  res@pmLegendOrthogonalPosF = -1.24
  res@pmLegendParallelPosF = 0.10
  res@lgPerimOn = False
   res@tmXBLabelFontHeightF = 0.0075 ;x axis label size
 ;-----------set axis
 restick = True
   restick@ttmFormat = "%D-%c %H:%M"
 restick@ttmValues=(/(/2014,9,22,12,0,0/),\
                     (/2014,9,23,0,0,0/),\
                     (/2014,9,23,12,0,0/),\
                     (/2014,9,24,0,0,0/),\
                     (/2014,9,24,12,0,0/),\
                     (/2014,9,25,0,0,0/),\
                     (/2014,9,25,12,0,0/),\
                     (/2014,9,26,0,0,0/),\
                     (/2014,9,26,12,0,0/),\
                     (/2014,9,27,0,0,0/),\
                     (/2014,9,27,12,0,0/),\
                     (/2014,9,28,0,0,0/),\
                     (/2014,9,28,12,0,0/)/)

; restick@ttmMajorStride=12 ;change the lable numbers
 restick@ttmMinorStride=4
  time_axis_labels(times,res,restick)
;---------------------------
plot = gsn_csm_xy(wks,times,ustar,res)


;-----------
draw(plot)
frame(wks)


wtimes = wrf_user_getvar(f0, "times", -1)

header =[/"time(UTC)"+",ACM2(No-nudge)"+",ACM2"+",ACM2(NARR)"+",ACM2*"+",YSU*"+",MYJ*"/]
csv_filename = "./Flux/Precip.csv"
system("rm -rf" + csv_filename)
write_table(csv_filename, "w", header, "%s")
alist=[/wtimes,ustar0_point,ustar1_point,ustar3_point,ustar2_point,ustar4_point,ustar5_point/]
format = "%s,%g,%g,%g,%g,%g,%g"
write_table(csv_filename, "a", alist, format)
end















