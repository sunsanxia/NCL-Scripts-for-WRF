
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
;---------------------------------------------------------------------

;f1 = addfile("/home/xsun/model/xsun/soft/WRFV3/run_NAMYSUNEW/wrfinput_d04.nc","r")  ;modify the cnmaxlevel too, MODIS is 20 and USGS is 24
f0= addfile("/home/xsun/model/xsun/work/run_NAMMODIS/wrfout_d02_2014-09-22_00:00:00","r")
f1= addfile("/home/xsun/model/xsun/work/run_NAMACMMODIS/wrfout_d02_2014-09-22_00:00:00","r")
f2= addfile("/home/xsun/model/xsun/work/run_NAMYSUMODIS/wrfout_d02_2014-09-22_00:00:00","r")
f3= addfile("/home/xsun/model/xsun/work/run_NAMMYJMODIS/wrfout_d02_2014-09-22_00:00:00","r")
;------overlay to countours on map ----------------------------------------------------------------------
  

;------------------------------------------------------------------------------
;landuse = f1->LU_INDEX(0,:,:)
t20=f0->SWDOWN(20,:,:)
t21 = f1->SWDOWN(20,:,:)
t22 =f2->SWDOWN(20,:,:)
t23 = f3->SWDOWN(20,:,:)

 wks = gsn_open_wks("eps", "ShorRadi_diff_4_22")
  gsn_define_colormap(wks, "BlRe")
  diff0=t21-t20
  diff2= t21-t22
  diff3 = t21-t23 
  diff4 = t22-t23
  copy_VarAtts(t20, diff0)
   copy_VarAtts(t22, diff2)
   copy_VarAtts(t23, diff3)
   copy_VarAtts(t23, diff4)
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
   res@NoHeaderFooter           = True  
   res@NoTitles = True
 ; res@Footer = False
  res@InitTime = False
  res@gsnMaximize = True
    res@cnFillOn    = True
  res@tfDoNDCOverlay = True
 res@gsnSpreadColors = True

  res@cnFillOn = True
  res@cnLineLabelsOn = False 
 res@cnLinesOn = False
  res@cnInfoLabelOn = False
   res@lbLabelBarOn        = False 
res@gsnLeftString = " "
res@gsnRightString = " "
 res@pmLabelBarHeightF = 0.3
  res@pmLabelBarWidthF = 0.8
 res@lbLabelFontHeightF = 0.0155
 res@pmLabelBarOrthogonalPosF = -0.15 ;label bar vertical position
 res@pmLabelBarParallelPosF = 0.5  ;label bar horizontal position
  ;res = wrf_map_resources(f1, res)
  ;res@mpMinLonF = -119.5
  ;res@mpMaxLonF = -119.3
  ;res@mpMinLatF = 45.0
  ;res@mpMaxLatF = 45.4
  ;res@mpGeophysicalLineColor = "Black"
  ;res@mpNationalLineColor    = "Black"
  ;res@mpUSStateLineColor     = "Black"
  ;res@mpGridLineColor        = "Black"
  ;res@mpLimbLineColor        = "Black"
  ;res@mpPerimLineColor       = "Black"
;res@mpUSStateLineThicknessF = 2.0
 ; res@mpMinLatF = 45.0 
 ;res@cnFillDrawOrder = "PreDraw"
  opts=res

 ; opts@lbOrientation = "Vertical"
  opts@cnFillOn = True
  ;opts@cnFillMode = "RasterFill"   ;for 2D information,pixles
 ; opts@cnLevelSelectionMode = "ManualLevels"   ;this five lines controls the color bar display
 ;opts@cnMinLevelValF = 0
; cnLevelSpacingF
;opts@cnLevelSpacingF = 1
;opts@cnMaxLevelValF = 10   
;opts@lbLabelStride =1 
 opts@tmXBLabelFontHeightF = 0.055
  opts@tmYLLabelFontHeightF=0.055
  opts1 = opts
  opts1@gsnLeftString   = "(NAM-ACM2*)-(NAM-YSU*)" 
   opts1@gsnLeftStringFontHeightF=0.018
   opts2 = opts
    opts2@gsnLeftString   = "(NAM-ACM2*)-(NAM-MYJ*)" 
   opts2@gsnLeftStringFontHeightF=0.018
