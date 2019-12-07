
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
;---------------------------------------------------------------------

;f1 = addfile("/home/xsun/model/xsun/soft/WRFV3/run_NAMYSUNEW/wrfinput_d04.nc","r")  ;modify the cnmaxlevel too, MODIS is 20 and USGS is 24
;f1= addfile("/home/xsun/model/xsun/soft/WRFV3/run/wrfout_d04_2014-09-21_00:00:000","r")
;f2= addfile("/home/xsun/model/xsun/work/run_NAMNG/nuisttar/wrfout_d04_2014-09-21_00:00:00","r")
;f3= addfile("/home/xsun/model/xsun/work/run_NARR/wrfout_d04_2014-09-21_00:00:00","r")
;f4= addfile("/home/xsun/model/xsun/work/run_NAMACMMODIS/wrfout_d04_2014-09-26_00:00:00","r")
;f5= addfile("/home/xsun/model/xsun/work/run_NAMYSUMODIS/wrfout_d04_2014-09-26_00:00:00","r")
;f6= addfile("/home/xsun/model/xsun/work/run_NAMMYJMODIS/wrfout_d04_2014-09-26_00:00:00","r")
;------overlay to countours on map ----------------------------------------------------------------------
fils4 = systemfunc("ls /home/xsun/xsun/Borah/work/run_NAMACMMODIS/wrfout_d02*")
fils5 = systemfunc("ls /home/xsun/xsun/Borah/work/run_NAMYSUMODIS/wrfout_d02*")
fils6 = systemfunc("ls /home/xsun/xsun/Borah/work/run_NAMMYJMODIS/wrfout_d02*")
f1 = addfile("/home/xsun/xsun/Borah/soft/WRFV3/run/wrfout_d02_2014-09-21_00:00:00.nc","r")
f2 = addfile("/home/xsun/xsun/Borah/work/run_NAMNG/d0102Rerun/wrfout_d02_2014-09-21_00:00:00.nc","r")
;f2= addfile("/home/xsun/model/xsun/work/run_NAMNG/nuisttar/wrfout_d04_2014-09-21_00:00:00","r")
f4 = addfiles(fils4,"r")
ListSetType(f4,"cat")
f3 = addfile("/home/xsun/xsun/Borah/work/run_NARR/d0102Rerun/wrfout_d02_2014-09-21_00:00:00.nc","r")
;f3= addfile("/home/xsun/model/xsun/work/run_NARR/wrfout_d04_2014-09-21_00:00:00","r")
f5 = addfiles(fils5,"r")
ListSetType(f5,"cat")
f6 = addfiles(fils6,"r")
ListSetType(f6,"cat") 
fils7=systemfunc("ls /home/xsun/xsun/Borah/work/run_NARRYSUMODIS/wrfout_d02*") ;YSU*(NARR)
fils8=systemfunc("ls /home/xsun/xsun/Borah/work/run_NARRMYJMODIS/wrfout_d02*")   ;MYJ(NARR)

f7 = addfiles(fils7,"r")
ListSetType(f7,"cat")
f8 = addfiles(fils8,"r")
ListSetType(f8,"cat")

;landuse = f1->LU_INDEX(0,:,:)
t2 = 19  ;this controls the time stamp out of the wrfout daily output
t1= 140  ;this controls the time stamp out of the whole dailyout file
LHF = f1->LH

SHF=f1->HFX
aveLHF = dim_avg_n(LHF(47:184,:,:), 0)
aveSHF = dim_avg_n(SHF(47:184,:,:), 0)
 ;wks = gsn_open_wks("pdf", "Bowen_USGS_ACM")
 ; gsn_define_colormap(wks, "rainbow")
  Bowen = aveSHF/aveLHF
   copy_VarAtts(aveSHF, Bowen)

   LHF2 = f2->LH
SHF2=f2->HFX
aveLHF2 = dim_avg_n(LHF2(47:184,:,:), 0)
aveSHF2 = dim_avg_n(SHF2(47:184,:,:), 0)
  Bowen2 = aveSHF2/aveLHF2
   copy_VarAtts(aveSHF2, Bowen2)

   LHF3 = f3->LH
