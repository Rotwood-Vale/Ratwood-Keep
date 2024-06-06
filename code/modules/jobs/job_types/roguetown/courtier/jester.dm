/datum/job/roguetown/jester
	title = "Jester"
	flag = JESTER
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = CLOTHED_RACES_TYPES

	tutorial = "The Grenzelhofts were known for their Jesters, wisemen with a tongue just as sharp as their wit. You command a position of a fool, envious of the position your superiors have upon you. Your cheap tricks and illusions of intelligence will only work for so long, and someday youll find yourself at the end of something sharper than you."

	allowed_ages = ADULT_AGES_LIST
	spells = list(/obj/effect/proc_holder/spell/self/telljoke,/obj/effect/proc_holder/spell/self/telltragedy)
	outfit = /datum/outfit/job/roguetown/jester
	display_order = JDO_JESTER
	give_bank_account = TRUE
	min_pq = -4 //retard jesters are funny so low PQ requirement
	max_pq = null

/datum/outfit/job/roguetown/jester/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/jester
	pants = /obj/item/clothing/under/roguetown/tights
	armor = /obj/item/clothing/suit/roguetown/shirt/jester
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/keyring/servant
	beltl = /obj/item/storage/belt/rogue/pouch
	head = /obj/item/clothing/head/roguetown/jester
	neck = /obj/item/clothing/neck/roguetown/coif
	//Desc says grenzelhoft has great jesters so 50% change to raceswap because slop lore
	if(ishumannorthern(H) && prob(50))
		H.skin_tone = SKIN_COLOR_GRENZELHOFT
		H.update_body()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/music, pick(1,2), TRUE)
		H.STASTR = rand(1, 20)
		H.STAINT = rand(1, 20)
		H.STALUC = rand(1, 20)
		H.cmode_music = 'sound/music/combat_jester.ogg'
/*
		if(H.gender == MALE)
			if(H.dna?.species)
				if(iself(H) || ishalfelf(H))
					H.dna.species.soundpack_m = new /datum/voicepack/male/elf/jester()
				if(ishumannothern(H))
					H.dna.species.soundpack_m = new /datum/voicepack/male/jester()
				if(isdwarf(H))
					H.dna.species.soundpack_m = new /datum/voicepack/male/dwarf/jester()
		H.hair_color = "cd65cb"
		H.facial_hair_color = "cd65cb"
		H.update_body_parts_head_only()
*/
	ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_ZJUMP, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LEAPER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NUTCRACKER, TRAIT_GENERIC)
