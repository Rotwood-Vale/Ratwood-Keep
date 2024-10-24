/datum/job/roguetown/goblinguard
	title = "Goblin Guard"
	flag = GOBLINGUARD
	department_flag = GOBLIN
	faction = "Station"
	total_positions = 3//From 6
	spawn_positions = 3//From 6
	allowed_sexes = list(MALE)
	allowed_races = list(/datum/species/goblinp)
	allowed_patrons = list(/datum/patron/inhumen/graggar)
	tutorial = "You're the hand of the King. He's an individual of higher power than any mortal. At least, that's what you've been taught. \
	Do what the king insists, while keeping order in the camp. Try not to venture out without the king's say-so. \
	'Tend' to captives when possible, instead of outright killing them."
	display_order = JDO_GOBLINGUARD
	outfit = /datum/outfit/job/roguetown/goblinguard
	min_pq = 3
	max_pq = null
	advclass_cat_rolls = list(CTAG_GOBS = 20)
	advjob_examine = TRUE
	always_show_on_latechoices = TRUE

/datum/outfit/job/roguetown/goblinguard/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	pants = /obj/item/clothing/under/roguetown/loincloth/brown
	belt = /obj/item/storage/belt/rogue/leather
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/rope/chain = 2)

/datum/job/roguetown/goblinguard/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

/datum/advclass/gob_brute
	name = "Brute"
	allowed_sexes = list(MALE)
	allowed_races = list(/datum/species/goblinp)
	outfit = /datum/outfit/job/roguetown/goblinguard/brute
	tutorial = "You're one of the King's trusted guards, though many just know you to be a brute. \
	Strong, perhaps too strong, for a Goblin. You've experience with a mace, heavy armor and unarmed combat."
	category_tags = list(CTAG_GOBS)

/datum/outfit/job/roguetown/goblinguard/brute/pre_equip(mob/living/carbon/human/H)
	. = ..()
	head = /obj/item/clothing/head/roguetown/helmet/goblin
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron/goblin
	r_hand = /obj/item/rogueweapon/mace/spiked
	l_hand = /obj/item/rogueweapon/shield/wood
	H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("perception", 1)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 1)
		H.change_stat("intelligence", -2)

/datum/advclass/gob_outrider
	name = "Outrider"
	allowed_sexes = list(MALE)
	allowed_races = list(/datum/species/goblinp)
	outfit = /datum/outfit/job/roguetown/goblinguard/outrider
	tutorial = "You're one of the few experienced with 'mounted' combat. \
	Whether by spear or crossbow, you'll tame these lands in the name of the King. \
	You're trained in the use of 'medium' armor, unlike your brutish contemporaries."
	category_tags = list(CTAG_GOBS)

/datum/outfit/job/roguetown/goblinguard/outrider/pre_equip(mob/living/carbon/human/H)
	. = ..()
	head = /obj/item/clothing/head/roguetown/helmet/leather/goblin
	armor = /obj/item/clothing/suit/roguetown/armor/leather/goblin
	r_hand = /obj/item/rogueweapon/spear/stone
	l_hand = /obj/item/rogueweapon/shield/wood
	H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3 , TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("perception", 2)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 1)
		H.change_stat("intelligence", -2)

/datum/advclass/gob_raider
	name = "Raider"
	allowed_sexes = list(MALE)
	allowed_races = list(/datum/species/goblinp)
	outfit = /datum/outfit/job/roguetown/goblinguard/raider
	tutorial = "Armour? A mace? Crossbows? Who needs any of that. You've an axe. \
	A really big fucking axe. At the King's word, you destroy. Simple as. If you can even lift the damn thing."
	category_tags = list(CTAG_GOBS)

/datum/outfit/job/roguetown/goblinguard/raider/pre_equip(mob/living/carbon/human/H)
	. = ..()
	armor = /obj/item/clothing/suit/roguetown/armor/leather/hide/goblin
	r_hand = /obj/item/rogueweapon/stoneaxe/battle
	H.verbs |= /mob/proc/haltyell
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 3 , TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.change_stat("strength", 4)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 1)
		H.change_stat("perception", -2)
		H.change_stat("intelligence", -4)
