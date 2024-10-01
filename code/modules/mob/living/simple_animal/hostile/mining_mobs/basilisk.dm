//A beast that fire freezing blasts.
/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/basilisk
	name = "basilisk"
	desc = ""
	icon = 'icons/mob/lavaland/lavaland_monsters.dmi'
	icon_state = "Basilisk"
	icon_living = "Basilisk"
	icon_aggro = "Basilisk_alert"
	icon_dead = "Basilisk_dead"
	icon_gib = "syndicate_gib"
	projectiletype = /obj/projectile/temp/basilisk
	projectilesound = 'sound/blank.ogg'
	ranged = 1
	ranged_message = "stares"
	ranged_cooldown_time = 30
	throw_message = "does nothing against the hard shell of"
	speed = 3
	obj_damage = 60
	attack_verb_continuous = "bites into"
	attack_verb_simple = "bite into"
	a_intent = INTENT_HARM
	speak_emote = list("chitters")
	attack_sound = 'sound/blank.ogg'
	gold_core_spawnable = HOSTILE_SPAWN
	loot = list(/obj/item/stack/ore/diamond{layer = ABOVE_MOB_LAYER},
				/obj/item/stack/ore/diamond{layer = ABOVE_MOB_LAYER})

	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 10
	move_to_delay = 20
	base_intents = list(/datum/intent/simple/imp)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 2, /obj/item/soul_fragment/essence)
	faction = list("caves")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	maxHealth = 200
	health = 200
	melee_damage_lower = 12
	melee_damage_upper = 12
	vision_range = 2
	aggro_vision_range = 8
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	obj_damage = 60
	retreat_distance = 0
	minimum_distance = 0
	milkies = FALSE
	food_type = list(/obj/item/reagent_containers/food/snacks/rogue/meat, /obj/item/bodypart, /obj/item/organ)
	footstep_type = FOOTSTEP_MOB_HEAVY
	pooptype = null
	STACON = 19
	STASTR = 12
	STASPD = 8
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	retreat_health = 100
	food = 0
	dodgetime = 0
	aggressive = 1
//	stat_attack = UNCONSCIOUS

/obj/projectile/temp/basilisk
	name = "freezing blast"
	icon_state = "ice_2"
	damage = 0
	damage_type = BURN
	nodamage = TRUE
	flag = "energy"
	temperature = 50

/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/basilisk/GiveTarget(new_target)
	if(..()) //we have a target
		if(isliving(target) && !target.Adjacent(targets_from) && ranged_cooldown <= world.time)//No more being shot at point blank or spammed with RNG beams
			OpenFire(target)

/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/basilisk/ex_act(severity, target)
	switch(severity)
		if(1)
			gib()
		if(2)
			adjustBruteLoss(140)
		if(3)
			adjustBruteLoss(110)

//Watcher
/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/basilisk/watcher
	name = "watcher"
	desc = ""
	icon = 'icons/mob/lavaland/watcher.dmi'
	icon_state = "watcher"
	icon_living = "watcher"
	icon_aggro = "watcher"
	icon_dead = "watcher_dead"
	pixel_x = -10
	throw_message = "bounces harmlessly off of"
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "impales"
	attack_verb_simple = "impale"
	a_intent = INTENT_HARM
	speak_emote = list("telepathically cries")
	attack_sound = 'sound/blank.ogg'
	stat_attack = UNCONSCIOUS
	movement_type = FLYING
	robust_searching = 1
	crusher_loot = /obj/item/crusher_trophy/watcher_wing
	loot = list()
	butcher_results = list(/obj/item/stack/ore/diamond = 2, /obj/item/stack/sheet/sinew = 2, /obj/item/stack/sheet/bone = 1)

/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/basilisk/watcher/random/Initialize()
	. = ..()
	if(prob(1))
		if(prob(75))
			new /mob/living/simple_animal/hostile/retaliate/rogue/asteroid/basilisk/watcher/magmawing(loc)
		else
			new /mob/living/simple_animal/hostile/retaliate/rogue/asteroid/basilisk/watcher/icewing(loc)
		return INITIALIZE_HINT_QDEL

/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/basilisk/watcher/magmawing
	name = "magmawing watcher"
	desc = ""
	icon_state = "watcher_magmawing"
	icon_living = "watcher_magmawing"
	icon_aggro = "watcher_magmawing"
	icon_dead = "watcher_magmawing_dead"
	maxHealth = 215 //Compensate for the lack of slowdown on projectiles with a bit of extra health
	health = 215
	light_range = 3
	light_power = 2.5
	light_color = LIGHT_COLOR_LAVA
	projectiletype = /obj/projectile/temp/basilisk/magmawing
	crusher_loot = /obj/item/crusher_trophy/blaster_tubes/magma_wing
	crusher_drop_mod = 60

/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/basilisk/watcher/icewing
	name = "icewing watcher"
	desc = ""
	icon_state = "watcher_icewing"
	icon_living = "watcher_icewing"
	icon_aggro = "watcher_icewing"
	icon_dead = "watcher_icewing_dead"
	maxHealth = 170
	health = 170
	projectiletype = /obj/projectile/temp/basilisk/icewing
	butcher_results = list(/obj/item/stack/ore/diamond = 5, /obj/item/stack/sheet/bone = 1) //No sinew; the wings are too fragile to be usable
	crusher_loot = /obj/item/crusher_trophy/watcher_wing/ice_wing
	crusher_drop_mod = 30

/obj/projectile/temp/basilisk/magmawing
	name = "scorching blast"
	icon_state = "lava"
	damage = 5
	damage_type = BURN
	nodamage = FALSE
	temperature = 500 //Heats you up!

/obj/projectile/temp/basilisk/magmawing/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(.)
		var/mob/living/L = target
		if (istype(L))
			L.adjust_fire_stacks(0.1)
			L.IgniteMob()

/obj/projectile/temp/basilisk/icewing
	damage = 5
	damage_type = BURN
	nodamage = FALSE

/obj/projectile/temp/basilisk/icewing/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(.)
		var/mob/living/L = target
		if(istype(L))
			L.apply_status_effect(/datum/status_effect/freon/watcher)

/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/basilisk/watcher/tendril
	fromtendril = TRUE
