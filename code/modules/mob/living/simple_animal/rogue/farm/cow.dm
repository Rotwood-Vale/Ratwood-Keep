
/mob/living/simple_animal/hostile/retaliate/rogue/cow
	icon = 'icons/roguetown/mob/monster/cow.dmi'
	name = "cow"
	desc = ""
	icon_state = "cow"
	icon_living = "cow"
	icon_dead = "cow_dead"
	icon_gib = "cow_gib"

	animal_species = /mob/living/simple_animal/hostile/retaliate/rogue/bull
	faction = list("cows")
	gender = FEMALE
	footstep_type = FOOTSTEP_MOB_SHOE
	emote_hear = list("brays.")
	emote_see = list("shakes its head.", "chews her cud.")

	botched_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 3,
						/obj/item/natural/hide = 2)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 5,
						/obj/item/natural/hide = 3,
						/obj/item/reagent_containers/food/snacks/fat = 2)
	perfect_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 6,
						/obj/item/natural/hide = 4,
						/obj/item/reagent_containers/food/snacks/fat = 4)


	health = COW_FEMALE_HEALTH
	maxHealth = COW_FEMALE_HEALTH

	food_type = list(/obj/item/reagent_containers/food/snacks/grown/wheat,
					/obj/item/reagent_containers/food/snacks/grown/oat,
					/obj/item/reagent_containers/food/snacks/grown/cabbage)
	pooptype = /obj/item/natural/poo/cow
	var/milkies = TRUE
	tame_chance = 25
	bonus_tame_chance = 15

	base_intents = list(/datum/intent/simple/headbutt)
	attack_verb_continuous = "headbutts"
	attack_verb_simple = "headbutt"
	melee_damage_lower = 10
	melee_damage_upper = 25
	STASPD = 2
	STACON = 20
	STASTR = 12
	childtype = list(/mob/living/simple_animal/hostile/retaliate/rogue/cow/cowlet = 95,
					/mob/living/simple_animal/hostile/retaliate/rogue/cow/cowlet/bullet = 5)
	remains_type = /obj/effect/decal/remains/cow

	can_have_ai = FALSE
	AIStatus = AI_OFF
	ai_controller = /datum/ai_controller/basic_controller/cow
	var/can_breed = TRUE

/mob/living/simple_animal/hostile/retaliate/rogue/cow/Initialize()
	..()
	AddComponent(/datum/component/tippable, \
		0.5 SECONDS, \
		0.5 SECONDS, \
		rand(25 SECONDS, 50 SECONDS), \
		null,
		CALLBACK(src, PROC_REF(after_cow_tipped)),\
		CALLBACK(src, PROC_REF(after_cow_untipped)))

	if(milkies)
		udder = new()
	ai_controller.set_blackboard_key(BB_BASIC_FOODS, food_type)
	if(can_breed)
		AddComponent(\
			/datum/component/breed,\
			list(/mob/living/simple_animal/hostile/retaliate/rogue/cow, /mob/living/simple_animal/hostile/retaliate/rogue/bull),\
			3 MINUTES,
			list(/mob/living/simple_animal/hostile/retaliate/rogue/cow/cowlet = 95, /mob/living/simple_animal/hostile/retaliate/rogue/cow/cowlet/bullet = 5),\
			CALLBACK(src, PROC_REF(after_birth)),\
		)
/mob/living/simple_animal/hostile/retaliate/rogue/cow/Destroy()
	qdel(udder)
	udder = null
	..()

/mob/living/simple_animal/hostile/retaliate/rogue/cow/attackby(obj/item/O, mob/user, params)
	if(!stat && istype(O, /obj/item/reagent_containers/glass))
		if(udder)
			udder.milkAnimal(O, user)
			return TRUE
	else
		return ..()

/obj/effect/decal/remains/cow
	name = "remains"
	gender = PLURAL
	icon_state = "skele"
	icon = 'icons/roguetown/mob/monster/cow.dmi'

/mob/living/simple_animal/hostile/retaliate/rogue/cow/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/cow/aggro (1).ogg','sound/vo/mobs/cow/aggro (2).ogg','sound/vo/mobs/cow/aggro (3).ogg')
		if("pain")
			return pick('sound/vo/mobs/cow/pain (1).ogg','sound/vo/mobs/cow/pain (2).ogg')
		if("death")
			return pick('sound/vo/mobs/cow/death (1).ogg','sound/vo/mobs/cow/death (2).ogg')
		if("idle")
			return pick('sound/vo/mobs/cow/idle (1).ogg','sound/vo/mobs/cow/idle (2).ogg','sound/vo/mobs/cow/idle (3).ogg','sound/vo/mobs/cow/idle (4).ogg','sound/vo/mobs/cow/idle (5).ogg')

/mob/living/simple_animal/hostile/retaliate/rogue/cow/proc/after_birth(mob/living/simple_animal/hostile/retaliate/rogue/cow/cowlet/baby, mob/living/partner)
	return

/mob/living/simple_animal/hostile/retaliate/rogue/cow/simple_limb_hit(zone)
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

/*
 * Proc called via callback after the cow is tipped by the tippable component.
 * Begins a timer for us pleading for help.
 *
 * tipper - the mob who tipped us
 */
/mob/living/simple_animal/hostile/retaliate/rogue/cow/proc/after_cow_tipped(mob/living/carbon/tipper)
	icon_state = "[initial(icon_state)]_tip"
	addtimer(CALLBACK(src, PROC_REF(set_tip_react_blackboard), tipper), rand(5 SECONDS, 8 SECONDS))

