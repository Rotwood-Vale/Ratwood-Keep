/datum/subclass/magos
	name = "Magos"
	tutorial = "Trained in the arcane or occult arts, you have fled from the rot looking for a place to continue your studies."

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	category_tags = list(CTAG_REFUGEE)

	maximum_possible_slots = 5

	outfit = /datum/outfit/job/roguetown/refugee/magos

/datum/outfit/job/roguetown/refugee/magos
	allowed_patrons = ALL_PATRONS

/datum/outfit/job/roguetown/refugee/magos/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Battle Magos", "Arcanist", "Occultist")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Battle Magos")
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shirt = /obj/item/clothing/suit/roguetown/armor/leather/vest
			backr = /obj/item/storage/backpack/rogue/satchel
			belt = /obj/item/storage/belt/rogue/leather
			backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger)
			gloves = /obj/item/clothing/gloves/roguetown/leather
			cloak = /obj/item/clothing/cloak/raincloak/blue
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail
			shoes = /obj/item/clothing/shoes/roguetown/armor
			beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltl = /obj/item/rogueweapon/sword/sabre
			head = /obj/item/clothing/head/roguetown/helmet/leather
			H.mind.adjust_spellpoints(2)
			H.change_stat("intelligence", 2) 
			H.change_stat("endurance", 2)
			H.change_stat("constitution", 1)
			H.change_stat("speed", 1)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/learnspell)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

		if("Arcanist")
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
			head = /obj/item/clothing/head/roguetown/roguehood/mage
			shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/mage
			belt = /obj/item/storage/belt/rogue/leather/rope
			beltr = /obj/item/reagent_containers/glass/bottle/rogue/manapot
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltl = /obj/item/rogueweapon/huntingknife
			backl = /obj/item/storage/backpack/rogue/satchel
			r_hand = /obj/item/rogueweapon/woodstaff
			H.mind.adjust_spellpoints(7)
			H.change_stat("strength", -1)
			H.change_stat("intelligence", 3)
			H.change_stat("constitution", -2)
			H.change_stat("endurance", -1)
			H.change_stat("speed", -1)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/learnspell)
			H.set_patron(/datum/patron/divine/noc)

		if("Occultist")
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 4, TRUE)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/strengthen_undead)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/raise_undead)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/sickness)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/eyebite)
			head = /obj/item/clothing/head/roguetown/necromhood
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/necromancer
			belt = /obj/item/storage/belt/rogue/leather/rope
			backl = /obj/item/storage/backpack/rogue/satchel
			beltr = /obj/item/reagent_containers/glass/bottle/rogue/manapot
			beltl = /obj/item/rogueweapon/huntingknife
			r_hand = /obj/item/rogueweapon/woodstaff
			H.change_stat("strength", -1)
			H.change_stat("intelligence", 3)
			H.change_stat("constitution", -2)
			H.change_stat("endurance", -1)
			H.change_stat("speed", -1)
			H.set_patron(/datum/patron/zizo)
			H.faction |= "undead"

	H.set_blindness(0)
