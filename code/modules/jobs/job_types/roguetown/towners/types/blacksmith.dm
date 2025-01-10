/datum/subclass/blacksmith
	name = "Blacksmith"
	tutorial = "A skilled blacksmith, able to forge capable weapons for warriors in the bog, \
	only after building a forge for themselves ofourse."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/towner/blacksmith

	category_tags = list(CTAG_TOWNER)

/datum/outfit/job/roguetown/towner/blacksmith/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	gloves = /obj/item/clothing/gloves/roguetown/leather
	cloak = /obj/item/clothing/cloak/apron/blacksmith
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/hammer/iron
	beltl = /obj/item/rogueweapon/tongs
	backl = /obj/item/storage/backpack/rogue/satchel
	pants = /obj/item/clothing/under/roguetown/trou //do not make this male exclusive, I need my tomboy smiths- wow50000
	backpack_contents = list(/obj/item/flint = 1, /obj/item/rogueore/coal=1, /obj/item/rogueore/iron=1, /obj/item/rogueweapon/huntingknife = 1)
	if(H.gender == MALE)
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
		shoes = /obj/item/clothing/shoes/roguetown/armor/leather
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
		H.change_stat("strength", 2)
		H.change_stat("endurance", 1)
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", 1)
		H.change_stat("speed", -1)
		H.change_stat("fortune", 1)