/mob/living/simple_animal/hostile/retaliate/rogue/cow/proc/after_cow_untipped(mob/living/carbon/tipper)
	icon_state = initial(icon_state)

/*
 * We've been waiting long enough, we're going to tell our AI to begin pleading.
 *
 * tipper - the mob who originally tipped us
 */
/mob/living/simple_animal/hostile/retaliate/rogue/cow/proc/set_tip_react_blackboard(mob/living/carbon/tipper)
	if(!ai_controller)
		return
	ai_controller.set_blackboard_key(BB_BASIC_MOB_TIP_REACTING, TRUE)
	ai_controller.set_blackboard_key(BB_BASIC_MOB_TIPPER, tipper)


/mob/living/simple_animal/hostile/retaliate/rogue/cow/Life()
	. = ..()
	if(.)
		if(food > 0)
			if(udder)
				if(production > 0)
					production--
					udder.generateMilk()


/mob/living/simple_animal/hostile/retaliate/rogue/bull
	icon = 'icons/roguetown/mob/monster/cow.dmi'
	name = "bull"
	desc = ""
	icon_state = "bull"
	icon_living = "bull"
	icon_dead = "bull_dead"
	icon_gib = "bull_gib"

	faction = list("cows")
	footstep_type = FOOTSTEP_MOB_SHOE
	emote_hear = list("chews.")
	emote_see = list("shakes his head.", "chews his cud.")

	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 7,
						/obj/item/natural/hide = 3)

	health = COW_MALE_HEALTH
	maxHealth = COW_MALE_HEALTH
	food_type = list(/obj/item/reagent_containers/food/snacks/grown/wheat,
					/obj/item/reagent_containers/food/snacks/grown/oat,
					/obj/item/reagent_containers/food/snacks/grown/cabbage)
	pooptype = /obj/item/natural/poo/cow

	base_intents = list(/datum/intent/simple/headbutt)
	attack_verb_continuous = "gores"
	attack_verb_simple = "gores"
	melee_damage_lower = 25
	melee_damage_upper = 50
	retreat_distance = 0
	minimum_distance = 0
	STACON = 20
	STASTR = 12
	STASPD = 2
	remains_type = /obj/effect/decal/remains/cow

	can_have_ai = FALSE
	AIStatus = AI_OFF
	ai_controller = /datum/ai_controller/basic_controller/cow

/mob/living/simple_animal/hostile/retaliate/rogue/bull/Initialize()
	. = ..()
	ai_controller.set_blackboard_key(BB_BASIC_FOODS, food_type)
	AddComponent(\
		/datum/component/breed,\
		list(/mob/living/simple_animal/hostile/retaliate/rogue/cow, /mob/living/simple_animal/hostile/retaliate/rogue/bull),\
		3 MINUTES,
		list(/mob/living/simple_animal/hostile/retaliate/rogue/cow/cowlet = 95, /mob/living/simple_animal/hostile/retaliate/rogue/cow/cowlet/bullet = 5),\
		CALLBACK(src, PROC_REF(after_birth)),\
	)

/mob/living/simple_animal/hostile/retaliate/rogue/bull/proc/after_birth(mob/living/simple_animal/hostile/retaliate/rogue/cow/cowlet/baby, mob/living/partner)
	return


/mob/living/simple_animal/hostile/retaliate/rogue/bull/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/cow/aggro (1).ogg','sound/vo/mobs/cow/aggro (2).ogg','sound/vo/mobs/cow/aggro (3).ogg')
		if("pain")
			return pick('sound/vo/mobs/cow/pain (1).ogg','sound/vo/mobs/cow/pain (2).ogg')
		if("death")
			return pick('sound/vo/mobs/cow/death (1).ogg','sound/vo/mobs/cow/death (2).ogg')
		if("idle")
			return pick('sound/vo/mobs/cow/idle (1).ogg','sound/vo/mobs/cow/idle (2).ogg','sound/vo/mobs/cow/idle (3).ogg','sound/vo/mobs/cow/idle (4).ogg','sound/vo/mobs/cow/idle (5).ogg')

/mob/living/simple_animal/hostile/retaliate/rogue/bull/taunted(mob/user)
	emote("aggro")
	Retaliate()
	GiveTarget(user)
	return

/mob/living/simple_animal/hostile/retaliate/rogue/bull/simple_limb_hit(zone)
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

/mob/living/simple_animal/hostile/retaliate/rogue/cow/cowlet
	name = "calf"
	desc = "So cute!"
	icon_state = "cowlet"
	icon_living = "cowlet"
	icon_dead = "cowlet_dead"
	icon_gib = "cowlet_gib"

	animal_species = null
	mob_size = MOB_SIZE_SMALL
	pass_flags = PASSTABLE | PASSMOB

	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 1)

	health = CALF_HEALTH
	maxHealth = CALF_HEALTH
	milkies = FALSE

	base_intents = list(/datum/intent/simple/headbutt)
	melee_damage_lower = 1
	melee_damage_upper = 6
	STACON = 5
	STASTR = 5
	STASPD = 5
	defprob = 50
	adult_growth = /mob/living/simple_animal/hostile/retaliate/rogue/cow

	ai_controller = /datum/ai_controller/basic_controller/cow/baby
	can_breed = FALSE

/mob/living/simple_animal/hostile/retaliate/rogue/cow/cowlet/bullet
	desc = "So cute! Be careful of those horns, though."
	icon_state = "bullet"
	icon_living = "bullet"
	icon_dead = "bullet_dead"
	icon_gib = "bullet_gib"

	gender = MALE

	adult_growth = /mob/living/simple_animal/hostile/retaliate/rogue/bull
