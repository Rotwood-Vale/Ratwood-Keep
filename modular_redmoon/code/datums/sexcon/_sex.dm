/datum/sex_action
	var/ru_name

/datum/sex_action/vaginal_sex/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	user.add_stress(/datum/stressevent/saw_wonder)
	user.add_curse(/datum/curse/zizo, TRUE)
	target.remove_stress(/datum/stressevent/saw_wonder)
	target.remove_curse(/datum/curse/zizo, TRUE)
