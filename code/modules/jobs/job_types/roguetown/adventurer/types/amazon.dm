/datum/subclass/amazon
	name = "Amazon"
	tutorial = "Amazons are warrior-women from the mysterious isle of Issa. These rare fighters are so tough they can beat ten average men!"
	allowed_sexes = list(FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/amazon
	pickprob = 25
	maximum_possible_slots = 3
	category_tags = list(CTAG_ADVENTURER)

	cmode_music = 'sound/music/combat_gronn.ogg'

/datum/outfit/job/roguetown/adventurer/amazon/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltl = /obj/item/rogueweapon/huntingknife
	shoes = /obj/item/clothing/shoes/roguetown/gladiator
	backl = /obj/item/storage/backpack/rogue/satchel
	if(prob(25))
		armor = /obj/item/clothing/suit/roguetown/armor/leather
	if(prob(25))
		armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
	if(prob(20))
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail/chainkini
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	if(prob(50))
		shoes = /obj/item/clothing/shoes/roguetown/armor
	if(prob(50))
		beltr = /obj/item/rogueweapon/sword/iron
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	else
		r_hand = /obj/item/rogueweapon/spear
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.change_stat("strength", 2)
	H.change_stat("intelligence", -2)
	H.change_stat("constitution", 3)
	H.change_stat("perception", 1)
	H.change_stat("endurance", 3)
	H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
	if(H.wear_mask) //for stupid stupid with bad eyes
		var/obj/I = H.wear_mask
		H.dropItemToGround(H.wear_mask, TRUE)
		qdel(I)