SHF3=f3->HFX
aveLHF3 = dim_avg_n(LHF3(47:184,:,:), 0)
aveSHF3 = dim_avg_n(SHF3(47:184,:,:), 0)
   Bowen3 = aveSHF3/aveLHF3
   copy_VarAtts(aveSHF3, Bowen3)

   LHF4 = f4[:]->LH
SHF4=f4[:]->HFX
aveLHF4 = dim_avg_n(LHF4(47:184,:,:), 0)
aveSHF4 = dim_avg_n(SHF4(47:184,:,:), 0)
   Bowen4 = aveSHF4/aveLHF4
   copy_VarAtts(aveSHF4, Bowen4)

   LHF5 = f5[:]->LH
SHF5=f5[:]->HFX
aveLHF5 = dim_avg_n(LHF5(47:184,:,:), 0)
aveSHF5 = dim_avg_n(SHF5(47:184,:,:), 0)
aveLHF5@_FillValue = 999
;if (any(aveLHF5).ne.0.0)  then
  ;print(aveLHF5)
  ; write branch
Bowen5 = aveSHF5/where(aveLHF5.ne.0,aveLHF5,aveLHF5@_FillValue)
;end if
   
   copy_VarAtts(aveSHF5, Bowen5)

   LHF6 = f6[:]->LH
SHF6=f6[:]->HFX
aveLHF6 = dim_avg_n(LHF6(47:184,:,:), 0)
aveSHF6 = dim_avg_n(SHF6(47:184,:,:), 0)
  ;Bowen6 = aveSHF6/aveLHF6
  aveLHF6@_FillValue = 999
   Bowen6 = aveSHF6/where(aveLHF6.ne.0,aveLHF6,aveLHF6@_FillValue)
   copy_VarAtts(aveSHF6, Bowen6)

   LHF7 = f7[:]->LH
SHF7=f7[:]->HFX
aveLHF7 = dim_avg_n(LHF7(47:184,:,:), 0)
aveSHF7 = dim_avg_n(SHF7(47:184,:,:), 0)

LHF8 = f8[:]->LH
SHF8=f8[:]->HFX
aveLHF8 = dim_avg_n(LHF8(47:184,:,:), 0)
aveSHF8 = dim_avg_n(SHF8(47:184,:,:), 0)
   
   lat= wrf_user_getvar(f1, "lat" ,0)
   lon= wrf_user_getvar(f1, "lon" ,0)
  ; lat=lat1(0,:,:)
   ;lon=lon1(0,:,:)
   Maxlat1= dim_max_n(lat,0)
   MaxLon1= dim_max_n(lon, 1)
   Minlat1= dim_min_n(lat,0)
   MinLon1= dim_min_n(lon, 1)
   Maxlat = dim_max(Maxlat1)
   MaxLon = dim_max(MaxLon1)
   Minlat = dim_min(Minlat1)
   MinLon = dim_min(MinLon1)
   print(Maxlat)
   print(MaxLon)
   print(Minlat)
   print(MinLon)
  
;  wks = gsn_open_wks("x11", "Modles Performance")
 wks = gsn_open_wks("eps", "../Flux/d2_SpaAveSHF_AllNARR#")
 gsn_define_colormap(wks, "BlGrYeOrReVi200")
 axislabelstyle = "panel"
;--------set resources
  res = True
  ;res@Footer=False
 ; res@tiMainString = "NAM-ACM2(MODIS)"
  ; res@tiMainString = "NAM-ACM2"
  ;  res@tiMainString = "NARR-ACM2"
  ;res@tiMainString = "NAM-ACM2(Non-nudge)"
  res@gsnDraw              = False
  res@gsnFrame             = False
  res@Footer = False
  res@InitTime = False
  ;res@gsnMaximize = True
    res@cnFillOn    = True
   ; res@mpProjection = "LambertConformal"
  res@tfDoNDCOverlay = True
 res@gsnSpreadColors = True
