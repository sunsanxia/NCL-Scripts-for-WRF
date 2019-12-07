
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
;---------------------------------------------------------------------

f1 = addfile("/home/xsun/model/xsun/soft/WPS/runNAMMODISNEW/geo_em.d01.nc","r")
f2 = addfile("/mnt/datadrive/xsun/work/run_NAMYSUMODIS/wrfout_d02_2014-09-21_00:00:00.nc","r")
f3 = addfile("/mnt/datadrive/xsun/work/run_NAMYSUMODIS/wrfout_d03_2014-09-21_00:00:00.nc","r")
f4 = addfile("/mnt/datadrive/xsun/work/run_NAMYSUMODIS/wrfout_d04_2014-09-21_00:00:00.nc","r")

;----------------------------------------------------------------------------
  

;------------------------------------------------------------------------------
;landuse = f1->LU_INDEX(0,:,:)
 ;landuse=wrf_user_getvar(f1, "HGT_M", 0)
  landuse=wrf_user_getvar(f1, "SOILTEMP", 0)
 wks = gsn_open_wks("eps", "domaint")
 ;colors = (/"white","snow"/)
 ;gsn_define_colormap(wks, colors)
;  wks = gsn_open_wks("x11", "Modles Performance")
var2 = wrf_user_getvar(f2,"HGT",0)
  lat2 = wrf_user_getvar(f2,"XLAT",0)
  lon2 = wrf_user_getvar(f2,"XLONG",0)
  var3 = wrf_user_getvar(f3,"HGT",0)
lat3 = wrf_user_getvar(f3,"XLAT",0)
  lon3 = wrf_user_getvar(f3,"XLONG",0)
  var4 = wrf_user_getvar(f4,"HGT",0)
  lat4 = wrf_user_getvar(f4,"XLAT",0)
  lon4 = wrf_user_getvar(f4,"XLONG",0)
dom_dims = dimsizes(landuse)
  dom_rank = dimsizes(dom_dims)
  nx1 = dom_dims(dom_rank - 1) - 1
  ny1 = dom_dims(dom_rank - 2) - 1
  dom_dims = dimsizes(var2)
  dom_rank = dimsizes(dom_dims)
  nx2 = dom_dims(dom_rank - 1) - 1
  ny2 = dom_dims(dom_rank - 2) - 1
  dom_dims = dimsizes(var3)
  dom_rank = dimsizes(dom_dims)
  nx3 = dom_dims(dom_rank - 1) - 1
  ny3 = dom_dims(dom_rank - 2) - 1
  dom_dims = dimsizes(var4)
  dom_rank = dimsizes(dom_dims)
  nx4 = dom_dims(dom_rank - 1) - 1
  ny4 = dom_dims(dom_rank - 2) - 1

   xbox_out = new(5,float)
 ybox_out = new(5,float)
 lnres=True
 lnres@gsLineThicknessF = 3.5

;--------set resources
  res = True
  ;res@Footer=False
 ; res@tiMainString = "NAM-ACM2(MODIS)"
  ; res@tiMainString = "NAM-ACM2"
  ;  res@tiMainString = "NARR-ACM2"
  ;res@tiMainString = "NAM-ACM2(Non-nudge)"
  res@gsnDraw              = False
  res@gsnFrame             = False
  
  res@gsnMaximize = True
    res@cnFillOn    = True
  res@tfDoNDCOverlay = True
  res@tmXBLabelFontHeightF = 0.0155
  res@tmYLLabelFontHeightF=0.0155
 res@gsnSpreadColors = False
  res@cnFillOn = True
  res@cnLineLabelsOn = False 
 res@cnLinesOn = False
  res@cnInfoLabelOn = False
res@gsnLeftString = " "
res@gsnRightString = " "
res@lbLabelBarOn = False    ; not display label
 res@pmLabelBarHeightF = 0.1
 res@lbLabelFontHeightF = 0.01
  res = wrf_map_resources(f1, res)
 res@mpProvincialLineColor = "Black"
  res@mpGeophysicalLineColor = "Black"
  res@mpNationalLineColor    = "Black"
  res@mpUSStateLineColor     = "Black"
  res@mpGridLineColor        = "Black"
  res@mpLimbLineColor        = "Black"
  res@mpPerimLineColor       = "Black"
   res@mpCountyLineColor = 0
   res@mpInlandWaterFillColor = 0
  res@mpUSStateLineThicknessF = 1.2
 ; res@mpMinLatF = 45.0 
  opts=res
  opts@cnFillOn = True
  ;opts@cnFillPalette=(/"snow","siennal"/)
  ;opts@cnFillMode = "RasterFill"
  opts@cnLevelSelectionMode = "ManualLevels"
 opts@cnMinLevelValF = 1
; cnLevelSpacingF
opts@cnLevelSpacingF =1
opts@cnMaxLevelValF = 20  
opts@cnMonoFillColor = True

opts@cnFillColor = 0  ;set color to background
opts@cnCellFillEdgeColor = "Black"
 ; opts@ContourParameters = (/1,20,1/)
;contour=wrf_contour(f1, wks, landuse,opts)
 plot=gsn_csm_contour_map(wks, landuse, opts)
 pmres = True
  pmres@gsMarkerColor = "Black"
  pmres@gsMarkerIndex = 4
  pmres@gsMarkerSizeF = 0.015
  pmres@gsMarkerThicknessF = 2.0
  text1 = "d02"
  text2 = "d03"
  text3="d04"
   txres = True
   txres@txFontHeightF =0.02
  d2=gsn_add_text(wks, plot, text1,-123,49,txres)
  d3=gsn_add_text(wks, plot, text2,-120.5,47.2,txres)
  d4=gsn_add_text(wks, plot, text3,-119.1,46.5,txres)
 ;plot = wrf_map_overlays(f1, wks, (/contour/),pltres,mpres) 
 ;marker=gsn_add_polymarker(wks,plot,-119.406023,45.713560,pmres)
 draw(plot)

 xbox = (/lon2(0,0),lon2(0,nx2),lon2(ny2,nx2),lon2(ny2,0),lon2(0,0)/)
  ybox = (/lat2(0,0),lat2(0,nx2),lat2(ny2,nx2),lat2(ny2,0),lat2(0,0)/)
  datatondc(plot, xbox, ybox, xbox_out, ybox_out)
  gsn_polyline_ndc(wks, xbox_out, ybox_out, lnres)

  xbox = (/lon3(0,0),lon3(0,nx3),lon3(ny3,nx3),lon3(ny3,0),lon3(0,0)/)
  ybox = (/lat3(0,0),lat3(0,nx3),lat3(ny3,nx3),lat3(ny3,0),lat3(0,0)/)
  datatondc(plot, xbox, ybox, xbox_out, ybox_out)
  gsn_polyline_ndc(wks, xbox_out, ybox_out, lnres)
  xbox = (/lon4(0,0),lon4(0,nx4),lon4(ny4,nx4),lon4(ny4,0),lon4(0,0)/)
  ybox = (/lat4(0,0),lat4(0,nx4),lat4(ny4,nx4),lat4(ny4,0),lat4(0,0)/)
  datatondc(plot, xbox, ybox, xbox_out, ybox_out)
  gsn_polyline_ndc(wks, xbox_out, ybox_out, lnres)
   
; draw(marker)
 frame(wks)           ; lets frame the plot - do not delete
  
 
end















