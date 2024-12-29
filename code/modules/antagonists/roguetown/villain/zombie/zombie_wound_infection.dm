/datum/wound
	/// Zombie infection probability for bites on this wound
	var/zombie_infection_probability = 90
	/// Time taken until zombie infection comes in
	var/zombie_infection_time = 1 MINUTES
	/// Actual infection timer
	var/zombie_infection_timer

/datum/wound/proc/zombie_infect_attempt()
	if (QDELETED(src) || QDELETED(owner) || QDELETED(bodypart_owner))
		return
	if (zombie_infection_timer || werewolf_infection_timer || !ishuman(owner) || !prob(zombie_infection_probability))
		return

	var/mob/living/carbon/human/wound_owner = owner
	wound_owner.attempt_zombie_infection(usr, "wound", zombie_infection_time) //Infect the unit

	severity = WOUND_SEVERITY_BIOHAZARD //Show the wound
	if (bodypart_owner)
		sortTim(bodypart_owner.wounds, GLOBAL_PROC_REF(cmp_wound_severity_dsc))
	return TRUE

/datum/wound/proc/zombie_wound_convert()
	if (QDELETED(src) || QDELETED(owner) || QDELETED(bodypart_owner))
		return FALSE
	if (!ishuman(owner))
		return FALSE

	// Clear conflicting infection timers
	werewolf_infection_timer = null

	// Initiate conversion
	if (istype(owner, /mob/living/carbon/human))
		var/mob/living/carbon/human/wound_owner = owner
		wound_owner.attempt_zombie_infection(src, "wound")
