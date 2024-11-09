
/datum/outfit/job/roguetown/1event/footsoldier/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/heavy/guard
	pants = /obj/item/clothing/under/roguetown/chainlegs
	gloves = /obj/item/clothing/gloves/roguetown/chain
	neck = /obj/item/clothing/neck/roguetown/gorget
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half
	shoes = /obj/item/clothing/shoes/roguetown/armor/leather
	belt = /obj/item/storage/belt/rogue/leather/black
	backr = /obj/item/storage/backpack/rogue/satchel/black
	backpack_contents = list(/obj/item/rope/chain = 1)
	r_hand = /obj/item/rogueweapon/sword/rapier
	l_hand = /obj/item/rogueweapon/shield/wood
	if(H.mind)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/polearms, 4, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/maces, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/sneaking, 1, TRUE) 
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/riding, 1, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("perception", 2)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 1)
		H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
