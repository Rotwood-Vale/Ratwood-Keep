/datum/advclass/noble
	name = "Noble"
	tutorial = "You are a noble, from some place far away, trying to visit the nobility of the area \
	you are encouraged to make your own story. But with wealth, come the poor, ready to pilfer you \
	of your hard earned (inherited) Mammons, so tread lightly unless you want to meet a grizzly end."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_TOLERATED_UP
	outfit = /datum/outfit/job/roguetown/adventurer/noble
	traits_applied = list(TRAIT_NOBLE)
	category_tags = list(CTAG_PILGRIM)

/datum/outfit/job/roguetown/adventurer/noble/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
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
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
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
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		pants = /obj/item/clothing/under/roguetown/tights/purple
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/purple
		cloak = /obj/item/clothing/cloak/half
		head = /obj/item/clothing/head/roguetown/fancyhat
	if(H.age == AGE_OLD)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		r_hand = /obj/item/rogueweapon/woodstaff





