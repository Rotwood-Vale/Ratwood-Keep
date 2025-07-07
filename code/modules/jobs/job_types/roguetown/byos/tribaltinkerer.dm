/datum/job/roguetown/tribaltinkerer
	title = "Tribal Tinkerer"
	flag = TRIBALTINKERER
	department_flag = TRIBAL
	selection_color = JCOLOR_TRIBAL
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/goblinp, /datum/species/kobold, /datum/species/anthromorphsmall)
	tutorial = "You're an accomplished crafstman in your own right, chosen by your lord, The Dragon, to supply the camp with fresh material. \
	Try not to fail him, or the many subjects that you're to service by extension with your trade."
	display_order = JDO_TRIBALTINKERER
	outfit = /datum/outfit/job/roguetown/tribaltinkerer
	min_pq = 2
	max_pq = null
	announce_latejoin = FALSE
	same_job_respawn_delay = 25 MINUTES
	job_reopens_slots_on_death = FALSE
	allowed_maps = list("Build Your Settlement")

/datum/outfit/job/roguetown/tribaltinkerer
	allowed_patrons = list(/datum/patron/inhumen/graggar)

/datum/outfit/job/roguetown/tribaltinkerer/pre_equip(mob/living/carbon/human/H)
	..()
	H.faction += list("orcs", "tribe")
	armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
	pants = /obj/item/clothing/under/roguetown/loincloth/brown
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	cloak = /obj/item/clothing/cloak/apron/blacksmith
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/storage/keyring/goblin = 1, /obj/item/rogueweapon/hammer/steel = 1, /obj/item/rogueweapon/handsaw = 1, /obj/item/rogueweapon/chisel = 1)
	ADD_TRAIT(H, TRAIT_GOBLINCAMP, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DARKVISION, TRAIT_GENERIC)

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/masonry, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/engineering, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 3, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("endurance", 1)
		H.change_stat("speed", -2)
		H.ventcrawler = VENTCRAWLER_ALWAYS

	if(!H.has_language(/datum/language/draconic))
		H.grant_language(/datum/language/draconic)
		to_chat(H, span_info("I can speak Draconic with ,s before my speech."))
