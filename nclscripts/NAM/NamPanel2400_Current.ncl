
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
;---------------------------------------------------------------------
;fili = "/home/xsun/model/xsun/data/NAM_12/namanl_218_20140924_1200_006.grb"
;f1 = addfile("/home/xsun/model/xsun/data/NAM_12/namanl_218_20140924_1200_000.grb","r")
;;f2 = addfile("/home/xsun/model/xsun/data/NAM_12/namanl_218_20140925_0000_000.grb","r")
;f3 = addfile("/home/xsun/model/xsun/data/NAM_12/namanl_218_20140925_1200_000.grb","r")
;f4 = addfile("/home/xsun/model/xsun/data/NAM_12/namanl_218_20140926_0000_000.grb","r")
;f5 = addfile("/home/xsun/model/xsun/data/NAM_12/namanl_218_20140926_1200_000.grb","r")
;f6 = addfile("/home/xsun/model/xsun/data/NAM_12/namanl_218_20140927_0000_000.grb","r")
;f7 = addfile("/home/xsun/model/xsun/data/NAM_12/namanl_218_20140927_1200_000.grb","r")
;f8 = addfile("/home/xsun/model/xsun/data/NAM_12/namanl_218_20140928_0000_000.grb","r")
f1 = addfile("/home/xsun/model/xsun/data/NAM_12/namanl_218_20140924_0000_000.grb","r")
f2 = addfile("/home/xsun/model/xsun/data/NAM_12/namanl_218_20140924_1200_000.grb","r")
f3 = addfile("/home/xsun/model/xsun/data/NAM_12/namanl_218_20140925_0000_000.grb","r")
f4 = addfile("/home/xsun/model/xsun/data/NAM_12/namanl_218_20140925_1200_000.grb","r")
f5 = addfile("/home/xsun/model/xsun/data/NAM_12/namanl_218_20140926_0000_000.grb","r")
f6 = addfile("/home/xsun/model/xsun/data/NAM_12/namanl_218_20140926_1200_000.grb","r")
f7 = addfile("/home/xsun/model/xsun/data/NAM_12/namanl_218_20140927_0000_000.grb","r")
f8 = addfile("/home/xsun/model/xsun/data/NAM_12/namanl_218_20140927_1200_000.grb","r")
;**************************************************************
;open file and read in data
;*************************************************************
uwind = f1->R_H_218_ISBL
hgt=f1->HGT_218_ISBL
u = f1->U_GRD_218_ISBL
v = f1->V_GRD_218_ISBL
uwind2 = f2->R_H_218_ISBL
hgt2=f2->HGT_218_ISBL
u2 = f2->U_GRD_218_ISBL
v2 = f2->V_GRD_218_ISBL
uwind3 = f3->R_H_218_ISBL
hgt3=f3->HGT_218_ISBL
u3 = f3->U_GRD_218_ISBL
v3 = f3->V_GRD_218_ISBL
uwind4 = f4->R_H_218_ISBL
hgt4=f4->HGT_218_ISBL
u4 = f4->U_GRD_218_ISBL
v4 = f4->V_GRD_218_ISBL
uwind5 = f5->R_H_218_ISBL
hgt5=f5->HGT_218_ISBL
u5 = f5->U_GRD_218_ISBL
v5 = f5->V_GRD_218_ISBL
uwind6 = f6->R_H_218_ISBL
hgt6=f6->HGT_218_ISBL
u6 = f6->U_GRD_218_ISBL
v6 = f6->V_GRD_218_ISBL
uwind7 = f7->R_H_218_ISBL
hgt7=f7->HGT_218_ISBL
u7 = f7->U_GRD_218_ISBL
v7 = f7->V_GRD_218_ISBL
uwind8 = f8->R_H_218_ISBL
hgt8=f8->HGT_218_ISBL
u8 = f8->U_GRD_218_ISBL
v8 = f8->V_GRD_218_ISBL
;speed = sqrt(u^2+v^2)
;copy_VarCoords(u, speed)
k1=33
printVarSummary(uwind)
printVarSummary(uwind2)
wks = gsn_open_wks("eps", "NAMPanel24002")
gsn_define_colormap(wks, "GMT_polar")
axislabelstyle = "panel"
res = True
res@gsnDraw = False
res@gsnFrame = False
res@tiMainOn =False
res@Footer = False
res@cnFillOn = True
res@cnLinesOn = False
 res@lbLabelBarOn        = False  