res@lbLabelBarOn = False
  res@cnFillOn = True
  res@cnLineLabelsOn = False 
 res@cnLinesOn = False
  res@cnInfoLabelOn = False
res@gsnLeftString = " "
res@gsnRightString = " "
res@tmXTOn = False
  res@tmYROn = False
  ; res@mpMinLatF              =   Minlat  
  ;res@mpMinLonF              = MinLon
  ;res@mpMaxLatF              =   Maxlat
  ;res@mpMaxLonF              =  MaxLon
 
 res@mpGeophysicalLineColor = "Black"
  res@mpNationalLineColor    = "Black"
  res@mpUSStateLineColor     = "Black"
  res@mpGridLineColor        = "Black"
  res@mpLimbLineColor        = "Black"
  res@mpPerimLineColor       = "Black"
 
 res1 = res
 res1@FieldTitle = "ACM2~S~#~N~(No-nudge)"
 res1@gsnLeftStringFontHeightF = 0.018
 res1@tmXBLabelsOn = False
 res1@mpGeophysicalLineColor = "Black"
  res1@mpNationalLineColor    = "Black"
  res1@mpUSStateLineColor     = "Black"
  res1@mpGridLineColor        = "Black"
  res1@mpLimbLineColor        = "Black"
  res1@mpPerimLineColor       = "Black"

res2 = res
 ;res2@gsnLeftString = "ACM2"
 res2@gsnLeftStringFontHeightF = 0.018
 res2@FieldTitle = "ACM2~S~#~N~"
 res2@tmXBLabelsOn = False
res2@tmYLLabelsOn=False
 res3 = res
 res3@FieldTitle = "ACM2~S~#~N~(NARR)"
 res3@gsnLeftStringFontHeightF = 0.018
 res3@tmXBLabelsOn = False
res3@tmYLLabelsOn=False
 res4 = res
 res4@FieldTitle = "ACM2*"
 res4@gsnLeftStringFontHeightF = 0.018
 ;res4@tmXBLabelsOn = False

 res5 = res
 res5@FieldTitle = "YSU*"
 res5@gsnLeftStringFontHeightF = 0.018
 ;res5@tmXBLabelsOn = False
res5@tmYLLabelsOn=False
 
 res6 = res
 res6@FieldTitle = "MYJ*"
 res6@gsnLeftStringFontHeightF = 0.018
 ;res6@tmXBLabelsOn = False
 res6@tmYLLabelsOn=False

 res7 = res
 res7@FieldTitle = "YSU*(NARR)"
 res7@gsnLeftStringFontHeightF = 0.018
 ;res6@tmXBLabelsOn = False
 res7@tmYLLabelsOn=False

 res8 = res
 res8@FieldTitle = "MYJ*(NARR)"
 res8@gsnLeftStringFontHeightF = 0.018
 ;res6@tmXBLabelsOn = False
 res8@tmYLLabelsOn=False

;plot= gsn_csm_contour_map(wks, Bowen(:,:), res1)

;plot2= gsn_csm_contour_map(wks, Bowen2(:,:), res2)

;plot3= gsn_csm_contour_map(wks, Bowen3(:,:), res3)
;plot4= gsn_csm_contour_map(wks, Bowen4(:,:), res4)
;plot5= gsn_csm_contour_map(wks, Bowen5(:,:), res5)
;plot6= gsn_csm_contour_map(wks, Bowen6(:,:), res6)


;plot= gsn_csm_contour_map(wks, aveLHF(:,:), res1)

;plot2= gsn_csm_contour_map(wks,aveLHF2(:,:), res2)

;plot3= gsn_csm_contour_map(wks,aveLHF3(:,:), res3)
;plot4= gsn_csm_contour_map(wks, aveLHF4(:,:), res4)
;plot5= gsn_csm_contour_map(wks, aveLHF5(:,:), res5)
;plot6= gsn_csm_contour_map(wks, aveLHF6(:,:), res6)
   
   pltres = True
   pltres@PanelPlot = True
   pltres2 = pltres
   pltres2@gsnLeftString = "ACM2"
 pltres2@gsnLeftStringFontHeightF = 0.018
 pltres2@tmXBLabelsOn = False
