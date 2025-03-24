/datum/subclass/manorguard/archer
	name = "Retinue Archer"
	tutorial = "You are a member of the Ducal Retinue. Ensure the safety of the Duchy and their people, defend the powers that be from the horrors of the outside world, and keep the Duchy of Rockhill alive."
	outfit = /datum/outfit/job/roguetown/manorguard/archer
	category_tags = list(CTAG_MAA)
	maximum_possible_slots = 2

/datum/outfit/job/roguetown/manorguard/archer/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/kettle
	

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/firearms, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("perception", 3)
		H.change_stat("endurance", 2)
		H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	H.adjust_blindness(-3)
	var/weapons = list("Arquebus & Sword", "Bow & Sword")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Arquebus & Sword") //Gunner
			beltl = /obj/item/ammo_holder/bullet/lead
			beltr = /obj/item/rogueweapon/sword
			backl = /obj/item/gun/ballistic/firearm/arquebus
			backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/rope/chain = 1, /obj/item/storage/keyring/man_at_arms = 1, /obj/item/powderflask = 1)
			H.mind.adjust_skillrank(/datum/skill/combat/firearms, 1, TRUE)
		if("Bow & Sword") //Archer
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
			beltr = /obj/item/rogueweapon/sword
			beltl = /obj/item/ammo_holder/quiver/arrows
			backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/rope/chain = 1, /obj/item/storage/keyring/man_at_arms = 1)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