res@gsnSpreadColors = True
;res@pmTickMarkDisplayMode = "Always"
  ;res@gsnMaximize = True
  res@gsnAddCyclic           = False
res@tiMainOn =False
 res@mpOutlineBoundarySets = "AllBoundaries" ;"USStates"
 res@mpUSStateLineThicknessF = 1.5
 res@mpGeophysicalLineThicknessF =1.5
 res@mpNationalLineThicknessF = 1.5
  ;res@mpLimitMode            = "LatLon"        
  res@mpMinLatF              =   30.  
  res@mpMinLonF              = -135.
  res@mpMaxLatF              =   60.
  res@mpMaxLonF              =  -104.
  res@tmXBTickSpacingF = 5        ;x axis spacing
  res@tmYLTickSpacingF = 5
  res@mpGeophysicalLineColor = "Black"
  res@mpNationalLineColor    = "Black"
  res@mpUSStateLineColor     = "Black"
  res@mpGridLineColor        = "Black"
  res@mpLimbLineColor        = "Black"
  res@mpPerimLineColor       = "Black"
  ;res@cnFillDrawOrder = "PreDraw"
    res@tfDoNDCOverlay         = True 
   ;res@gsnLeftString   = "" 
   ;res@gsnRightString   = "" 
    delete(res@description) 
delete(res@units) 
 ;   res@NoTitles = True
res@mpProjection =  "CylindricalEquidistant" 
;plota=gsn_csm_contour_map(wks, uwind(k1,:,:), res)

res2=True
;res2@Footer = False
res2@tiMainOn =False
res2@gsnAddCyclic           = False
res2@gsnDraw = False
res2@gsnFrame = False
res2@cnLinesOn = True
res2@cnFillOn = False
; res2@mpLimitMode            = "LatLon"
;res2@pmTickMarkDisplayMode = "Always"
;res2@mpOutlineBoundarySets = "USStates"
;res2@mpGridAndLimbOn   = True 
  res2@mpMinLatF              =   43.  
  res2@mpMinLonF              = -123.
  res2@mpMaxLatF              =   48.
  res2@mpMaxLonF              =  -116.
  res2@cnLineThicknessF = 1.5
  res2@cnLineColor =  "snow"
  res2@cnInfoLabelOn = "False" ;contour from..to..
  res2@cnLabelMasking=True   ; to let label information display above the cnlines
  res2@cnLineLabelsOn = True
  res2@cnLineLabelDensityF = 3.5
  res2@cnLineLabelFontHeightF = 0.018
res2@cnExplicitLineLabelsOn = False
res2@cnMonoLineLabelFontColor = True
res2@cnLineLabelBackgroundColor = 0
res2@cnLevelSpacingF = 40
res2@gsnLeftString   = "" 
  res2@gsnRightString   = "" 
;res2@NoTitles = True
;res2@cnInfoLabelConstantSpacingF = 80
;res2@cnLevelSelectionMode = "ExplicitLevels"
;res2@cnLevels = (/1080,1160,1240,1320,1400/)
    res2@mpGeophysicalLineColor = "Black"
  res2@mpNationalLineColor    = "Black"
  res2@mpUSStateLineColor     = "Black"
  res2@mpGridLineColor        = "Black"
  res2@mpLimbLineColor        = "Black"
  res2@mpPerimLineColor       = "Black"
 ;res2@cnFillDrawOrder = "PreDraw"
    res2@tfDoNDCOverlay         = True 
;res2@mpProjection = "LambertConformal"
   delete(res2@description) 
