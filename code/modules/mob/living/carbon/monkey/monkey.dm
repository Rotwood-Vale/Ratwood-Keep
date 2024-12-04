/mob/living/carbon/monkey
	name = "monkey"
	verb_say = "chimpers"
	initial_language_holder = /datum/language_holder/monkey
	icon = 'icons/mob/monkey.dmi'
	icon_state = "monkey1"
	gender = NEUTER
	pass_flags = PASSTABLE
	ventcrawler = VENTCRAWLER_NUDE
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/monkey = 5, /obj/item/stack/sheet/animalhide/monkey = 1)
	type_of_meat = /obj/item/reagent_containers/food/snacks/meat/slab/monkey
	gib_type = /obj/effect/decal/cleanable/blood/gibs
	unique_name = TRUE
	bodyparts = list(/obj/item/bodypart/chest/monkey, /obj/item/bodypart/head/monkey, /obj/item/bodypart/l_arm/monkey,
					 /obj/item/bodypart/r_arm/monkey, /obj/item/bodypart/r_leg/monkey, /obj/item/bodypart/l_leg/monkey)
	hud_type = /datum/hud/monkey

/mob/living/carbon/monkey/Initialize(mapload, cubespawned=FALSE, mob/spawner)
	verbs += /mob/living/proc/mob_sleep
	verbs += /mob/living/proc/lay_down

	if(unique_name) //used to exclude pun pun
		gender = pick(MALE, FEMALE)
	real_name = name

	//initialize limbs
	create_bodyparts()
	create_internal_organs()

	. = ..()

	if (cubespawned)
		var/cap = CONFIG_GET(number/monkeycap)
		if (LAZYLEN(SSmobs.cubemonkeys) > cap)
			if (spawner)
				to_chat(spawner, span_warning("Bluespace harmonics prevent the spawning of more than [cap] monkeys on the station at one time!"))
			return INITIALIZE_HINT_QDEL
		SSmobs.cubemonkeys += src

	create_dna(src)
	dna.initialize_dna(random_blood_type())
	AddComponent(/datum/component/footstep, FOOTSTEP_MOB_BAREFOOT, 1, 2)

/mob/living/carbon/monkey/Destroy()
	SSmobs.cubemonkeys -= src
	return ..()

/mob/living/carbon/monkey/create_internal_organs()
	internal_organs += new /obj/item/organ/lungs
	internal_organs += new /obj/item/organ/heart
	internal_organs += new /obj/item/organ/brain
	internal_organs += new /obj/item/organ/tongue
	internal_organs += new /obj/item/organ/eyes
	internal_organs += new /obj/item/organ/ears
	internal_organs += new /obj/item/organ/liver
	internal_organs += new /obj/item/organ/stomach
	..()

/mob/living/carbon/monkey/on_reagent_change()
	. = ..()
	remove_movespeed_modifier(MOVESPEED_ID_MONKEY_REAGENT_SPEEDMOD, TRUE)
	var/amount
	if(reagents.has_reagent(/datum/reagent/medicine/morphine))
		amount = -1
	if(reagents.has_reagent(/datum/reagent/consumable/nuka_cola))
		amount = -1
	if(amount)
		add_movespeed_modifier(MOVESPEED_ID_MONKEY_REAGENT_SPEEDMOD, TRUE, 100, override = TRUE, multiplicative_slowdown = amount)

/mob/living/carbon/monkey/updatehealth()
	. = ..()
	var/slow = 0
	if(!HAS_TRAIT(src, TRAIT_IGNOREDAMAGESLOWDOWN))
		var/health_deficiency = (maxHealth - health)
		if(health_deficiency >= 45)
			slow += (health_deficiency / 25)
	add_movespeed_modifier(MOVESPEED_ID_MONKEY_HEALTH_SPEEDMOD, TRUE, 100, override = TRUE, multiplicative_slowdown = slow)

/mob/living/carbon/monkey/adjust_bodytemperature(amount)
	. = ..()
	var/slow = 0
	if (bodytemperature < 283.222)
		slow += ((283.222 - bodytemperature) / 10) * 1.75
	add_movespeed_modifier(MOVESPEED_ID_MONKEY_TEMPERATURE_SPEEDMOD, TRUE, 100, override = TRUE, multiplicative_slowdown = slow)

/mob/living/carbon/monkey/Stat()
	..()
	if(statpanel("Status"))
		stat(null, "Intent: [a_intent]")
		stat(null, "Move Mode: [m_intent]")
	return


/mob/living/carbon/monkey/verb/removeinternal()
	set name = "Remove Internals"
	set category = "IC"
	internal = null
	return


/mob/living/carbon/monkey/IsAdvancedToolUser()//Unless its monkey mode monkeys can't use advanced tools
	if(mind && is_monkey(mind))
		return TRUE
	return FALSE

/mob/living/carbon/monkey/can_use_guns(obj/item/G)
	if(G.trigger_guard == TRIGGER_GUARD_NONE)
		to_chat(src, span_warning("I are unable to fire this!"))
		return FALSE
	return TRUE

/mob/living/carbon/monkey/reagent_check(datum/reagent/R) //can metabolize all reagents
	return FALSE

/mob/living/carbon/monkey/canBeHandcuffed()
	return TRUE

/mob/living/carbon/monkey/IsVocal()
	if(!getorganslot(ORGAN_SLOT_LUNGS))
		return 0
	return 1

/mob/living/carbon/monkey/angry
	aggressive = TRUE

/mob/living/carbon/monkey/angry/Initialize()
	. = ..()
	if(prob(10))
		var/obj/item/clothing/head/helmet/justice/escape/helmet = new(src)
		equip_to_slot_or_del(helmet,SLOT_HEAD)
		helmet.attack_self(src) // todo encapsulate toggle
