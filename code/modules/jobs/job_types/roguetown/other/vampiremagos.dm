/datum/subclass/vampiremagos
	name = "Magos"
	tutorial = "Trained in the arcane or occult arts, you have fled from the rot looking for a place to continue your studies."

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	category_tags = list(CTAG_ANTAG)

	maximum_possible_slots = 5

	outfit = /datum/outfit/job/roguetown/vampiremagos

/datum/outfit/job/roguetown/vampiremagos
	allowed_patrons = ALL_PATRONS

/datum/outfit/job/roguetown/vampiremagos/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	if(H.mind)		//Faster casting roll, better arcana. Starts with more spell points. Has terrible learning stats, and a bad book. No chalk.
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane,3, TRUE)
		head = /obj/item/clothing/head/roguetown/roguehood/mage
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		pants = /obj/item/clothing/under/roguetown/trou/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
		armor = /obj/item/clothing/suit/roguetown/shirt/robe/newmage/sorcerer
		belt = /obj/item/storage/belt/rogue/leather/rope
		backpack_contents = list(/obj/item/book/granter/spellbook/mid = 1 )
		beltr = /obj/item/reagent_containers/glass/bottle/rogue/lessermanapot
		neck = /obj/item/storage/belt/rogue/pouch/coins/poor
		beltl = /obj/item/rogueweapon/huntingknife
		backl = /obj/item/storage/backpack/rogue/satchel
		r_hand = /obj/item/rogueweapon/woodstaff
		H.mind.adjust_spellpoints(5)
		H.change_stat("strength", -2)
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", -2)
		H.change_stat("endurance", -1)
		H.mind.AddSpell(new SPELL_LEARNSPELL)
		H.mind.AddSpell(new SPELL_PRESTIDIGITATION)
		H.set_patron(/datum/patron/zizo)
		if(istype(H.dna.species, /datum/species/dwarf) || istype(H.dna.species,/datum/species/anthromorphsmall)|| istype(H.dna.species, /datum/species/kobold))
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/light
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/mage
