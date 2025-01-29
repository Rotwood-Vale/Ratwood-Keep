/datum/subclass/underdwellers
	name = "Under Dwellers"
	tutorial = "You are of those not quite fit for society, those who hide away in the caves and sewers. That society has deemed you lesser. So now, you live amongst your own little communities, far from where the surface dwellers dare see you."

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/kobold, /datum/species/anthromorphsmall, /datum/species/anthromorph)
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
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/hunting, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/sewing, 1, TRUE)
			pants = /obj/item/clothing/under/roguetown/tights/vagrant
			r_hand = /datum/supply_pack/rogue/weapons/spear
			belt = /obj/item/storage/belt/rogue/leather/rope
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			backl = /obj/item/storage/backpack/rogue/satchel
			beltl = /obj/item/rogueweapon/huntingknife
			H.change_stat("strength", 1)
			H.change_stat("endurance", 1)
			H.change_stat("constitution", 1)
			H.change_stat("speed", 1)
			H.change_stat("intelligence", -1)
			ADD_TRAIT(H, TRAIT_WILD_EATER, TRAIT_GENERIC)

		if("Caveling Gatherer")
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/mining, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/farming, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/hunting, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/sewing, 2, TRUE)
			armor = /obj/item/clothing/suit/roguetown/armor/leather
			pants = /obj/item/clothing/under/roguetown/tights/vagrant
			belt = /obj/item/storage/belt/rogue/leather/rope
			beltl = /obj/item/rogueweapon/huntingknife
			beltr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
			backl = /obj/item/storage/backpack/rogue/satchel
			l_hand = /obj/item/ammo_holder/quiver/arrows
			H.change_stat("speed", 1)
			H.change_stat("perception", 2)
			H.change_stat("fortune", 2)
			ADD_TRAIT(H, TRAIT_WILD_EATER, TRAIT_GENERIC)
		
		if("Caveling Tinkerer")	
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/engineering, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/smithing, 2, TRUE)
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
			pants = /obj/item/clothing/under/roguetown/tights/vagrant
			belt = /obj/item/storage/belt/rogue/leather/rope
			beltr = /obj/item/rogueweapon/huntingknife
			shoes = /obj/item/clothing/shoes/roguetown/shortboots
			backl = /obj/item/storage/backpack/rogue/satchel
			backr = /obj/item/rogueweapon/hammer/wood
			backpack_contents = list(/obj/item/rogueweapon/hammer/steel = 1, /obj/item/rogueweapon/handsaw = 1, /obj/item/rogueweapon/chisel = 1)
			H.change_stat("intelligence", 2)
			H.change_stat("strength", -1)
			ADD_TRAIT(H, TRAIT_WILD_EATER, TRAIT_GENERIC)
		
		if("Caveling Shaman")
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			gloves = /obj/item/clothing/gloves/roguetown/leather
			belt = /obj/item/storage/belt/rogue/leather
			backl = /obj/item/storage/backpack/rogue/satchel
			l_hand = /obj/item/rogueweapon/woodstaff
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
			pants = /obj/item/clothing/under/roguetown/tights/vagrant
			head = /obj/item/clothing/head/roguetown/hatfur
			shoes = /obj/item/clothing/shoes/roguetown/shortboots
			cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown 
			backpack_contents = list(/obj/item/rogueweapon/huntingknife = 1)
			H.change_stat("strength", -1)
			H.change_stat("speed", 1)
			H.change_stat("intelligence", 2)
			ADD_TRAIT(H, TRAIT_WILD_EATER, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/learnspell)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fetch)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/message)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/lesser_heal)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose)
			var/datum/devotion/C = new /datum/devotion(H, H.patron)
			C.grant_spells(H)
			H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

	H.set_blindness(0)
