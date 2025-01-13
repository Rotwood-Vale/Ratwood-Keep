/datum/sex_action
	var/ru_name

/mob/living/carbon/human/proc/has_curse(curse_type)
	if(!curse_type)
		return FALSE
		
	for(var/datum/curse/curse in curses)
		if(istype(curse, curse_type))
			return TRUE
			
	return FALSE

/datum/sex_action/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	if(user.has_stress_event(/datum/stressevent/saw_wonder))
		user.remove_stress(/datum/stressevent/saw_wonder)
	if(target.has_stress_event(/datum/stressevent/saw_wonder))
		target.remove_stress(/datum/stressevent/saw_wonder)
	if(user.has_curse(/datum/curse/zizo))
		user.remove_curse(/datum/curse/zizo, TRUE)
	if(target.has_curse(/datum/curse/zizo))
		target.remove_curse(/datum/curse/zizo, TRUE)
