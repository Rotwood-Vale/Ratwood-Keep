
/obj/structure/closet/dirthole
	name = "hole"
	desc = "Just a small hole..."
	icon_state = "hole1"
	icon = 'icons/turf/roguefloor.dmi'
	var/stage = 1
	var/mutable_appearance/abovemob
	var/turf/open/floor/rogue/dirt/mastert
	var/faildirt = 0
	mob_storage_capacity = 3
	allow_dense = TRUE
	opened = TRUE
	density = FALSE
	anchored = TRUE
	can_buckle = FALSE
	max_integrity = 0
	buckle_lying = 90
	layer = 2.8

/obj/structure/closet/dirthole/grave
	desc = "A hole big enough for a coffin."
	stage = 3
	faildirt = 3
	icon_state = "grave"

/obj/structure/closet/dirthole/closed
	desc = "A mound of dirt with something below."
	stage = 4
	faildirt = 3
	climb_offset = 10
	icon_state = "gravecovered"
	opened = FALSE
	locked = TRUE

/obj/structure/closet/dirthole/closed/loot/Initialize()
	. = ..()
	lootroll = rand(1,4)

/obj/structure/closet/dirthole/closed/loot
	var/looted = FALSE
	var/lootroll = 0

/obj/structure/closet/dirthole/closed/loot/open()
	if(!looted)
		looted = TRUE
		switch(lootroll)
			if(1)
				new /mob/living/carbon/human/species/skeleton/npc(mastert)
			if(2)
				new /obj/structure/closet/crate/chest/lootbox(mastert)
	..()

/obj/structure/closet/dirthole/closed/loot/examine(mob/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_SOUL_EXAMINE))
		if(lootroll == 1)
			. += span_warning("Better let this one sleep.")

/obj/structure/closet/dirthole/insertion_allowed(atom/movable/AM)
	if(istype(AM, /obj/structure/closet/crate/chest) || istype(AM, /obj/structure/closet/burial_shroud))
		for(var/mob/living/M in contents)
			return FALSE
	if(istype(AM, /obj/structure/closet/crate/coffin))
		return TRUE
	. = ..()

/obj/structure/closet/dirthole/toggle(mob/living/user)
	return

/obj/structure/closet/dirthole/attackby(obj/item/attacking_item, mob/user, params)
	if(!istype(attacking_item, /obj/item/rogueweapon/shovel))
		return ..()
	var/obj/item/rogueweapon/shovel/attacking_shovel = attacking_item
	if(user.used_intent.type != /datum/intent/shovelscoop)
		return

	if(attacking_shovel.heldclod)
		playsound(loc,'sound/items/empty_shovel.ogg', 100, TRUE)
		QDEL_NULL(attacking_shovel.heldclod)
		if(stage == 3) //close grave
			stage = 4
			climb_offset = 10
			locked = TRUE
			close()
			var/founds
			for(var/atom/A in contents)
				founds = TRUE
				break
			if(!founds)
				stage = 2
				climb_offset = 0
				locked = FALSE
				open()
			update_icon()
		else if(stage < 4)
			stage--
			climb_offset = 0
			update_icon()
			if(stage == 0)
				qdel(src)
		attacking_shovel.update_icon()
		return
	else
		if(stage == 3)
			var/turf/underT = get_step_multiz(src, DOWN)
			if(underT && isopenturf(underT) && mastert)
				attacking_shovel.heldclod = new(attacking_shovel)
				attacking_shovel.update_icon()
				playsound(mastert,'sound/items/dig_shovel.ogg', 100, TRUE)
				mastert.ChangeTurf(/turf/open/transparent/openspace)
				return
//					for(var/D in GLOB.cardinals)
//						var/turf/T = get_step(mastert, D)
//						if(T)
//							if(istype(T, /turf/open/water))
//								attacking_shovel.heldclod = new(attacking_shovel)
//								attacking_shovel.update_icon()
//								playsound(mastert,'sound/items/dig_shovel.ogg', 100, TRUE)
//								mastert.ChangeTurf(T.type, flags = CHANGETURF_INHERIT_AIR)
//								return
			to_chat(user, span_warning("I can't dig myself any deeper."))
			return
		var/used_str = 10
		if(iscarbon(user))
			var/mob/living/carbon/C = user
			if(C.domhand)
				used_str = C.get_str_arms(C.used_hand)
			C.stamina_add(max(60 - (used_str * 5), 1))
		if(stage < 3)
			if(faildirt < 2)
				if(prob(used_str * 5))
					stage++
				else
					faildirt++
			else
				stage++
		if(stage == 4)
			stage = 3
			climb_offset = 0
			locked = FALSE
			open()
			for(var/obj/structure/gravemarker/G in loc)
				qdel(G)
				if(isliving(user))
					var/mob/living/L = user
					L.apply_status_effect(/datum/status_effect/debuff/cursed)
		update_icon()
		attacking_shovel.heldclod = new(attacking_shovel)
		attacking_shovel.update_icon()
		playsound(loc,'sound/items/dig_shovel.ogg', 100, TRUE)
		return

