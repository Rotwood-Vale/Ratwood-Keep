/datum/subclass/fisher
	name = "Fisher"
	tutorial = "You are a fisherman, with your bag of bait and your fishing rod, you are one of few who can reliably get a stable source of meat around here."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/towner/fisher

	category_tags = list(CTAG_TOWNER)

/datum/outfit/job/roguetown/towner/fisher/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/armor/leather
	belt = /obj/item/storage/belt/rogue/leather
	backl = /obj/item/storage/backpack/rogue/satchel
	backr = /obj/item/fishingrod
	beltr = /obj/item/cooking/pan
	beltl = /obj/item/flint
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	head = /obj/item/clothing/head/roguetown/fisherhat
	backpack_contents = list(/obj/item/natural/worms = 2,/obj/item/rogueweapon/shovel/small=1,/obj/item/rogueweapon/huntingknife)
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights/random
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
		armor = /obj/item/clothing/suit/roguetown/armor/workervest
	else
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE) //Fishers should be good at gutting particularly ornery fish.
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE) //Fishers should be good at spearfishing and harpooning their prey.
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/hunting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)

		H.change_stat("perception", 1)
		H.change_stat("constitution", 1)
		H.change_stat("fortune", 1)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/labor/fishing, 5, TRUE)
		else
			H.mind.adjust_skillrank(/datum/skill/labor/fishing, 4, TRUE)
