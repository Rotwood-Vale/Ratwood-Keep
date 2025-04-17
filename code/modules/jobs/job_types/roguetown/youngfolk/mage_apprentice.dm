/datum/job/roguetown/wapprentice
	title = "Magicians Apprentice"
	flag = MAGEAPPRENTICE
	department_flag = YOUNGFOLK
	faction = "Station"
	total_positions = 3
	spawn_positions = 3

	allowed_races = RACES_TOLERATED_UP_PLUS_SMOLFOLK
	allowed_ages = list(AGE_ADULT)

	tutorial = "Your master once saw potential in you, something you are uncertain if they still do with your recent studies. The path to using magic is something treacherous and untamed, and you are still decades away from calling yourself even a journeyman in the field. Listen and serve, and someday you will earn your hat."

	spells = list(SPELL_LEARNSPELL, SPELL_PRESTIDIGITATION)
	outfit = /datum/outfit/job/roguetown/wapprentice

	display_order = JDO_MAGEAPPRENTICE
	give_bank_account = TRUE

	min_pq = 0
	max_pq = null

/datum/outfit/job/roguetown/wapprentice/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
	pants = /obj/item/clothing/under/roguetown/tights/random
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltr = /obj/item/storage/magebag/apprentice
	beltl = /obj/item/storage/keyring/mageapprentice
	r_hand = /obj/item/rogueweapon/woodstaff
	backpack_contents = list(/obj/item/chalk = 1, /obj/item/book/granter/spellbook/apprentice = 1)
	if(H.gender == MALE)
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		armor = /obj/item/clothing/suit/roguetown/shirt/robe/newmage/adept
		backr = /obj/item/storage/backpack/rogue/satchel
	else
		shoes = /obj/item/clothing/shoes/roguetown/sandals
		armor = /obj/item/clothing/suit/roguetown/shirt/robe/newmage/adept
		backr = /obj/item/storage/backpack/rogue/satchel
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 3, TRUE)	//they get potion crafting round start now.
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		H.mind.adjust_spellpoints(3)
		H.change_stat("intelligence", 3)
		H.change_stat("strength", -1)
	if(istype(H.dna.species, /datum/species/dwarf) || istype(H.dna.species,/datum/species/anthromorphsmall)|| istype(H.dna.species, /datum/species/kobold))
		shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/light
		armor = /obj/item/clothing/suit/roguetown/shirt/robe/mage