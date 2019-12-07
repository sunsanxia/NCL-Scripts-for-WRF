
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
;---------------------------------------------------------------------
fils2 = systemfunc("ls /home/xsun/xsun/Borah/work/run_NAMACMMODIS/wrfout_d04*")
fils4 = systemfunc("ls /home/xsun/xsun/Borah/work/run_NAMYSUMODIS/wrfout_d04*")
fils5 = systemfunc("ls /home/xsun/xsun/Borah/work/run_NAMMYJMODIS/wrfout_d04*")
f0 = addfile("/home/xsun/xsun/Borah/soft/WRFV3/run/wrfout_d04_2014-09-21_00:00:000.nc","r")
f1 = addfile("/home/xsun/xsun/Borah/work/run_NAMNG/nuisttar/wrfout_d04_2014-09-21_00:00:00.nc","r")
f2 = addfiles(fils2,"r")
ListSetType(f2,"cat")
f3 = addfile("/home/xsun/xsun/Borah/work/run_NARR/wrfout_d04_2014-09-21_00:00:00.nc","r")
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

;----------------------------For calculation of outgoing LW Radiation--------------------------------------------------
  ustar000 = wrf_user_getvar(f0, "EMISS", -1)
  ustar000_point =ustar000(:, locY, locX) 
 ustar100 = wrf_user_getvar(f1, "EMISS", -1)
  ustar100_point =ustar100(:, locY, locX)
  ustar200 = f2[:]->EMISS
  ustar200_point = ustar200(:, locY, locX)
  ustar300 = wrf_user_getvar(f3,"EMISS", -1)
  ustar300_point = ustar300(:, locY, locX);
  ustar400 = f4[:]->EMISS
ustar500 = f5[:]->EMISS
ustar400_point = ustar400(:, locY, locX)
ustar500_point = ustar500(:, locY, locX)


ustar001= wrf_user_getvar(f0, "TSK", -1)
  ustar001_point =ustar001(:, locY, locX) 
 ustar101 = wrf_user_getvar(f1, "TSK", -1)
  ustar101_point =ustar101(:, locY, locX)
  ustar201 = f2[:]->TSK
  ustar201_point = ustar201(:, locY, locX)
  ustar301 = wrf_user_getvar(f3,"TSK", -1)
  ustar301_point = ustar301(:, locY, locX);
  ustar401 = f4[:]->TSK
ustar501 = f5[:]->TSK
ustar401_point = ustar401(:, locY, locX)
ustar501_point = ustar501(:, locY, locX)





;---------------------------------------------------------------------------

 ustar01 = wrf_user_getvar(f0, "ALBEDO", -1)
  ustar01_point =ustar01(:, locY, locX) 
 ustar11 = wrf_user_getvar(f1, "ALBEDO", -1)
  ustar11_point =ustar11(:, locY, locX)
  ustar21 = f2[:]->ALBEDO
  ustar21_point = ustar21(:, locY, locX)
  ustar31 = wrf_user_getvar(f3,"ALBEDO", -1)
  ustar31_point = ustar31(:, locY, locX);
  ustar41 = f4[:]->ALBEDO
ustar51 = f5[:]->ALBEDO
ustar41_point = ustar41(:, locY, locX)
ustar51_point = ustar51(:, locY, locX)

 ustar02 = wrf_user_getvar(f0, "SWDOWN", -1)
  ustar02_point =ustar02(:, locY, locX) 
 ustar12 = wrf_user_getvar(f1, "SWDOWN", -1)
  ustar12_point =ustar12(:, locY, locX)
  ustar22 = f2[:]->SWDOWN
  ustar22_point = ustar22(:, locY, locX)
  ustar32 = wrf_user_getvar(f3,"SWDOWN", -1)
  ustar32_point = ustar32(:, locY, locX);
  ustar42 = f4[:]->SWDOWN
ustar52 = f5[:]->SWDOWN
ustar42_point = ustar42(:, locY, locX)
ustar52_point = ustar52(:, locY, locX)

 ustar03 = wrf_user_getvar(f0, "GLW", -1)
  ustar03_point =ustar03(:, locY, locX) 
 ustar13 = wrf_user_getvar(f1, "GLW", -1)
  ustar13_point =ustar13(:, locY, locX)
  ustar23 = f2[:]->GLW
  ustar23_point = ustar23(:, locY, locX)
  ustar33 = wrf_user_getvar(f3,"GLW", -1)
  ustar33_point = ustar33(:, locY, locX);
  ustar43 = f4[:]->GLW
ustar53 = f5[:]->GLW
ustar43_point = ustar43(:, locY, locX)
ustar53_point = ustar53(:, locY, locX)


ustar04 = wrf_user_getvar(f0, "HFX", -1)
  ustar04_point =ustar04(:, locY, locX) 
 ustar14 = wrf_user_getvar(f1, "HFX", -1)
  ustar14_point =ustar14(:, locY, locX)
  ustar24 = f2[:]->HFX
  ustar24_point = ustar24(:, locY, locX)
  ustar34 = wrf_user_getvar(f3,"HFX", -1)
  ustar34_point = ustar34(:, locY, locX);
  ustar44 = f4[:]->HFX
