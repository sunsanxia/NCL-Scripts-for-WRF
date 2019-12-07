
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
  ustar0 = wrf_user_getvar(f0, "GRDFLX", -1)
  ustar0_point =ustar0(:, locY, locX) 
 ustar1 = wrf_user_getvar(f1, "GRDFLX", -1)
  ustar1_point =ustar1(:, locY, locX)
  ustar2 = f2[:]->GRDFLX
  ustar2_point = ustar2(:, locY, locX)
  ustar3 = wrf_user_getvar(f3,"GRDFLX", -1)
  ustar3_point = ustar3(:, locY, locX);
  ustar4 = f4[:]->GRDFLX
ustar5 = f5[:]->GRDFLX
ustar4_point = ustar4(:, locY, locX)
ustar5_point = ustar5(:, locY, locX)
ustar6 = wrf_user_getvar(f6,"GRDFLX", -1)
ustar7 = wrf_user_getvar(f7,"GRDFLX", -1)
ustar6_point = ustar6(:, locY, locX)
ustar7_point = ustar7(:, locY, locX)
;------------------------------------------------------------------------------
 timess = wrf_times_c(f1->Times,0)

  ntimes = dimsizes(timess)-5
  times = timess -8  ;LST time

 ; print(times)
  copy_VarAtts(timess, times)
;----creat array to save paramers----------------------------------------------
ustar = new ((/8,193/),float)
  ; ustar(5, 0:192) = ustar0_point
  ustar(7, 0:192) = ustar0_point
  ustar(6, 0:192) = ustar1_point
  ustar(5, 0:192) = ustar3_point
  ustar(4, 0:192) = ustar2_point
  ustar(3, 0:192) = -ustar6_point
  ustar(2, 0:192) = -ustar7_point
  ustar(1, 0:192) = -ustar4_point
  ustar(0, 0:192) = -ustar5_point 
;ustar(6, 0:192) = obsvar(:)
 

;-----------------------------------------------------------------
wks = gsn_open_wks("eps", "./Flux/GFLST_ALLNARR2")  
;wks = gsn_open_wks("x11", "Modles Performance")
;--------set resources
  res = True
  ;res@xyExplicitLegendLabels = (/"NAM-ACM2(No-nudge)","NAM-ACM2","NAM-ACM2*","NARR-ACM2","NAM-YSU*","NAM-MYJ*"/)
  ;res@xyLineColors = (/"grey","blue","red","green","chocolate2","lightseagreen"/)
   res@xyExplicitLegendLabels = (/"MYJ*(NARR)","YSU*(NARR)","MYJ*","YSU*","ACM2*","ACM2~S~#~N~(NARR)","ACM2~S~#~N~","ACM2~S~#~N~(No-nudge)"/)
  ;res@xyLineColors = (/"grey","blue","red","green","chocolate2","lightseagreen","black"/)
  res@xyLineColors = (/"dark sea green","chocolate4","lightseagreen","chocolate2","green","red","blue","grey"/)
  res@xyLineThicknessF = 3
  res@tiYAxisString = "Ground Heat Flux (W~S~2~N~m~S~-2~N~)"
  res@tiYAxisFont = 21
  res@tiYAxisFontHeightF = 0.01
  res@trYMinF = -80
  res@trYMaxF = 120
  res@trXMinF = times(47) ;44
  res@trXMaxF = times(184) ;188
  res@gsnMaximize = True
  res@gsnDraw = False
  res@gsnFrame = False
  res@vpWidthF = 0.8
  res@vpHeightF = 0.3
  res@pmLegendDisplayMode = "Always"
  res@lgLabelFontHeightF = 0.006
  res@pmLegendWidthF = 0.04
  res@pmLegendHeightF = 0.09
  res@pmLegendOrthogonalPosF = -1.18
  res@pmLegendParallelPosF = 0.07
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


;-----------
draw(plot)
frame(wks)

wtimes = wrf_user_getvar(f0, "times", -1)

header =[/"time(UTC)"+",ACM2(No-nudge)"+",ACM2"+",ACM2(NARR)"+",ACM2*"+",YSU*"+",MYJ*"+",YSU*(NARR)"+",MYJ*(NARR)"/]
csv_filename = "./Flux/GH_ALLNARR.csv"
system("rm -rf" + csv_filename)
write_table(csv_filename, "w", header, "%s")
alist=[/wtimes,ustar0_point,ustar1_point,ustar3_point,ustar2_point,ustar6_point,ustar7_point,ustar4_point,ustar5_point/]
format = "%s,%g,%g,%g,%g,%g,%g,%g,%g"
write_table(csv_filename, "a", alist, format)

end