delete(res2@units) 
res11 = res
res11@gsnLeftString   = "0000 UTC 24 Sep 2014" 
res11@gsnRightString   = "1600 LST" 
res11@gsnLeftStringFontHeightF=0.018
res11@gsnRightStringFontHeightF=0.018
res11@tmXBLabelsOn = False
res21 = res
res21@gsnLeftString   = "1200 UTC 24 Sep 2014" 
res21@gsnLeftStringFontHeightF=0.018
res21@gsnRightString   = ""
res21@tmXBLabelsOn = False
res21@tmYLLabelsOn = False
 res31 = res
res31@gsnLeftString   = "0000 UTC 25 Sep 2014" 
res31@gsnLeftStringFontHeightF=0.018
res31@gsnRightString   = ""
res31@tmXBLabelsOn = False

res41 = res
res41@gsnLeftString   = "1200 UTC 25 Sep 2014" 
res41@gsnLeftStringFontHeightF=0.018
res41@gsnRightString   = ""
res41@tmXBLabelsOn = False
res41@tmYLLabelsOn = False

res51 = res
res51@gsnLeftString   = "0000 UTC 26 Sep 2014" 
res51@gsnLeftStringFontHeightF=0.018
res51@gsnRightString   = ""
res51@tmXBLabelsOn = False

res61 = res
res61@gsnLeftString   = "1200 UTC 26 Sep 2014" 
res61@gsnLeftStringFontHeightF=0.018
res61@gsnRightString   = ""
res61@tmXBLabelsOn = False
res61@tmYLLabelsOn = False

res71 = res
res71@gsnLeftString   = "0000 UTC 27 Sep 2014" 
res71@gsnLeftStringFontHeightF=0.018
res71@gsnRightString   = ""
;res71@tmXBLabelsOn = False

res81 = res
res81@gsnLeftString   = "1200 UTC 27 Sep 2014" 
res81@gsnLeftStringFontHeightF=0.018
res81@gsnRightString   = ""
res81@tmYLLabelsOn = False
;plotb=gsn_csm_contour_map(wks, hgt(k1,:,:), res2)
vecres=True
vecres@gsnDraw = False
vecres@gsnFrame = False
vecres@Footer = False
;vecres@vcRefAnnoOn =False
vecres@vcRefAnnoPerimOn = False
vecres@vcRefAnnoOn = False    ;turn off vector info
vecres@vcRefAnnoString1On = False
vecres@vcRefAnnoString2On = False
;vecres@vcRefMagnitudeF           = 4.0   
 vecres@vcRefAnnoOrthogonalPosF   = -0.2 
vecres@vcGlyphStyle     = "CurlyVector"   ; curly vectors
  vecres@vcRefMagnitudeF  = 15              ; define vector ref mag
  vecres@vcRefLengthF     = 0.045           ; define length of vec ref
  vecres@gsnRightString   = " "             ; turn off right string
  vecres@gsnLeftString    = " "             ; turn off left string
  vecres@tiXAxisString    = " "             ; turn off axis label
 ; vecres@mpOutlineBoundarySets = "AllBoundaries" ;"USStates"
 ;vecres@mpUSStateLineThicknessF = 1.5
 ;vecres@mpGeophysicalLineThicknessF =1.5
 ;vecres@mpNationalLineThicknessF = 1.5
  ;res@mpLimitMode            = "LatLon"        
  ;vecres@mpMinLatF              =   30.  
  ;vecres@mpMinLonF              = -135.
  ;vecres@mpMaxLatF              =   60.
  ;vecres@mpMaxLonF              =  -104.
  ;vecres@tfDoNDCOverlay         = True 
;vecres@mpProjection = "LambertConformal"
       delete(vecres@description) 
delete(vecres@units) 

  vecres8=True
vecres8@gsnDraw = False
vecres8@gsnFrame = False
vecres8@Footer = False
;vecres@vcRefAnnoOn =False
vecres8@vcRefAnnoPerimOn = False
;vecres8@vcLineArrowColor = "DimGrey"
vecres8@vcRefAnnoString2On = False
vecres8@vcRefMagnitudeF           = 4.0   
 vecres8@vcRefAnnoOrthogonalPosF   = 0.15   ;vector info position
