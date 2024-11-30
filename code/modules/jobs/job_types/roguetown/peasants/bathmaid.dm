/datum/job/roguetown/nightmaiden
	title = "Bath Swain"
	f_title = "Bath Wench"
	flag = WENCH
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 5
	spawn_positions = 5

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_VERY_SHUNNED_UP
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)

	tutorial = "Nobody would envy your lot in life, for the role of bath-servant is not something so idly taken. Such folk often come from a place of desperation, 'least usually: for any with true compassion or skill would seek position with a nunnery or the medical trade. Launder clothes and soothe wounds, that is your loathsome creed."

	outfit = /datum/outfit/job/roguetown/nightmaiden
	display_order = JDO_WENCH
	give_bank_account = TRUE
	can_random = FALSE
	min_pq = -10
	max_pq = null

/datum/outfit/job/roguetown/nightmaiden/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	r_hand = /obj/item/soap/bath
	l_hand = /obj/item/rogue/instrument/harp
	mouth = /obj/item/key/nightmaiden
	if(H.gender == MALE)
		pants =	/obj/item/clothing/under/roguetown/loincloth
		belt =	/obj/item/storage/belt/rogue/leather/cloth
	else
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/sexy
		pants =	/obj/item/clothing/under/roguetown/tights/stockings/fishnet/random
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/music, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 2)
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
