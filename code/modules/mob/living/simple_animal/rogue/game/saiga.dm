

//the saiga

/mob/living/simple_animal/hostile/retaliate/rogue/saiga
	name = "saiga doe"
	desc = ""
	icon = 'icons/roguetown/mob/monster/saiga.dmi'
	icon_state = "saiga"
	icon_living = "saiga"
	icon_dead = "saiga_dead"
	icon_gib = "saiga_gib"
	gender = FEMALE
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	emote_see = list("looks around.", "chews some leaves.")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	move_to_delay = 8
	animal_species = /mob/living/simple_animal/hostile/retaliate/rogue/saiga/saigabuck
	butcher_results = list(
						/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 4,
						/obj/item/reagent_containers/food/snacks/fat = 2,
						/obj/item/natural/hide = 4,
						/obj/item/natural/bundle/bone/full = 1,
						)
	base_intents = list(/datum/intent/simple/headbutt)
	health = 156
	maxHealth = 156
	food_type = list(
				/obj/item/reagent_containers/food/snacks/grown/wheat,
				/obj/item/reagent_containers/food/snacks/grown/oat,
				/obj/item/reagent_containers/food/snacks/grown/apple,
				)
	tame_chance = 25
	bonus_tame_chance = 15
	footstep_type = FOOTSTEP_MOB_SHOE
	pooptype = /obj/item/natural/poo/horse
	faction = list("saiga")
	attack_verb_continuous = "headbutts"
	attack_verb_simple = "headbutt"
	melee_damage_lower = 10
	melee_damage_upper = 25
	retreat_distance = 10
	minimum_distance = 10
	STASPD = 15
	STACON = 8
	STASTR = 12
	childtype = list(
				/mob/living/simple_animal/hostile/retaliate/rogue/saiga/saigakid = 70,
				/mob/living/simple_animal/hostile/retaliate/rogue/saiga/saigaboy = 30,
				)
	pixel_x = -8
	attack_sound = list('sound/vo/mobs/saiga/attack (1).ogg','sound/vo/mobs/saiga/attack (2).ogg')
	can_buckle = TRUE
	buckle_lying = 0
	can_saddle = TRUE
	aggressive = 1
	remains_type = /obj/effect/decal/remains/saiga
	var/obj/item/inventory_neck

/mob/living/simple_animal/hostile/retaliate/rogue/saiga/saigakid
	name = "saiga calf"
	desc = ""
	icon_state = "saigakid"
	icon_living = "saigakid"
	icon_dead = "saigakid_dead"
	icon_gib = "saigakid_gib"
	animal_species = null
	butcher_results = list(
					/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 1,
					/obj/item/natural/bone = 3,
					)
	health = 20
	pass_flags = PASSTABLE | PASSMOB
	mob_size = MOB_SIZE_SMALL
	maxHealth = 20
	melee_damage_lower = 1
	melee_damage_upper = 6
	STACON = 5
	STASTR = 5
	STASPD = 5
	defprob = 50
	pixel_x = -16
	adult_growth = /mob/living/simple_animal/hostile/retaliate/rogue/saiga
	tame = TRUE
	can_buckle = FALSE
	aggressive = 1

/mob/living/simple_animal/hostile/retaliate/rogue/saiga/saigabuck
	name = "saiga buck"
	desc = ""
	icon_state = "buck"
	icon_living = "buck"
	icon_dead = "buck_dead"
	icon_gib = "buck_gib"
	gender = MALE
	emote_see = list("stares.")
	speak_chance = 1
	turns_per_move = 3
	see_in_dark = 6
	move_to_delay = 8
	butcher_results = list(
					/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 4,
					/obj/item/reagent_containers/food/snacks/fat = 1,
					/obj/item/natural/hide = 4,
					/obj/item/natural/bundle/bone/full = 1,
					/obj/item/clothing/head/roguetown/helmet/leather/saiga = 1,
					)
	faction = list("saiga")
	attack_verb_continuous = "headbutts"
	attack_verb_simple = "headbutt"
	health = 400
	maxHealth = 400
	melee_damage_lower = 60
	melee_damage_upper = 90
	environment_smash = ENVIRONMENT_SMASH_NONE
	retreat_distance = 0
	minimum_distance = 0
	retreat_health = 0.3
	milkies = FALSE //what the fuck
	STACON = 15
	STASTR = 12
	STASPD = 12
	attack_sound = list('sound/vo/mobs/saiga/attack (1).ogg','sound/vo/mobs/saiga/attack (2).ogg')
	buckle_lying = 0
	tame_chance = 25
	bonus_tame_chance = 15
	aggressive = 1
	remains_type = /obj/effect/decal/remains/saiga

