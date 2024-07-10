/mob/living/pixelshifteast()
	if(!canface())
		return FALSE
	if(pixel_x <= 16)
		pixel_x++

	set_mob_offsets("pixel_shift", _x = _x--, _y = _y)	

/mob/living/pixelshiftwest()
	if(!canface())
		return FALSE
	if(pixel_x >= -16)
		pixel_x--

/mob/living/pixelshiftnorth()
	if(!canface())
		return FALSE
	if(pixel_y <= 16)
		pixel_y++

/mob/verb/pixelshiftsouth()
	set hidden = TRUE
	if(!canface())
		return FALSE
	if(pixel_y >= -16)
		pixel_y--
	set_mob_offsets("pixel_shift", _x = _x--, _y = _y)	

