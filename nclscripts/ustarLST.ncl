
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
f4 = addfiles(fils4,"r")
ListSetType(f4,"cat")
f5 = addfiles(fils5,"r")
ListSetType(f5,"cat")
f3 = addfile("/mnt/datadrive/xsun/work/run_NARR/wrfout_d04_2014-09-21_00:00:00.nc","r")
obsname =  "/home/xsun/model/xsun/work/obs20142.csv"
obsvars = asciiread(obsname,-1,"string")
delim = ","
obsvar = tofloat(str_get_field(obsvars(1::), 5, delim))
obsvar@_FillValue = 999

;----------------------------------------------------------------------------
  lat = 45.713560
  lon = -119.406023
  llres = True
  llres@ReturnInt = True ; Return integer values
  locij = wrf_user_ll_to_ij(f1, lon, lat, llres)
  locij = locij -1
  locX = locij(0)
  locY = locij(1)

;------------------------------------------------------------------------------
 ustar0 = wrf_user_getvar(f0, "UST", -1)
  ustar0_point =ustar0(:, locY, locX) 
 ustar1 = wrf_user_getvar(f1, "UST", -1)
  ustar1_point =ustar1(:, locY, locX)
  ustar2 = f2[:]->UST
  ustar2_point = ustar2(:, locY, locX)
  ustar3 = wrf_user_getvar(f3,"UST", -1)
  ustar3_point = ustar3(:, locY, locX);
  ustar4 = f4[:]->UST
ustar5 = f5[:]->UST
ustar4_point = ustar4(:, locY, locX)
ustar5_point = ustar5(:, locY, locX) 
;------------------------------------------------------------------------------
  timess = wrf_times_c(f1->Times,0)
  
  ntimes = dimsizes(timess)-5
  times = timess -8  ;LST time
  
  print(times)
  copy_VarAtts(timess, times)
;----creat array to save paramers----------------------------------------------
   ustar = new ((/7,193/),float)
  ;ustar(0, 0:192) = ustar0_point
  ;ustar(1, 0:192) = ustar1_point
  ;ustar(2, 0:192) = ustar2_point
  ;ustar(3, 0:192) = ustar3_point
  ;ustar(4, 0:192) = ustar4_point
  ;ustar(5, 0:192) = ustar5_point  
;ustar(6, 0:192) = obsvar(:)
ustar(6, 0:192) = ustar0_point
  ustar(5, 0:192) = ustar1_point
  ustar(4, 0:192) = ustar3_point
  ustar(3, 0:192) = ustar2_point
  ustar(2, 0:192) = ustar4_point
  ustar(1, 0:192) = ustar5_point  
ustar(0, 0:192) = obsvar(:)
;-----------------------------------------------------------------
 ; wks = gsn_open_wks("x11", "Modles Performance")
wks = gsn_open_wks("eps", "./Flux/ustarLST")
;--------set resources
  res = True
  ;res@xyExplicitLegendLabels = (/"NAM-ACM2(No-nudge)","NAM-ACM2","NAM-ACM2*","NARR-ACM2","NAM-YSU*","NAM-MYJ*","Observations"/)
  res@xyExplicitLegendLabels = (/"OBS","MYJ*","YSU*","ACM2*","ACM2(NARR)","ACM2","ACM2(No-nudge)"/)
  ;res@xyLineColors = (/"grey","blue","red","green","chocolate2","lightseagreen","black"/)
  res@xyLineColors = (/"black","lightseagreen","chocolate2","green","red","blue","grey"/)
  res@xyLineThicknessF = 3
  res@tiYAxisString = "u*(m.s~S~-1~N~)"
  res@tiYAxisFont = 21
  res@tiYAxisFontHeightF = 0.01
     res@tiXAxisString = "Time (LST)"
    res@tiXAxisFontHeightF = 0.01
  res@trYMinF = -0.1
  res@trYMaxF = 0.8
  res@trXMinF = times(47) ;44 22.12
  res@trXMaxF = times(184) ;188 28.12
 ; res@tmXBMode = "Manual"
 ; res@tmXBTickStartF = res@trXMinF ;Force tickmark start at first Value
  res@gsnMaximize = True
  res@gsnDraw = False
  res@gsnFrame = False
  res@vpWidthF = 0.8
  res@vpHeightF = 0.3
  res@pmLegendDisplayMode = "Always"
  res@lgLabelFontHeightF = 0.008
  res@pmLegendWidthF = 0.04
  res@pmLegendHeightF = 0.09
  res@pmLegendOrthogonalPosF = -1.18  ;vertical postion of legend
res@lgPerimOn = False  
res@pmLegendParallelPosF = 0.08  ;horizontal position of legend
  res@tmXBMode = "Explicit"
 ; res@tmXBTickStartF = res@trXMinF-3 ;tickmark start at first Value 
  res@tmXBMinorPerMajor = 6  
;res@tmXBTickEndF = res@trXMaxF
  res@tmXBLabelFontHeightF = 0.0075 ;x axis label size
  res@tmXTOn = False
  res@tmYROn = False
  ;res@tmXBMajorLengthF = 0.010
  ;res@tmXBMinorLengthF = 0.005
 ;-----------set axis
;resplot = True 
restick = True
   restick@ttmFormat = "%D-%c %H:%M"
  ; restick@ttmMajorStride=12 ;change the lable numbers
  restick@ttmMinorStride=4
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
; restick@ttmMinorStride=1 
;res@tmXBMinorPerMajor = 10
 ; restick@ttmNumTicks = 0
 time_axis_labels(times,res,restick)



;---------------------------
plot = gsn_csm_xy(wks,times,ustar,res)


;-----------
draw(plot)
frame(wks)

end















