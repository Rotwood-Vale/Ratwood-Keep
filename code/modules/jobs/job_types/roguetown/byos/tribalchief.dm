/datum/job/roguetown/tribalchief
	title = "Tribal Chief"
	f_title = "Tribal Chieftess"
	flag = TRIBALCHIEF
	department_flag = TRIBAL
	selection_color = JCOLOR_TRIBAL
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/goblinp, /datum/species/anthromorphsmall, /datum/species/kobold, /datum/species/dracon, /datum/species/halforc)
	tutorial = "You're the Chief of the local island tribe. A representation of The Dragon's rule, as you are the biggest and strongest. You ensure the spread of his dominion over others where you can, while ensuring none disturb his slumber. \
	There's news of an arriving duchy seeking to lay claim to The Dragon's island. \
	Have your subjects sneak through the caves and elsewhere, robbing and kidnapping passersby. Spread His will upon the weak fools. Bring gold and slaves to your tribe in The Dragon's name!"
	whitelist_req = FALSE
	outfit = /datum/outfit/job/roguetown/tribalchief
	display_order = JDO_TRIBALCHIEF
	min_pq = 6
	max_pq = null
	announce_latejoin = FALSE
	same_job_respawn_delay = 25 MINUTES
	job_reopens_slots_on_death = FALSE
	allowed_maps = list("Build Your Settlement")

/datum/outfit/job/roguetown/tribalchief
	allowed_patrons = list(/datum/patron/inhumen/graggar)

/datum/outfit/job/roguetown/tribalchief/pre_equip(mob/living/carbon/human/H)
	..()
	H.faction += list("orcs", "tribe")
	beltl = /obj/item/rogueweapon/huntingknife/idagger/steel/special
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
	pants = /obj/item/clothing/under/roguetown/loincloth/brown
	head = /obj/item/clothing/head/roguetown/crown/surplus
	cloak = /obj/item/clothing/cloak/heartfelt
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/storage/keyring/goblinchief = 1)
	ADD_TRAIT(H, TRAIT_GOBLINCAMP, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DARKVISION, TRAIT_GENERIC)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		if(istype(H.dna.species, /datum/species/halforc)) // Horc with +4 strength might be too strong.
			H.change_stat("strength", 2)
		else
			H.change_stat("strength", 4)
			H.ventcrawler = VENTCRAWLER_ALWAYS
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", 3)
		H.change_stat("endurance", 2)
		H.change_stat("speed", 1)

	if(!H.has_language(/datum/language/draconic))
		H.grant_language(/datum/language/draconic)
		to_chat(H, span_info("I can speak Draconic with ,s before my speech."))


