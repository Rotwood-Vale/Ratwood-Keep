// Urban costal-city dwellers, ranging from thieves to guardsmen. Sword skill and crossbow, but doesn't excell at much besides versatility.
/datum/advclass/mercenary/condottiero
	name = "Condottiero Guildsman"
	tutorial = "Hailing from shady port cities you found your calling in life. Slinging bolts, cutting throats, and taking names. Wether an ex-thief or an ex-guard, it matters not. You are bound by your Guild, and you are bound by coin."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/mercenary/condottiero
	category_tags = list(CTAG_MERCENARY)
	maximum_possible_slots = 5

/datum/outfit/job/roguetown/mercenary/condottiero/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	cloak = /obj/item/clothing/cloak/half/red
	gloves = /obj/item/clothing/gloves/roguetown/angle
	belt = /obj/item/storage/belt/rogue/leather/black
	head = /obj/item/clothing/head/roguetown/helmet
	armor = /obj/item/clothing/suit/roguetown/armor/plate/scale
	backl = /obj/item/storage/backpack/rogue/satchel
	beltl = /obj/item/rogueweapon/sword/short
	beltr = /obj/item/quiver/bolts
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	r_hand = /obj/item/rogueweapon/shield/wood
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	pants = /obj/item/clothing/under/roguetown/trou/leather
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	backpack_contents = list(/obj/item/roguekey/mercenary, /obj/item/storage/belt/rogue/pouch/coins/poor, /obj/item/rogueweapon/huntingknife/idagger/navaja)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)	//Not a rogue but, you know, possible thief.
		H.change_stat("endurance", 2)
		H.change_stat("constitution", 2)
		H.change_stat("strength", 1)
		H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
