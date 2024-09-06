
/obj/structure/fluff/testportal
	name = "portal"
	icon_state = "shitportal"
	icon = 'icons/roguetown/misc/structure.dmi'
	density = FALSE
	anchored = TRUE
	layer = BELOW_MOB_LAYER
	max_integrity = 0
	var/aportalloc = "a"

/obj/structure/fluff/testportal/Initialize()
	name = aportalloc
	..()

/obj/structure/fluff/testportal/attack_hand(mob/user)
	var/fou
	for(var/obj/structure/fluff/testportal/T in shuffle(GLOB.testportals))
		if(T.aportalloc == aportalloc)
			if(T == src)
				continue
			to_chat(user, "<b>I teleport to [T].</b>")
			playsound(src, 'sound/misc/portal_enter.ogg', 100, TRUE)
			user.forceMove(T.loc)
			fou = TRUE
			break
	if(!fou)
		to_chat(user, "<b>There is no portal connected to this. Report it as a bugs.</b>")
	. = ..()


/obj/structure/fluff/traveltile
	name = "travel"
	icon_state = "travel"
	icon = 'icons/turf/roguefloor.dmi'
	density = FALSE
	anchored = TRUE
	layer = ABOVE_OPEN_TURF_LAYER
	max_integrity = 0
	alpha = 190
	var/aportalid = "REPLACETHIS"
	var/aportalgoesto = "REPLACETHIS"
	var/aallmig
	var/required_trait = null

/obj/structure/fluff/traveltile/Initialize()
	GLOB.traveltiles += src
	. = ..()

/obj/structure/fluff/traveltile/Destroy()
	GLOB.traveltiles -= src
	. = ..()

/obj/structure/fluff/traveltile/proc/get_other_end_turf()
	if(!aportalgoesto)
		return null
	for(var/obj/structure/fluff/traveltile/travel in shuffle(GLOB.traveltiles))
		if(travel == src)
			continue
		if(travel.aportalid != aportalgoesto)
			continue
		return get_turf(travel)
	return null

/obj/structure/fluff/traveltile/attack_ghost(mob/dead/observer/user)
	if(!user.Adjacent(src))
		return
	var/turf/target_loc = get_other_end_turf()
	if(!target_loc)
		to_chat(user, "<b>It is a dead end.</b>")
		return
	user.forceMove(target_loc)

/obj/structure/fluff/traveltile/attack_hand(mob/user)
	if(!isliving(user))
		return ..()
	user_try_travel(user)

/obj/structure/fluff/traveltile/proc/can_go(atom/movable/AM)
	. = TRUE
	if(AM.pulledby)
		return FALSE
	if(AM.recent_travel)
		if(world.time < AM.recent_travel + 15 SECONDS)
			. = FALSE
	if(. && required_trait && isliving(AM))
		var/mob/living/L = AM
		if(HAS_TRAIT(L, required_trait))
			return TRUE
		else
			to_chat(L, "<b>It is a dead end.</b>")
			return FALSE

/atom/movable
	var/recent_travel = 0

/obj/structure/fluff/traveltile/Crossed(atom/movable/AM)
	. = ..()
	if(!isliving(AM))
		return
	var/mob/living/living = AM
	if(living.stat != CONSCIOUS)
		return
	if(living.incapacitated())
		return
	// if it's in the same chain, it will actually stop a pulled thing being pulled, bandaid solution with a timer
	addtimer(CALLBACK(src, PROC_REF(user_try_travel), living), 1)

/obj/structure/fluff/traveltile/proc/user_try_travel(mob/living/user)
	var/turf/target_loc = get_other_end_turf()
	if(!target_loc)
		to_chat(user, "<b>It is a dead end.</b>")
		return
	if(!can_go(user))
		return
	if(!do_after(user, 5 SECONDS, FALSE, target = src))
		return
	if(!can_go(user))
		return
	if(user.pulling)
		user.pulling.recent_travel = world.time
	user.recent_travel = world.time
	reveal_travel_trait_to_others(user)
	mob_move_travel_z_level(user, target_loc)

/obj/structure/fluff/traveltile/proc/reveal_travel_trait_to_others(mob/living/user)
	if(!required_trait)
		return
	if(!HAS_TRAIT(user, required_trait))
		return
	for(var/mob/living/carbon/human/H in hearers(6,src))
		if(!HAS_TRAIT(H, required_trait))
			to_chat(H, "<b>I discover a well hidden entrance</b>")
			ADD_TRAIT(H, required_trait, TRAIT_GENERIC)

/obj/structure/fluff/traveltile/bandit

/obj/structure/fluff/traveltile/vampire

/obj/structure/fluff/traveltile/dungeon
    name = "gate"
    desc = "This gate's enveloping darkness is so oppressive you dread to step through it."
    icon = 'icons/roguetown/misc/portal.dmi'
    icon_state = "portal"
    density = FALSE
    anchored = TRUE
    max_integrity = 0
    bound_width = 96
    appearance_flags = NONE
    opacity = FALSE
    var/turf/target_location

    /obj/structure/fluff/traveltile/dungeon/Initialize()
        . = ..()
        target_location = get_other_end_turf()

    /obj/structure/fluff/traveltile/dungeon/Crossed(atom/movable/AM)
        . = ..()
        if(!isliving(AM))
            return
        var/mob/living/L = AM
        if(L.stat != CONSCIOUS || L.incapacitated())
            return
        addtimer(CALLBACK(src, .proc/try_teleport, L), 1)

    /obj/structure/fluff/traveltile/dungeon/Uncross(atom/movable/AM, atom/newloc)
        . = ..()
        if(!isliving(AM))
            return TRUE
        var/mob/living/L = AM
        if(is_bandit_locked(L) && newloc == target_location)
            to_chat(L, "<span class='warning'>You are locked out of the dungeon for the first 30 minutes.</span>")
            return FALSE
        return TRUE

    /obj/structure/fluff/traveltile/dungeon/proc/try_teleport(mob/living/user)
        if(!can_go(user))
            return
        if(is_bandit_locked(user))
            to_chat(user, "<span class='warning'>You are locked out of the dungeon for the first 30 minutes.</span>")
            return
        if(!target_location)
            to_chat(user, "<span class='warning'>It is a dead end.</span>")
            return
        if(!do_after(user, 5 SECONDS, FALSE, target = src))
            return
        if(!can_go(user))
            return
        if(user.pulling)
            user.pulling.recent_travel = world.time
        user.recent_travel = world.time
        reveal_travel_trait_to_others(user)
        mob_move_travel_z_level(user, target_location)

    /obj/structure/fluff/traveltile/dungeon/proc/is_bandit_locked(mob/living/user)
        if(istype(user, /mob/living/carbon/human))
            var/mob/living/carbon/human/H = user
            if(H.mind && H.mind.has_antag_datum(/datum/antagonist/bandit))
                var/datum/antagonist/bandit/B = H.mind.has_antag_datum(/datum/antagonist/bandit)
                return B.dungeon_locked
        return FALSE
