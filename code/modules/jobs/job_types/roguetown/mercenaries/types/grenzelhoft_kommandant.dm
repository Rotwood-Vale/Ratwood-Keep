/datum/advclass/grenzelhoft_kommandant
	name = "Grenzelhoft Kommandant"
	tutorial = "Unbreakable. Resolute. Master of the field. Fearless. \
	These are the first words that come to mind when one mentions the Kommandant, the unparalleled leader of the well reputed, \
	expensive and noble Grenzelhoft mercenaries of the emperiate guild of the Grenzel empire. \
	The mercenaries of Gren rightfully fear and respect their Kommandant, walking to certain death on his one word."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		/datum/species/akula,
		/datum/species/vulpkanin,
		/datum/species/lupian,
		/datum/species/dracon,
		/datum/species/moth, //grenzelmoft?
		/datum/species/dwarf/mountain,
		/datum/species/human/northern,
		/datum/species/demihuman,
		/datum/species/anthromorph,
		/datum/species/tabaxi
	)
	outfit = /datum/outfit/job/roguetown/mercenary/grenzelhoft_kommandant
	maximum_possible_slots = 1
	min_pq = 4
	torch = FALSE
	cmode_music = 'sound/music/combat_grenzelhoft.ogg'
	category_tags = list(CTAG_MERCENARY)

/datum/outfit/job/roguetown/mercenary/grenzelhoft_kommandant/pre_equip(mob/living/carbon/human/H)
	..()
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/keyring/mercenary_boss
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	neck = /obj/item/clothing/neck/roguetown/gorget
	shirt = /obj/item/clothing/suit/roguetown/shirt/grenzelhoft
	head = /obj/item/clothing/head/roguetown/grenzelhofthat
	armor = /obj/item/clothing/suit/roguetown/armor/blacksteel/cuirass
	pants = /obj/item/clothing/under/roguetown/grenzelpants
	shoes = /obj/item/clothing/shoes/roguetown/armor/grenzelhoft
	gloves = /obj/item/clothing/gloves/roguetown/grenzelgloves
	backr = /obj/item/storage/backpack/rogue/satchel
	r_hand = /obj/item/rogueweapon/sword/long/rider/messer

	//Humie grenzelhofts are always set to be, well, grenzelhoft
	if(ishumannorthern(H))
		var/list/skin_slop = H.dna.species.get_skin_list()
		H.skin_tone = skin_slop["Grenzelhoft"]
		H.update_body()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("endurance", 2)
		H.change_stat("constitution", 2)
		H.change_stat("perception", 2)
		H.change_stat("speed", 2)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
