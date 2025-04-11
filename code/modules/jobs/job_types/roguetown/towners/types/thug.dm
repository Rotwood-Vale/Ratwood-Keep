/datum/subclass/thug
	name = "Thug"
	tutorial = "You are a lowly thug, selling your brawn to the first bidder you can fine. Maybe you convince the merchant to hire you, or maybe you are a guard for the whitevein. \
	It is entirely up to you"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/towner/thug
	category_tags = list(CTAG_TOWNER)
	maximum_possible_slots = 5

/datum/outfit/job/roguetown/towner/thug/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	gloves = /obj/item/clothing/gloves/roguetown/leather
	belt = /obj/item/storage/belt/rogue/leather
	pants = /obj/item/clothing/under/roguetown/trou
	shoes = /obj/item/clothing/shoes/roguetown/armor/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor
	beltr = /obj/item/rogueweapon/mace/woodclub
	beltl = /obj/item/rogueweapon/huntingknife
	if(prob(23))
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor
	if(prob(77))
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor/red
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("constitution", 2)
		H.change_stat("endurance", 1)
		H.change_stat("intelligence", -1)
	
