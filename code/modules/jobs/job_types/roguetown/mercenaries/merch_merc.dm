/datum/job/roguetown/grabber
	title = "Henchman"
	flag = GRABBER
	department_flag = MERCENARIES
	faction = "Station"
	total_positions = 2
	spawn_positions = 2

	allowed_races = RACES_VERY_SHUNNED_UP
	allowed_sexes = list(MALE, FEMALE)

	tutorial = "You are brute, a hired muscle for the local brothel.\
				Working under the nightmaster, you ensure nobody causes trouble or harms the prostitutes,\
				and help keeping the long arm of the law away from the shady business happening inside."

	outfit = /datum/outfit/job/roguetown/grabber
	display_order = JDO_GRABBER
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_giza.ogg'

/datum/outfit/job/roguetown/grabber/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		if(H.gender == MALE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
		else
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
	if(H.gender == MALE)
		shoes = /obj/item/clothing/shoes/roguetown/armor/leather
		pants = /obj/item/clothing/under/roguetown/tights/sailor
		neck = /obj/item/storage/belt/rogue/pouch/coins/poor
		beltr = /obj/item/rogueweapon/mace/woodclub
		beltl = /obj/item/storage/keyring/nightman
		belt = /obj/item/storage/belt/rogue/leather/rope
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor
		if(prob(30))
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor/red
		if(prob(23))
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor
		H.change_stat("strength", 2)
		H.change_stat("intelligence", -3)
		H.change_stat("endurance", 3)
		H.change_stat("constitution", 2)
	else
		shoes = /obj/item/clothing/shoes/roguetown/gladiator
		pants = /obj/item/clothing/under/roguetown/tights/sailor
		beltr = /obj/item/rogueweapon/sword/cutlass
		neck = /obj/item/storage/belt/rogue/pouch/coins/poor
		beltl = /obj/item/storage/keyring/nightman
		belt = /obj/item/storage/belt/rogue/leather/rope
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor
		if(prob(23))
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor
		if(prob(77))
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor/red
		H.change_stat("strength", 1)
		H.change_stat("perception", 2)
		H.change_stat("intelligence", -3)
		H.change_stat("endurance", 4)
		H.change_stat("speed", 3)
		H.change_stat("constitution", 1)
