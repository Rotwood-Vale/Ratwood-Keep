/datum/advclass/foresworn //Tanky class, starts with good con/end and spears or sword/shield
	name = "Foresworn"
	tutorial = "Perhaps a mercenary, perhaps a deserter - at one time, you killed for a master in return for gold. Now you live with no such master over your head - and take what you please."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/bandit/foresworn
	category_tags = list(CTAG_BANDIT)
	cmode_music = 'sound/music/combat_bandit2.ogg'

/datum/outfit/job/roguetown/bandit/foresworn/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	belt = /obj/item/storage/belt/rogue/leather
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	shoes = /obj/item/clothing/shoes/roguetown/armor
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/needle/thorn = 1, /obj/item/natural/cloth = 1)
	mask = /obj/item/clothing/mask/rogue/facemask/steel
	neck = /obj/item/clothing/neck/roguetown/gorget
	H.change_stat("strength", 2) //Removing the speed, buffing CON and INT to double down on Foresworn being a "Bandit Tank" (Brigands are hard-hitting and great grapplers, Knaves are fast/ranged, Foresworn are sturdy and skilled)
	H.change_stat("endurance", 2)
	H.change_stat("constitution", 3)
	H.change_stat("intelligence", -1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	H.adjust_blindness(-3)
	var/weapons = list("Spear","Sword & Shield")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Spear") //Deserter watchman. Maybe should be shield and spear? plenty of shields at the bandit hideout though.
			r_hand = /obj/item/rogueweapon/spear
			head = /obj/item/clothing/head/roguetown/helmet/skullcap
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE) //Wielded defense goes from 
		if("Sword & Shield") //Mercenary on the wrong side of the law
			backl= /obj/item/rogueweapon/shield/tower/metal //Before, wielding the sword with two hands would give you 130% defense and sword + shield would give 150%; Now, wielding the sword with two hands gives 150% and sword + shield gives 180%.
			beltr = /obj/item/rogueweapon/sword/iron //iron sword like literally every adventurer gets
			head = /obj/item/clothing/head/roguetown/helmet/leather/volfhelm
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE) 
	H.verbs |= /mob/proc/haltyell
	H.ambushable = FALSE
