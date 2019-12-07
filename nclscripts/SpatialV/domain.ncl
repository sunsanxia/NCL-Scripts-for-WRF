
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
;---------------------------------------------------------------------
f1 = addfile("/mnt/datadrive/xsun/work/run_NAMYSUMODIS/wrfout_d01_2014-09-21_00:00:00.nc","r")
f2 = addfile("/mnt/datadrive/xsun/work/run_NAMYSUMODIS/wrfout_d02_2014-09-21_00:00:00.nc","r")
f3 = addfile("/mnt/datadrive/xsun/work/run_NAMYSUMODIS/wrfout_d03_2014-09-21_00:00:00.nc","r")
f4 = addfile("/mnt/datadrive/xsun/work/run_NAMYSUMODIS/wrfout_d04_2014-09-21_00:00:00.nc","r")

 wks = gsn_open_wks("ps", "wrf_overlay_doms")  ; Open graphics file


  var1 = wrf_user_getvar(f1,"HGT",0)
  lat1 = wrf_user_getvar(f1,"XLAT",0)
  lon1 = wrf_user_getvar(f1,"XLONG",0)
  var2 = wrf_user_getvar(f2,"HGT",0)
  lat2 = wrf_user_getvar(f2,"XLAT",0)
  lon2 = wrf_user_getvar(f2,"XLONG",0)
  var3 = wrf_user_getvar(f3,"HGT",0)
lat3 = wrf_user_getvar(f3,"XLAT",0)
  lon3 = wrf_user_getvar(f3,"XLONG",0)
  var4 = wrf_user_getvar(f4,"HGT",0)
  lat4 = wrf_user_getvar(f4,"XLAT",0)
  lon4 = wrf_user_getvar(f4,"XLONG",0)

  var1@lat2d = lat1
  var1@lon2d = lon1
 var2@lat2d = lat2
  var2@lon2d = lon2
   var3@lat2d = lat3
  var3@lon2d = lon3
   var4@lat2d = lat4
  var4@lon2d = lon4


  dom_dims = dimsizes(var1)
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

 res=True
 res@gsnDraw = False
 res@gsnFrame = False
 res@Footer=False
 res@cnFillOn = False
 res@cnLineLabelsOn =False
 res@cnLinesOn= False
  res@tfDoNDCOverlay = True
 res@cnLineColor =  "White"
 res@cnInfoLabelOn = False
  res@mpDataBaseVersion     = "MediumRes"          ; Default is LowRes
  res@mpGeophysicalLineColor = "Black"
  res@mpNationalLineColor    = "Black"
  res@mpUSStateLineColor     = "Black"
  res@mpGridLineColor        = "Black"
  res@mpLimbLineColor        = "Black"
  res@mpPerimLineColor       = "Black"
  res@mpDataSetName = "Earth..1"
  res@mpOutlineDrawOrder    = "PreDraw"           ; Draw map outlines last
  res@mpGridAndLimbOn       = False               ; Turn off lat/lon lines
  res@pmTickMarkDisplayMode = "Always"             ; Turn on map tickmarks
  res = wrf_map_resources(f1,res)
  res@mpLimitMode        = "Corners"
  res@mpFillOn = True               ; Portion of map to zoom
   res@cnFillPattern = -1
   res@mpFillPatternBackground = -1
   res@mpLandFillPattern = -1
  res@mpLeftCornerLatF   = lat1(0,0)
  res@mpLeftCornerLonF   = lon1(0,0)
  res@mpRightCornerLatF  = lat1(ny1,nx1)
  res@mpRightCornerLonF  = lon1(ny1,nx1)
  
  res@mpUSStateLineThicknessF = 2.0

 xbox_out = new(5,float)
 ybox_out = new(5,float)
 lnres=True
 lnres@gsLineThicknessF = 1.5

 map = gsn_csm_contour_map(wks, var1, res)

 draw(map)
xbox = (/lon2(0,0),lon2(0,nx2),lon2(ny2,nx2),lon2(ny2,0),lon2(0,0)/)
  ybox = (/lat2(0,0),lat2(0,nx2),lat2(ny2,nx2),lat2(ny2,0),lat2(0,0)/)
  datatondc(map, xbox, ybox, xbox_out, ybox_out)
  gsn_polyline_ndc(wks, xbox_out, ybox_out, lnres)

  xbox = (/lon3(0,0),lon3(0,nx3),lon3(ny3,nx3),lon3(ny3,0),lon3(0,0)/)
  ybox = (/lat3(0,0),lat3(0,nx3),lat3(ny3,nx3),lat3(ny3,0),lat3(0,0)/)
  datatondc(map, xbox, ybox, xbox_out, ybox_out)
  gsn_polyline_ndc(wks, xbox_out, ybox_out, lnres)
  xbox = (/lon4(0,0),lon4(0,nx4),lon4(ny4,nx4),lon4(ny4,0),lon4(0,0)/)
  ybox = (/lat4(0,0),lat4(0,nx4),lat4(ny4,nx4),lat4(ny4,0),lat4(0,0)/)
  datatondc(map, xbox, ybox, xbox_out, ybox_out)
  gsn_polyline_ndc(wks, xbox_out, ybox_out, lnres)
end















