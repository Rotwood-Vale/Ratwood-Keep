/datum/job/roguetown/goblinsmith
	title = "Goblin Smith"
	flag = GOBLINSMITH
	department_flag = GOBLIN
	faction = "Station"
	total_positions = 1//From 2
	spawn_positions = 1//From 2
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_GOBLIN
	allowed_patrons = list(/datum/patron/inhumen/graggar)
	tutorial = "You're an accomplished smith in your own right, chosen by your lord, the Chief, to supply the camp with fresh material. \
	Try not to fail him, or the many subjects that you're to service by extension with your trade."
	display_order = JDO_GOBLINSMITH
	outfit = /datum/outfit/job/roguetown/goblinsmith
	min_pq = 2
	max_pq = null

/datum/outfit/job/roguetown/goblinsmith/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/suit/roguetown/armor/leather/hide/goblin
	pants = /obj/item/clothing/under/roguetown/loincloth/brown
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	cloak = /obj/item/clothing/cloak/apron/blacksmith
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/keyring/goblin = 1)
	ADD_TRAIT(H, TRAIT_GOBLINCAMP, TRAIT_GENERIC)

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2 , TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/masonry, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/engineering, pick(2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 3, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("endurance", 1)
		H.change_stat("speed", -2)
