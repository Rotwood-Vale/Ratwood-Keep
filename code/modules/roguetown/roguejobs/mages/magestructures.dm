
/obj/structure/fluff/walldeco/mageguild
	name = "Mage's Guild"
	icon_state = "mageguild"

/obj/effect/turf_decal/magedecal
	icon = 'icons/effects/96x96.dmi'
	icon_state = "imbuement2"

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
s
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
	name = "mana fountain"
	desc = ""
	icon = 'icons/roguetown/misc/64x64.dmi'
	icon_state = "manafountain"
	layer = BELOW_MOB_LAYER
	pixel_x = -16
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

/obj/structure/leyline
	name = "inactive leyline"
	desc = "A curious arrangement of stones."
	icon = 'icons/effects/effects.dmi'
	icon_state = "inactiveleyline"
	var/active = FALSE
	var/mob/living/guardian = null
	anchored = TRUE
	density = FALSE
	var/time_between_uses = 12000
	var/last_process = 0
/obj/structure/leyline/Initialize()
	.=..()
	last_process = world.time

/obj/structure/leyline/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(last_process + time_between_uses > world.time)
		to_chat(user, span_notice("The leyline appears to be drained of energy."))
		return
	if(!isarcyne(user))
		if(!active)
			to_chat(user, span_notice("I wave a hand through the circle of rocks. Nothing happens."))
			return
		else
			if(prob(60) && (!guardian))
				if(do_after(user, 60))
					to_chat(user, span_notice("I reach out towards the active leyline, peering within- and something peers back!"))
					sleep(2 SECONDS)
					guardian = new /mob/living/simple_animal/hostile/retaliate/rogue/leylinelycan(src.loc, src)
					src.visible_message(span_danger("[src] emerges from the leyline rupture!"))
			else
				if(do_after(user, 60))
					to_chat(user, span_notice("I reach out towards the active leyline, and it shatters! A large, usable piece of it drops at your feet."))
					new /obj/item/natural/leyline(user.loc)
					active = FALSE
					icon_state = "inactiveleyline"
					name = "inactive leyline"
					desc = "A curious arrangement of stones."
					update_icon()
					last_process = world.time

	else
		if(!active)
			to_chat(user, span_notice("I wave a hand through the circle of rocks, and pulse my arcyne magic through it. The leyline activates!"))
			icon_state = "leylinerupture"
			name = "active leyline"
			desc = "An active tear into the leyline. It gives off plenty of energy"
			active = TRUE
			update_icon()
		else
			if(guardian)
				if(do_after(user, 60))
					to_chat(user, span_danger("The leyline is abuzz with energy in a feedback from the [guardian]! It lashes out at me!"))
					user.electrocute_act(10)

			if(prob(60) && (!guardian))
				if(do_after(user, 60))
					to_chat(user, span_notice("I reach out towards the active leyline, peering within- and something peers back!"))
					sleep(2 SECONDS)
					guardian = new /mob/living/simple_animal/hostile/retaliate/rogue/leylinelycan(src.loc, src)
					src.visible_message(span_danger("[guardian] emerges from the leyline rupture!"))

			else
				if(do_after(user, 60))
					to_chat(user, span_notice("I reach out towards the active leyline, and it shatters! A large, usable piece of it drops at your feet."))
					new /obj/item/natural/leyline(user.loc)
					active = FALSE
					icon_state = "inactiveleyline"
					name = "inactive leyline"
					desc = "A curious arrangement of stones."
					update_icon()
					last_process = world.time

/obj/structure/manaflower
	name = "manaflower"
	desc = ""
	icon = 'icons/roguetown/misc/crops.dmi'
	icon_state = "manabloom"
	color = null
	layer = BELOW_MOB_LAYER
	max_integrity = 60
	density = FALSE
	debris = list(/obj/item/natural/fibers = 1, /obj/item/reagent_containers/food/snacks/grown/rogue/manabloom = 1)

/obj/structure/manaflower/attack_hand(mob/living/carbon/human/user)
	playsound(src.loc, "plantcross", 80, FALSE, -1)
	user.visible_message(span_warning("[user] harvests [src]."))
	if(do_after(user, 3 SECONDS, target = src))
		new /obj/item/reagent_containers/food/snacks/grown/rogue/manabloom (get_turf(src))
		qdel(src)
/obj/structure/manaflower/Crossed(mob/living/carbon/human/H)
	playsound(src.loc, "plantcross", 80, FALSE, -1)


/obj/structure/voidstoneobelisk
	name = "Voidstone Obelisk"
	desc = "A smooth unnatural Obelisk, looking at it provides the sense of unease."
	icon = 'icons/mob/summonable/32x32.dmi'
	icon_state = "dormantobelisk"
	anchored = TRUE
	density = TRUE

/obj/structure/voidstoneobelisk/attacked_by(obj/item/I, mob/living/user)
	user.changeNext_move(CLICK_CD_MELEE)
	var/newforce = get_complex_damage(I, user, blade_dulling)
	if(!newforce)
		return 0
	if(newforce < damage_deflection)
		return 0
	if(user.used_intent.no_attack)
		return 0
	log_combat(user, src, "attacked", I)
	var/verbu = "hits"
	verbu = pick(user.used_intent.attack_verb)
	if(newforce > 1)
		if(user.stamina_add(5))
			user.visible_message(span_danger("[user] [verbu] [src] with [I]!"))
	user.visible_message(span_danger("[src] comes to life, archaic stone shifting into position!"))
	sleep(2)
	new /mob/living/simple_animal/hostile/retaliate/rogue/voidstoneobelisk(src.loc)
	qdel(src)

/obj/structure/voidstoneobelisk/attack_hand(mob/living/carbon/human/user)
	to_chat(user, span_notice("You reach out to touch the abberant obelisk..."))
	if(do_after(user, 3 SECONDS, target = src))
		user.visible_message(span_danger("[src] comes to life, archaic stone shifting into position!"))
		sleep(2)
		new /mob/living/simple_animal/hostile/retaliate/rogue/voidstoneobelisk(src.loc)
		qdel(src)