/datum/mob_descriptor/butt
	name = "butt"
	slot = MOB_DESCRIPTOR_SLOT_BUTT
	verbage = "has"
	show_obscured = FALSE

/datum/mob_descriptor/butt/can_describe(mob/living/described)
	if(!ishuman(described))
		return FALSE
	var/mob/living/carbon/human/H = described
	var/obj/item/organ/butt/buttie = H.getorganslot(ORGAN_SLOT_BUTT)
	if(!buttie)
		return FALSE
	if(H.underwear)
		return FALSE
	if(!get_location_accessible(H, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	return TRUE

/datum/mob_descriptor/butt/get_description(mob/living/described)
	var/mob/living/carbon/human/H = described
	var/obj/item/organ/butt/buttie = H.getorganslot(ORGAN_SLOT_BUTT)
	var/adjective
	switch(buttie.butt_size)
		if(1)
			adjective = "a small"
		if(2)
			adjective = "an average"
		if(3)
			adjective = "a large"
		if(4)
			adjective = "a massive"
		if(5)
			adjective = "a colossal"
	return "[adjective] ass"
