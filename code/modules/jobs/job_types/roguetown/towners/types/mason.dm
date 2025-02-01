/datum/subclass/mason
	name = "Mason"
	tutorial = "You are a mason, master of your craft, if you can imagine it, you can make it \
	No material is beneath you, sculpting, cutting, chiseling? nothing is beneath you."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/towner/mason
	category_tags = list(CTAG_TOWNER)

/datum/outfit/job/roguetown/towner/mason/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/roguehood
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/pick
	beltl = /obj/item/flashlight/flare/torch/lantern
	backr = /obj/item/rogueweapon/stoneaxe/woodcut
	backl = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(/obj/item/rogueweapon/hammer/steel = 1, /obj/item/rogueweapon/handsaw = 1, /obj/item/rogueweapon/chisel = 1)
	shoes = /obj/item/clothing/shoes/roguetown/armor/leather
	if(H.gender == FEMALE)
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen
	if(H.gender == MALE)
		armor = /obj/item/clothing/suit/roguetown/armor/workervest
		pants = /obj/item/clothing/under/roguetown/trou
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
		H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/mining, 4, TRUE) // ROCK AND STONE!!
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE) 
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE) // Need to climb to build
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 3, TRUE) 
		H.mind.adjust_skillrank(/datum/skill/craft/masonry, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE) // AXE MEN! GIVE ME SPLINTERS!
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	if(H.age == AGE_MIDDLEAGED)
		H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/mining, 1, TRUE)
	if(H.age == AGE_OLD)
		H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/mining, 2, TRUE)

	H.change_stat("strength", 2)
	H.change_stat("fortune", 2)
