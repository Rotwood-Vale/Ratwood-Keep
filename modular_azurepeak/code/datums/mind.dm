/datum/mind
	var/has_studied = FALSE

/datum/mind/proc/get_requried_sleep_xp_for_skill(skill_type, level_amount)
	return sleep_adv.get_requried_sleep_xp_for_skill(skill_type, level_amount)

/datum/mind/proc/get_next_level_for_skill(skill_type)
	return sleep_adv.get_next_level_for_skill(skill_type)
