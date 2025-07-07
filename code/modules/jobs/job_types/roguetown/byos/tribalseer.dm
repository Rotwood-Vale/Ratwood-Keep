/datum/job/roguetown/tribalseer
	title = "Tribal Seer"
	flag = TRIBALSEER
	department_flag = TRIBAL
	selection_color = JCOLOR_TRIBAL
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/goblinp, /datum/species/kobold, /datum/species/anthromorphsmall)
	spells = list(SPELL_FIREBALL, SPELL_PRESTIDIGITATION,
	SPELL_MESSAGE, SPELL_DIAGNOSE, SPELL_LESSER_HEAL)
	tutorial = "You've seen visions of fire and magma, gnashing claws and red scales. The Dragon's will burns behind your eyes, and Graggar's voice echoes in your dreams. \
	Your wild hallucinations and prophetic trances set you apart from the rest of your tribe—some fear you, others revere you, but all know you are touched by something greater. \
	You serve as the spiritual heart of the tribe, guiding the Chief and your kin with fervent, sometimes unsettling, devotion. \
	Let no one doubt your faith: you are the Dragon's chosen, and you will do anything, no matter how mad, to see Graggar's vision made real."
	outfit = /datum/outfit/job/roguetown/tribalseer
	display_order = JDO_TRIBALSEER
	min_pq = 5
	max_pq = null
	announce_latejoin = FALSE
	same_job_respawn_delay = 25 MINUTES
	job_reopens_slots_on_death = FALSE
	allowed_maps = list("Build Your Settlement")

/datum/outfit/job/roguetown/tribalseer
    allowed_patrons = list(/datum/patron/inhumen/graggar)

/datum/outfit/job/roguetown/tribalseer/pre_equip(mob/living/carbon/human/H)
	..()
	H.faction += list("orcs", "tribe")
	pants = /obj/item/clothing/under/roguetown/loincloth/brown
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltr = /obj/item/storage/keyring/goblinchief
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
	backl = /obj/item/storage/backpack/rogue/satchel
	backr = /obj/item/rogueweapon/woodstaff
	id = /obj/item/clothing/ringP/graggar
	backpack_contents = list(/obj/item/storage/fancy/ifak = 1,
							/obj/item/storage/fancy/skit = 1,
							/obj/item/scrying/eye = 1,
							/obj/item/reagent_containers/glass/alembic = 1)
	ADD_TRAIT(H, TRAIT_GOBLINCAMP, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DARKVISION, TRAIT_GENERIC)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 4, TRUE)
		H.change_stat("intelligence", 6)
		H.change_stat("fortune", 2)
		H.ventcrawler = VENTCRAWLER_ALWAYS

	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_spells(H)//No real spells of Graggar, yet.
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

	if(!H.has_language(/datum/language/draconic))
		H.grant_language(/datum/language/draconic)
		to_chat(H, span_info("I can speak Draconic with ,s before my speech."))
