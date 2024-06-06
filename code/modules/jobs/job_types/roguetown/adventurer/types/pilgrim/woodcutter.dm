/datum/advclass/woodcutter
	name = "Woodcutter"
	tutorial = "You are a strong Lumberjack, armed with an axe, you can gather wood \
	either for yourself, or for others. You are an expert carpenter too, so you can bend wood into whatever you need, and chop it efficiently"
	allowed_sexes = list("male")
	allowed_races = CLOTHED_RACES_TYPES
	outfit = /datum/outfit/job/roguetown/adventurer/woodcutter
	isvillager = TRUE
	ispilgrim = TRUE

/datum/outfit/job/roguetown/adventurer/woodcutter/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE) // AXE MEN! GIVE ME SPLINTERS!
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE) 
	H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(0,0,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE) 
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/masonry, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/engineering, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/traps, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/cooking, pick(0,1,1), TRUE)
	belt = /obj/item/storage/belt/rogue/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	pants = /obj/item/clothing/under/roguetown/trou
	head = /obj/item/clothing/head/roguetown/roguehood
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	backr = /obj/item/storage/backpack/rogue/satchel
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	armor = /obj/item/clothing/suit/roguetown/armor/workervest
	beltr = /obj/item/rogueweapon/stoneaxe/woodcut
	beltl = /obj/item/rogueweapon/huntingknife
	backpack_contents = list(/obj/item/flint = 1)
	H.change_stat("strength", 3)
	H.change_stat("constitution", 1)
	H.change_stat("perception", 1)
