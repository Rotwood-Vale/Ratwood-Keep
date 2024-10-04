//AKA cryosleep.

/obj/structure/long_sleep //Shamelessly jury-rigged from the way Fallout13 handles this.
	name = "longsleep mushshroom"
	desc = "A magical mushroom capable of teleporting people to other locations.\n(Drag your sprite onto this to exit the round!)"
	icon = 'icons/roguetown/misc/longsleep.dmi'
	icon_state = "longsleep"
	layer = ABOVE_MOB_LAYER
	density = TRUE
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	var/in_use = FALSE
	light_range = 2
	light_power = 0.80
	light_color = "#ebff33"

/obj/structure/long_sleep/MouseDrop_T(atom/dropping, mob/user)
	. = ..()
	if(!isliving(user) || user.incapacitated())
		return //No ghosts or incapacitated folk allowed to do this.
	if(!ishuman(dropping))
		return //Only humans have job slots to be freed.
	if(in_use) // Someone's already going in.
		return
	var/mob/living/carbon/human/departing_mob = dropping
	var/datum/job/mob_job
	if(departing_mob != user && departing_mob.client)
		to_chat(user, "<span class='warning'>This one retains their free will. It's their choice if they want to leave the round or not.</span>")
		return
	if(alert("Are you sure you want to [departing_mob == user ? "depart the round for good (you" : "send this person away (they"] will be removed from the current round, the job slot freed)?", "Going to Bed", "Confirm", "Cancel") != "Confirm")
		return
	if(user.incapacitated() || QDELETED(departing_mob) || (departing_mob != user && departing_mob.client) || get_dist(src, dropping) > 2 || get_dist(src, user) > 2)
		return //Things have changed since the alert happened.
	user.visible_message("<span class='warning'>[user] [departing_mob == user ? "is trying to teleport using the longsleep mushshroom!" : "is trying to teleport [departing_mob] using the long mushshroom!"]</span>", "<span class='notice'>You [departing_mob == user ? "are trying to go to teleport using the longsleep mushshroom." : "are trying to teleport [departing_mob] using the longsleep mushshroom."]</span>")
	in_use = TRUE
	if(!do_after(user, 50, target = src))
		in_use = FALSE
		return
	in_use = FALSE
	update_icon()
	var/dat = "[key_name(user)] has despawned [departing_mob == user ? "themselves" : departing_mob], job [departing_mob.job], at [AREACOORD(src)]. Contents despawned along:"
	if(departing_mob.mind)
		mob_job = SSjob.GetJob(departing_mob.mind.assigned_role)
		mob_job.current_positions = max(0, mob_job.current_positions - 1)
	if(!length(departing_mob.contents))
		dat += " none."
	else
		var/atom/movable/content = departing_mob.contents[1]
		dat += " [content.name]"
		for(var/i in 2 to length(departing_mob.contents))
			content = departing_mob.contents[i]
			dat += ", [content.name]"
		dat += "."
	if(departing_mob.mind)
		departing_mob.mind.unknow_all_people()
		for(var/datum/mind/MF in get_minds())
			departing_mob.mind.become_unknown_to(MF)
	GLOB.chosen_names -= departing_mob.real_name
	message_admins(dat)
	log_admin(dat)
	if(departing_mob.stat == DEAD)
		departing_mob.visible_message("<span class='notice'>[user] teleports the body of [departing_mob] using the longsleep mushroom. They're someone else's problem now.</span>")
	else
		departing_mob.visible_message("<span class='notice'>[departing_mob == user ? "Out of their own volition, " : "Ushered by [user], "][departing_mob] teleports away using the longsleep mushroom.</span>")
	qdel(departing_mob)

