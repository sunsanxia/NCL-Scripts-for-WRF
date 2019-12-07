load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl" 
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin

a = addfile("./wrfout_d04_2014-09-21_00:00:00.nc","r")
;find the ij location for the point
;times = wrf_user_list_times(a)
;ntimes = dimsizes(times)
  lat = 45.713560
  lon = -119.406023
  llres = True
  llres@ReturnInt = True ; Return integer values
  locij = wrf_user_ll_to_ij(a, lon, lat, llres)
  locij = locij -1
  locX = locij(0)
  locY = locij(1)

  ustar = wrf_user_getvar(a, "UST", -1)
  ustar_point = ustar(:, locY, locX) 
  times = wrf_times_c(a->Times,0)
  ntimes = dimsizes(times)-13
 
  print(times)
 
  wks = gsn_open_wks("x11", "fricvelo")

  res = True
  res@gsnMaximize = True
  res@vpWidthF = 1.8
  res@vpHeightF = 0.5
 res@tmYROn = False ;turn off right tickmarks.
 res@tmXTOn = False ; turn off top tickmarks
 
 ; res@tmYLFormat = "f" 
  res@trXMinF = times(36)
  res@trXMaxF = times(ntimes)
 ; res@tmXBTickSpacingF = 150

;res@tmXBOn = True
;res@tmXBLablesOn = True
res@tmXBLabelFontHeightF = 0.015 ; x axis label size
;res@tmYLLableFontHeightF = 0.01
; res@tmXBLableFontHeightF = 0.01
  res@trXMaxF= times(ntimes)
  restick = True
  restick@ttmFormat = "%D-%c %H:%M"
 ; restick@ttmNumTicks = 11
  restick@ttmMajorStride=12 ;change the lable numbers
  restick@ttmMinorStride=3
  time_axis_labels(times,res,restick)
 ;  res@tiMainFontHeightF = 0.025
 
 res@tiXAxisFontHeightF = 0.025 ; x lable size 
 ustar_res = True
 ustar_plot = gsn_csm_xy(wks,times, ustar_point, res)
  
end