vecres8@vcGlyphStyle     = "CurlyVector"   ; curly vectors
  vecres8@vcRefAnnoString1 = "15 m/s"
  vecres8@vcRefAnnoFontHeightF = 0.02

  vecres8@vcRefMagnitudeF  = 15              ; define vector ref mag
  vecres8@vcRefLengthF     = 0.045           ; define length of vec ref
  vecres8@gsnRightString   = " "             ; turn off right string
  vecres8@gsnLeftString    = " "             ; turn off left string
  vecres8@tiXAxisString    = " "             ; turn off axis label
     delete(vecres8@description) 
delete(vecres8@units) 

plot=gsn_csm_contour_map(wks, uwind(k1,:,:), res11)
plotB  = gsn_csm_vector(wks, u(k1,:,:),v(k1,:,:),vecres)
plotC   = gsn_csm_contour(wks, hgt(k1,:,:), res2)
overlay(plot, plotB)
overlay(plot,plotC)

plot2=gsn_csm_contour_map(wks, uwind2(k1,:,:), res21)
plotB2  = gsn_csm_vector(wks, u2(k1,:,:),v2(k1,:,:),vecres)
plotC2   = gsn_csm_contour(wks, hgt2(k1,:,:), res2)
overlay(plot2, plotB2)
overlay(plot2,plotC2)

plot3=gsn_csm_contour_map(wks, uwind3(k1,:,:), res31)
plotB3  = gsn_csm_vector(wks, u3(k1,:,:),v3(k1,:,:),vecres)
plotC3   = gsn_csm_contour(wks, hgt3(k1,:,:), res2)
overlay(plot3, plotB3)
overlay(plot3,plotC3)

plot4=gsn_csm_contour_map(wks, uwind4(k1,:,:), res41)
plotB4  = gsn_csm_vector(wks, u4(k1,:,:),v4(k1,:,:),vecres)
plotC4   = gsn_csm_contour(wks, hgt4(k1,:,:), res2)
overlay(plot4, plotB4)
overlay(plot4,plotC4)

plot5=gsn_csm_contour_map(wks, uwind5(k1,:,:), res51)
plotB5  = gsn_csm_vector(wks, u5(k1,:,:),v5(k1,:,:),vecres)
plotC5   = gsn_csm_contour(wks, hgt5(k1,:,:), res2)
overlay(plot5, plotB5)
overlay(plot5,plotC5)

plot6=gsn_csm_contour_map(wks, uwind6(k1,:,:), res61)
plotB6  = gsn_csm_vector(wks, u6(k1,:,:),v6(k1,:,:),vecres)
plotC6   = gsn_csm_contour(wks, hgt6(k1,:,:), res2)
overlay(plot6, plotB6)
overlay(plot6,plotC6)

plot7=gsn_csm_contour_map(wks, uwind7(k1,:,:), res71)
plotB7  = gsn_csm_vector(wks, u7(k1,:,:),v7(k1,:,:),vecres)
plotC7   = gsn_csm_contour(wks, hgt7(k1,:,:), res2)
overlay(plot7, plotB7)
overlay(plot7,plotC7)

plot8=gsn_csm_contour_map(wks, uwind8(k1,:,:), res81)
plotB8  = gsn_csm_vector(wks, u8(k1,:,:),v8(k1,:,:),vecres8)
plotC8   = gsn_csm_contour(wks, hgt8(k1,:,:), res2)
overlay(plot8, plotB8)
overlay(plot8,plotC8)
;draw(plot)
;frame(wks)
resP=True
resP@gsnMaximize=True
resP@gsnPanelLabelBar    = True                ; add common colorbar
  resP@lbLabelFontHeightF  = 0.007               ; make labels smaller
 ; resP@NoTitles = True
 resP@cnLineDrawOrder = "PostDraw"
gsn_panel(wks,(/plot,plot2,plot3,plot4,plot5,plot6,plot7,plot8/),(/4,2/),resP)  
end















