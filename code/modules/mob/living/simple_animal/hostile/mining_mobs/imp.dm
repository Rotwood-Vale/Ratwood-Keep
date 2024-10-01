//A speedy, annoying and scaredy demon
/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/imp
	name = "fire imp"
	desc = "Lowest on the hierarchy of slaughter demons, this one is still nothing to sneer at."
	icon = 'modular_hearthstone/icons/mob/lavaland/lavaland_monsters.dmi'
	icon_state = "imp"
	icon_living = "imp"
	icon_aggro = "imp"
	icon_dead = "imp_dead"
	icon_gib = "syndicate_gib"
	projectiletype = /obj/projectile/magic/aoe/fireball/rogue2  //obj/item/projectile/magic/impfireball
	projectilesound = 'modular_hearthstone/sound/misc/impranged.wav'
	ranged = 1
	ranged_message = "shoots a fireball"
	ranged_cooldown_time = 70
	throw_message = "does nothing against the hardened skin of"
	speed = 1
	harm_intent_damage = 15
	attack_verb_continuous = "claws"
	attack_verb_simple = "claw"
	a_intent = INTENT_HARM
	speak_emote = list("groans")
	attack_sound = 'modular_hearthstone/sound/misc/impattacks.wav'
	gold_core_spawnable = HOSTILE_SPAWN
	//crusher_loot = /obj/item/crusher_trophy/blaster_tubes/impskull
	loot = list()
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 2, /obj/item/stack/sheet/bone = 4, /obj/item/stack/sheet/leather = 2, /obj/item/stack/ore/plasma = 2)
	robust_searching = FALSE
	deathsound = 'modular_hearthstone/sound/misc/impdies.wav'

	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 4
	see_in_dark = 10
	move_to_delay = 3
	base_intents = list(/datum/intent/simple/imp)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 2, /obj/item/soul_fragment/essence)
	faction = list("caves")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	maxHealth = 150
	health = 150
	melee_damage_lower = 15
	melee_damage_upper = 15
	vision_range = 5
	aggro_vision_range = 15
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	obj_damage = 60
	retreat_distance = 5
	minimum_distance = 3
	milkies = FALSE
	food_type = list(/obj/item/reagent_containers/food/snacks/rogue/meat, /obj/item/bodypart, /obj/item/organ)
	footstep_type = FOOTSTEP_MOB_HEAVY
	pooptype = null
	STACON = 19
	STASTR = 14
	STASPD = 5
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	retreat_health = 100
	food = 0
	dodgetime = 0
	aggressive = 1
//	stat_attack = UNCONSCIOUS



/mob/living/simple_animal/hostile/asteroid/imp/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/glory_kill, \
		messages_unarmed = list("grabs the imp's eyes and rips them out, shoving the bloody imp aside!", "grabs and crushes the imp's skull apart with their bare hands!", "rips the imp's head clean off with their bare hands!"), \
		messages_pka = list("sticks their PKA into the imp's mouth and shoots it, showering everything in gore!", "bashes the imp's head into their chest with their PKA!", "shoots off both legs of the imp with their PKA!"), \
		messages_pka_bayonet = list("slices the imp's head off by the neck with the PKA's bayonet!", "repeatedly stabs the imp in their gut with the PKA's bayonet!"), \
		messages_crusher = list("chops the imp horizontally in half with their crusher in one swift move!", "chops off the imp's legs with their crusher and kicks their face hard, exploding it while they're in the air!", "slashes each of the imp's arms off by the shoulder with their crusher!"), \
		health_given = 7.5, \
		threshold = (maxHealth/10 * 1.5), \
		crusher_drop_mod = 2)

/mob/living/simple_animal/hostile/asteroid/imp/attacked_by(obj/item/I, mob/living/user)
	. = ..()
	playsound(src, 'modular_hearthstone/sound/misc/impinjured.wav', rand(25,100), -1) //HURT ME PLENTY

/mob/living/simple_animal/hostile/asteroid/imp/bullet_act(obj/item/projectile/P)
	. = ..()
	playsound(src, 'modular_hearthstone/sound/misc/impinjured.wav', rand(25,100), -1)

/mob/living/simple_animal/hostile/asteroid/imp/Aggro()
	. = ..()
	playsound(src, pick('modular_hearthstone/sound/misc/impsight.wav', 'modular_hearthstone/sound/misc/impsight2.wav'), rand(50,75), -1)

/mob/living/simple_animal/hostile/asteroid/imp/LoseAggro()
	. = ..()
	playsound(src, pick('modular_hearthstone/sound/misc/impnearby.wav', 'modular_hearthstone/sound/misc/impnearby.wav'), rand(25, 60), -1)






/*/obj/item/projectile/magic/impfireball //bobyot y u no use child of fireball
	name = "demonic fireball" //because it fucking explodes and deals brute damage even when values are set to -1
	icon_state = "fireball"
	damage = 10
	damage_type = BURN
	nodamage = 0
	armor_penetration = 20
	var/firestacks = 5

/obj/item/projectile/magic/impfireball/on_hit(target)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		C.adjust_fire_stacks(firestacks)
		C.IgniteMob()
		if(C.stat != DEAD && C.stat != UNCONSCIOUS)
			playsound(C, 'modular_hearthstone/sound/misc/doominjured.wav', 100, -1)
		else if(C.stat == DEAD)
			playsound(C, 'modular_hearthstone/sound/misc/doomdies.wav', 100, -1)
		else
			playsound(C, pick('modular_hearthstone/sound/misc/doomscream.wav', 'modular_hearthstone/sound/misc/doomscream2.wav'), 100, -1)
*/


/datum/intent/simple/imp
	name = "imp"
	icon_state = "instrike"
	attack_verb = list("lacerates", "bites", "claws", "slashes")
	animname = "blank22"
	blade_class = BCLASS_CUT
	hitsound = "genchop"
	chargetime = 20
	penfactor = 10
	swingdelay = 3
	candodge = TRUE
	canparry = TRUE
	item_d_type = "stab"
