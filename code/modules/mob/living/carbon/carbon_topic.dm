/mob/living/carbon/soul_examine(mob/user)
	var/list/message = list()
	if((stat >= DEAD) && (isobserver(user) || HAS_TRAIT(user, TRAIT_SOUL_EXAMINE)))
		if(getorganslot(ORGAN_SLOT_BRAIN) && !key && !get_ghost(FALSE, TRUE))
			message += span_deadsay("[p_their(TRUE)] soul has departed...")
		else
			message += span_deadsay("[p_they(TRUE)] [p_are()] still earthbound.")
	return message
