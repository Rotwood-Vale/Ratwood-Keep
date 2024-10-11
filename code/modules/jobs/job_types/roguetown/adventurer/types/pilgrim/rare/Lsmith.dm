//dwarf master smith

/datum/advclass/masterblacksmith
	name = "Master Blacksmith"
	tutorial = "A master blacksmith, able to forge steel like dough, and gold like clay. \
	create masterful weapons and armor, be a legend among those who interest in your mighty forge."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/masterblacksmith
	maximum_possible_slots = 1
	pickprob = 0.0001
	category_tags = list(CTAG_PILGRIM)

/datum/outfit/job/roguetown/adventurer/masterblacksmith/pre_equip(mob/living/carbon/human/H)
	..()
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/hammer
	beltl = /obj/item/rogueweapon/tongs
	// neck = /obj/item/storage/belt/rogue/pouch/coins/rich NO POUCH - gets gems
	mouth = /obj/item/rogueweapon/huntingknife

	gloves = /obj/item/clothing/gloves/roguetown/leather
	mask = /obj/item/clothing/mask/rogue/facemask/steel
	pants = /obj/item/clothing/under/roguetown/trou
	cloak = /obj/item/clothing/cloak/apron/blacksmith

	backl = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(/obj/item/flint = 1, /obj/item/rogueore/coal=2, /obj/item/rogueore/iron=3, /obj/item/rogueore/silver=2, /obj/item/riddleofsteel = 1, /obj/item/roguegem/yellow = 1, /obj/item/roguegem/violet = 1, /obj/item/roguegem/diamond = 1, /obj/item/roguegem/blue = 1, /obj/item/roguegem/green = 1)

	if(H.gender == MALE)
		
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt

		if(H.mind)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 5) // Hammer.
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 5)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3)
			H.mind.adjust_skillrank(/datum/skill/craft/masonry, 5)
			H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 2)
			H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 6)
			H.mind.adjust_skillrank(/datum/skill/craft/armorsmithing, 6)
			H.mind.adjust_skillrank(/datum/skill/craft/weaponsmithing, 6)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1)
			if(H.age == AGE_OLD)
				H.mind.adjust_skillrank(/datum/skill/craft/masonry, 1)
				H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2)
				H.mind.adjust_skillrank(/datum/skill/combat/maces, 1)
				H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 2)
				H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1)
			H.change_stat("strength", 4)
			H.change_stat("endurance", 4)
			H.change_stat("constitution", 6)
			H.change_stat("speed", 1)
			H.change_stat("fortune", 4)


	else
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		
		if(H.mind)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 5) // Hammer.
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 5)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3)
			H.mind.adjust_skillrank(/datum/skill/craft/masonry, 5)
			H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 2)
			H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 6)
			H.mind.adjust_skillrank(/datum/skill/craft/armorsmithing, 6)
			H.mind.adjust_skillrank(/datum/skill/craft/weaponsmithing, 6)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1)
			if(H.age == AGE_OLD)
				H.mind.adjust_skillrank(/datum/skill/craft/masonry, 1)
				H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2)
				H.mind.adjust_skillrank(/datum/skill/combat/maces, 1)
				H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 2)
				H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1)
			H.change_stat("strength", 4)
			H.change_stat("endurance", 4)
			H.change_stat("constitution", 6)
			H.change_stat("speed", 1)
			H.change_stat("fortune", 4)
