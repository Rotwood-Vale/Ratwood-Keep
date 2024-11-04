/datum/job/roguetown/clinicdoctor
	title = "Clinic Physician"
	tutorial = "You are a newly funded sawbones for a small upcoming clinic in town, whether you got tired of traveling and wanted to settle down somewhere or your good-natured outlook drove you to be closer to the ill and infirmed here you are, funded by a private benefactor and a reasonable two weeks pay provided in advance. and here you stand yet to prove you are worth the coins payed."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	flag = CLINICDOC
	department_flag = CLINIC
	outfit = /datum/outfit/job/roguetown/clinicdoctor
	faction = "Station"
	display_order = JDO_CLINICDOC
	spawn_positions = 6
	total_positions = 6
	min_pq = 0
	give_bank_account = 30
	always_show_on_latechoices = TRUE
	job_reopens_slots_on_death = TRUE
	same_job_respawn_delay = 15 MINUTES
	selection_color = JCOLOR_CLINIC
	max_pq = null
	cmode_music = 'sound/music/combat_maniac2.ogg'

/datum/outfit/job/roguetown/clinicdoctor/pre_equip(mob/living/carbon/human/H)
	..()
	cloak = /obj/item/clothing/cloak/raincloak/mortus
	head = /obj/item/clothing/head/roguetown/helmet/bandana
	neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/physician
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	gloves = /obj/item/clothing/gloves/roguetown/leather
	pants = /obj/item/clothing/under/roguetown/trou/leather/mourning
	shoes = /obj/item/clothing/shoes/roguetown/armor
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/rogueweapon/huntingknife/cleaver/combat
	beltr = /obj/item/rogueweapon/mace/cudgel
	backl = /obj/item/storage/backpack/rogue/backpack/rucksack
	backpack_contents = list(/obj/item/storage/fancy/skit = 1, /obj/item/storage/fancy/ifak = 1, /obj/item/reagent_containers/glass/alembic = 1, /obj/item/roguekey/clinic, /obj/item/storage/belt/rogue/pouch/coins/mid)

	ADD_TRAIT(H, TRAIT_EMPATH, "[type]")
	ADD_TRAIT(H, TRAIT_NOSTINK, "[type]")
	ADD_TRAIT(H, TRAIT_STEELHEARTED, "[type]")
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", 2)
		H.change_stat("fortune", 2)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/docheal)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/stable)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/purge)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/debride)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/cpr)
		

