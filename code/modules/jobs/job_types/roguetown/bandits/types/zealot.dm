/datum/subclass/zealot //cleric
	name = "Zealot"
	tutorial = "A true believer, and in return Matthios allows this unhinged individual to channel some power."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/bandit/zealot
	category_tags = list(CTAG_BANDIT)
	cmode_music = 'sound/music/combat_bandit2.ogg'
	maximum_possible_slots = 1

/datum/outfit/job/roguetown/bandit/zealot/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/treatment, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)

	head = /obj/item/clothing/head/roguetown/menacing/bandit
	shirt = /obj/item/clothing/suit/roguetown/armor/leather/vest
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	id = /obj/item/clothing/ringP
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltl = /obj/item/rogueweapon/huntingknife
	pants = /obj/item/clothing/under/roguetown/trou/leather
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/needle/thorn = 1, /obj/item/natural/bundle/cloth/bandage/full = 1)
	var/boots2choose = pickweight(list("Short" = 1, "Leather" = 1))
	switch(boots2choose)
		if("Short")
			shoes = /obj/item/clothing/shoes/roguetown/shortboots
		if("Leather")
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather

	H.change_stat("strength", 2)
	H.change_stat("constitution", 1)
	H.change_stat("intelligence", -2)
	H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	H.adjust_blindness(-3)
	var/weapons = list("Crusher", "Club & Shield")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Crusher")
			r_hand = /obj/item/rogueweapon/flail/crusher
		if("Club & Shield")
			backl= /obj/item/rogueweapon/shield/wood
			beltr = /obj/item/rogueweapon/mace/woodclub
	H.verbs |= /mob/proc/haltyell
	H.ambushable = FALSE

	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_spells_churchling(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
