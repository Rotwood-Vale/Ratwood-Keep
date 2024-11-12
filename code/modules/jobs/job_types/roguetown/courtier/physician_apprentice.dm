/datum/job/roguetown/physician_apprentice
	title = "Physician Apprentice"
	flag = PHYSAPPRE
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	allowed_races = RACES_TOLERATED_UP
	allowed_sexes = list(MALE, FEMALE)
	display_order = JDO_PHYSAPPRE
	tutorial = "Your Master or Mistress had found you in poor health. \
	An orphan, perhaps, or just some random beggar off the street. \
	Whatever the case, they're your mentor now. \
	Teaching you the arts of healing, how to break then set bones and, most importantly, how to behave in court. \
	Tend to the farm, the patients and your sense of being as you navigate this treacherous world they've brought you into."
	outfit = /datum/outfit/job/roguetown/physician_apprentice
	whitelist_req = TRUE

	give_bank_account = 15
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_physician.ogg'

/datum/outfit/job/roguetown/physician_apprentice
	name = "Physician Apprentice"
	jobtype = /datum/job/roguetown/physician_apprentice
	allowed_patrons = list(/datum/patron/divine/pestra, /datum/patron/inhumen/graggar)

/datum/outfit/job/roguetown/physician_apprentice/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/physician
	shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/random
	gloves = /obj/item/clothing/gloves/roguetown/leather
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shoes = /obj/item/clothing/shoes/roguetown/armor/leather
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/reagent_containers/glass/bottle/waterskin
	beltr = /obj/item/keyring/physician
	backl = /obj/item/storage/backpack/rogue/backpack
	ADD_TRAIT(H, TRAIT_EMPATH, "[type]")
	ADD_TRAIT(H, TRAIT_NOSTINK, "[type]")
	ADD_TRAIT(H, TRAIT_ROT_EATER, "[type]")
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 3, TRUE)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/docheal)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/stable)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/purge)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/debride)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/cpr)
		H.change_stat("strength", -1)
		H.change_stat("constitution", -1)
		H.change_stat("intelligence", 2)
