/datum/advclass/amazon
	name = "Amazon"
	tutorial = "Amazons are tough warrior-women trained in agility and skirmishing compared to their male counterpart."
	allowed_sexes = list(FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/amazon
	category_tags = list(CTAG_ADVENTURER)

	traits_applied = list(TRAIT_CRITICAL_RESISTANCE, TRAIT_NOPAINSTUN, TRAIT_STEELHEARTED)
	cmode_music = 'sound/music/combat_gronn.ogg'

/datum/outfit/job/roguetown/adventurer/amazon/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE) //switching to your sidearm is faster than reloading your spear
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/butchering, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE) //amazons still have worse skills spread than barbarians but this bridges the gap quite a bit
	r_hand = /obj/item/rogueweapon/spear
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltl = /obj/item/rogueweapon/huntingknife
	shoes = /obj/item/clothing/shoes/roguetown/gladiator
	backl = /obj/item/storage/backpack/rogue/satchel
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/chainkini
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	H.change_stat("intelligence", -2) //dumber than warrior, used to justify high speed
	H.change_stat("strength", 2)
	H.change_stat("constitution", 2) //weaker and more fragile than the barbarian(same level as warrior) but faster than both
	H.change_stat("endurance", 2)
	H.change_stat("speed", 2) //6 point balance, 1 less than warrior but stats are optimised towards combat better
	if(H.wear_mask) //for stupid retards with bad eyes
		var/obj/I = H.wear_mask
		H.dropItemToGround(H.wear_mask, TRUE)
		qdel(I)
