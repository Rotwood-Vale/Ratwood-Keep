/datum/job/roguetown/goblinshaman
	title = "Goblin Shaman"
	flag = GOBLINSHAMAN
	department_flag = GOBLIN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/goblinp)
	spells = list(/obj/effect/proc_holder/spell/invoked/projectile/fetch, /obj/effect/proc_holder/spell/targeted/touch/prestidigitation,
	/obj/effect/proc_holder/spell/invoked/lesser_heal, /obj/effect/proc_holder/spell/invoked/diagnose)
	tutorial = "Were you Humen, they'd call you a sorcerer. Perhaps a witch, even. But you know better than the rest. \
	You're one of Graggar's chosen. A vessel for his power in this world, for better or worse. Serve as a spiritual advisor to your Chief. \
	Assure he has all he needs to succeed, and, should he fail, take his place."
	outfit = /datum/outfit/job/roguetown/goblinshaman
	display_order = JDO_GOBLINSHAMAN
	min_pq = 5
	max_pq = null

/datum/outfit/job/roguetown/goblinshaman
	allowed_patrons = list(/datum/patron/inhumen/graggar)

/datum/outfit/job/roguetown/goblinshaman/pre_equip(mob/living/carbon/human/H)
	..()
	H.faction += "orcs"
	pants = /obj/item/clothing/under/roguetown/loincloth/brown
	belt = /obj/item/storage/belt/rogue/leather/rope
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
	backl = /obj/item/storage/backpack/rogue/satchel
	r_hand = /obj/item/rogueweapon/woodstaff
	id = /obj/item/clothing/ringP/graggar
	backpack_contents = list(/obj/item/keyring/goblinchief = 1,
							/obj/item/storage/fancy/ifak = 1,
							/obj/item/storage/fancy/skit = 1)
	ADD_TRAIT(H, TRAIT_GOBLINCAMP, TRAIT_GENERIC)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
		H.change_stat("intelligence", 4)
		H.change_stat("fortune", 2)

	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_spells(H)//No real spells of Graggar, yet.
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

//If a non-Goblin gets control by admin intervention.
	if(!H.has_language(/datum/language/orcish))
		H.grant_language(/datum/language/orcish)
		to_chat(H, span_info("I can speak Orchish with ,o before my speech."))
