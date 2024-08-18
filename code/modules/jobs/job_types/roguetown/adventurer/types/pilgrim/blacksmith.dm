/datum/advclass/blacksmith
	name = "Blacksmith"
	tutorial = "A skilled blacksmith, able to forge capable weapons for warriors in the bog, \
	only after building a forge for themselves ofourse."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/blacksmith

	category_tags = list(CTAG_PILGRIM, CTAG_TOWNER)

/datum/outfit/job/roguetown/adventurer/blacksmith/pre_equip(mob/living/carbon/human/H)
	..()
	belt = /obj/item/storage/belt/rogue/leather

	beltr = /obj/item/rogueweapon/hammer
	beltl = /obj/item/rogueweapon/tongs

	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	gloves = /obj/item/clothing/gloves/roguetown/leather
	cloak = /obj/item/clothing/cloak/apron/blacksmith
	mouth = /obj/item/rogueweapon/huntingknife
	pants = /obj/item/clothing/under/roguetown/trou

	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/flint = 1, /obj/item/rogueore/coal=1, /obj/item/rogueore/iron=1)

	if(H.gender == MALE)

		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
	else
		
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE) 
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE) 
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE) // okish fists now(used to be four when the last note was written lmao)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/engineering, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/weaponsmithing, 3, TRUE) //removes a lot of the combat skills for 3 in all smithing, would not be opposed to making it maces 1 instead of 2 if you really wanna disarm towners
		H.mind.adjust_skillrank(/datum/skill/craft/traps, 1, TRUE) //intended to make smiths be able to make mantraps (they are made of metal)
		H.change_stat("strength", 2) //takes a point from end and con to give to str and int(smiths are meant to be smart and strong not tough as nails ??? and as fit as an olympic athelete ????)
		H.change_stat("endurance", 1)
		H.change_stat("intelligence", 1)
		H.change_stat("constitution", 1)
		H.change_stat("speed", -1)
		H.change_stat("fortune", 1)