/datum/status_effect/debuff/cursed
	id = "cursed"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/cursed
	effectedstats = list("fortune" = -3)
	duration = 10 MINUTES

/atom/movable/screen/alert/status_effect/debuff/cursed
	name = "Cursed"
	desc = "I feel... unlucky."
	icon_state = "debuff"

/obj/structure/closet/dirthole/MouseDrop_T(atom/movable/O, mob/living/user)
	var/turf/T = get_turf(src)
	if(istype(O, /obj/structure/closet/crate/coffin))
		O.forceMove(T)
	if(!istype(O) || O.anchored || istype(O, /atom/movable/screen))
		return
	if(!istype(user) || user.incapacitated() || !(user.mobility_flags & MOBILITY_STAND))
		return
	if(!Adjacent(user) || !user.Adjacent(O))
		return
	if(user == O) //try to climb onto it
		return ..()
	if(!opened)
		return
	if(!isturf(O.loc))
		return

	var/actuallyismob = 0
	if(isliving(O))
		actuallyismob = 1
	else if(!isitem(O))
		return
	var/list/targets = list(O, src)
	add_fingerprint(user)
	user.visible_message(span_warning("[user] [actuallyismob ? "tries to ":""]stuff [O] into [src]."), \
				 	 	span_warning("I [actuallyismob ? "try to ":""]stuff [O] into [src]."), \
				 	 	span_hear("I hear clanging."))
	if(actuallyismob)
		if(do_after_mob(user, targets, 40))
			user.visible_message(span_notice("[user] stuffs [O] into [src]."), \
							 	 span_notice("I stuff [O] into [src]."), \
							 	 span_hear("I hear a loud bang."))
			O.forceMove(T)
			user_buckle_mob(O, user)
	else
		O.forceMove(T)
	return 1

/obj/structure/closet/dirthole/take_contents()
	var/atom/L = drop_location()
	..()
	for(var/obj/structure/closet/crate/coffin/C in L)
		if(C != src && insert(C) == -1)
			break


/obj/structure/closet/dirthole/close(mob/living/user)
	if(!opened || !can_close(user))
		return FALSE
	take_contents()
	opened = FALSE
//	update_icon()
	return TRUE

/obj/structure/closet/dirthole/dump_contents()
	..()

/obj/structure/closet/dirthole/open(mob/living/user)
	if(opened)
		return
	opened = TRUE
	dump_contents()
	update_icon()
	return 1


/obj/structure/closet/dirthole/update_icon()
	switch(stage)
		if(1)
			name = "hole"
			icon_state = "hole1"
			can_buckle = FALSE
		if(2)
			name = "hole"
			icon_state = "hole2"
			can_buckle = FALSE
		if(3)
			name = "pit"
			icon_state = "grave"
			can_buckle = TRUE
		if(4)
			name = "grave"
			icon_state = "gravecovered"
			can_buckle = FALSE
	update_abovemob()

/obj/structure/closet/dirthole/Initialize()
    abovemob = mutable_appearance('icons/turf/roguefloor.dmi', "grave_above")
    abovemob.layer = ABOVE_MOB_LAYER
    update_icon()
    var/turf/open/floor/rogue/dirt/T = loc
    if(istype(T))
        mastert = T
        T.holie = src
        if(T.muddy)
            if(prob(55))
                if(prob(20))
                    if(prob(30))
                        new /obj/item/natural/worms/grubs(T)
                    else
                        new /obj/item/natural/worms/leech(T)
                else
                    new /obj/item/natural/worms(T)
        else
            if(prob(23))
                new /obj/item/natural/stone(T)
    return ..()

/obj/structure/closet/dirthole/Destroy()
	QDEL_NULL(abovemob)
	if(mastert && mastert.holie == src)
		mastert.holie = null
	return ..()

