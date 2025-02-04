/datum/subclass/underdarkrefugees
	name = "Underdark Refugees"
	tutorial = "You are Refugees from the Underdark, perhaps you are running from the Matriarch. Or simple have committed offense. None the less, you have left the comfort of your home and wandered off."

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/elf/dark)
	category_tags = list(CTAG_REFUGEE)

	maximum_possible_slots = 5

	outfit = /datum/outfit/job/roguetown/refugee/underdarkrefugees

/datum/outfit/job/roguetown/refugee/underdarkrefugees
	allowed_patrons = ALL_PATRONS

/datum/outfit/job/roguetown/refugee/underdarkrefugees/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Underdark Noble", "Underdark Assassin", "Underdark Wych", "Underdark Fugitive")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)
		if("Underdark Noble")
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			head = /obj/item/clothing/head/roguetown/fancyhat
			shoes = /obj/item/clothing/shoes/roguetown/armor/nobleboot
			pants = /obj/item/clothing/under/roguetown/tights/purple
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
			neck = /obj/item/storage/belt/rogue/pouch/coins/rich
			id = /obj/item/clothing/ring/silver 
			gloves =/obj/item/clothing/gloves/roguetown/leather
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather/advanced
			backl = /obj/item/storage/backpack/rogue/satchel
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
			beltl = /obj/item/ammo_holder/quiver/bolts
			beltr = /obj/item/rogueweapon/sword/sabre/elf
			cloak = /obj/item/clothing/cloak/raincloak/furcloak/black
			H.change_stat("strength", 1)
			H.change_stat("endurance", 1)
			H.change_stat("constitution", 1)
			H.change_stat("speed", 1)
			H.change_stat("intelligence", 2)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_XENOPHOBIC, TRAIT_GENERIC)
			H.set_patron(/datum/patron/zizo)
			H.faction += "undead"

		if("Underdark Assassin")
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
			head = /obj/item/clothing/head/roguetown/roguehood/reinforced
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
			pants = /obj/item/clothing/under/roguetown/tights/purple
			gloves =/obj/item/clothing/gloves/roguetown/leather
			belt = /obj/item/storage/belt/rogue/leather
			beltl = /obj/item/rogueweapon/huntingknife/elvish
			shoes = /obj/item/clothing/shoes/roguetown/armor/nobleboot
			backl = /obj/item/storage/backpack/rogue/satchel
			H.change_stat("strength", 1)
			H.change_stat("perception", 1)
			H.change_stat("speed", 2)
			H.change_stat("intelligence", 1)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_XENOPHOBIC, TRAIT_GENERIC)
			H.set_patron(/datum/patron/zizo)
			H.faction += "undead"
		
		if("Underdark Wych")	
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
			cloak = /obj/item/clothing/cloak/black_cloak
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
			pants = /obj/item/clothing/under/roguetown/tights/purple
			belt = /obj/item/storage/belt/rogue/leather
			beltr = /obj/item/rogueweapon/huntingknife/elvish
			shoes = /obj/item/clothing/shoes/roguetown/armor/nobleboot
			backl = /obj/item/storage/backpack/rogue/satchel
			backpack_contents = list(/obj/item/reagent_containers/powder/spice = 2, /obj/item/reagent_containers/powder/ozium = 1, /obj/item/reagent_containers/powder/moondust = 2)
			H.change_stat("intelligence", 3)
			H.change_stat("speed", 2)
			H.change_stat("strength", -2)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_XENOPHOBIC, TRAIT_GENERIC)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/learnspell)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fetch)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/message)
			H.set_patron(/datum/patron/zizo)
			H.faction += "undead"
		
		if("Underdark Fugitive")
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
			belt = /obj/item/storage/belt/rogue/leather/rope
			pants = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
			cloak = /obj/item/clothing/cloak/raincloak/purple
			H.change_stat("speed", 2)
			H.change_stat("intelligence", 2)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_XENOPHOBIC, TRAIT_GENERIC)

	H.set_blindness(0)
