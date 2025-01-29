/datum/subclass/woodcutter
	name = "Woodcutter"
	tutorial = "You are a woodworker, physically capable of falling any tree yet knowledgeable \
	in the ways of bending wood to your will. With enough time, your only limit is your imagination."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/towner/woodcutter
	category_tags = list(CTAG_TOWNER)

/datum/outfit/job/roguetown/towner/woodcutter/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/roguehood
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/hammer/wood
	beltl = /obj/item/rogueweapon/handsaw
	backr = /obj/item/storage/backpack/rogue/satchel
	backl = /obj/item/rogueweapon/stoneaxe/woodcut
	backpack_contents = list(/obj/item/flint = 1, /obj/item/rogueweapon/huntingknife = 1)
	shoes = /obj/item/clothing/shoes/roguetown/armor/leather
	if(H.gender == FEMALE)
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen
	if(H.gender == MALE)
		armor = /obj/item/clothing/suit/roguetown/armor/workervest
		pants = /obj/item/clothing/under/roguetown/trou
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random

	H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE) // AXE MEN! GIVE ME SPLINTERS!
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE) 
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE) // Need to climb to build
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 3, TRUE) 
	H.mind.adjust_skillrank(/datum/skill/craft/masonry, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	if(H.age == AGE_MIDDLEAGED)
		H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 1, TRUE)
	if(H.age == AGE_OLD)
		H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 2, TRUE)

	H.change_stat("strength", 3)
	H.change_stat("constitution", 1)
	H.change_stat("endurance", 1)
	H.change_stat("intelligence", 1)
