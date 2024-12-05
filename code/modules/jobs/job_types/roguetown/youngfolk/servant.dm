/datum/job/roguetown/servant
	title = "Servant"
	f_title = "Maid"
	flag = SERVANT
	department_flag = YOUNGFOLK
	faction = "Station"
	total_positions = 6
	spawn_positions = 6

	allowed_races = RACES_SHUNNED_UP_PLUS_SEELIE
	allowed_ages = ALL_AGES_LIST

	tutorial = "Granted a life of comfortable servitute in the Duke's manor, you follow the Head Butler/Maid's commands and spend your day performing necessary but menial tasks."

	outfit = /datum/outfit/job/roguetown/servant
	display_order = JDO_SERVANT
	give_bank_account = TRUE
	min_pq = -10
	max_pq = null

/datum/outfit/job/roguetown/servant/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		if(!isseelie(H))
			H.change_stat("strength", -1)
			H.change_stat("constitution", -1)
			H.change_stat("intelligence", 1)
			H.change_stat("perception", 1)
			H.change_stat("speed", 1)
		else if(isseelie(H))
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/splash)	//Splash now waters crops AND cleans blood, in a 3x3 area but only IF the water bolt hits something
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/summon_rat)			//Good for meat for cooking
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/roustame)			//Good for meat for cooking
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/replenish)			//Replenish was a cut spell now being added for Seelie maids, will replenish EMPTY bushes with more berries
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/sate_crop)			//Different from Dendor spell, will satisfy crop hunger but not bless it

	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		belt = /obj/item/storage/belt/rogue/leather
		beltr = /obj/item/keyring/servant
		beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
	else
		pants = /obj/item/clothing/under/roguetown/tights/stockings/silk/black
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/black
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		cloak = /obj/item/clothing/cloak/apron/waist
		belt = /obj/item/storage/belt/rogue/leather
		beltr = /obj/item/keyring/servant
		beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
