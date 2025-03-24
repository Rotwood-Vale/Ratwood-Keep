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
	if(user.has_stress(/datum/stressevent/saw_wonder))
		user.remove_stress(/datum/stressevent/saw_wonder)
	if(target.has_stress(/datum/stressevent/saw_wonder))
		target.remove_stress(/datum/stressevent/saw_wonder)
	if(user.has_curse(/datum/curse/zizo))
		user.remove_curse(/datum/curse/zizo, TRUE)
	if(target.has_curse(/datum/curse/zizo))
		target.remove_curse(/datum/curse/zizo, TRUE)

/datum/sex_action/anal_ride_sex/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	user.mind.adjust_experience(/datum/skill/misc/riding, user.STAINT / 8, FALSE)

/datum/sex_action/vaginal_ride_sex/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	user.mind.adjust_experience(/datum/skill/misc/riding, user.STAINT / 8, FALSE)
