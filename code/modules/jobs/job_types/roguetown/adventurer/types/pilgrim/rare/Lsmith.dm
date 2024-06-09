//dwarf master smith

/datum/advclass/masterblacksmith
	name = "Master Blacksmith"
	tutorial = "A master blacksmith, able to forge steel like dough, and gold like clay. \
	create masterful weapons and armor, be a legend among those who interest in your mighty forge"
	allowed_sexes = list("male", "female")
	allowed_races = CLOTHED_RACES_TYPES
	outfit = /datum/outfit/job/roguetown/adventurer/masterblacksmith
	isvillager = FALSE
	ispilgrim = TRUE
	maxchosen = 1
	pickprob = 5

/datum/outfit/job/roguetown/adventurer/masterblacksmith/pre_equip(mob/living/carbon/human/H)
	..()
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/hammer
	beltl = /obj/item/rogueweapon/tongs
	neck = /obj/item/storage/belt/rogue/pouch/coins/mid
	mouth = /obj/item/rogueweapon/huntingknife

	gloves = /obj/item/clothing/gloves/roguetown/leather
	mask = /obj/item/clothing/mask/rogue/facemask/steel
	pants = /obj/item/clothing/under/roguetown/trou
	cloak = /obj/item/clothing/cloak/apron/blacksmith

	backl = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(/obj/item/flint = 1, /obj/item/rogueore/coal=2, /obj/item/rogueore/iron=2, /obj/item/rogueore/silver=1)

	if(H.gender == MALE)
		
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt

		if(H.mind)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/masonry, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 6, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/armorsmithing, 6, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/weaponsmithing, 6, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			if(H.age == AGE_OLD)
				H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/craft/armorsmithing, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/craft/weaponsmithing, 1, TRUE)
			H.change_stat("strength", 2)
			H.change_stat("speed", -1)

	else
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		
		if(H.mind)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/masonry, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 6, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/armorsmithing, 6, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/weaponsmithing, 6, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			if(H.age == AGE_OLD)
				H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/craft/armorsmithing, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/craft/weaponsmithing, 1, TRUE)
			H.change_stat("strength", 2)
			H.change_stat("speed", -1)
