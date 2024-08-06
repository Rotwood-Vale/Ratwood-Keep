/datum/job/roguetown/veteran
	title = "Veteran Mercenary"
	flag = VETERAN
	department_flag = MERCENARIES
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_sexes = list(MALE, FEMALE) //same as town guard
	allowed_races = RACES_ALL_KINDS // same as town guard
	tutorial = "You've known combat your entire life. There isn't a way to kill a man you havent practiced in the tapestries of war itself. You wouldn't call yourself a hero, those belong to the men left rotting in the fields of where you practiced your ancient trade. You don't sleep well at night anymore, you don't like remembering what you've had to do to survive. Trading adventure for stable pay was the only logical solution, and maybe someday you'll get to lay down the blade..."
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	display_order = JDO_VET
	whitelist_req = TRUE

	spells = list(/obj/effect/proc_holder/spell/self/convertrole/mercenary)

	outfit = /datum/outfit/job/roguetown/veteran
	give_bank_account = 35
	min_pq = 3
	max_pq = null

	cmode_music = 'sound/music/combat_guard.ogg'

/datum/job/roguetown/veteran/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.cloak, /obj/item/clothing/cloak/half/vet))
			var/obj/item/clothing/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = "veteran cloak ([index])"

/datum/outfit/job/roguetown/veteran/pre_equip(mob/living/carbon/human/H)
	..()
	cloak = /obj/item/clothing/cloak/half/vet
	neck = /obj/item/clothing/neck/roguetown/bervor
	armor = /obj/item/clothing/suit/roguetown/armor/plate/scale
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	pants = /obj/item/clothing/under/roguetown/chainlegs
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/rogueweapon/sword/sabre
	beltr = /obj/item/roguekey/mercenary
	backr = /obj/item/storage/backpack/rogue/satchel/black
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1)
	if(H.mind)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 6, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 6, TRUE)
		else
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 5, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)		//Actual cancer but he fucks. Hard.
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
		H.change_stat("perception", 1)
		H.change_stat("intelligence", 4)
		H.change_stat("endurance", 1)
	H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
