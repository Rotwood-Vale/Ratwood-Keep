/datum/advclass/blacksmith
	name = "Blacksmith"
	allowed_sexes = list("male", "female")
	allowed_races = ALL_RACES_TYPES
	outfit = /datum/outfit/job/roguetown/adventurer/blacksmith
	isvillager = TRUE
	ispilgrim = TRUE

/datum/outfit/job/roguetown/adventurer/blacksmith/pre_equip(mob/living/carbon/human/H)
	..()
	belt = /obj/item/storage/belt/rogue/leather

	beltr = /obj/item/rogueweapon/hammer
	beltl = /obj/item/rogueweapon/tongs

	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	gloves = /obj/item/clothing/gloves/roguetown/leather
	cloak = /obj/item/clothing/cloak/apron/brown
	mouth = /obj/item/rogueweapon/huntingknife
	pants = /obj/item/clothing/under/roguetown/trou

	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/flint = 1, /obj/item/rogueore/coal=1, /obj/item/rogueore/iron=1)

	if(H.gender == MALE)

		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
		
		
		if(H.mind)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(1,2,3), TRUE) // If you can make a sword you can swing one.
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(2,2,3), TRUE) 
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE) 
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE) // The strongest fists in the land.
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE) 
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, pick(0,0,1), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, pick(1,1,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, pick(1,2,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/masonry, pick(0,0,1), TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/engineering, pick(2,2,3), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, pick(1,2,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, pick(1,1,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/traps, pick(1,1,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, pick(0,0,1), TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/weaponsmithing, 3, TRUE)
			if(prob(50))
				H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
			H.change_stat("strength", 1)
			H.change_stat("endurance", 2)
			H.change_stat("constitution", 2)
			H.change_stat("speed", -1)
	else
		
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		
		
		if(H.mind)
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/armorsmithing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/weaponsmithing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)

			if(prob(50))
				H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)

			H.change_stat("strength",  1)
			H.change_stat("intelligence", -1)
			H.change_stat("speed", -1)
