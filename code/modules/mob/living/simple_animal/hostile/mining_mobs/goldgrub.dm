//An ore-devouring but easily scared creature
/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/goldgrub
	name = "goldgrub"
	desc = ""
	icon = 'icons/mob/lavaland/lavaland_monsters.dmi'
	icon_state = "Goldgrub"
	icon_living = "Goldgrub"
	icon_aggro = "Goldgrub_alert"
	icon_dead = "Goldgrub_dead"
	icon_gib = "syndicate_gib"
	aggro_vision_range = 9
	friendly_verb_continuous = "harmlessly rolls into"
	friendly_verb_simple = "harmlessly roll into"
	harm_intent_damage = 5
	attack_verb_continuous = "barrels into"
	attack_verb_simple = "barrel into"
	attack_sound = 'sound/blank.ogg'
	a_intent = INTENT_HELP
	speak_emote = list("screeches")
	throw_message = "sinks in slowly, before being pushed out of "
	deathmessage = "spits up the contents of its stomach before dying!"
	status_flags = CANPUSH
	search_objects = 1
	wanted_objects = list(/obj/item/stack/ore/diamond, /obj/item/stack/ore/gold, /obj/item/stack/ore/silver,
						  /obj/item/stack/ore/uranium)


	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 4
	see_in_dark = 10
	move_to_delay = 5
	base_intents = list(/datum/intent/simple/goldgrub)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 2, /obj/item/soul_fragment/essence)
	faction = list("caves")
	maxHealth = 45
	health = 45
	melee_damage_lower = 0
	melee_damage_upper = 0
	vision_range = 2
	aggro_vision_range = 9
	environment_smash = ENVIRONMENT_SMASH_NONE
	obj_damage = 0
	retreat_distance = 5
	minimum_distance = 3
	milkies = FALSE
	food_type = list(/obj/item/reagent_containers/food/snacks/rogue/meat, /obj/item/bodypart, /obj/item/organ)
	footstep_type = FOOTSTEP_MOB_HEAVY
	pooptype = null
	STACON = 19
	STASTR = 10
	STASPD = 10
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	retreat_health = 100
	food = 0
	dodgetime = 0
	aggressive = 0
//	stat_attack = UNCONSCIOUS

	var/chase_time = 100
	var/will_burrow = TRUE

/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/goldgrub/Initialize()
	. = ..()
	var/i = rand(1,3)
	while(i)
		loot += pick(/obj/item/stack/ore/silver, /obj/item/stack/ore/gold, /obj/item/stack/ore/uranium, /obj/item/stack/ore/diamond)
		i--

/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/goldgrub/GiveTarget(new_target)
	target = new_target
	if(target != null)
		if(istype(target, /obj/item/stack/ore) && loot.len < 10)
			visible_message(span_notice("The [name] looks at [target.name] with hungry eyes."))
		else if(isliving(target))
			Aggro()
			visible_message(span_danger("The [name] tries to flee from [target.name]!"))
			retreat_distance = 10
			minimum_distance = 10
			if(will_burrow)
				addtimer(CALLBACK(src, PROC_REF(Burrow)), chase_time)

/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/goldgrub/AttackingTarget()
	if(istype(target, /obj/item/stack/ore))
		EatOre(target)
		return
	return ..()

/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/goldgrub/proc/EatOre(atom/targeted_ore)
	for(var/obj/item/stack/ore/O in get_turf(targeted_ore))
		if(length(loot) < 10)
			var/using = min(10 - length(loot), O.amount)
			for(var/i in 1 to using)
				loot += O.type
			O.use(using)
	visible_message(span_notice("The ore was swallowed whole!"))

/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/goldgrub/proc/Burrow()//Begin the chase to kill the goldgrub in time
	if(!stat)
		visible_message(span_danger("The [name] buries into the ground, vanishing from sight!"))
		qdel(src)

/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/goldgrub/bullet_act(obj/projectile/P)
	visible_message(span_danger("The [P.name] was repelled by [name]'s girth!"))
	return BULLET_ACT_BLOCK

/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/goldgrub/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	vision_range = 9
	. = ..()

/datum/intent/simple/goldgrub
	name = "goldgrub"
	icon_state = "instrike"
	attack_verb = list("harmlessly rolls onto")
	animname = "blank22"
	blade_class = BCLASS_CUT
	hitsound = "genchop"
	chargetime = 20
	penfactor = 0
	swingdelay = 3
	candodge = TRUE
	canparry = TRUE
	item_d_type = "stab"
