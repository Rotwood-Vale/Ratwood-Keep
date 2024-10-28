/obj/structure/fog_wall
	name = "heavy fog"
	desc = "Heavy, thick fog. The kind to assure you that you're about to have a bad day."
	icon = 'icons/effects/effects.dmi'
	icon_state = "barriershimmer"
	density = FALSE
	anchored = TRUE
	opacity = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

	var/dissipate_time = 30 MINUTES

/obj/structure/fog_wall/Initialize()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(dissipate_fog)), dissipate_time)

/obj/structure/fog_wall/proc/dissipate_fog()
	qdel(src)

/obj/structure/fog_wall/CanPass(atom/movable/mover)
	if(isliving(mover))
		var/mob/living/M = mover
		if(M.mind.special_role == "Bandit")
			to_chat(M, "<span class=notice>The gods would be angry, were I to pass this now. I can feel them watching.</span>")
			return FALSE
	return TRUE
