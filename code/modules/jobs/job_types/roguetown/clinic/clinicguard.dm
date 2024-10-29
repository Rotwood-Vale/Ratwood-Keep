/datum/job/roguetown/clinicguard
	title = "Clinic Guard"
	tutorial = "You are a newly funded guard approached by a wealthy benefactor to make sure his physicians can work in peace, must have saw something in ya aye? you are traveled and well versed enough in combat to handle yourself and this is definetly looking like a step up from common sellsword work. with a pouch full of a reasonable two weeks pay provided in advance here you stand yet to prove you are worth the coins payed. just remember your Hippocratic Oath is sometimes to save a life one has to be taken."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	flag = CLINICGUARD
	department_flag = CLINIC
	outfit = /datum/outfit/job/roguetown/clinicguard
	torch = FALSE
	faction = "Station"
	display_order = JDO_CLINICGUARD
	always_show_on_latechoices = TRUE
	job_reopens_slots_on_death = TRUE
	same_job_respawn_delay = 5 MINUTES
	maximum_possible_slots = 3
	spawn_positions = 3
	total_positions = 3
	min_pq = 0
	max_pq = null
	whitelist_req = TRUE
	traits_applied = list(TRAIT_EMPATH, TRAIT_NOSTINK, TRAIT_NOPAINSTUN)
	cmode_music = 'sound/music/combat_maniac2.ogg'

/datum/outfit/job/roguetown/clinicguard/pre_equip(mob/living/carbon/human/H)
	..()
	cloak = /obj/item/clothing/cloak/raincloak/mortus
	head = /obj/item/clothing/head/roguetown/helmet/bandana
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	beltr = /obj/item/rogueweapon/sword
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	shoes = /obj/item/clothing/shoes/roguetown/armor/leather
	neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
	pants = /obj/item/clothing/under/roguetown/trou/leather/mourning
	gloves = /obj/item/clothing/gloves/roguetown/leather
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/brigandine/light
	backl = /obj/item/storage/backpack/rogue/backpack/rucksack
	beltl = /obj/item/rogueweapon/flail
	backpack_contents = list( /obj/item/storage/fancy/ifak = 1, /obj/item/storage/belt/rogue/pouch/coins/mid, /obj/item/rogueweapon/huntingknife, /obj/item/roguekey/clinic)

	ADD_TRAIT(H, TRAIT_STEELHEARTED, "[type]")
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("endurance", 1)
		H.change_stat("constitution", 1)
		H.change_stat("perception", 1)
		H.change_stat("speed", 1)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/cpr) // taught a bit from the docs. aint gonna be able to do the surgery to set the heart up unless investment put into treatment
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
