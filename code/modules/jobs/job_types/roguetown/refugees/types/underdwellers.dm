/datum/subclass/underdwellers
	name = "Under Dwellers"
	tutorial = "You are of those not quite fit for society, those who hide away in the caves and sewers. That society has deemed you lesser. So now, you live amongst your own little communities, far from where the surface dwellers dare see you."

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/kobold, /datum/species/anthromorphsmall)
	category_tags = list(CTAG_REFUGEE)

	maximum_possible_slots = 10

	outfit = /datum/outfit/job/roguetown/refugee/underdwellers

/datum/outfit/job/roguetown/refugee/underdwellers
	allowed_patrons = ALL_PATRONS

/datum/outfit/job/roguetown/refugee/underdwellers/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Caveling", "Caveling Gatherer", "Caveling Tinkerer", "Caveling Shaman")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)
		if("Caveling")
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/hunting, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
			pants = /obj/item/clothing/under/roguetown/loincloth/brown
			r_hand = /datum/supply_pack/rogue/weapons/spear
			belt = /obj/item/storage/belt/rogue/leather/rope
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			backl = /obj/item/storage/backpack/rogue/satchel
			beltl = /obj/item/rogueweapon/huntingknife
			cloak = /obj/item/clothing/cloak/tribal
			H.change_stat("strength", 2)
			H.change_stat("endurance", 1)
			H.change_stat("speed", 1)
			H.change_stat("intelligence", -2)
			ADD_TRAIT(H, TRAIT_WILD_EATER, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)

		if("Caveling Gatherer")
			H.mind.adjust_skillrank(/datum/skill/craft/hunting, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/mining, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/farming, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
			pants = /obj/item/clothing/under/roguetown/loincloth/brown
			belt = /obj/item/storage/belt/rogue/leather/rope
			beltl = /obj/item/rogueweapon/huntingknife
			beltr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
			backl = /obj/item/storage/backpack/rogue/satchel
			l_hand = /obj/item/ammo_holder/quiver/arrows
			cloak = /obj/item/clothing/cloak/volfmantle
			H.change_stat("strength", 1)
			H.change_stat("perception", 2) // 3 more statpoints than the others since they don't get dodge expert/anything too unique
			H.change_stat("fortune", 2)
			ADD_TRAIT(H, TRAIT_WILD_EATER, TRAIT_GENERIC)

		if("Caveling Tinkerer")
			H.mind.adjust_skillrank(/datum/skill/craft/engineering, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)

			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
			pants = /obj/item/clothing/under/roguetown/loincloth/brown
			belt = /obj/item/storage/belt/rogue/leather/rope
			beltr = /obj/item/rogueweapon/huntingknife
			shoes = /obj/item/clothing/shoes/roguetown/shortboots
			backl = /obj/item/storage/backpack/rogue/satchel
			backpack_contents = list(/obj/item/rogueweapon/hammer/steel = 1, /obj/item/flint = 1, /obj/item/rogueore/coal = 1, /obj/item/rogueore/iron = 1)
			H.change_stat("intelligence", 2)
			H.change_stat("strength", -1)
			H.change_stat("fortune", 1)
			ADD_TRAIT(H, TRAIT_WILD_EATER, TRAIT_GENERIC)

		if("Caveling Shaman")
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			gloves = /obj/item/clothing/gloves/roguetown/leather
			belt = /obj/item/storage/belt/rogue/leather/rope
			beltl = /obj/item/rogueweapon/huntingknife
			backl = /obj/item/storage/backpack/rogue/backpack/rucksack
			l_hand = /obj/item/rogueweapon/woodstaff
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/brown
			pants = /obj/item/clothing/under/roguetown/loincloth/brown
			head = /obj/item/clothing/head/roguetown/helmet/leather/volfhelm
			shoes = /obj/item/clothing/shoes/roguetown/shortboots
			cloak = /obj/item/clothing/cloak/tribal
			backpack_contents = list(/obj/item/rogueweapon/surgery/hemostat/improv = 2, /obj/item/rogueweapon/surgery/retractor/improv = 1, /obj/item/rogueweapon/surgery/saw/improv = 1, /obj/item/book/granter/spellbook/apprentice = 1)
			H.change_stat("strength", -1)
			H.change_stat("speed", 1)
			H.change_stat("intelligence", 2)
			ADD_TRAIT(H, TRAIT_WILD_EATER, TRAIT_GENERIC)
			H.mind.AddSpell(new SPELL_PRESTIDIGITATION)
			H.mind.adjust_spellpoints(1)
			H.mind.AddSpell(new SPELL_LEARNSPELL)
			var/datum/devotion/C = new /datum/devotion(H, H.patron)
			C.grant_spells_churchling(H)
			H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

	H.set_blindness(0)
