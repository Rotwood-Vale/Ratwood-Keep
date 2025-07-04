/proc/get_soil_on_turf(turf/target_turf)
	return locate(/obj/structure/soil) in target_turf

/proc/get_farming_effort_divisor(mob/user)
	return (1 / get_farming_effort_multiplier(user))

/proc/get_farming_effort_multiplier(mob/user, factor = 2)
	return (10 + (user.get_skill_level(/datum/skill/labor/farming) * factor)) * 0.1

/proc/get_farming_do_time(mob/user, time)
	return time / get_farming_effort_multiplier(user, 3)

/proc/apply_farming_fatigue(mob/user, fatigue_amount)
	var/multiplier = get_farming_effort_multiplier(user)
	user.energy_add(fatigue_amount / multiplier)
