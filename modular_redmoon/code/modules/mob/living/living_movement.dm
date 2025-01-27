/mob/living/proc/movement_speed_function()
	var/spdchange
	if(STASPD <= 10)
		if(STASPD == 1)
			spdchange = -2
		if(STASPD == 2)
			spdchange = -1.8
		if(STASPD == 3)
			spdchange = -1.6
		if(STASPD == 4)
			spdchange = -1.4
		if(STASPD == 5)
			spdchange = -1.2
		if(STASPD == 6)
			spdchange = -1
		if(STASPD == 7)
			spdchange = -0.8
		if(STASPD == 8)
			spdchange = -0.6
		if(STASPD == 9)
			spdchange = -0.4
		if(STASPD == 10)
			spdchange = 0
	else
		if(STASPD == 11)
			spdchange = 0.2
		if(STASPD == 12)
			spdchange = 0.4
		if(STASPD == 13)
			spdchange = 0.6
		if(STASPD == 14)
			spdchange = 0.8
		if(STASPD == 15)
			spdchange = 1
		if(STASPD == 16)
			spdchange = 1.2
		if(STASPD == 17)
			spdchange = 1.4
		if(STASPD == 18)
			spdchange = 1.6
		if(STASPD == 19)
			spdchange = 1.8
		if(STASPD == 20)
			spdchange = 2
	mod = mod+spdchange
	//maximum speed is achieved at 15spd, everything else results in insanity
	add_movespeed_modifier(MOVESPEED_ID_MOB_WALK_RUN_CONFIG_SPEED, TRUE, 100, override = TRUE, multiplicative_slowdown = mod)