/obj/structure/closet/dirthole/post_buckle_mob(mob/living/M)
	. = ..()
	update_abovemob()

/obj/structure/closet/dirthole/proc/update_abovemob()
	if(has_buckled_mobs() && stage == 3)
		add_overlay(abovemob)
	else
		cut_overlay(abovemob)

/obj/structure/closet/dirthole/post_unbuckle_mob()
	. = ..()
	update_abovemob()


/obj/structure/spike_pit
	name = "spike pit"
	desc = "A hole filled with sharp wooden ends that protrude upwards."
	icon_state = "spike_pit"
	can_buckle = TRUE
	icon = 'icons/turf/roguefloor.dmi'
	density = FALSE
	anchored = TRUE
	can_buckle = FALSE
	max_integrity = 0
	buckle_lying = 90
	layer = 2.8

/obj/structure/spike_pit/Crossed(atom/movable/AM)
	var/hitsound = pick('sound/combat/hits/bladed/genstab (1).ogg', 'sound/combat/hits/bladed/genstab (2).ogg', 'sound/combat/hits/bladed/genstab (3).ogg')
	// TO DO: figure out how to either make jumping its own special proc
	// Or read throw_at to understand how to parse it here to allow jumping
	
	if(isliving(AM))
		var/mob/living/L = AM
		if(L.movement_type & (FLYING|FLOATING)) //don't close the trap if they're flying/floating over it.
			return ..()

	if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		var/area = BODY_ZONE_L_LEG
		if(prob(50))
			area = BODY_ZONE_R_LEG
		var/obj/item/bodypart/affecting = H.get_bodypart(check_zone(area))
		if(!affecting) //if somehow no legs
			affecting =  H.get_bodypart(check_zone(BODY_ZONE_CHEST))

		//Wounds bleed pretty slow alone so this is more to be annoying than dangerous.
		var/damage = 30
		affecting.receive_damage(damage)
		var/datum/wound/choice = /datum/wound/puncture
		if(prob(25))
			choice = /datum/wound/puncture/large
		affecting.add_wound(choice)
		H.forceMove(drop_location())

		H.emote("painscream")
		var/delay = 20 - H.STACON // Might be too long, if you figure out a better answer let me know.
		delay = delay * 10
		//H.Paralyze(delay)
		buckle_mob(H, TRUE)
		H.clear_alert("buckled") //easiest way to hide this option. Have to click the pit with a free hand to get loose.
		playsound(src.loc, hitsound, 100)
		return

	if(istype(AM, /mob/living/simple_animal))
		var/mob/living/simple_animal/L = AM
		L.adjustHealth(40)
		L.Paralyze(40)
		buckle_mob(L, TRUE)
		L.get_sound("pain")
		playsound(src.loc, hitsound, 100)
		return

	. = ..()

/obj/structure/spike_pit/attackby(obj/item/I, mob/user, params)
	
	if(istype(I, /obj/item/rogueweapon/shovel))
		playsound(loc,'sound/items/dig_shovel.ogg', 100, TRUE)
		to_chat(user, span_info("I start covering up \the [name]..."))
		if(do_after(user, 5 SECONDS, src))
			playsound(loc,'sound/items/empty_shovel.ogg', 100, TRUE)
			qdel(src)
			return
	. = ..()

obj/structure/spike_pit/attack_hand(mob/user)
	
	if(has_buckled_mobs())
		var/person = buckled_mobs[1].name
		if(user == buckled_mobs[1])
			person = "themself"
		user.visible_message(span_warning("[user.name] starts to pull [person] off \the [name]..."))
		if(do_after(user, 3 SECONDS))
			unbuckle_mob(buckled_mobs[1], TRUE)
			user.visible_message(span_warning("[user.name] pulls [person] out of the spikes."))

	. = ..()
	

/datum/crafting_recipe/roguetown/spike_pit
	name = "spike pit - (3 stakes; SHOVEL; BEGINNER)"
	result = list( /obj/structure/spike_pit )
	tools = list( /obj/item/rogueweapon/shovel = 1 )
	reqs = list( /obj/item/grown/log/tree/stake = 3)

/datum/crafting_recipe/roguetown/spike_pit/TurfCheck(mob/user, turf/T)
	var/turf/to_check = get_step(user.loc, user.dir)
	if(!istype(to_check, /turf/open/floor/rogue/dirt))
		to_chat(user, span_info("I need a dirt floor to do this."))
		return FALSE
	return TRUE