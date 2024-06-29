/proc/get_soil_on_turf(turf/target_turf)
	for(var/atom/movable/movable as anything in target_turf.contents)
		// Soil does not have subtypes
		if(movable.type == /obj/structure/soil)
			return movable
	return null

/proc/get_farming_effort_divisor(mob/user)
	return (1 / get_farming_effort_multiplier(user))

/proc/get_farming_effort_multiplier(mob/user, factor = 2)
	return (10 + (user.mind.get_skill_level(/datum/skill/labor/farming) * factor)) * 0.1

/proc/get_farming_do_time(mob/user, time)
	return time / get_farming_effort_multiplier(user, 3)

/proc/apply_farming_fatigue(mob/user, fatigue_amount)
	var/multiplier = get_farming_effort_multiplier(user)
	user.rogfat_add(fatigue_amount / multiplier)

/proc/adjust_experience(mob/user, skill_type, exp_amount)
	user.mind.adjust_experience(skill_type, exp_amount)
