/datum/job/roguetown/triballackey
	title = "Tribal Lackey"
	flag = TRIBALLACKEY
	department_flag = TRIBAL
	selection_color = JCOLOR_TRIBAL
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/goblinp, /datum/species/kobold, /datum/species/anthromorphsmall)
	tutorial = "You are the lowest of the low in the tribe. You're the camp's laborer, in service to the Chief before all others. \
	They've chosen you, as the weakest of them all, to prepare and service the camp in whatever fashion they see fit. \
	Make sure everyone is fed, healthy, and satisfied, all while hoping maybe one day you'll be something more."
	outfit = /datum/outfit/job/roguetown/triballackey
	display_order = JDO_TRIBALLACKEY
	min_pq = 2
	max_pq = null
	announce_latejoin = FALSE
	same_job_respawn_delay = 25 MINUTES
	job_reopens_slots_on_death = FALSE
	allowed_maps = list("Build Your Settlement")

/datum/outfit/job/roguetown/triballackey
	allowed_patrons = list(/datum/patron/inhumen/graggar)

/datum/outfit/job/roguetown/triballackey/pre_equip(mob/living/carbon/human/H)
	..()
	H.faction += list("orcs", "tribe")
	pants = /obj/item/clothing/under/roguetown/loincloth/brown
	belt = /obj/item/storage/belt/rogue/leather/rope
	cloak = /obj/item/clothing/cloak/apron/cook
	beltr = /obj/item/rogueweapon/huntingknife/stoneknife
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/storage/keyring/goblin = 1, /obj/item/needle = 1, )
	ADD_TRAIT(H, TRAIT_GOBLINCAMP, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DARKVISION, TRAIT_GENERIC)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/hunting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/fishing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/mining, 2, TRUE)
		H.change_stat("intelligence", 1)
		H.change_stat("fortune", 2)
		H.ventcrawler = VENTCRAWLER_ALWAYS

	if(!H.has_language(/datum/language/draconic))
		H.grant_language(/datum/language/draconic)
		to_chat(H, span_info("I can speak Draconic with ,s before my speech."))
