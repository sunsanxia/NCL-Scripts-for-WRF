
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
;---------------------------------------------------------------------
fils2 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMMODIS/wrfout_d04*")
f0 = addfile("/home/xsun/model/xsun/soft/WRFV3/run/wrfout_d04_2014-09-21_00:00:000.nc","r")
f1 = addfile("/mnt/datadrive/xsun/work/run_NAMNG/nuisttar/wrfout_d04_2014-09-21_00:00:00.nc","r")
f2 = addfiles(fils2,"r")
ListSetType(f2,"cat")
f3 = addfile("/mnt/datadrive/xsun/work/run_NARR/wrfout_d04_2014-09-21_00:00:00.nc","r")
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
  



ustar1 = wrf_user_getvar(f1, "UST", -1)
  ustar1_point =ustar1(:, locY, locX)
  ustar2 = f2[:]->UST
  ustar2_point = ustar2(:, locY, locX)
  ustar3 = wrf_user_getvar(f3,"UST", -1)
  ustar3_point = ustar3(:, locY, locX);
;------------------------------------------------------------------------------
  times = wrf_times_c(f1->Times,0)
  ntimes = dimsizes(times)-5
;----creat array to save paramers----------------------------------------------
  ustar = new ((/3,193/),float)
  ustar(0, 0:192) = ustar1_point
  ustar(1, 0:192) = ustar2_point
  ustar(2, 0:192) = ustar3_point
 

;-----------------------------------------------------------------
  wks = gsn_open_wks("x11", "Modles Performance")
;--------set resources
  res = True
  res@xyExplicitLegendLabels = (/"NAM-ACM2","NAM-ACM2(MODIS)","NARR-ACM2"/)
  res@xyLineColors = (/"blue","red","green"/)
  res@xyLineThicknessF = 3
  res@tiYAxisString = "u~B~*~N~ (m.s~S~-1~N~)"
  res@tiYAxisFont = 21
  res@tiYAxisFontHeightF = 0.012
  res@trYMinF = 0.0
  res@trYMaxF = 0.7
  res@trXMinF = times(0) ;43
  res@trXMaxF = times(192) ;187
  res@gsnMaximize = True
  res@gsnDraw = False
  res@gsnFrame = False
  res@vpWidthF = 0.8
  res@vpHeightF = 0.3
  res@pmLegendDisplayMode = "Always"
  res@lgLabelFontHeightF = 0.01
  res@pmLegendWidthF = 0.04
  res@pmLegendHeightF = 0.09
  res@lgPerimOn = False
  res@pmLegendOrthogonalPosF = -1.25
  res@pmLegendParallelPosF = 0.10
  res@tmXBLabelFontHeightF = 0.0075 ;x axis label size
  ;res@tmXBMode = "Manual"
  ;res@tmXBTickStartF = res@trXMinF ; 
;-----------set axis
 restick = True
   restick@ttmFormat = "%D-%c %H:%M"
 restick@ttmMajorStride=12 ;change the lable numbers
  restick@ttmMinorStride=3
  time_axis_labels(times,res,restick)
;---------------------------
plot = gsn_csm_xy(wks,times,ustar,res)


;-----------
draw(plot)
frame(wks)

end















