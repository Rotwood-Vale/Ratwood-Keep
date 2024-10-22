/datum/job/roguetown/goblincook
	title = "Goblin Cook"
	flag = GOBLINCOOK
	department_flag = GOBLIN
	faction = "Station"
	total_positions = 1//From 2
	spawn_positions = 1//From 2
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/goblinp)
	allowed_patrons = list(/datum/patron/inhumen/graggar)
	tutorial = "You're one of the camp cooks, in service to the King, your lord on this mortal plane. \
	He's chosen you, out of many others, to prepare and service the camp when it comes to the culinary arts. \
	Maintain a farm, task the lower-goblins with foraging and try not to cook anything that'll kill your King."
	outfit = /datum/outfit/job/roguetown/goblincook
	display_order = JDO_GOBLINCOOK
	min_pq = 0
	max_pq = null
	always_show_on_latechoices = TRUE

/datum/outfit/job/roguetown/goblincook/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/suit/roguetown/armor/leather/hide/goblin
	pants = /obj/item/clothing/under/roguetown/loincloth/brown
	belt = /obj/item/storage/belt/rogue/leather/rope
	cloak = /obj/item/clothing/cloak/apron/cook
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/butchering, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.change_stat("intelligence", 1)
		H.change_stat("fortune", 1)
