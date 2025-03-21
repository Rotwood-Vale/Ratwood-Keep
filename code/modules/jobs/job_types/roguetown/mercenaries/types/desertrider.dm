/datum/subclass/desert_rider
	name = "Desert Rider"
	tutorial = "Hooded figures clad in red and easily identifiable by their distinctive emblem, the Desert Riders of Shalvistine are a loosely-governed society of mercenaries and refugees hailing from the fringes of the Zybantian Empire. You were riding saigaback before you could even walk, and you likely feel more at ease on four legs than two. Due to political unrest with neighboring Lalvestine, increasingly deadly sandstorms, or merely a sense of adventure, you find yourself with the Mercenaries’ Guild in Rockhill, selling your skills with the blade to those willing to pay."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		/datum/species/tieberian,
		/datum/species/lizardfolk,
		/datum/species/tabaxi,
		/datum/species/human/northern,
		/datum/species/demihuman,
		/datum/species/anthromorph,
		/datum/species/elf/dark,
	)
	outfit = /datum/outfit/job/roguetown/mercenary/desert_rider
	maximum_possible_slots = 10
	min_pq = 2
	torch = FALSE
	cmode_music = 'sound/music/combat_desertrider.ogg'
	category_tags = list(CTAG_MERCENARY)

/datum/outfit/job/roguetown/mercenary/desert_rider/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/armor/shalal
	head = /obj/item/clothing/head/roguetown/roguehood/shalal
	gloves = /obj/item/clothing/gloves/roguetown/leather/angle
	belt = /obj/item/storage/belt/rogue/leather/shalal
	armor = /obj/item/clothing/suit/roguetown/armor/plate/scale
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	backr = /obj/item/storage/backpack/rogue/satchel
	backl = /obj/item/rogueweapon/sword/long/rider
	beltl = /obj/item/storage/keyring/mercenary
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	pants = /obj/item/clothing/under/roguetown/chainlegs/iron
	neck = /obj/item/clothing/neck/roguetown/shalal

	if(ishumannorthern(H))
		var/list/skin_slop = H.dna.species.get_skin_list()
		H.skin_tone = skin_slop["Shalvistine"]
		H.update_body()
	if(isdemihuman(H))
		var/list/skin_slop = H.dna.species.get_skin_list()
		H.skin_tone = skin_slop["Shalvistine"]
		H.update_body()

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("endurance", 2)
		H.change_stat("constitution", 1)
		H.change_stat("perception", 1)
		H.change_stat("speed", 2)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
