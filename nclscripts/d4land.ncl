
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
  res@Footer=False
 ; res@tiMainString = "NAM-ACM2(MODIS)"
  ; res@tiMainString = "NAM-ACM2"
  ;  res@tiMainString = "NARR-ACM2"
  ;res@tiMainString = "NAM-ACM2(Non-nudge)"
  res@gsnDraw              = False
  res@gsnFrame             = False
  res@InitTime= False
 res@gsnSpreadColors = True
  res@cnFillOn = True
  res@cnLineLabelsOn = False 
 res@cnLinesOn = False
  res@cnInfoLabelOn = False
res@gsnLeftString = " "
res@gsnRightString = " "
  pltres=True
  mpres=True
  mpres@mpGeophysicalLineColor = "Black"
  mpres@mpNationalLineColor    = "Black"
  mpres@mpUSStateLineColor     = "Black"
  mpres@mpGridLineColor        = "Black"
  mpres@mpLimbLineColor        = "Black"
  mpres@mpPerimLineColor       = "Black"
  mpres@mpUSStateLineThicknessF = 2.0
  opts=res
  opts@cnFillOn = True
  opts@cnFillMode = "RasterFill"
  opts@ContourParameters = (/1,20,1/)
contour=wrf_contour(f1, wks, landuse,opts)
 pmres = True
  pmres@gsMarkerColor = "Black"
  pmres@gsMarkerIndex = 16
  pmres@gsMarkerSizeF = 0.01
 plot = wrf_map_overlays(f1, wks, (/contour/),pltres,mpres) 
 marker=gsn_add_polymarker(wks,plot,-119.406023,45.713560,pmres)
 draw(plot)
; draw(marker)
 frame(wks)           ; lets frame the plot - do not delete
  
 
end















