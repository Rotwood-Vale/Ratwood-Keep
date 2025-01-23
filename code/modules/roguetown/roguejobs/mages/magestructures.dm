
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


/obj/structure/well/fountain/mana
	name = "water fountain"
	desc = ""
	icon = 'icons/roguetown/misc/64x64.dmi'
	icon_state = "fountain"
	layer = BELOW_MOB_LAYER
	layer = -0.1

/obj/structure/well/fountain/mana/onbite(mob/user)
	if(isliving(user))
		var/mob/living/L = user
		if(L.stat != CONSCIOUS)
			return
		if(iscarbon(user))
			var/mob/living/carbon/C = user
			if(C.is_mouth_covered())
				return
		playsound(user, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 100, FALSE)
		user.visible_message(span_info("[user] starts to drink from [src]."))
		if(do_after(L, 25, target = src))
			var/list/waterl = list(/datum/reagent/medicine/manapot = 2)
			var/datum/reagents/reagents = new()
			reagents.add_reagent_list(waterl)
			reagents.trans_to(L, reagents.total_volume, transfered_by = user, method = INGEST)
			playsound(user,pick('sound/items/drink_gen (1).ogg','sound/items/drink_gen (2).ogg','sound/items/drink_gen (3).ogg'), 100, TRUE)
		return
	..()
/obj/structure/well/fountain/mana/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/reagent_containers/glass))
		var/obj/item/reagent_containers/glass/W = I
		if(W.reagents.holder_full())
			to_chat(user, span_warning("[W] is full."))
			return
		if(do_after(user, 60, target = src))
			var/list/waterl = list(/datum/reagent/medicine/manapot = 40)
			W.reagents.add_reagent_list(waterl)
			to_chat(user, "<span class='notice'>I fill [W] from [src].</span>")
			playsound(user, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 80, FALSE)
			return
	if(istype(I, /obj/item/reagent_containers/glass))
	else ..()

/obj/machinery/light/rogue/forge/arcane
	icon = 'icons/roguetown/misc/forge.dmi'
	name = "infernal forge"
	desc = "This forge uses cycling magma from an internal core to heat things."
	icon_state = "infernal0"
	base_state = "infernal"
	heat_time = 300

/obj/machinery/light/rogue/forge/arcane/process()
	if(isopenturf(loc))
		var/turf/open/O = loc
		if(IS_WET_OPEN_TURF(O))
			extinguish()
	if(on)
		if(initial(fueluse) > 0)
			if(fueluse > 0)
				fueluse = max(fueluse - 10, 0)
			if(fueluse == 0)//It's litterally powered by arcane lava. It's not gonna run out of fuel.
				fueluse = 4000
		update_icon()