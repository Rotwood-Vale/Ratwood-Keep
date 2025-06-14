/datum/subclass/seamstress
	name = "Seamster"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/towner/seamstress
	category_tags = list(CTAG_TOWNER)

/datum/outfit/job/roguetown/towner/seamstress/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	cloak = /obj/item/clothing/cloak/raincloak
	shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/white
	pants = /obj/item/clothing/under/roguetown/tights/random
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	beltr = /obj/item/rogueweapon/huntingknife/scissors/steel
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/natural/cloth = 2, /obj/item/natural/bundle/fibers/full = 1, /obj/item/needle = 1)
	if(H.gender == MALE) // We're givign males male specific clothes so they don't walk around in a dress
		belt = /obj/item/storage/belt/rogue/leather/cloth
		armor = /obj/item/clothing/suit/roguetown/armor/gambeson
	else
		belt = /obj/item/storage/belt/rogue/leather/cloth/lady
		armor = /obj/item/clothing/suit/roguetown/armor/armordress
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.change_stat("intelligence", 1)
		H.change_stat("speed", 3)  
		H.change_stat("strength", 2)
		if(H.age == AGE_MIDDLEAGED)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
