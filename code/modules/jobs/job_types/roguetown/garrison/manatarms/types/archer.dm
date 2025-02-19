/datum/subclass/manorguard/archer
	name = "Retinue Archer"
	tutorial = "You are a member of the Ducal Retinue. Ensure the safety of the Duchy and their people, defend the powers that be from the horrors of the outside world, and keep the Duchy of Rockhill alive."
	outfit = /datum/outfit/job/roguetown/manorguard/archer
	category_tags = list(CTAG_MAA)

/datum/outfit/job/roguetown/manorguard/archer/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/kettle
	beltl = /obj/item/rogueweapon/mace/cudgel
	if(prob(50))
		beltr = /obj/item/ammo_holder/quiver/bolts
		backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	else
		beltr = /obj/item/ammo_holder/quiver/arrows
		backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow

	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/rope/chain = 1, /obj/item/storage/keyring/man_at_arms = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/firearms, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("perception", 3)
		H.change_stat("constitution", -1)
		H.change_stat("endurance", 1)
		H.change_stat("speed", 2)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