/mob/living/simple_animal/hostile/retaliate/rogue/saiga/saigaboy
	name = "saiga calf"
	desc = ""
	gender = MALE
	icon_state = "saigaboy"
	icon_living = "saigaboy"
	icon_dead = "saigaboy_dead"
	icon_gib = "saigaboy_gib"
	animal_species = null
	butcher_results = list(
					/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 1,
					/obj/item/natural/bone = 3,
					)
	health = 20
	maxHealth = 20
	pass_flags = PASSTABLE | PASSMOB
	mob_size = MOB_SIZE_SMALL
	milkies = FALSE
	melee_damage_lower = 1
	melee_damage_upper = 6
	STACON = 5
	STASTR = 5
	STASPD = 5
	adult_growth = /mob/living/simple_animal/hostile/retaliate/rogue/saiga/saigabuck
	tame = TRUE
	can_buckle = FALSE
	aggressive = 1

/mob/living/simple_animal/hostile/retaliate/rogue/saiga/tame
	tame = TRUE

/mob/living/simple_animal/hostile/retaliate/rogue/saiga/saigabuck/tame
	tame = TRUE

//the saiga's procs

/mob/living/simple_animal/hostile/retaliate/rogue/saiga/find_food()
	..()
	var/obj/structure/spacevine/SV = locate(/obj/structure/spacevine) in loc
	if(SV)
		SV.eat(src)
		food = max(food + 30, 100)

/mob/living/simple_animal/hostile/retaliate/rogue/saiga/update_icon()
	cut_overlays()
	..()
	if(stat != DEAD)
		if(ssaddle)
			var/mutable_appearance/saddlet = mutable_appearance(icon, "saddle-f-above", 4.3)
			add_overlay(saddlet)
			saddlet = mutable_appearance(icon, "saddle-f")
			add_overlay(saddlet)
		if(has_buckled_mobs())
			var/mutable_appearance/mounted = mutable_appearance(icon, "saiga_mounted", 4.3)
			add_overlay(mounted)

/mob/living/simple_animal/hostile/retaliate/rogue/saiga/tamed()
	..()
	deaggroprob = 30
	if(can_buckle)
		var/datum/component/riding/D = LoadComponent(/datum/component/riding)
		D.set_riding_offsets(RIDING_OFFSET_ALL, list(TEXT_NORTH = list(0, 8), TEXT_SOUTH = list(0, 8), TEXT_EAST = list(-2, 8), TEXT_WEST = list(2, 8)))
		D.set_vehicle_dir_layer(SOUTH, OBJ_LAYER)
		D.set_vehicle_dir_layer(NORTH, OBJ_LAYER)
		D.set_vehicle_dir_layer(EAST, OBJ_LAYER)
		D.set_vehicle_dir_layer(WEST, OBJ_LAYER)

/mob/living/simple_animal/hostile/retaliate/rogue/saiga/death()
	unbuckle_all_mobs()
	.=..()


//reproduces some iancode to allow equipping objects to saiga without having to do a bunch of bespoke stuff for every single item.
/mob/living/simple_animal/hostile/retaliate/rogue/saiga/Destroy()
	QDEL_NULL(inventory_neck)
	return ..()

/mob/living/simple_animal/hostile/retaliate/rogue/saiga/handle_atom_del(atom/A)
	if(A == inventory_neck)
		inventory_neck = null
		regenerate_icons()

