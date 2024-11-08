/obj/structure/fog_wall
	name = "heavy fog"
	desc = "Heavy, thick fog. The kind to assure you that you're about to have a bad day."
	icon = 'icons/effects/effects.dmi'
	icon_state = "nothing"
	density = FALSE
	anchored = TRUE
	opacity = FALSE//from TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	var/walltimer // tracks this wall's specific timer

#define FOG_DISSIPATE_TIME_MAX 30 MINUTES
GLOBAL_LIST_EMPTY(fogwall_warns) // to avoid spamming the bandit's chat

/obj/structure/fog_wall/Initialize()
	. = ..()
	walltimer = addtimer(CALLBACK(src, PROC_REF(dissipate_fog)), FOG_DISSIPATE_TIME_MAX, TIMER_STOPPABLE)
	add_cloak()

/obj/structure/fog_wall/Destroy()
	deltimer(walltimer)
	walltimer = null
	return ..()

/obj/structure/fog_wall/proc/dissipate_fog()
	qdel(src)

/obj/structure/fog_wall/proc/add_cloak()
	var/image/I = image(icon = 'icons/effects/effects.dmi', icon_state = "smoke", loc = src)
	I.override = TRUE
	add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/fog, "fog", I)

/datum/atom_hud/alternate_appearance/basic/fog/mobShouldSee(mob/M)
	if(M.mind?.special_role == "Bandit")
		return TRUE
	return FALSE

/obj/structure/fog_wall/proc/describe_time()
	var/timedesc = "... hmm, I'm not sure"
	switch(timeleft(walltimer))
		if(1 to 3 MINUTES)
			timedesc = " nearly cleared"
		if(3 MINUTES to 10 MINUTES)
			timedesc = " fairly dense"
		if(10 MINUTES to 20 MINUTES)
			timedesc = " considerably heavy"
		if(20 MINUTES to FOG_DISSIPATE_TIME_MAX)
			timedesc = " impenetrably thick"
	return timedesc

/obj/structure/fog_wall/examine(mob/user)
	. = ..()
	. += span_info("Currently, it looks to be[span_notice(describe_time())].")

/datum/atom_hud/alternate_appearance/basic/fog/New()
	..()
	for(var/mob in GLOB.player_list)
		if(mobShouldSee(mob))
			add_hud_to(mob)

/obj/structure/fog_wall/CanPass(atom/movable/AM)
	if(AM in GLOB.fogwall_warns)
		return FALSE
	if(isliving(AM))
		var/mob/living/M = AM
		if(M.mind?.special_role == "Bandit")
			to_chat(M, span_warning("The fog's too thick for me to pass through right now.") + span_info("\n\
								Currently, it looks to be[span_notice(describe_time())]."))
			GLOB.fogwall_warns += M
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(clear_fogwall_warning), M), 40 SECONDS)
			return FALSE
	return TRUE

/proc/clear_fogwall_warning(mob/target)
	if(target)
		GLOB.fogwall_warns -= target
