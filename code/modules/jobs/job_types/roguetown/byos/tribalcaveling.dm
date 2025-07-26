/datum/job/roguetown/tribalcaveling
	title = "Tribal Caveling"
	flag = TRIBALCAVELING
	department_flag = TRIBAL
	selection_color = JCOLOR_TRIBAL
	faction = "Station"
	total_positions = 6
	spawn_positions = 6
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/goblinp, /datum/species/kobold, /datum/species/anthromorphsmall)
	tutorial = "A gremlin among many other gremlins. You worship the chief as the representation of The Dragon, his chosen as the biggest and the strongest. \
	There's little to say about you, aside from your proclivity for skullduggery over outright skull smashing, much to your chief's disappointment. Obey when called upon. \
	This is The Dragon's island, and there's rumor of newcomers, which means more gold for him. \
	Perhaps if you brought a fresh slave or mammons... The Dragon would finally notice you."
	outfit = /datum/outfit/job/roguetown/tribalcaveling
	display_order = JDO_TRIBALCAVELING
	min_pq = 0
	max_pq = null
	announce_latejoin = FALSE
	same_job_respawn_delay = 25 MINUTES
	job_reopens_slots_on_death = FALSE
	allowed_maps = list("Build Your Settlement")

/datum/outfit/job/roguetown/tribalcaveling
	allowed_patrons = list(/datum/patron/inhumen/graggar)

/datum/outfit/job/roguetown/tribalcaveling/pre_equip(mob/living/carbon/human/H)
	..()
	H.faction += list("orcs", "tribe")
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	pants = /obj/item/clothing/under/roguetown/loincloth/brown
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	l_hand = /obj/item/rogueweapon/huntingknife/stoneknife
	r_hand = /obj/item/rogueweapon/spear/stone
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/ammo_holder/quiver/arrows
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/storage/keyring/goblin = 1, /obj/item/lockpickring/mundane = 1)
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	ADD_TRAIT(H, TRAIT_DARKVISION, TRAIT_GENERIC)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.change_stat("strength", -1)
		H.change_stat("perception", 2)
		H.change_stat("speed", 2)
		ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
		H.ventcrawler = VENTCRAWLER_ALWAYS

	if(!H.has_language(/datum/language/draconic))
		H.grant_language(/datum/language/draconic)
		to_chat(H, span_info("I can speak Draconic with ,s before my speech."))
