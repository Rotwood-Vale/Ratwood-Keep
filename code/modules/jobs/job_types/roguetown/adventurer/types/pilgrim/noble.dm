/datum/advclass/noble
	name = "Noble"
	tutorial = "You are a noble, from some place far away, trying to visit the nobility of the area \
	you are encouraged to make your own story. But with wealth, come the poor, ready to pilfer you \
	of your hard earned (inherited) Mammons, so tread lightly unless you want to meet a grizzly end."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/noble
	traits_applied = list(TRAIT_NOBLE)
	category_tags = list(CTAG_PILGRIM)

	noble_income = 10

/datum/outfit/job/roguetown/adventurer/noble/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/boots
	belt = /obj/item/storage/belt/rogue/leather/black
	beltr = /obj/item/flashlight/flare/torch/lantern
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel)
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	id = /obj/item/clothing/ring/silver
	cloak = /obj/item/clothing/cloak/half/red
	if(H.pronouns == SHE_HER || H.pronouns == THEY_THEM_F)
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/purple
		head = /obj/item/clothing/head/roguetown/hatblu
		beltl = /obj/item/storage/belt/rogue/pouch/food
		pants = /obj/item/clothing/under/roguetown/tights/stockings/silk/random	//Added Silk Stockings for the female nobles
	else
		pants = /obj/item/clothing/under/roguetown/tights/random
		shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/random
		head = /obj/item/clothing/head/roguetown/fancyhat
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/music, 1, TRUE)
	H.change_stat("perception", 1)
	H.change_stat("constitution", 1)
	H.change_stat("intelligence", 1)
	H.change_stat("speed", 1)
	if(H.age == AGE_OLD)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		r_hand = /obj/item/rogueweapon/woodstaff





