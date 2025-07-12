/datum/job/roguetown/tribalguard
	title = "Tribal Guard"
	flag = TRIBALGUARD
	department_flag = TRIBAL
	selection_color = JCOLOR_TRIBAL
	faction = "Station"
	total_positions = 3//From 6
	spawn_positions = 3//From 6
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/goblinp, /datum/species/kobold, /datum/species/anthromorphsmall)
	tutorial = "You're the hand of the Chief, and the iron claw of The Dragon. He's of higher power than any mortal. At least, that's what you've been taught. He is the biggest and strongest afterall. \
	Do what the Chief insists, while keeping order in the fort. Try not to venture out without the Chief's say-so. \
	'Tend' to captives when possible, instead of outright killing them."
	display_order = JDO_TRIBALGUARD
	outfit = /datum/outfit/job/roguetown/tribalguard
	min_pq = 4
	max_pq = null
	subclass_cat_rolls = list(CTAG_TRIBALS = 20)
	advjob_examine = TRUE
	announce_latejoin = FALSE
	same_job_respawn_delay = 25 MINUTES
	job_reopens_slots_on_death = FALSE
	allowed_maps = list("Build Your Settlement")

/datum/outfit/job/roguetown/tribalguard
	allowed_patrons = list(/datum/patron/inhumen/graggar)

/datum/outfit/job/roguetown/tribalguard/pre_equip(mob/living/carbon/human/H)
	..()
	H.faction += list("orcs", "tribe")
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	pants = /obj/item/clothing/under/roguetown/loincloth/brown
	belt = /obj/item/storage/belt/rogue/leather
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/rope/chain = 2, /obj/item/storage/keyring/goblinguard = 1)
	ADD_TRAIT(H, TRAIT_GOBLINCAMP, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DARKVISION, TRAIT_GENERIC)
	H.ventcrawler = VENTCRAWLER_ALWAYS

	if(!H.has_language(/datum/language/draconic))
		H.grant_language(/datum/language/draconic)
		to_chat(H, span_info("I can speak Draconic with ,s before my speech."))

/datum/job/roguetown/tribalguard/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

/datum/subclass/tribal_brute
	name = "Brute"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/goblinp, /datum/species/kobold, /datum/species/anthromorphsmall)
	outfit = /datum/outfit/job/roguetown/tribalguard/brute
	tutorial = "You're one of the Chief's trusted guards, though many just know you to be a brute. \
	Strong, perhaps too strong, for your size. You've experience with a mace, heavy armor and unarmed combat."
	category_tags = list(CTAG_TRIBALS)

/datum/outfit/job/roguetown/tribalguard/brute/pre_equip(mob/living/carbon/human/H)
	. = ..()
	head = /obj/item/clothing/head/roguetown/helmet/leather
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
	r_hand = /obj/item/rogueweapon/mace/spiked
	l_hand = /obj/item/rogueweapon/shield/wood
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.change_stat("strength", 3)
		H.change_stat("perception", 1)
		H.change_stat("endurance", 1)
		H.change_stat("intelligence", -2)

/datum/subclass/tribal_sorcerer
	name = "Sorcerer"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/goblinp, /datum/species/kobold, /datum/species/anthromorphsmall)
	outfit = /datum/outfit/job/roguetown/tribalguard/spellcaster
	tutorial = "You are a rare sorcerer among your tribe, gifted with arcane power by The Dragon. Your magic is a sign of favor, and you are expected to use your talents to protect and empower your kin. Support your allies with spells and cunning, and remember that your gifts set you apart—use them wisely in service to The Dragon's will."
	category_tags = list(CTAG_TRIBALS)

/datum/outfit/job/roguetown/tribalguard/spellcaster/pre_equip(mob/living/carbon/human/H)
	. = ..()
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/brown
	r_hand = /obj/item/rogueweapon/woodstaff
	cloak = /obj/item/clothing/cloak/tribal
	backpack_contents = list(/obj/item/book/granter/spellbook/apprentice = 1)
	ADD_TRAIT(H, TRAIT_DARKVISION, TRAIT_GENERIC)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		H.mind.adjust_spellpoints(5)
		H.mind.AddSpell(new SPELL_LEARNSPELL)
		H.mind.AddSpell(new SPELL_PRESTIDIGITATION)
		H.change_stat("intelligence", 2)
		H.change_stat("strength", -1)

/datum/subclass/tribal_raider
	name = "Raider"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/goblinp, /datum/species/kobold, /datum/species/anthromorphsmall)
	outfit = /datum/outfit/job/roguetown/tribalguard/raider
	tutorial = "Armour? A mace? Crossbows? Who needs any of that. You've an axe. \
	A really big fucking axe. At the Chief's word, you destroy. Simple as. If you can even lift the damn thing."
	category_tags = list(CTAG_TRIBALS)

/datum/outfit/job/roguetown/tribalguard/raider/pre_equip(mob/living/carbon/human/H)
	. = ..()
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	r_hand = /obj/item/rogueweapon/stoneaxe/battle
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.change_stat("strength", 4)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 1)
		H.change_stat("perception", -1)
		H.change_stat("intelligence", -4)

/datum/subclass/tribal_archer
	name = "Boltslinger"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/goblinp, /datum/species/kobold, /datum/species/anthromorphsmall)
	outfit = /datum/outfit/job/roguetown/tribalguard/tribal_archer
	tutorial = "Unlike the rest of your fellows, you know how to put a bolt into a Humen. \
	You're provided a crossbow, a dagger and given enough training to hold your own. Try not to shoot the Chief."
	category_tags = list(CTAG_TRIBALS)

/datum/outfit/job/roguetown/tribalguard/tribal_archer/pre_equip(mob/living/carbon/human/H)
	. = ..()
	head = /obj/item/clothing/head/roguetown/helmet/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
	r_hand = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	beltr = /obj/item/rogueweapon/huntingknife/idagger/steel
	beltl = /obj/item/ammo_holder/quiver/bolts
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 1)
		H.change_stat("perception", 4)
		H.change_stat("intelligence", -1)
