/datum/job/roguetown/artificer
	title = "Artificer"
	flag = ARTIFICER
	department_flag = YEOMEN
	faction = "Station"
	total_positions = 2
	spawn_positions = 2

	allowed_races = RACES_SHUNNED_UP
	allowed_sexes = list(MALE, FEMALE)

	tutorial = "Hidden in the depths are ancient mechanical secrets, something your creed has taken it upon themselves to studying and understanding. To some, these mechanical wonders may seem like magic, but you know their inner workings as well as you do stone, down to the last cog."

	outfit = /datum/outfit/job/roguetown/artificer
	display_order = JDO_ARTIFICER
	give_bank_account = 8
	min_pq = 0
	max_pq = null

/datum/outfit/job/roguetown/artificer/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/labor/mining, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/masonry, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/engineering, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	head = /obj/item/clothing/head/roguetown/hatfur
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/hatblu
//	armor = /obj/item/clothing/suit/roguetown/armor/workervest
	cloak = /obj/item/clothing/cloak/apron/waist/brown
	pants = /obj/item/clothing/under/roguetown/trou
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	shoes = /obj/item/clothing/shoes/roguetown/armor/leather
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
	beltl = /obj/item/key/artificer
	mask = /obj/item/clothing/mask/rogue/spectacles/golden
	backl = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(/obj/item/rogueweapon/hammer/claw = 1, /obj/item/key/artificer)
	H.change_stat("strength", 1)
	H.change_stat("intelligence", 2)
	H.change_stat("endurance", 1)
	H.change_stat("constitution", 1)
	H.change_stat("speed", -1)