;opts@lbLabelConstantSpacingF =1
;opts@cnLineDashPattern = 1
 ; opts@ContourParameters = (/1,20,1/)
;contour=wrf_contour(f1, wks, landuse,opts)
plot0=wrf_contour(f0, wks, diff0, opts1)
 plota=wrf_contour(f1, wks, diff2, opts1)
 plotb=wrf_contour(f2,wks,diff3,opts1)
plotc= wrf_contour(f3, wks, diff4, opts1)


;overlay(plot,plotb)
; plota=gsn_csm_contour_map_overlay(wks, landuse(0,:,:), hgt(0,:,:), opts, res2)
  pltres= True
   pltres@PanelPlot= True
   pltres@NoHeaderFooter = True
   pltres@NoTitles = True
  ;pltres@gsnDraw              = False
  ; pltres@gsnFrame             = False   ; save for dispal  wks
  pltres@tmXBLabelFontHeightF = 0.55
  pltres@tmYLLabelFontHeightF=0.55
  pltres1=pltres
  ;pltres1@NoTitles = True
   pltres1@tiMain  = "(NAM-ACM2*)-(NAM-YSU*)" 
   pltres1@gsnLeftStringFontHeightF=0.018
   pltres2 = pltres
    pltres2@gsnLeftString   = "(NAM-ACM2*)-(NAM-MYJ*)" 
   pltres2@gsnLeftStringFontHeightF=0.018
  ;pltres@NoTitles = True  ;move any titles in the map
  mpres = True
  ;mpres@mpMinLonF = -119.5
  ;mpres@mpMaxLonF = -119.3
  ;mpres@mpMinLatF = 45.0
 ; mpres@mpMaxLatF = 45.4
  mpres@mpGeophysicalLineColor = "Black"
  mpres@mpNationalLineColor    = "Black"
  mpres@mpUSStateLineColor     = "Black"
  mpres@mpGridLineColor        = "Black"
  mpres@mpLimbLineColor        = "Black"
  mpres@mpPerimLineColor       = "Black"
  mpres@tmXBLabelFontHeightF = 0.0155
  mpres@tmYLLabelFontHeightF=0.0155
  mpres@mpUSStateLineThicknessF = 2.0
  mpres@mpGridAndLimbOn = False
  ;res@mpMinLatF = 45.0 
  plots=new(4,graphic)
 plots(0)=wrf_map_overlays(f0,wks,(/plot0/), pltres,mpres)
 plots(1) = wrf_map_overlays(f1,wks,(/plota/), pltres1,mpres)
 plots(2) = wrf_map_overlays(f2,wks,(/plotb/), pltres2,mpres)
  plots(3)=wrf_map_overlays(f3,wks,(/plotc/), pltres2,mpres)
resP=True
resP@gsnMaximize=True
resP@gsnPanelLabelBar    = True                ; add common colorbar
  resP@lbLabelFontHeightF  = 0.007               ; make labels smaller
   ;resP@cnMinLevelValF = -100
   ;resP@lbLabelStrings = (/"-300","-200","-100","-50","-25","0","25","50","100","200","300"/)
; cnLevelSpacingF
;resP@cnLevelSpacingF = 20
;resP@cnMaxLevelValF = 100   
;opts@lbLabelStride =1 
  
 resP@gsnPanelFigureStrings = (/"ACM2*-ACM2","ACM2*-YSU*","ACM2*-MYJ*","YSU*-MYJ*"/)
 resP@gsnPanelFigureStringsFontHeightF  = 0.006
 ;resP@gsnPanelFigureStringsJust = "TopLeft"
 ;resP@amJust="TopLeft"
 resP@gsnPanelFigureStringsPerimOn = False
; resP@amParallelPosF = 0.1
; resP@amOrthogonalPosF = 0.1
 resP@gsnPanelFigureStringsBackgroundFillColor = -1
 resP@cnLineDrawOrder = "PostDraw"
gsn_panel(wks,(/plots/),(/2,2/),resP) 

end















