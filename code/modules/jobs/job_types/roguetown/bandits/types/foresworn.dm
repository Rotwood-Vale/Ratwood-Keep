/datum/subclass/foresworn //Generalist glass. Good with a variety of weapons, more even spread stats.
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
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
	belt = /obj/item/storage/belt/rogue/leather
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/needle/thorn = 1, /obj/item/natural/cloth = 1)
	var/mask2choose = pickweight(list("Shepherd" = 1, "Iron" = 1, "Steel" = 1))
	switch(mask2choose)
		if("Shepherd")
			mask = /obj/item/clothing/mask/rogue/shepherd
		if("Iron")
			mask = /obj/item/clothing/mask/rogue/facemask
		if("Steel")
			mask = /obj/item/clothing/mask/rogue/facemask/steel
	var/neck2choose = pickweight(list("Coif" = 1, "Chaincoif" = 2, "Gorget" = 2))
	switch(neck2choose)
		if("Coif")
			neck = /obj/item/clothing/neck/roguetown/coif
		if("Chaincoif")
			neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
		if("Gorget")
			neck = /obj/item/clothing/neck/roguetown/gorget
	var/armor2choose = pickweight(list("Hide" = 2, "Leather" = 2, "Chain" = 1))
	switch(armor2choose)
		if("Gambeson")
			armor = /obj/item/clothing/suit/roguetown/armor/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/advanced
		if("Paddedr")
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
			wrists = /obj/item/clothing/wrists/roguetown/bracers
		if("Chain")
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	var/pants2choose = pickweight(list("Leather" = 1, "Chain" = 1))
	switch(pants2choose)
		if("Leather")
			pants = /obj/item/clothing/under/roguetown/trou/leather
		if("Chain")
			pants = /obj/item/clothing/under/roguetown/chainlegs
	var/boots2choose = pickweight(list("Dark" = 1, "Leather" = 1))
	switch(boots2choose)
		if("Dark")
			shoes = /obj/item/clothing/shoes/roguetown/armor
		if("Leather")
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
	H.change_stat("strength", 2) //less buffs than brigand but less int debuff also somewhat faster
	H.change_stat("endurance", 2)
	H.change_stat("constitution", 2)
	H.change_stat("intelligence", -2)
	H.change_stat("speed", 2)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	H.adjust_blindness(-3)
	var/weapons = list("Spear","Sword & Shield")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Spear") //Deserter watchman. Maybe should be shield and spear? plenty of shields at the bandit hideout though.
			r_hand = /obj/item/rogueweapon/spear
			beltr = /obj/item/rogueweapon/huntingknife
			head = /obj/item/clothing/head/roguetown/helmet/skullcap
		if("Sword & Shield") //Mercenary on the wrong side of the law
			backl= /obj/item/rogueweapon/shield/wood
			beltr = /obj/item/rogueweapon/sword/iron //iron sword like literally every refugee gets
			head = /obj/item/clothing/head/roguetown/helmet/leather/volfhelm
	H.verbs |= /mob/proc/haltyell
	H.ambushable = FALSE