/mob/living/simple_animal/hostile/retaliate/rogue/saiga/Topic(href, href_list)
	if(!(iscarbon(usr)) || !usr.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		usr << browse(null, "window=mob[REF(src)]")
		usr.unset_machine()
		return

	//Removing from inventory
	if(href_list["remove_inv"])
		var/remove_from = href_list["remove_inv"]
		switch(remove_from)
			if("neck")
				if(inventory_neck)
					usr.put_in_hands(inventory_neck)
					inventory_neck = null
					regenerate_icons()
				else
					to_chat(usr, span_warning("There is nothing to remove from its [remove_from]!"))
					return

		show_inv(usr)

	//Adding things to inventory
	else if(href_list["add_inv"])
		var/add_to = href_list["add_inv"]

		switch(add_to)
			if("neck")
				if(inventory_neck)
					to_chat(usr, span_warning("It's already wearing something!"))
					return
				else
					var/obj/item/item_to_add = usr.get_active_held_item()

					if(!item_to_add)
						usr.visible_message(span_notice("[usr] pets [src]."), span_notice("I rest your hand on [src]'s neck for a moment."))
						return

					if(!usr.temporarilyRemoveItemFromInventory(item_to_add))
						to_chat(usr, span_warning("\The [item_to_add] is stuck to your hand, you cannot put it on [src]'s neck!"))
						return

					//The objects that corgis can wear on their backs.
					var/allowed = FALSE
					if(ispath(item_to_add.dog_fashion, /datum/dog_fashion/saiga))
						allowed = TRUE

					if(!allowed)
						to_chat(usr, span_warning("I set [item_to_add] on [src]'s neck, but it falls off!"))
						item_to_add.forceMove(drop_location())
						if(prob(25))
							step_rand(item_to_add)
						return

					item_to_add.forceMove(src)
					src.inventory_neck = item_to_add
					regenerate_icons()

		show_inv(usr)
	else
		return ..()

/obj/effect/decal/remains/saiga
	name = "remains"
	gender = PLURAL
	icon_state = "skele"
	icon = 'icons/roguetown/mob/monster/saiga.dmi'

/mob/living/simple_animal/hostile/retaliate/rogue/saiga/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/saiga/attack (1).ogg','sound/vo/mobs/saiga/attack (2).ogg')
		if("pain")
			return pick('sound/vo/mobs/saiga/pain (1).ogg','sound/vo/mobs/saiga/pain (2).ogg','sound/vo/mobs/saiga/pain (3).ogg')
		if("death")
			return pick('sound/vo/mobs/saiga/death (1).ogg','sound/vo/mobs/saiga/death (2).ogg')
		if("idle")
			return pick('sound/vo/mobs/saiga/idle (1).ogg','sound/vo/mobs/saiga/idle (2).ogg','sound/vo/mobs/saiga/idle (3).ogg','sound/vo/mobs/saiga/idle (4).ogg','sound/vo/mobs/saiga/idle (5).ogg','sound/vo/mobs/saiga/idle (6).ogg','sound/vo/mobs/saiga/idle (7).ogg')

/mob/living/simple_animal/hostile/retaliate/rogue/saiga/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			return "snout"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "snout"
		if(BODY_ZONE_PRECISE_SKULL)
			return "head"
		if(BODY_ZONE_PRECISE_EARS)
			return "head"
		if(BODY_ZONE_PRECISE_NECK)
			return "neck"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_STOMACH)
			return "stomach"
		if(BODY_ZONE_HEAD)
			return "head"
		if(BODY_ZONE_R_LEG)
			return "leg"
		if(BODY_ZONE_L_LEG)
			return "leg"
		if(BODY_ZONE_R_ARM)
			return "foreleg"
		if(BODY_ZONE_L_ARM)
			return "foreleg"

	return ..()

