//Gutlunches, passive mods that devour blood and gibs
/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/gutlunch
	name = "gutlunch"
	desc = ""
	icon = 'icons/mob/lavaland/lavaland_monsters.dmi'
	icon_state = "gutlunch"
	icon_living = "gutlunch"
	icon_dead = "gutlunch"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_emote = list("warbles", "quavers")

	weather_immunities = list("lava","ash")
	density = FALSE
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "squishes"
	response_harm_simple = "squish"
	friendly_verb_continuous = "pinches"
	friendly_verb_simple = "pinch"
	a_intent = INTENT_HELP
	ventcrawler = VENTCRAWLER_ALWAYS
	gold_core_spawnable = FRIENDLY_SPAWN
	stat_attack = UNCONSCIOUS
	gender = NEUTER
	stop_automated_movement = FALSE
	stop_automated_movement_when_pulled = TRUE
	stat_exclusive = TRUE
	robust_searching = TRUE
	search_objects = 3 //Ancient simplemob AI shitcode. This makes them ignore all other mobs.
	del_on_death = TRUE
	loot = list(/obj/effect/decal/cleanable/blood/gibs)
	deathmessage = "is pulped into bugmash."

	animal_species = /mob/living/simple_animal/hostile/retaliate/rogue/asteroid/gutlunch
	childtype = list(/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/gutlunch/grublunch = 100)

	wanted_objects = list(/obj/effect/decal/cleanable/xenoblood/xgibs, /obj/effect/decal/cleanable/blood/gibs/, /obj/item/organ)
	// var/obj/item/udder/gutlunch/udder = null


	emote_hear = list("trills.")
	emote_see = list("sniffs.", "burps.")
	speak_chance = 1
	turns_per_move = 8
	see_in_dark = 10
	move_to_delay = 15
	base_intents = list(/datum/intent/simple/goldgrub)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 2, /obj/item/soul_fragment/essence)
	faction = list("caves")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	maxHealth = 1000
	health = 1000
	melee_damage_lower = 0
	melee_damage_upper = 0
	vision_range = 5
	aggro_vision_range = 8
	environment_smash = ENVIRONMENT_SMASH_NONE
	obj_damage = 0
	retreat_distance = 4
	minimum_distance = 4
	milkies = FALSE
	food_type = list(/obj/item/reagent_containers/food/snacks/rogue/meat, /obj/item/bodypart, /obj/item/organ)
	footstep_type = FOOTSTEP_MOB_HEAVY
	pooptype = null
	STACON = 19
	STASTR = 14
	STASPD = 8
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	retreat_health = 100
	food = 0
	dodgetime = 0
	aggressive = 0
//	stat_attack = UNCONSCIOUS


/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/gutlunch/Initialize()
	udder = new()
	. = ..()

/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/gutlunch/CanAttack(atom/the_target) // Gutlunch-specific version of CanAttack to handle stupid stat_exclusive = true crap so we don't have to do it for literally every single simple_animal/hostile except the two that spawn in lavaland
	if(isturf(the_target) || !the_target || the_target.type == /atom/movable/lighting_object) // bail out on invalids
		return FALSE

	if(see_invisible < the_target.invisibility)//Target's invisible to us, forget it
		return FALSE

	if(isliving(the_target))
		var/mob/living/L = the_target

		if(faction_check_mob(L) && !attack_same)
			return FALSE
		if(L.stat > stat_attack || L.stat != stat_attack && stat_exclusive)
			return FALSE

		return TRUE

	if(isobj(the_target) && is_type_in_typecache(the_target, wanted_objects))
		return TRUE

	return FALSE

/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/gutlunch/Destroy()
	QDEL_NULL(udder)
	return ..()

/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/gutlunch/regenerate_icons()
	cut_overlays()
	if(udder.reagents.total_volume == udder.reagents.maximum_volume)
		add_overlay("gl_full")
	..()

/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/gutlunch/attackby(obj/item/O, mob/user, params)
	if(stat == CONSCIOUS && istype(O, /obj/item/reagent_containers/glass))
		udder.milkAnimal(O, user)
		regenerate_icons()
	else
		..()

/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/gutlunch/AttackingTarget()
	if(is_type_in_typecache(target,wanted_objects)) //we eats
		udder.generateMilk()
		regenerate_icons()
		visible_message(span_notice("[src] slurps up [target]."))
		qdel(target)
	return ..()

//Male gutlunch. They're smaller and more colorful!
/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/gutlunch/gubbuck
	name = "gubbuck"
	gender = MALE

/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/gutlunch/gubbuck/Initialize()
	. = ..()
	add_atom_colour(pick("#E39FBB", "#D97D64", "#CF8C4A"), FIXED_COLOUR_PRIORITY)
	resize = 0.85
	update_transform()

//Lady gutlunch. They make the babby.
/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/gutlunch/guthen
	name = "guthen"
	gender = FEMALE

/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/gutlunch/guthen/Life()
	..()
	if(udder.reagents.total_volume == udder.reagents.maximum_volume) //Only breed when we're full.
		make_babies()

/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/gutlunch/guthen/make_babies()
	. = ..()
	if(.)
		udder.reagents.clear_reagents()
		regenerate_icons()

/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/gutlunch/grublunch
	name = "grublunch"
	wanted_objects = list() //They don't eat.
	gold_core_spawnable = NO_SPAWN
	var/growth = 0

//Baby gutlunch
/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/gutlunch/grublunch/Initialize()
	. = ..()
	add_atom_colour("#9E9E9E", FIXED_COLOUR_PRIORITY) //Somewhat hidden
	resize = 0.45
	update_transform()

/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/gutlunch/grublunch/Life()
	..()
	growth++
	if(growth > 50) //originally used a timer for this but was more problem that it's worth.
		growUp()

/mob/living/simple_animal/hostile/retaliate/rogue/asteroid/gutlunch/grublunch/proc/growUp()
	var/mob/living/L
	if(prob(45))
		L = new /mob/living/simple_animal/hostile/retaliate/rogue/asteroid/gutlunch/gubbuck(loc)
	else
		L = new /mob/living/simple_animal/hostile/retaliate/rogue/asteroid/gutlunch/guthen(loc)
	mind?.transfer_to(L)
	L.faction = faction
	L.setDir(dir)
	L.Stun(20, ignore_canstun = TRUE)
	visible_message(span_notice("[src] grows up into [L]."))
	Destroy()

//Gutlunch udder
/obj/item/udder/gutlunch
	name = "nutrient sac"

/obj/item/udder/gutlunch/Initialize()
	. = ..()
	reagents = new(50)
	reagents.my_atom = src

/obj/item/udder/gutlunch/generateMilk()
	if(prob(60))
		reagents.add_reagent(/datum/reagent/consumable/cream, rand(2, 5))
	if(prob(45))
		reagents.add_reagent(/datum/reagent/medicine/salglu_solution, rand(2,5))
