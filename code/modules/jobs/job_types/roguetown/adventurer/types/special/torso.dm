//challenge class, spawns with no limbs
/datum/advclass/torso
	name = "Torso"
	tutorial = "Some horrible accident in the forest away all of your limbs!\nSurvival will be a true TRIUMPH."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/torso
	traits_applied = list(TRAIT_HEAVYARMOR, TRAIT_MEDIUMARMOR, TRAIT_STEELHEARTED)
	category_tags = list(CTAG_CHALLENGE)

/datum/outfit/job/roguetown/adventurer/torso/pre_equip(mob/living/carbon/human/H)
	..()
	//insane stats, not like they benefit you until you get limbs
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3 ,TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.change_stat("strength", 5)
	H.change_stat("endurance", 6)
	H.change_stat("constitution", 6)
	H.change_stat("perception", 4)
	H.change_stat("speed", 4)
	pants = /obj/item/clothing/under/roguetown/tights/black
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	backl = /obj/item/storage/backpack/rogue/satchel
	beltl = /obj/item/rogueweapon/huntingknife

	var/static/list/safe_bodyzones = list(
		BODY_ZONE_HEAD,
		BODY_ZONE_CHEST,
	)
	for(var/obj/item/bodypart/limb in H.bodyparts)
		if(limb.body_zone in safe_bodyzones)
			continue
		limb.drop_limb()
		qdel(limb)
