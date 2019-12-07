
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
;---------------------------------------------------------------------

f1 = addfile("/home/xsun/model/xsun/soft/WPS/runNAMMODISNEW/geo_em.d04.nc","r")

;----------------------------------------------------------------------------
  

;------------------------------------------------------------------------------
;landuse = f1->LU_INDEX(0,:,:)
 landuse=wrf_user_getvar(f1, "LU_INDEX", 0)
 wks = gsn_open_wks("ps", "d4landuse")
  gsn_define_colormap(wks, "MPL_BrBG")
;  wks = gsn_open_wks("x11", "Modles Performance")

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
 res@gsnSpreadColors = True
  res@cnFillOn = True
  res@cnLineLabelsOn = False 
 res@cnLinesOn = False
  res@cnInfoLabelOn = False
res@gsnLeftString = " "
res@gsnRightString = " "
 res@pmLabelBarHeightF = 0.1
 res@lbLabelFontHeightF = 0.01
  res = wrf_map_resources(f1, res)
  res@mpGeophysicalLineColor = "Black"
  res@mpNationalLineColor    = "Black"
  res@mpUSStateLineColor     = "Black"
  res@mpGridLineColor        = "Black"
  res@mpLimbLineColor        = "Black"
  res@mpPerimLineColor       = "Black"
  res@mpUSStateLineThicknessF = 2.0
 ; res@mpMinLatF = 45.0 
  opts=res
  opts@cnFillOn = True
  opts@cnFillMode = "RasterFill"
  opts@cnLevelSelectionMode = "ManualLevels"
 opts@cnMinLevelValF = 1
; cnLevelSpacingF
opts@cnLevelSpacingF =1
opts@cnMaxLevelValF = 20  
 ; opts@ContourParameters = (/1,20,1/)
;contour=wrf_contour(f1, wks, landuse,opts)
 plot=gsn_csm_contour_map(wks, landuse, opts)
 pmres = True
  pmres@gsMarkerColor = "Black"
  pmres@gsMarkerIndex = 4
  pmres@gsMarkerSizeF = 0.015
  pmres@gsMarkerThicknessF = 2.0
 ;plot = wrf_map_overlays(f1, wks, (/contour/),pltres,mpres) 
 marker=gsn_add_polymarker(wks,plot,-119.406023,45.713560,pmres)
 draw(plot)
; draw(marker)
 frame(wks)           ; lets frame the plot - do not delete
  
 
end















