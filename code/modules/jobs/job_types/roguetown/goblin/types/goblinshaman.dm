/datum/subclass/goblinshaman
	name = "Goblin Shaman"
	tutorial = "Were you Humen, they'd call you a sorcerer. Perhaps a witch, even. But you know better than the rest. \
	You're one of Graggar's chosen. A vessel for his power in this world, for better or worse. Serve as a spiritual advisor to your Chief. \
	Assure he has all he needs to succeed, and, should he fail, take his place."
	maximum_possible_slots = 1
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/goblinp)
	outfit = /datum/outfit/job/roguetown/goblinshaman
	min_pq = 0
	category_tags = list(CTAG_GOBLIN)

/datum/outfit/job/roguetown/goblinshaman
	allowed_patrons = list(/datum/patron/inhumen/graggar)

/datum/outfit/job/roguetown/goblinshaman/pre_equip(mob/living/carbon/human/H)
	..()
	H.faction += "orcs"
	pants = /obj/item/clothing/under/roguetown/loincloth/brown
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltr = /obj/item/storage/keyring/goblinchief
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
	backl = /obj/item/storage/backpack/rogue/satchel
	backr = /obj/item/rogueweapon/woodstaff
	l_hand = /obj/item/chalk
	r_hand = /obj/item/book/granter/spellbook/apprentice
	id = /obj/item/clothing/ringP/graggar
	backpack_contents = list(/obj/item/storage/fancy/ifak = 1,
							/obj/item/storage/fancy/skit = 1,
							/obj/item/scrying/eye = 1,
							/obj/item/reagent_containers/glass/alembic = 1)
	ADD_TRAIT(H, TRAIT_GOBLINCAMP, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DARKVISION, TRAIT_GENERIC)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 4, TRUE)
		H.change_stat("intelligence", 6)
		H.change_stat("fortune", 2)
		H.mind.AddSpell(new SPELL_LEARNSPELL)
		H.mind.AddSpell(new SPELL_PRESTIDIGITATION)
		H.mind.AddSpell(new SPELL_FETCH)
		H.mind.AddSpell(new SPELL_MESSAGE)
		H.mind.AddSpell(new SPELL_LESSER_HEAL)
		H.mind.AddSpell(new SPELL_CPR)
		H.mind.AddSpell(new SPELL_DIAGNOSE)

	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_spells(H)//No real spells of Graggar, yet.
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

//If a non-Goblin gets control by admin intervention.
	if(!H.has_language(/datum/language/orcish))
		H.grant_language(/datum/language/orcish)
		to_chat(H, span_info("I can speak Orchish with ,o before my speech."))
