/datum/subclass/amazon
	name = "Amazon"
	tutorial = "Amazons are warrior-women from the mysterious isle of Issa. These rare fighters are so tough they can beat an average man!"
	allowed_sexes = list(FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/refugee/amazon
	maximum_possible_slots = 5
	category_tags = list(CTAG_REFUGEE)

	cmode_music = 'sound/music/combat_gronn.ogg'

/datum/outfit/job/roguetown/refugee/amazon/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/hunting, 3, TRUE)
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltl = /obj/item/rogueweapon/huntingknife
	shoes = /obj/item/clothing/shoes/roguetown/gladiator
	backl = /obj/item/storage/backpack/rogue/satchel
	H.change_stat("strength", 3)
	H.change_stat("intelligence", -2)
	H.change_stat("constitution", 3)
	H.change_stat("perception", 2)
	H.change_stat("endurance", 3)
	H.change_stat("speed", 3)
	ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	var/weapons = list("Sword","Spear")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Sword") //one weapon to hurt people one weapon to kill people
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			beltr = /obj/item/rogueweapon/sword/iron
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/chainkini
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		if("Spear") //plate users beware, you're in for a scare!
			armor = /obj/item/clothing/suit/roguetown/armor/leather/bikini
			r_hand = /obj/item/rogueweapon/spear
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
