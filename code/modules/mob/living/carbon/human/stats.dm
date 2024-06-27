/mob/living/carbon/human/set_patron(datum/patron/new_patron)
	. = ..()
	if(. && devotion)
		devotion.patron = new_patron
