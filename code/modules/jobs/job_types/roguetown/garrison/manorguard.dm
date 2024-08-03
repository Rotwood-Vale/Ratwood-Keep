/datum/job/roguetown/manorguard
	title = "Man at Arms"
	flag = MANATARMS
	department_flag = GARRISON
	faction = "Station"
	total_positions = 8
	spawn_positions = 8

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	tutorial = "Having proven yourself loyal and capable, you are entrusted to defend the Royal Family and their Court, trained regularly in combat and siege warfare you stand a small chance of surviving the King's reign."
	display_order = JDO_CASTLEGUARD
	whitelist_req = TRUE

	outfit = /datum/outfit/job/roguetown/manorguard
	advclass_cat_rolls = CTAG_MENATARMS

	give_bank_account = 22
	min_pq = 6
	max_pq = null

	cmode_music = 'sound/music/combat_guard2.ogg'

/datum/job/roguetown/manorguard/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.cloak, /obj/item/clothing/cloak/stabard/surcoat/guard))
			var/obj/item/clothing/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = "man-at-arms jupon ([index])"

/datum/outfit/job/roguetown/manorguard/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/under/roguetown/chainlegs
	cloak = /obj/item/clothing/cloak/stabard/surcoat/guard
	gloves = /obj/item/clothing/gloves/roguetown/chain
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	beltl = /obj/item/keyring/guardcastle
	belt = /obj/item/storage/belt/rogue/leather/black
	backr = /obj/item/storage/backpack/rogue/satchel/black
	if(H.gender == FEMALE)
		var/acceptable = list("Tomboy", "Bob", "Curly Short")
		if(!(H.hairstyle in acceptable))
			H.hairstyle = pick(acceptable)
			H.update_hair()

// Maces + Axes + Shield	-	Better armor, typical Man-at-Arms loadout
/datum/advclass/manorguard/footsman
	name = "Men-at-Arms Footsman"
	tutorial = "You are a professional soldier of the realm, specializing in shields, swords, bows, and crossbows. You sport a keen eye, looking for your enemies weaknesses."
	outfit = /datum/outfit/job/roguetown/manorguard/boltman

	category_tags = list(CTAG_MENATARMS)

/datum/outfit/job/roguetown/manorguard/boltman/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)		//Skilled swordsman.
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 5, TRUE)		//Only effects draw and reload time.
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 5, TRUE)			//Only effects draw times.

	//Normal shared skill section.
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	H.verbs |= /mob/proc/haltyell

	//Basically slight bonuses; slightly better than Watch, less than a knight
	H.change_stat("strength", 2)
	H.change_stat("intelligence", 1)
	H.change_stat("constitution", 2)
	H.change_stat("endurance", 2)

	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy		//Bit worse shirt protection than the archer
	armor = /obj/item/clothing/suit/roguetown/armor/plate/scale			//Makes up for worse shirt protection with kinda better armor protection
	head = /obj/item/clothing/head/roguetown/helmet/sallet				//Better protection than kettle archer has
	if(prob(50))
		beltr = /obj/item/rogueweapon/stoneaxe/woodcut		//If too weak, consider giving steel axe.
		backl = /obj/item/rogueweapon/shield/wood
	else
		beltr = /obj/item/rogueweapon/mace/cudgel
		backl = /obj/item/rogueweapon/spear/billhook

	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/rope/chain = 1)

// Shield + Swords + Crossbow/Bow	-	Lighter armor, but ranged + sword skill in exchange for it.
/datum/advclass/manorguard/boltman
	name = "Men-at-Arms Boltman"
	tutorial = "You are a professional soldier of the realm, specializing in shields, swords, bows, and crossbows. You sport a keen eye, looking for your enemies weaknesses."
	outfit = /datum/outfit/job/roguetown/manorguard/boltman

	category_tags = list(CTAG_MENATARMS)

/datum/outfit/job/roguetown/manorguard/boltman/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)		//Skilled swordsman.
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 5, TRUE)		//Only effects draw and reload time.
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 5, TRUE)			//Only effects draw times.

	//Normal shared skill section.
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	H.verbs |= /mob/proc/haltyell

	//Basically slight bonuses; slightly better than Watch, less than a knight
	H.change_stat("strength", 2)
	H.change_stat("intelligence", 1)
	H.change_stat("constitution", 1)
	H.change_stat("endurance", 1)
	H.change_stat("speed", 1)

	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail			//Helps against other attack types
	armor = /obj/item/clothing/suit/roguetown/armor/leather/studded		//Helps against arrows; makes sense for a ranged-type role.
	head = /obj/item/clothing/head/roguetown/helmet/kettle				//Worse helmet than a sallet, but makes sense + you have kinda better skills anyway.
	//I feel bad they have full hands round-start but this is the price you have for being given a satchel.
	l_hand = /obj/item/rogueweapon/shield/tower
	r_hand = /obj/item/rogueweapon/sword/short
	beltr = /obj/item/quiver/bolts
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow

	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/rope/chain = 1)
