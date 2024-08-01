/datum/advclass/apothecary
	name = "Apothecary"
	tutorial = "You are an Alchemist, with your tools and knowledge you are the most capable of making remedies for your fellow townsfolk's ailments, or creating drugs to help withstand the gloom this town carries."
	allowed_sexes = list(MALE, FEMALE)
	category_tags = list(CTAG_PILGRIM, CTAG_TOWNER)
	outfit = /datum/outfit/job/roguetown/adventurer/apothecary

/datum/outfit/job/roguetown/adventurer/apothecary/pre_equip(mob/living/carbon/human/H, visualsOnly)
	..()
	pants = /obj/item/clothing/under/roguetown/tights
	shirt = /obj/item/clothing/suit/roguetown/shirt/tunic
	armor = /obj/item/clothing/suit/roguetown/shirt/rags
	belt = /obj/item/storage/belt/rogue/leather/rope
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltr = /obj/item/rogueweapon/huntingknife
	backr = /obj/item/rogueweapon/woodstaff
	backl = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(
		/obj/item/reagent_containers/glass/bottle = 3,
		/obj/item/reagent_containers/glass/mortar = 1,
		/obj/item/pestle = 1,
	)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE )
		H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		H.change_stat("intelligence", 2)
