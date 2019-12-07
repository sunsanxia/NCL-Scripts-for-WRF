
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
;---------------------------------------------------------------------
fils2 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMMODIS/wrfout_d04*")
fils5 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMYSU/wrfout_d04*")
fils6 = systemfunc("ls /mnt/datadrive/xsun/work/run_NAMMYJ/wrfout_d04*")
f1 = addfile("/mnt/datadrive/xsun/work/run_NAMNG/nuisttar/wrfout_d04_2014-09-21_00:00:00.nc","r")
f2 = addfiles(fils2,"r")
ListSetType(f2,"cat")
f3 = addfile("/mnt/datadrive/xsun/work/run_NARR/wrfout_d04_2014-09-21_00:00:00.nc","r")
f4= addfile("/home/xsun/model/xsun/soft/WRFV3/run/wrfout_d04_2014-09-21_00:00:000.nc","r")
f5= addfiles(fils5,"r")
ListSetType(f5,"cat")
f6 = addfiles(fils6,"r")
ListSetType(f6,"cat")
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
 th = wrf_user_getvar(f6, "th", -1)
 height = wrf_user_getvar(f6, "z", -1)
 HGT = f3->HGT(44,locY,locX)  ; HGT at 54 times
 ZNWW = f1->ZNW(0,:) ;eta whole levels

;print(ZNW)  
th_point = th(:, :,locY, locX)
  ;ZNWW=ZNW(1,:)
;  heightt = height(:,:,locY, locX)
;print(heightt) 
 ;heightt = heightt*0.001
;print(heightt)
;print(HGT) 
;print(ZNWW)
; z = f1->z(0,:)
 ; lat = f1->XLAT(0,locY, locX)
 ; lon = f1->XLONG(0,locY, locX) 
;------------------------------------------------------------------------------
  timess = wrf_times_c(f1->Times,0)

  ntimes = dimsizes(timess)-5
  times = timess -8 ; LST time

;  print(times)
  copy_VarAtts(timess, times)
 heightt = height(44,:,locY, locX)
print(heightt)
 heightt = heightt*0.001  ; m to km, unit
;ZNW = ZNW(1,:)

 ;-------------------------name dimensions-----------------------------------  
  
  th_point!0 = "times"
  th_point&times = times
  th_point!1 = "ZNWW"
 th_point&ZNWW = ZNWW
; printVarSummary(heightt)
 ;printVarSummary(times)
;printVarSummary(th_point)
;----creat array to save paramers----------------------------------------------
 ; ustar = new ((/3,193/),float)
  ;ustar(0, 0:192) = ustar1_point
  ;ustar(1, 0:192) = ustar2_point
  ;ustar(2, 0:192) = ustar3_point
 

;-----------------------------------------------------------------
;   wks = gsn_open_wks("ps", "ConNAMMODISTH")
 ; wks = gsn_open_wks("ps", "ConNAMTH")
  ; wks = gsn_open_wks("ps", "ConNARRTH")
 ;wks = gsn_open_wks("ps", "ConNAMnonudgeTH")
 wks = gsn_open_wks("ps", "ConNAMMYJTHEta")
   gsn_define_colormap(wks, "rainbow")
;  wks = gsn_open_wks("x11", "Modles Performance")

;--------set resources
  res = True
 ; res@tiMainString = "NAM-ACM2(MODIS)"
  ; res@tiMainString = "NAM-ACM2"
  ;  res@tiMainString = "NARR-ACM2"
  ;res@tiMainString = "NAM-ACM2(Non-nudge)"
  res@tiMainString = "NAM-MYJ*"
 res@tiMainFontHeightF = 0.01 
 res@gsnSpreadColors = True
  res@cnFillOn = True
  res@cnLineLabelsOn = False 
 res@cnLinesOn = False
  res@cnInfoLabelOn = False
res@gsnLeftString = " "
res@gsnRightString = " "
 ; res@cnLevelSelectionMode = "ExplicitLevels"
 ; res@lbLabelAutoStride = True
  res@lbLabelStride = 10 ;skip every 9 other label
 ;res@cnLevels = (/"282","286","290","294","298","302","306"/)
 ; res@cnFillColors
 res@cnLevelSelectionMode = "ManualLevels"
 res@cnMinLevelValF = 286
; cnLevelSpacingF
res@cnMaxLevelValF = 306  ;label bar range
 res@cnLevelSpacingF = 0.2  ;label color spacing
 res@pmLabelBarWidthF = 0.4 
 res@cnLineLabelPerimOn = False
 res@lbBoxLinesOn = False ; turn off labelbar box lines 
 res@pmLabelBarHeightF = 0.1
 res@pmLabelBarOrthogonalPosF = 0.0 ;label bar vertical position
 res@pmLabelBarParallelPosF = 0.5  ;label bar horizontal position
 res@lbLabelFontHeightF = 0.0075
  
  res@lbTitleOn = True
  res@lbTitleString = "Potential Temperature (K)"
  res@lbTitlePosition = "Right" ;title position to the color bar
  res@lbTitleFontHeightF = 0.01 ;make title smaller 
  res@lbTitleDirection = "Across" ;title direction
  res@gsnMaximize = True
  res@vpWidthF = 0.8
  res@vpHeightF = 0.3
  res@tiYAxisString = "Height (km)"
 res@tiYAxisFontHeightF = 0.012
  ;res@trYMinF = 0.4
  ;res@trYMaxF = 4.0
  res@trXMinF = times(47)
  res@trXMaxF = times(184)
  res@tmXBLabelFontHeightF = 0.0075
  res@gsnYAxisIrregular2Linear = True
 ; res@UnitLabel = ""
 ; res@FieldTitle = ""
  ;tgain@description = ""
  ;tgain@units = ""
 ;-----------set axis
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

  time_axis_labels(times,res,restick)
;---------------------------
plot = gsn_csm_contour(wks,th_point(ZNWW|:,times|:),res)
;plot = gsn_csm_contour(wks,th_point(heightt(0:192,0:43),times(0:192)),res)
end















