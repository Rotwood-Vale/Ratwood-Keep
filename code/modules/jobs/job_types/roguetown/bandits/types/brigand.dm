/datum/subclass/brigand //Strength class, starts with axe or flails and medium armor training
	name = "Brigand"
	tutorial = "Cast from society, you use your powerful physical might and endurance to take from those who are weaker from you."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/bandit/brigand
	category_tags = list(CTAG_BANDIT)
	cmode_music = 'sound/music/combat_bandit_brigand.ogg'

/datum/outfit/job/roguetown/bandit/brigand/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
	belt = /obj/item/storage/belt/rogue/leather
	if(prob(30))
		belt = /obj/item/storage/belt/rogue/leather/black
	pants = /obj/item/clothing/under/roguetown/trou/leather
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/needle/thorn = 1, /obj/item/natural/cloth = 1)
	head = /obj/item/clothing/head/roguetown/helmet/leather/volfhelm
	var/neck2choose = pickweight(list("Coif" = 3, "Chaincoif" = 1))
	switch(neck2choose)
		if("Coif")
			neck = /obj/item/clothing/neck/roguetown/coif
		if("Chaincoif")
			neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
	var/mask2choose = pickweight(list("Rag" = 1, "Iron" = 2, "Steel" = 1))
	switch(mask2choose)
		if("Rag")
			mask = /obj/item/clothing/mask/rogue/rag
		if("Iron")
			mask = /obj/item/clothing/mask/rogue/facemask
		if("Steel")
			mask = /obj/item/clothing/mask/rogue/facemask/steel
	var/armor2choose = pickweight(list("Hide" = 2, "Leather" = 2, "Plate" = 1))
	switch(armor2choose)
		if("Hide")
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
			shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
		if("Leather")
			armor = /obj/item/clothing/suit/roguetown/armor/leather
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/light
		if("Plate")
			armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
			shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	var/boots2choose = pickweight(list("Dark" = 1, "Leather" = 1))
	switch(boots2choose)
		if("Dark")
			shoes = /obj/item/clothing/shoes/roguetown/armor
		if("Leather")
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
	H.change_stat("strength", 3)
	H.change_stat("endurance", 2)
	H.change_stat("constitution", 2)
	H.change_stat("perception", 1)
	H.change_stat("intelligence", -2)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	H.adjust_blindness(-3)
	var/weapons = list("Axe & Cudgel","Flail & Shield")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Axe & Cudgel") //one weapon to hurt people one weapon to kill people
			backl= /obj/item/rogueweapon/stoneaxe/woodcut
			beltr = /obj/item/rogueweapon/mace/cudgel
		if("Flail & Shield") //plate users beware, you're in for a scare!
			backl= /obj/item/rogueweapon/shield/wood
			beltr = /obj/item/rogueweapon/flail

	H.verbs |= /mob/proc/haltyell
	H.ambushable = FALSE
