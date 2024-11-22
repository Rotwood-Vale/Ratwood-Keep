/datum/job/roguetown/goblincook
	title = "Goblin Cook"
	flag = GOBLINCOOK
	department_flag = GOBLIN
	faction = "Station"
	total_positions = 1//From 2
	spawn_positions = 1//From 2
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_GOBLIN
	allowed_patrons = list(/datum/patron/inhumen/graggar)
	tutorial = "You're one of the camp cooks, in service to the Chief, your lord on this mortal plane. \
	He's chosen you, out of many others, to prepare and service the camp when it comes to the culinary arts. \
	Maintain a farm, task the lower-goblins with foraging and try not to cook anything that'll kill your Chief."
	outfit = /datum/outfit/job/roguetown/goblincook
	display_order = JDO_GOBLINCOOK
	min_pq = 2
	max_pq = null

/datum/outfit/job/roguetown/goblincook/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/suit/roguetown/armor/leather/hide/goblin
	pants = /obj/item/clothing/under/roguetown/loincloth/brown
	belt = /obj/item/storage/belt/rogue/leather/rope
	cloak = /obj/item/clothing/cloak/apron/cook
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/keyring/goblin = 1)
	ADD_TRAIT(H, TRAIT_GOBLINCAMP, TRAIT_GENERIC)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/hunting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.change_stat("intelligence", 1)
		H.change_stat("fortune", 1)
