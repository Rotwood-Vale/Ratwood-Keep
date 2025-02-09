// Boolean. Returns true if all antag datums are actually "good", false otherwise.
/datum/mind/proc/isactuallygood()
	var/is_good_guy = TRUE
	for(var/datum/antagonist/GG in antag_datums)
		is_good_guy &&= GG.isgoodguy
	return is_good_guy

// Get a bonus multiplier dependant on age to apply to exp gains. Arg is a skill path.
/datum/mind/proc/get_learning_boon(skill)
	var/mob/living/carbon/human/H = current
	if(!istype(H))
		return 1
	var/boon = H.age == AGE_OLD ? 0.8 : 1 // Can't teach an old dog new tricks. Most old jobs start with higher skill too.
	boon += get_skill_level(skill) / 10
	// if(HAS_TRAIT(H, TRAIT_TUTELAGE)) //5% boost for being a good teacher
	// 	boon += 0.05
	return boon