ustar54 = f5[:]->HFX
ustar44_point = ustar54(:, locY, locX)
ustar54_point = ustar54(:, locY, locX)



;ustar0_point = ustar04_point/(ustar03_point - ustar000_point*(5.67*1e-8)*(ustar001_point^4) +(1- ustar01_point)*ustar02_point)
;ustar1_point = ustar14_point/(ustar13_point - ustar100_point*(5.67*1e-8)*(ustar101_point^4) +(1- ustar11_point)*ustar12_point)
;ustar2_point = ustar24_point/(ustar23_point - ustar200_point*(5.67*1e-8)*(ustar201_point^4) +(1- ustar21_point)*ustar22_point)
;ustar3_point = ustar34_point/(ustar33_point - ustar300_point*(5.67*1e-8)*(ustar301_point^4) +(1- ustar31_point)*ustar32_point)
;ustar4_point = ustar44_point/(ustar43_point - ustar400_point*(5.67*1e-8)*(ustar401_point^4) +(1- ustar41_point)*ustar42_point)
;ustar5_point = ustar54_point/(ustar53_point - ustar500_point*(5.67*1e-8)*(ustar501_point^4) +(1- ustar51_point)*ustar52_point)
;Rn = GLW-OLR+(1-ALBEDO)*SWDOWN  ;netradiation

ustar0_point = ustar03_point - ustar000_point*5.67*0.00000001*(ustar001_point^4) +(1- ustar01_point)*ustar02_point
ustar1_point = ustar13_point - ustar100_point*5.67*0.00000001*(ustar101_point^4) +(1- ustar11_point)*ustar12_point
ustar2_point = ustar23_point - ustar200_point*5.67*0.00000001*(ustar201_point^4) +(1- ustar21_point)*ustar22_point
ustar3_point = ustar33_point - ustar300_point*5.67*0.00000001*(ustar301_point^4) +(1- ustar31_point)*ustar32_point
ustar4_point = ustar43_point - ustar400_point*5.67*0.00000001*(ustar401_point^4) +(1- ustar41_point)*ustar42_point
ustar5_point = ustar53_point - ustar500_point*5.67*0.00000001*(ustar501_point^4) +(1- ustar51_point)*ustar52_point

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
wks = gsn_open_wks("eps", "./Flux/NetRadi2_LST")  
;wks = gsn_open_wks("x11", "Modles Performance")
;--------set resources
  res = True
  ;res@xyExplicitLegendLabels = (/"NAM-ACM2(No-nudge)","NAM-ACM2","NAM-ACM2*","NARR-ACM2","NAM-YSU*","NAM-MYJ*"/)
  ;res@xyLineColors = (/"grey","blue","red","green","chocolate2","lightseagreen"/)
  res@xyExplicitLegendLabels = (/"MYJ*","YSU*","ACM2*","ACM2(NARR)","ACM2","ACM2(No-nudge)"/)
  ;res@xyLineColors = (/"grey","blue","red","green","chocolate2","lightseagreen","black"/)
  res@xyLineColors = (/"lightseagreen","chocolate2","green","red","blue","grey"/)
  res@xyLineThicknessF = 3
  res@tiYAxisString = "Rn"
  res@tiYAxisFont = 21
  res@tiYAxisFontHeightF = 0.01
  ;res@trYMinF = 0
  ;res@trYMaxF = 500
  res@trXMinF = times(47) ;44
  res@trXMaxF = times(184) ;188
  res@gsnMaximize = True
  res@gsnDraw = False
  res@gsnFrame = False
  res@vpWidthF = 0.8
  res@vpHeightF = 0.3
  res@pmLegendDisplayMode = "Always"
  res@lgLabelFontHeightF = 0.008
  res@pmLegendWidthF = 0.04
  res@pmLegendHeightF = 0.09
  res@pmLegendOrthogonalPosF = -1.2
  res@pmLegendParallelPosF = 0.08
  res@lgPerimOn = False
   res@tmXBLabelFontHeightF = 0.0075 ;x axis label size
   res@tmXTOn = False
  res@tmYROn = False
   res@tiXAxisString = "Time (LST)"
    res@tiXAxisFontHeightF = 0.01
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

draw(plot)
frame(wks)
;-----------


wtimes = wrf_user_getvar(f0, "times", -1)

header =[/"time(UTC)"+",ACM2(No-nudge)"+",ACM2"+",ACM2(NARR)"+",ACM2*"+",YSU*"+",MYJ*"/]
csv_filename = "./Flux/NetRadi2.csv"
system("rm -rf" + csv_filename)
write_table(csv_filename, "w", header, "%s")
alist=[/wtimes,ustar0_point,ustar1_point,ustar3_point,ustar2_point,ustar4_point,ustar5_point/]
format = "%s,%g,%g,%g,%g,%g,%g"
write_table(csv_filename, "a", alist, format)



end















