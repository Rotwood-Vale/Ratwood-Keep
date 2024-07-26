/datum/mob_descriptor/defiant
	name = "Defiant"
	slot = MOB_DESCRIPTOR_SLOT_NOTHING
	verbage = "looks"
	describe = "defiant!"
	show_obscured = TRUE

/datum/mob_descriptor/defiant/can_describe(mob/living/described)
	if(!described.defiant)
		return FALSE
	return TRUE

/datum/mob_descriptor/defiant/can_user_see(mob/living/described, mob/user)
	// Always see if you yourself are
	if(user == described)
		return TRUE
	// Ghosts can see
	if(!isliving(user))
		return TRUE
	var/mob/living/living_user = user
	// Other defiants can not see
	if(living_user.defiant)
		return FALSE
	// Further than 2 tiles dont see it
	if(get_dist(described, living_user) > 2)
		return FALSE
	return TRUE

/datum/mob_descriptor/age
	name = "Age"
	slot = MOB_DESCRIPTOR_SLOT_AGE
	verbage = "looks"

/datum/mob_descriptor/age/can_describe(mob/living/described)
	if(!ishuman(described))
		return FALSE
	return TRUE

/datum/mob_descriptor/age/get_description(mob/living/described)
	var/mob/living/carbon/human/human = described
	if(human.age == AGE_OLD)
		return "old"
	else if (human.age == AGE_MIDDLEAGED)
		return "middle-aged"
	else
		return "adult"

/datum/mob_descriptor/penis
	name = "penis"
	slot = MOB_DESCRIPTOR_SLOT_PENIS
	verbage = "has"

/datum/mob_descriptor/penis/can_describe(mob/living/described)
	if(!ishuman(described))
		return FALSE
	var/mob/living/carbon/human/human = described
	var/obj/item/organ/penis/penis = human.getorganslot(ORGAN_SLOT_PENIS)
	if(!penis)
		return FALSE
	if(!get_location_accessible(human, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	return TRUE

/datum/mob_descriptor/penis/get_description(mob/living/described)
	var/mob/living/carbon/human/human = described
	var/obj/item/organ/penis/penis = human.getorganslot(ORGAN_SLOT_PENIS)
	var/adjective
	switch(penis.penis_size)
		if(1)
			adjective = "a small"
		if(2)
			adjective = "an average"
		if(3)
			adjective = "a large"
	var/used_name
	if(penis.erect_state != ERECT_STATE_HARD && penis.sheath_type != SHEATH_TYPE_NONE)
		switch(penis.sheath_type)
			if(SHEATH_TYPE_NORMAL)
				if(penis.penis_size == 3)
					used_name = "a fat sheath"
				else
					used_name = "a sheath"
			if(SHEATH_TYPE_SLIT)
				used_name = "a genital slit"
	else
		used_name = "[adjective] [penis.name]"
	return "[used_name]"

/datum/mob_descriptor/testicles
	name = "balls"
	slot = MOB_DESCRIPTOR_SLOT_TESTICLES
	verbage = "has"

/datum/mob_descriptor/testicles/can_describe(mob/living/described)
	if(!ishuman(described))
		return FALSE
	var/mob/living/carbon/human/human = described
	var/obj/item/organ/testicles/testes = human.getorganslot(ORGAN_SLOT_TESTICLES)
	if(!testes)
		return FALSE
	if(!get_location_accessible(human, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	var/obj/item/organ/penis/penis = human.getorganslot(ORGAN_SLOT_PENIS)
	if(penis && penis.sheath_type == SHEATH_TYPE_SLIT) //If our penis hides in a slit, dont describe testicles
		return FALSE
	return TRUE

/datum/mob_descriptor/testicles/get_description(mob/living/described)
	var/mob/living/carbon/human/human = described
	var/obj/item/organ/testicles/testes = human.getorganslot(ORGAN_SLOT_TESTICLES)
	var/adjective
	switch(testes.ball_size)
		if(1)
			adjective = "a small"
		if(2)
			adjective = "an average"
		if(3)
			adjective = "a large"
	return "[adjective] pair of balls"

/datum/mob_descriptor/vagina
	name = "vagina"
	slot = MOB_DESCRIPTOR_SLOT_VAGINA
	verbage = "has"

/datum/mob_descriptor/vagina/can_describe(mob/living/described)
	if(!ishuman(described))
		return FALSE
	var/mob/living/carbon/human/human = described
	var/obj/item/organ/vagina/vagina = human.getorganslot(ORGAN_SLOT_VAGINA)
	if(!vagina)
		return FALSE
	if(!get_location_accessible(human, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	return TRUE

/datum/mob_descriptor/vagina/get_description(mob/living/described)
	return "a vagina"

/datum/mob_descriptor/breasts
	name = "breasts"
	slot = MOB_DESCRIPTOR_SLOT_BREASTS
	verbage = "has"

/datum/mob_descriptor/breasts/can_describe(mob/living/described)
	if(!ishuman(described))
		return FALSE
	var/mob/living/carbon/human/human = described
	var/obj/item/organ/breasts/breasts = human.getorganslot(ORGAN_SLOT_BREASTS)
	if(!breasts)
		return FALSE
	if(!get_location_accessible(human, BODY_ZONE_CHEST))
		return FALSE
	return TRUE

/datum/mob_descriptor/breasts/get_description(mob/living/described)
	var/mob/living/carbon/human/human = described
	var/obj/item/organ/breasts/breasts = human.getorganslot(ORGAN_SLOT_BREASTS)
	var/adjective
	switch(breasts.breast_size)
		if(0)
			adjective = "a flat"
		if(1)
			adjective = "a very small"
		if(2)
			adjective = "a small"
		if(3)
			adjective = "an average"
		if(4)
			adjective = "a large"
		if(5)
			adjective = "an enormous"
	return "[adjective] pair of breasts"
