//Wonder recipes
//NOTE: Wonders are named after their proper keys, the wonder structure handles that code
/datum/crafting_recipe/roguetown/structure/wonder
	name = "wonder"
	result = /obj/structure/wonder
	reqs = list(
		/obj/item/bodypart = 2,
		/obj/item/organ/stomach = 1,
	)
	verbage_simple = "construct"
	verbage = "constructs"
	craftsound = 'sound/foley/Building-01.ogg'
	skillcraft = null
	always_availible = FALSE
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/structure/wonder/first
	name = "first wonder"
	result = /obj/structure/wonder
	reqs = list(
		/obj/item/bodypart = 2,
		/obj/item/organ/stomach = 1,
	)

/datum/crafting_recipe/roguetown/structure/wonder/second
	name = "second wonder"
	result = /obj/structure/wonder
	reqs = list(
		/obj/item/bodypart = 2,
		/obj/item/organ/lungs = 2,
	)

/datum/crafting_recipe/roguetown/structure/wonder/third
	name = "third wonder"
	result = /obj/structure/wonder
	reqs = list(
		/obj/item/bodypart/head = 3,
		/obj/item/bodypart = 2,
		/obj/item/organ/stomach = 2,
	)

/datum/crafting_recipe/roguetown/structure/wonder/fourth
	name = "fourth wonder"
	result = /obj/structure/wonder
	reqs = list(
		/obj/item/organ/tongue = 4,
		/obj/item/organ/eyes = 3,
		/obj/item/organ/liver = 4,
	)

//Wonder structure
/obj/structure/wonder
	name = "wonder"
	desc = "What a disgusting thing, what type of maniac would make this!?"
	icon = 'icons/roguetown/maniac/creations.dmi'
	icon_state = "creation1"
	resistance_flags = INDESTRUCTIBLE
	density = TRUE
	anchored = TRUE
	/// The maniac that made this structure
	var/datum/antagonist/maniac/dream_master
	/// Index of the wonder
	var/wonder_id = 1
	/// Whether or not we have been gazed at
	var/gazed_at = FALSE
	/// Dreamer key number
	var/key_num = ""
	/// Dreamer key text
	var/key_text = ""

/obj/structure/wonder/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/structure/wonder/OnCrafted(dirin, mob/user)
	. = ..()
	playsound(src, 'sound/villain/wonder.ogg', 100, vary = FALSE)
	dream_master = user?.mind?.has_antag_datum(/datum/antagonist/maniac)
	if(dream_master)
		if(LAZYACCESS(dream_master.recipe_progression, dream_master.current_wonder))
			user.mind.forget_crafting_recipe(dream_master.recipe_progression[dream_master.current_wonder])
		wonder_id = dream_master.current_wonder
		if(wonder_id >= 4)
			to_chat(user, span_userdanger("I must SUM the keys. I am WAKING up!"))
			dream_master.agony(user)
		key_num = LAZYACCESS(dream_master.num_keys, wonder_id)
		key_text = LAZYACCESS(dream_master.key_nums, wonder_id)
		name = "[key_text ? "[key_text] " : ""]Wonder"
		icon_state = "creation[clamp(wonder_id, 1, 4)]"
		dream_master.current_wonder++
		if(LAZYACCESS(dream_master.recipe_progression, dream_master.current_wonder))
			user.mind.teach_crafting_recipe(dream_master.recipe_progression[dream_master.current_wonder])
		dream_master.wonders_made |= src
	START_PROCESSING(SSobj, src)
	
/obj/structure/wonder/examine(mob/user)
	. = ..()
	if(gazed_at && (user.mind?.has_antag_datum(/datum/antagonist/maniac) == dream_master))
		. += span_danger("They have GAZED at my wonder!")
	if(isobserver(user))
		return
	if(dream_master)
		process()

/obj/structure/wonder/process()
	. = ..()
	var/list/viewers = view(7, src)
	for(var/mob/living/carbon/human/victim in viewers)
		if(dream_master && (victim.mind?.has_antag_datum(/datum/antagonist/maniac) == dream_master))
			if(victim.stat == DEAD)
				continue
			for(var/mob/living/carbon/human/other_victim in viewers - victim)
				other_victim.blur_eyes(2)
				if(prob(10))
					to_chat(other_victim, span_userdanger("It is WONDERFUL!"))
		else
			if(!victim.mind || (victim.stat == DEAD))
				continue
			var/obj/item/organ/heart/heart = victim.getorganslot(ORGAN_SLOT_HEART)
			if(dream_master && heart && !heart.inscryption)
				heart.inscryption = "<b>INRL</b> - [key_text] - [key_num]"
				heart.inscryption_key = key_text
				victim.add_stress(/datum/stressevent/saw_wonder)
				victim.emote("scream")
				SEND_SOUND(victim, 'sound/villain/seen_wonder.ogg')
				victim.Paralyze(5 SECONDS)
				victim.add_client_colour(/datum/client_colour/maniac_marked)
				gazed_at = TRUE
				break