/mob/living/simple_animal/hostile/retaliate/rogue/saigabuck/update_icon()
	cut_overlays()
	..()
	if(stat != DEAD)
		if(ssaddle)
			var/mutable_appearance/saddlet = mutable_appearance(icon, "saddle-above", 4.3)
			add_overlay(saddlet)
			saddlet = mutable_appearance(icon, "saddle")
			add_overlay(saddlet)
		if(has_buckled_mobs())
			var/mutable_appearance/mounted = mutable_appearance(icon, "buck_mounted", 4.3)
			add_overlay(mounted)


/mob/living/simple_animal/hostile/retaliate/rogue/saigabuck/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/saiga/attack (1).ogg','sound/vo/mobs/saiga/attack (2).ogg')
		if("pain")
			return pick('sound/vo/mobs/saiga/pain (1).ogg','sound/vo/mobs/saiga/pain (2).ogg','sound/vo/mobs/saiga/pain (3).ogg')
		if("death")
			return pick('sound/vo/mobs/saiga/death (1).ogg','sound/vo/mobs/saiga/death (2).ogg')
		if("idle")
			return pick('sound/vo/mobs/saiga/idle (1).ogg','sound/vo/mobs/saiga/idle (2).ogg','sound/vo/mobs/saiga/idle (3).ogg','sound/vo/mobs/saiga/idle (4).ogg','sound/vo/mobs/saiga/idle (5).ogg','sound/vo/mobs/saiga/idle (6).ogg','sound/vo/mobs/saiga/idle (7).ogg')

/mob/living/simple_animal/hostile/retaliate/rogue/saigabuck/Initialize()
	. = ..()
	if(tame)
		tamed()

/mob/living/simple_animal/hostile/retaliate/rogue/saigabuck/taunted(mob/user)
	emote("aggro")
	Retaliate()
	GiveTarget(user)
	return


/mob/living/simple_animal/hostile/retaliate/rogue/saigabuck/tamed()
	..()
	deaggroprob = 20
	if(can_buckle)
		var/datum/component/riding/D = LoadComponent(/datum/component/riding)
		D.set_riding_offsets(RIDING_OFFSET_ALL, list(TEXT_NORTH = list(0, 8), TEXT_SOUTH = list(0, 8), TEXT_EAST = list(-2, 8), TEXT_WEST = list(2, 8)))
		D.set_vehicle_dir_layer(SOUTH, ABOVE_MOB_LAYER)
		D.set_vehicle_dir_layer(NORTH, OBJ_LAYER)
		D.set_vehicle_dir_layer(EAST, OBJ_LAYER)
		D.set_vehicle_dir_layer(WEST, OBJ_LAYER)

/mob/living/simple_animal/hostile/retaliate/rogue/saigabuck/death()
	unbuckle_all_mobs()
	.=..()

/mob/living/simple_animal/hostile/retaliate/rogue/saigabuck/eat_plants()
	//..()
	var/obj/structure/spacevine/SV = locate(/obj/structure/spacevine) in loc
	if(SV)
		SV.eat(src)
		food = max(food + 30, 100)


/mob/living/simple_animal/hostile/retaliate/rogue/saigabuck/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			return "snout"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "snout"
		if(BODY_ZONE_PRECISE_SKULL)
			return "head"
		if(BODY_ZONE_PRECISE_EARS)
			return "head"
		if(BODY_ZONE_PRECISE_NECK)
			return "neck"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_STOMACH)
			return "stomach"
		if(BODY_ZONE_HEAD)
			return "head"
		if(BODY_ZONE_R_LEG)
			return "leg"
		if(BODY_ZONE_L_LEG)
			return "leg"
		if(BODY_ZONE_R_ARM)
			return "foreleg"
		if(BODY_ZONE_L_ARM)
			return "foreleg"
	return ..()

/mob/living/simple_animal/hostile/retaliate/rogue/saigabuck/tame/saddled/Initialize()
	. = ..()
	var/obj/item/natural/saddle/S = new(src)
	ssaddle = S
	update_icon()

/mob/living/simple_animal/hostile/retaliate/rogue/saiga/tame/saddled/Initialize()
	. = ..()
	var/obj/item/natural/saddle/S = new(src)
	ssaddle = S
	update_icon()
