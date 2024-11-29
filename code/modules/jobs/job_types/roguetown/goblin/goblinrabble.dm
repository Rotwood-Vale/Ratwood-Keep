/datum/job/roguetown/goblinrabble
	title = "Goblin Rabble"
	flag = GOBLINRABBLE
	department_flag = GOBLIN
	faction = "Station"
	total_positions = 6
	spawn_positions = 6
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/goblinp)
	tutorial = "You're the lowest of the low. A goblin among many other goblins. \
	There's little to say about you, aside from your Chief deeming you less than fit for service."
	outfit = /datum/outfit/job/roguetown/goblinrabble
	display_order = JDO_GOBLINRABBLE
	min_pq = 0
	max_pq = null

/datum/outfit/job/roguetown/goblinrabble
	allowed_patrons = list(/datum/patron/inhumen/graggar)

/datum/outfit/job/roguetown/goblinrabble/pre_equip(mob/living/carbon/human/H)
	..()
	H.faction += "orcs"
	armor = /obj/item/clothing/suit/roguetown/armor/leather/hide/goblin
	pants = /obj/item/clothing/under/roguetown/loincloth/brown
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	l_hand = /obj/item/rogueweapon/huntingknife/stoneknife
	belt = /obj/item/storage/belt/rogue/leather
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/keyring/goblin = 1)
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	ADD_TRAIT(H, TRAIT_GOBLINCAMP, TRAIT_GENERIC)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, round(rand(1,5)), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, round(rand(1,5)), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.change_stat("fortune", 2)

//If a non-Goblin gets control by admin intervention.
	if(!H.has_language(/datum/language/orcish))
		H.grant_language(/datum/language/orcish)
		to_chat(H, span_info("I can speak Orchish with ,o before my speech."))
