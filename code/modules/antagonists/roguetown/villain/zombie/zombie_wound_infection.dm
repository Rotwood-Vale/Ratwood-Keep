/datum/wound
	/// Zombie infection probability for bites on this wound
	var/zombie_infection_probability = 15
	/// Time taken until zombie infection comes in
	var/zombie_infection_time = 2 MINUTES
	/// Actual infection timer
	var/zombie_infection_timer

/datum/wound/proc/zombie_infect_attempt()
	if(QDELETED(src) || QDELETED(owner) || QDELETED(bodypart_owner))
		return
	if(zombie_infection_timer || werewolf_infection_timer || !ishuman(owner) || !prob(zombie_infection_probability))
		return
	var/mob/living/carbon/human/human_owner = owner
	var/datum/antagonist/zombie/zombie_antag = human_owner.zombie_check()
	if(!zombie_antag)
		return
	if(human_owner.stat >= DEAD) //do shit the natural way i guess
		return

	
	to_chat(human_owner, span_danger("I feel horrible... REALLY horrible..."))
	human_owner.mob_timers["puke"] = world.time
	human_owner.vomit(1, blood = TRUE, stun = FALSE)
	zombie_infection_timer = addtimer(CALLBACK(src, PROC_REF(wake_zombie)), zombie_infection_time, TIMER_STOPPABLE)
	severity = WOUND_SEVERITY_BIOHAZARD
	if(bodypart_owner)
		sortTim(bodypart_owner.wounds, GLOBAL_PROC_REF(cmp_wound_severity_dsc))
	return zombie_antag

/datum/wound/proc/wake_zombie() // this is only called when zombies are turned via wounds
	if(QDELETED(src) || QDELETED(owner) || QDELETED(bodypart_owner))
		return FALSE
	if(!ishuman(owner))
		return FALSE
	werewolf_infection_timer = null
	var/datum/antagonist/zombie/zombie_antag = owner.mind?.has_antag_datum(/datum/antagonist/zombie)
	if(!zombie_antag || zombie_antag.has_turned)
		return FALSE
	owner.flash_fullscreen("redflash3")
	to_chat(owner, span_danger("It hurts... Is this really the end for me?"))
	owner.emote("scream") // heres your warning to others bro
	owner.Knockdown(1)
	zombie_antag.wake_zombie(infected_wake = TRUE, converted = TRUE)
	return TRUE
