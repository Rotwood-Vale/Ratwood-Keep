/obj/structure/fog_wall
	name = "heavy fog"
	desc = "Heavy, thick fog. The kind to assure you that you're about to have a bad day."
	icon = 'icons/effects/effects.dmi'
	icon_state = "nothing"
	density = FALSE
	anchored = TRUE
	opacity = FALSE//from TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

	var/dissipate_time = 30 MINUTES

GLOBAL_LIST_EMPTY(fogwall_warns) // to avoid spamming the bandit's chat

/obj/structure/fog_wall/Initialize()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(dissipate_fog)), dissipate_time)
	add_cloak()

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

/datum/atom_hud/alternate_appearance/basic/fog/New()
	..()
	for(var/mob in GLOB.player_list)
		if(mobShouldSee(mob))
			add_hud_to(mob)

/obj/structure/fog_wall/CanPass(atom/movable/AM)
	if(AM in fogwall_warns)
		return FALSE
	if(ishuman(AM))
		var/mob/living/human/M = AM
		if(M.mind?.special_role == "Bandit")
			to_chat(M, "<span class=notice>The gods would be angry, were I to pass this now. I can feel them watching.</span>")
			GLOB.fogwall_warns += M
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(clear_fogwall_warning), M), 20 SECONDS)
			return FALSE
	return TRUE

/proc/clear_fogwall_warning(mob/target)
	if(!QDELETED(target))
		GLOB.fogwall_warns -= target
