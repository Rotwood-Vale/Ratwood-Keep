GLOBAL_VAR(king_throne)

/obj/structure/roguethrone
	name = "throne of rockhill"
	desc = "A big throne, to hold the Lord's giant personality. Say 'help' with the crown on your head if you are confused."
	icon = 'icons/roguetown/misc/96x96.dmi'
	icon_state = "throne"
	density = FALSE
	can_buckle = 1
	pixel_x = -32
	max_integrity = 999999
	buckle_lying = FALSE
	obj_flags = NONE
	var/rebel_leader_sit_time = 0
	var/notified_rebel_able = FALSE

/obj/structure/roguethrone/post_buckle_mob(mob/living/M)
	..()
	density = TRUE
	M.set_mob_offsets("bed_buckle", _x = 0, _y = 8)

/obj/structure/roguethrone/post_unbuckle_mob(mob/living/M)
	..()
	density = FALSE
	M.reset_offsets("bed_buckle")

/obj/structure/roguethrone/Initialize()
	. = ..()
	if(GLOB.king_throne == null)
		GLOB.king_throne = src
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/structure/roguethrone/Destroy()
	if(GLOB.king_throne == src)
		GLOB.king_throne = null
	GLOB.lordcolor -= src
	return ..()

/obj/structure/roguethrone/process()
	var/dt = 1 SECONDS
	process_rebel_leader_sit(dt)
	. = ..()

/obj/structure/roguethrone/proc/process_rebel_leader_sit(dt)
	if(!length(buckled_mobs))
		return
	var/mob/living/user = buckled_mobs[1]
	if(user.stat != CONSCIOUS)
		return
	var/datum/antagonist/prebel/P = user.mind?.has_antag_datum(/datum/antagonist/prebel)
	if(!P)
		return
	if(rebel_leader_sit_time == 0)
		to_chat(user, span_notice("Finally, I'm sitting on the throne - when I get more comfortable here I'll be able to announce victory. Other rebels here will help me get comfortable faster."))
	var/time_modifier = 1.0
	/// Increase modifier for every other conscious rebel in view
	for(var/mob/living/living_mob in view(7, loc))
		if(living_mob == user)
			continue
		if(living_mob.stat != CONSCIOUS)
			continue
		var/datum/antagonist/prebel/rebel_antag = living_mob.mind?.has_antag_datum(/datum/antagonist/prebel)
		if(!rebel_antag)
			continue
		time_modifier += REBEL_THRONE_SPEEDUP_PER_PERSON
	rebel_leader_sit_time += (dt * time_modifier)
	if(rebel_leader_sit_time >= REBEL_THRONE_TIME && !notified_rebel_able)
		notified_rebel_able = TRUE
		to_chat(user, span_notice("That's it - time to announce our victory!"))
	
/obj/structure/roguethrone/lordcolor(primary,secondary)
	if(!primary || !secondary)
		return
	var/mutable_appearance/M = mutable_appearance(icon, "throne_primary", -(layer+0.1))
	M.color = primary
	add_overlay(M)
	M = mutable_appearance(icon, "throne_secondary", -(layer+0.1))
	M.color = secondary
	add_overlay(M)
	GLOB.lordcolor -= src

/obj/item/throne_placer
	name = "Portable Throne"
	desc = "A mysterious artifact that conjures a throne."
	icon = 'icons/roguetown/items/gems.dmi'
	icon_state = "diamond_cut" // Use the diamond_cut icon
	w_class = WEIGHT_CLASS_SMALL
	color = "#03f8fc"

/obj/item/throne_placer/attack_self(mob/user)
    if(!HAS_TRAIT(user, TRAIT_NOBLE))
        to_chat(user, span_warning("Only the nobility may wield the power to place a throne!"))
        return

    var/turf/target = get_step(user.loc, user.dir)
    if(!isturf(target))
        to_chat(user, span_warning("You can't place a throne there!"))
        return
    if(locate(/obj/structure/roguethrone) in target)
        to_chat(user, span_warning("There is already a throne there!"))
        return

    // Long use time (5 seconds)
    var/time = 150 // tenths of a second = 5 seconds
    if(!do_after(user, time, target))
        return

    new /obj/structure/roguethrone(target)
    new /obj/structure/roguemachine/titan(target)
    to_chat(user, span_notice("You conjure a throne before you!"))
    playsound(user.loc, 'sound/magic/crystal.ogg', 100, TRUE)
    qdel(src)
