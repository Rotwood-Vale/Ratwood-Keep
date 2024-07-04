/datum/sex_action
	abstract_type = /datum/sex_action
	var/name = "Zodomize"
	/// Time to do the act
	var/do_time = 3 SECONDS
	/// Whether the act is continous and will be done on repeat
	var/continous = TRUE
	var/stamina_cost = 2

/datum/sex_action/proc/can_perform(mob/living/user, mob/living/target)
	return TRUE

/datum/sex_action/proc/on_start(mob/living/user, mob/living/target)
	return

/datum/sex_action/proc/on_perform(mob/living/user, mob/living/target)
	return

/datum/sex_action/proc/on_finish(mob/living/user, mob/living/target)
	return

/datum/sex_action/proc/is_finished(mob/living/user, mob/living/target)
	return FALSE
