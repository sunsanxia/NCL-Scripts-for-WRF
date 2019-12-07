
;
; Concepts illustrated:
;   - Setting the mininum/maximum value of the Y axis in an XY plot
;   - Changing the width and height of a plot
;   - Forcing a tickmark label at beginning of X axis
;----------------------------------------------------------------------
;
; These files are loaded by default in NCL V6.2.0 and newer
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

begin
  years  = ispan(1950,2005,1)
  nyears = dimsizes(years)
  arr    = random_uniform(-4.,4.,nyears)
	
  wks = gsn_open_wks("png","tm")        ; send graphics to PNG file

  res = True
;
;  The following vp resources set the boundaries of the xy plot
;  in ndc grid space (0.->1.)  The gsnMaximize = True resizes
;  the plot so it fits in the given rame.
;
  res@gsnMaximize = True
  res@vpWidthF    = 0.8     ; make the plot wider than it is high
  res@vpHeightF   = 0.3

  res@trYMinF     = -4.5		; set minimum Y-axis value
  res@trYMaxF     =  4.5		; set maximum Y-axis value
  res@trXMinF     = min(years)-1        ; set minimum X-axis value
  res@trXMaxF     = max(years)+1        ; set maximum X-axis value

  plot = gsn_csm_xy(wks,years,arr,res)

  res@tmXBMode        = "Manual"
  res@tmXBTickStartF  = res@trXMinF   ; Force tickmark labelling to start at first value

  plot = gsn_csm_xy(wks,years,arr,res)
end
