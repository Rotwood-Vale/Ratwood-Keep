/datum/job/roguetown/nightmaiden
	//Let's try to be a LITTLE less on-the-nose, huh?
	//Also it's what the job is called in code let's do it
	title = "Nightswain"
	f_title = "Nightmaiden"
	flag = WENCH
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 5
	spawn_positions = 5

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_VERY_SHUNNED_UP
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	subclass_cat_rolls = list(CTAG_WENCH = 3)

	tutorial = "Selling your body like a piece of meat in a butcher's shop, stripped of dignity and treated as a commodity, you trade in empty pleasure and lies whispered between sheets. Your value to the Nightmaster is as stock, a good to be sold, but at least it's more than nothing."

	outfit = /datum/outfit/job/roguetown/nightmaiden
	display_order = JDO_WENCH
	give_bank_account = TRUE
	can_random = FALSE
	min_pq = 2
	max_pq = null

/datum/job/roguetown/nightmaiden/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

//Discount rogue
/datum/subclass/nightmaiden/harlot
	name = "Harlot"
	tutorial = "The world broke you young. You learned to smile through gritted teeth as you sold yourself for a warm bed and a full belly. Sometimes when you're alone you think about what you've done to survive. What's been done to you. You tell yourself the tears stopped long ago. You've gotten good at lying to yourself."
	outfit = /datum/outfit/job/roguetown/nightmaiden/harlot
	category_tags = list(CTAG_WENCH)
	maximum_possible_slots = 5
	torch = FALSE

/datum/outfit/job/roguetown/nightmaiden/harlot/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	r_hand = /obj/item/soap/bath
	if(H.gender == MALE)
		pants =	/obj/item/clothing/under/roguetown/loincloth
		belt =	/obj/item/storage/belt/rogue/leather/cloth
	else
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/gen/sexy
		armor = /obj/item/clothing/suit/roguetown/armor/corset
		pants =	/obj/item/clothing/under/roguetown/tights/stockings/fishnet/random
		belt =	/obj/item/storage/belt/rogue/leather/cloth

	beltr = /obj/item/storage/keyring/nightman
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/music, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE) // Don't go picking any COCKS around here or we're going to have a real problem.
		H.change_stat("speed", 1)
		H.change_stat("endurance", 2)
	ADD_TRAIT(H, TRAIT_NUTCRACKER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)


//High class prostitute
/datum/subclass/nightmaiden/escort
	name = "Coquette"
	tutorial = "You aren't like these other whores. They peddle cheap pleasure, you sell something with more substance: You and the joy of your company. You are educated, intelligent, and talented. You belong on a rich lover's arm not here. Not wasted on dirty peasants and common soldiers."
	outfit = /datum/outfit/job/roguetown/nightmaiden/escort
	category_tags = list(CTAG_WENCH)
	maximum_possible_slots = 5
	torch = FALSE

/datum/outfit/job/roguetown/nightmaiden/escort/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	r_hand = /obj/item/soap/bath
	l_hand = /obj/item/rogue/instrument/harp
	if(H.gender == MALE)
		pants =	/obj/item/clothing/under/roguetown/tights
		belt =	/obj/item/storage/belt/rogue/leather/cloth
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
		armor = /obj/item/clothing/suit/roguetown/shirt/tunic/random
	else
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/silkdress/random
		armor = /obj/item/clothing/suit/roguetown/armor/corset
		pants =	/obj/item/clothing/under/roguetown/tights/stockings/silk/random
		belt =	/obj/item/storage/belt/rogue/leather/cloth

	beltr = /obj/item/storage/keyring/nightman
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/music, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.change_stat("intelligence", 1)
		H.change_stat("endurance", 2)
	ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
	


//Dominatrix/Leather Daddy
/datum/subclass/nightmaiden/dominatrix
	name = "Tickler"
	tutorial = "There is a thin, blurred line where pain meets pleasure. You cater to a specific kind of client, the kind who like to walk that line. You have practiced the art of pain and domination and made it your own. Still, you will always be the whore and they the client. What power do you really have?"
	outfit = /datum/outfit/job/roguetown/nightmaiden/tickler
	category_tags = list(CTAG_WENCH)
	maximum_possible_slots = 1 //I don't want the whorehouse overrun with these guys. Only one Tickler
	torch = FALSE

/datum/outfit/job/roguetown/nightmaiden/tickler/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/armor //These are just dark boots
	head = /obj/item/clothing/head/roguetown/menacing
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	if(H.gender == MALE)
		pants =	/obj/item/clothing/under/roguetown/trou/leather
		belt =	/obj/item/storage/belt/rogue/leather/black
		wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	else
		armor = /obj/item/clothing/suit/roguetown/armor/leather/bikini
		pants =	/obj/item/clothing/under/roguetown/tights/stockings/fishnet/black
		belt =	/obj/item/storage/belt/rogue/leather/black

	beltr = /obj/item/storage/keyring/nightman
	beltl = /obj/item/rogueweapon/whip
	if(H.mind)
		//Worst overall skills since they can kindof wrestle people? But not anybody that matters
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE) //I'm the boss of this gym
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
		H.change_stat("strength", 2) //Gotta look the part on examine.
		H.change_stat("endurance", 1)
		H.change_stat("intelligence", -2) //I'm erring on the side of caution because I can already see the complaining about the "combat prostitute" coming
	ADD_TRAIT(H, TRAIT_DEATHBYSNUSNU, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)


// Washing Implements

/obj/item/soap/bath
	name = "herbal soap"
	desc = "A soap made from various herbs"
	uses = 10

/obj/item/soap/bath/attack(mob/target, mob/user)
	var/turf/bathspot = get_turf(target)
	if(!istype(bathspot, /turf/open/water/bath))
		to_chat(user, span_warning("They must be in the bath water!"))
		return
	if(istype(target, /mob/living/carbon/human))
		visible_message(span_info("[user] begins scrubbing [target] with the [src]."))
		if(do_after(user, 50))
			if(HAS_TRAIT(user, TRAIT_GOODLOVER))
				visible_message(span_info("[user] expertly scrubs and soothes [target] with the [src]."))
				to_chat(target, span_love("I feel so relaxed and clean!"))
				SEND_SIGNAL(target, COMSIG_ADD_MOOD_EVENT, "bathcleaned", /datum/mood_event/bathcleaned)
			else
				visible_message(span_info("[user] tries their best to scrub [target] with the [src]."))
				to_chat(target, span_warning("Ouch! That hurts!"))
			uses -= 1
			if(uses == 0)
				qdel(src)