pltres2@tmYLLabelsOn=False
plot0= wrf_contour(f1, wks, aveSHF, res1)

plot20= wrf_contour(f1, wks, aveSHF2, res2)

plot30= wrf_contour(f1, wks, aveSHF3, res3)
plot40= wrf_contour(f1, wks, aveSHF4, res4)
plot50= wrf_contour(f1, wks, aveSHF5, res5)
plot60= wrf_contour(f1, wks, aveSHF6, res6)
plot70= wrf_contour(f1, wks, aveSHF7, res7)
plot80= wrf_contour(f1, wks, aveSHF8, res8)

mapres = True
 mapres@tmXBLabelFontHeightF = 0.018
 mapres@tmYLLabelFontHeightF = 0.018
 mapres@mpGridAndLimbOn = False
 mapres@mpGeophysicalLineColor = "Black"
  mapres@mpNationalLineColor    = "Black"
  mapres@mpUSStateLineColor     = "Black"
  mapres@mpGridLineColor        = "Black"
  mapres@mpLimbLineColor        = "Black"
  mapres@mpPerimLineColor       = "Black"
  mapres1 = mapres
  mapres1@tmXBLabelsOn = False
    mapres2 = mapres
  mapres2@tmXBLabelsOn = False
  mapres2@tmYLLabelsOn = False
    mapres3 = mapres
  mapres3@tmXBLabelsOn = False
  mapres3@tmYLLabelsOn = False
    mapres4 = mapres
mapres4@tmXBLabelsOn = False
  mapres4@tmYLLabelsOn = False
    mapres5 = mapres
 ; mapres5@tmYLLabelsOn = False
    mapres6 = mapres
  mapres6@tmYLLabelsOn = False
  mapres7 = mapres
  mapres7@tmYLLabelsOn = False
  mapres8 = mapres
  mapres8@tmYLLabelsOn = False

plot = wrf_map_overlays(f1, wks, (/plot0/), pltres, mapres1)
plot2 = wrf_map_overlays(f1, wks, (/plot20/), pltres2, mapres2)
plot3 = wrf_map_overlays(f1, wks, (/plot30/), pltres, mapres3)
plot4 = wrf_map_overlays(f1, wks, (/plot40/), pltres, mapres4)
plot5 = wrf_map_overlays(f1, wks, (/plot50/), pltres, mapres5)
plot6 = wrf_map_overlays(f1, wks, (/plot60/), pltres, mapres6)
plot7 = wrf_map_overlays(f1, wks, (/plot70/), pltres, mapres7)
plot8 = wrf_map_overlays(f1, wks, (/plot80/), pltres, mapres8)
;plot= gsn_csm_contour_map(wks, Bowen(:,:), res1)

;plot2= gsn_csm_contour_map(wks,Bowen2(:,:), res2)

;plot3= gsn_csm_contour_map(wks,Bowen3(:,:), res3)
;plot4= gsn_csm_contour_map(wks, Bowen4(:,:), res4)
;plot5= gsn_csm_contour_map(wks, Bowen5(:,:), res5)
;plot6= gsn_csm_contour_map(wks, Bowen6(:,:), res6)


resP= True
resP@gsnMaximize = True
resP@gsnPanelLabelBar = True
resP@lbLabelFontHeightF = 0.008
resP@pmLabelBarOrthogonalPosF = 0.10
resP@gsnPanelYWhiteSpacePercent = 0.0015
resP@gsnPanelDebug = True
resP@gsnPanelXF = (/0.05, 0.28, 0.51, 0.74,0.05, 0.28, 0.51, 0.74/)
resP@gsnPanelYF=(/0.78,0.78,0.78,0.78,0.53,0.53,0.53,0.53/)
;resP@lbLabelStrings = (/"0","0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","1","2","3"/)
gsn_panel(wks, (/plot,plot2,plot3,plot4,plot5,plot6,plot7,plot8/),(/2,4/) , resP)
end















