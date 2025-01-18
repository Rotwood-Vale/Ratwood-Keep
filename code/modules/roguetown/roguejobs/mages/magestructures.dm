
//adapted from forcefields.dm, this needs to be destructible
/obj/structure/arcyne_wall
	desc = "A wall of pure arcyne force."
	name = "Arcyne Wall"
	icon = 'icons/effects/effects.dmi'
	icon_state = "arcynewall"
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')
	opacity = 0
	density = TRUE
	max_integrity = 200
	CanAtmosPass = ATMOS_PASS_DENSITY
	climbable = TRUE
	climb_time = 0

/obj/structure/arcyne_wall/Initialize()
	. = ..()

/obj/structure/arcyne_wall/caster
	var/mob/caster

/obj/structure/arcyne_wall/caster/Initialize(mapload, mob/summoner)
	. = ..()
	caster = summoner

/obj/structure/arcyne_wall/caster/CanPass(atom/movable/mover, turf/target)	//only the caster can move through this freely
	if(mover == caster)
		return TRUE
	if(ismob(mover))
		var/mob/M = mover
		if(M.anti_magic_check(chargecost = 0) || structureclimber == M)
			return TRUE
	return FALSE

/obj/structure/arcyne_wall/greater
	desc = "An immensely strong wall of pure arcyne force."
	name = "Greater Arcyne Wall"
	icon = 'icons/effects/effects.dmi'
	icon_state = "arcynewall"
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')
	max_integrity = 1100
	CanAtmosPass = ATMOS_PASS_DENSITY
	climbable = TRUE
	climb_time = 0

/obj/structure/arcyne_wall/greater/caster
	var/mob/caster

/obj/structure/arcyne_wall/greater/caster/Initialize(mapload, mob/summoner)
	. = ..()
	caster = summoner

/obj/structure/arcyne_wall/greater/caster/CanPass(atom/movable/mover, turf/target)	//only the caster can move through this freely
	if(mover == caster)
		return TRUE
	if(ismob(mover))
		var/mob/M = mover
		if(M.anti_magic_check(chargecost = 0) || structureclimber == M)
			return TRUE
	return FALSE

/obj/structure/mineral_door/wood/deadbolt/arcyne
	desc = "arcyne door"
	icon_state = "arcyne"
	base_state = "arcyne"
	keylock = FALSE
	max_integrity = 2000
	over_state = "arcyneopen"

/obj/structure/mineral_door/wood/deadbolt/arcyne/caster
	var/mob/caster

/obj/structure/mineral_door/wood/deadbolt/arcyne/caster/Initialize(mapload, mob/summoner)
//	icon_state = base_state
	. = ..()
	caster = summoner

/obj/structure/mineral_door/wood/deadbolt/arcyne/caster/attack_right(mob/user)
	..()
	if(door_opened || isSwitchingStates)
		return
	if(user == caster)
		lock_toggle(user)
		to_chat(user, span_warning("The lock to this door is broken."))
		return
	if(brokenstate)
		to_chat(user, span_warning("There isn't much left of this door."))
		return
	if(get_dir(src,user) == lockdir)
		lock_toggle(user)
	else
		to_chat(user, span_warning("The door doesn't lock from this side."))