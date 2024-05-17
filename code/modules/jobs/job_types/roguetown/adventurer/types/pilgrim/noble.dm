/datum/advclass/noble
	name = "Noble"
	allowed_sexes = list("male", "female")
	allowed_races = NOBLE_RACES_TYPES
	outfit = /datum/outfit/job/roguetown/adventurer/noble
	traits_applied = list(RTRAIT_NOBLE)
	isvillager = FALSE
	ispilgrim = TRUE


/datum/outfit/job/roguetown/adventurer/noble/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
	H.change_stat("intelligence", 1)
	shoes = /obj/item/clothing/shoes/roguetown/boots
	belt = /obj/item/storage/belt/rogue/leather/black
	beltr = /obj/item/flashlight/flare/torch/lantern
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel)
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	id = /obj/item/clothing/ring/silver
	if(H.gender == FEMALE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/music, 1, TRUE)
		H.change_stat("strength", -2)
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/purple
		head = /obj/item/clothing/head/roguetown/hatblu
		cloak = /obj/item/clothing/cloak/raincloak/purple
		beltl = /obj/item/storage/belt/rogue/pouch/food
	if(H.gender == MALE)
		H.change_stat("strength", -1)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		pants = /obj/item/clothing/under/roguetown/tights/purple
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/purple
		cloak = /obj/item/clothing/cloak/half
		head = /obj/item/clothing/head/roguetown/fancyhat
	if(H.age == AGE_OLD)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		r_hand = /obj/item/rogueweapon/woodstaff





