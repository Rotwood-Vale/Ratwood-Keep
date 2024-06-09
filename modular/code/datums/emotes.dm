/mob/living/carbon/human/get_emote_frequency() /////// RAT WOOD CHANGES TO EMOTE PITCH
	var/cont = 43500
	var/mult = STASTR
	if(gender == MALE)
		if(STASTR > 10)
			if(STASTR >= 15)
				mult *= 1.2
			cont -= 400 * mult
		if(STASTR < 10) 
			mult = (mult - 10) * -1
			if(STASTR <= 5)
				mult *= 2
			cont += 500 * mult
	else
		if(STASTR > 10)
			if(STASTR >= 15)
				mult *= 1.5
			cont -= 300 * mult
		if(STASTR < 10) 
			mult = (mult - 10) * -1
			if(STASTR <= 5)
				mult *= 1.2
			cont += 400 * mult
	return cont
