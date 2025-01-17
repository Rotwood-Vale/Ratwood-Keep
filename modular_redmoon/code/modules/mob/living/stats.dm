/mob/living/roll_stats()
	. = ..()
	var/mob/living/carbon/human/H = src
	if(H.background)
		H.background.apply_to_human(H)
