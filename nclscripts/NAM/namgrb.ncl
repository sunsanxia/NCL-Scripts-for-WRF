
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
;---------------------------------------------------------------------
;fili = "/home/xsun/model/xsun/data/NAM_12/namanl_218_20140924_1200_006.grb"
f1 = addfile("/home/xsun/model/xsun/data/NAM_12/namanl_218_20140924_1200_000.grb","r")
;**************************************************************
;open file and read in data
;*************************************************************
uwind = f1->R_H_218_ISBL
hgt=f1->HGT_218_ISBL
u = f1->U_GRD_218_ISBL
v = f1->V_GRD_218_ISBL
;speed = sqrt(u^2+v^2)
;copy_VarCoords(u, speed)
k1=33
printVarSummary(uwind)
wks = gsn_open_wks("eps", "NAM")
gsn_define_colormap(wks, "GMT_polar")
res = True
res@gsnDraw = False
res@gsnFrame = False
res@cnFillOn = True
res@cnLinesOn = False
res@gsnSpreadColors = True
;res@pmTickMarkDisplayMode = "Always"
  res@gsnMaximize = True
  res@gsnAddCyclic           = False

 res@mpOutlineBoundarySets = "AllBoundaries" ;"USStates"
 res@mpUSStateLineThicknessF = 2.0
 res@mpGeophysicalLineThicknessF =2.0
 res@mpNationalLineThicknessF = 2.0
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
;res@mpProjection = "LambertConformal"
;plota=gsn_csm_contour_map(wks, uwind(k1,:,:), res)

res2=True
res2@gsnAddCyclic           = False
res2@gsnDraw = False
res2@gsnFrame = False
res2@cnLinesOn = True
res2@cnFillOn = False
; res2@mpLimitMode            = "LatLon"
;res2@pmTickMarkDisplayMode = "Always"
;res2@mpOutlineBoundarySets = "USStates"
;res2@mpGridAndLimbOn   = True 
  res2@mpMinLatF              =   30.  
  res2@mpMinLonF              = -135.
  res2@mpMaxLatF              =   60.
  res2@mpMaxLonF              =  -104.
  res2@cnLineColor =  "snow"
  res2@cnLabelMasking=True   ; to let label information display above the cnlines
res2@cnMonoLineLabelFontColor = True
res2@cnLineLabelBackgroundColor = 0
    res@mpGeophysicalLineColor = "Black"
  res2@mpNationalLineColor    = "Black"
  res2@mpUSStateLineColor     = "Black"
  res2@mpGridLineColor        = "Black"
  res2@mpLimbLineColor        = "Black"
  res2@mpPerimLineColor       = "Black"
 ;res2@cnFillDrawOrder = "PreDraw"
    res2@tfDoNDCOverlay         = True 
res2@mpProjection = "LambertConformal"
;plotb=gsn_csm_contour_map(wks, hgt(k1,:,:), res2)
vecres=True
vecres@gsnDraw = False
vecres@gsnFrame = False
;vecres@vcRefAnnoOn =False
vecres@vcRefAnnoPerimOn = False
vecres@vcRefAnnoString2On = False
vecres@vcRefMagnitudeF           = 4.0   
 vecres@vcRefAnnoOrthogonalPosF   = -0.2 
vecres@vcGlyphStyle     = "CurlyVector"   ; curly vectors
  vecres@vcRefMagnitudeF  = 20              ; define vector ref mag
  vecres@vcRefLengthF     = 0.045           ; define length of vec ref
  vecres@gsnRightString   = " "             ; turn off right string
  vecres@gsnLeftString    = " "             ; turn off left string
  vecres@tiXAxisString    = " "             ; turn off axis label
plot=gsn_csm_contour_map_overlay(wks, uwind(k1,:,:), hgt(k1,:,:),res, res2)
plotB   = gsn_csm_vector(wks,u(k1,:,:),v(k1,:,:),vecres)
overlay(plot, plotB)
draw(plot)
frame(wks)
end















