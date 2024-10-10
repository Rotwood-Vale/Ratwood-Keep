/datum/advclass/farmermaster
	name = "Master Farmer"
	tutorial = "A master farmer, a story simlar to the likes of Goliath and David, \
	You, a simple peasent, through sheer determination have conquered nature \
	and made it bow before your green thumb."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/farmermaster
	maximum_possible_slots = 1
	pickprob = 0.0001
	category_tags = list(CTAG_PILGRIM)

/datum/outfit/job/roguetown/adventurer/farmermaster/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 6, TRUE) // GIT OEUH ME FAHM
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 6, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 6, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/farming, 6, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/cooking, 5, TRUE) // Legendary chef gets high farming skill, fairs fair
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
	belt = /obj/item/storage/belt/rogue/leather/rope
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	pants = /obj/item/clothing/under/roguetown/trou
	head = /obj/item/clothing/head/roguetown/strawhat
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	backr = /obj/item/storage/backpack/rogue/satchel
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	backl = /obj/item/storage/backpack/rogue/backpack
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	armor = /obj/item/clothing/suit/roguetown/armor/workervest
	mouth = /obj/item/clothing/mask/cigarette/pipe/westman
	if(H.gender == FEMALE)
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		pants = null
	backpack_contents = list(/obj/item/seeds/wheat = 1,/obj/item/seeds/wheat/oat = 1,/obj/item/seeds/apple = 1,/obj/item/seeds/pipeweed = 1,/obj/item/seeds/sweetleaf = 1,/obj/item/seeds/berryrogue = 1,/obj/item/seeds/cabbage = 1,/obj/item/seeds/pear = 1,/obj/item/seeds/cherry = 1,/obj/item/seeds/olive = 1,/obj/item/seeds/nut = 1,/obj/item/seeds/tomato = 1,/obj/item/seeds/onion = 1,/obj/item/seeds/garlic = 1,/obj/item/seeds/carrot = 1,/obj/item/seeds/potato = 1,/obj/item/seeds/eggplant = 1,/obj/item/seeds/bean = 1,/obj/item/seeds/radish = 1,/obj/item/seeds/beet = 1,/obj/item/seeds/bellpepper = 1,/obj/item/seeds/peas = 1,/obj/item/seeds/rice = 1,/obj/item/seeds/cucumber = 1,/obj/item/seeds/tea = 1,/obj/item/seeds/mycelium/plumphelmet = 1,/obj/item/seeds/mycelium/trippy = 1,/obj/item/seeds/mycelium/amanita = 1)
	beltl = /obj/item/rogueweapon/sickle
	beltr = /obj/item/flint
	backr = /obj/item/rogueweapon/hoe
	H.change_stat("strength", 2)
	H.change_stat("endurance", 8) // Wenches swoon over the utterly BUILT back of a legendary soilworker
	H.change_stat("constitution", 4)
	H.change_stat("speed", 1)
