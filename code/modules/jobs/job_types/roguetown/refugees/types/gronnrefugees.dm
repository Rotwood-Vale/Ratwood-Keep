/datum/subclass/gronnrefugee
	name = "Gronn Refugees"
	tutorial = "You are Refugees of Gronn. Be it the far and cold steppes, or of the Jade Empire. You have found yourself now here within Enigma. To what you do next? Is up to you."

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/human/northern, /datum/species/halforc, /datum/species/goblinp)
	category_tags = list(CTAG_REFUGEE)

	maximum_possible_slots = 5

	outfit = /datum/outfit/job/roguetown/refugee/gronnrefugee

/datum/outfit/job/roguetown/refugee/gronnrefugee
	allowed_patrons = ALL_PATRONS

/datum/outfit/job/roguetown/refugee/gronnrefugee/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Tribal", "Silks Merchant", "Spice Lord", "Imperial Handgonner")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Tribal")
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/hunting, 2, TRUE)
			head = /obj/item/clothing/head/roguetown/hatfur
			shoes = /obj/item/clothing/shoes/roguetown/armor/nomadboots
			pants = /obj/item/clothing/under/roguetown/trou/nomadpants
			shirt = /obj/item/clothing/suit/roguetown/armor/leather/hatanga_degel
			gloves =/obj/item/clothing/gloves/roguetown/leather
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather/Huus_quyaq
			backl = /obj/item/storage/backpack/rogue/satchel
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
			beltl = /obj/item/rogueweapon/huntingknife
			beltr = /obj/item/rogueweapon/stoneaxe/woodcut
			l_hand = /obj/item/ammo_holder/quiver/arrows
			H.change_stat("strength", 2)
			H.change_stat("endurance", 3)
			H.change_stat("constitution", 2)
			H.change_stat("intelligence", -2)
			ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)

			if(!H.has_language(/datum/language/orcish))
				H.grant_language(/datum/language/orcish)
				to_chat(H, span_info("I can speak Orchish with ,o before my speech."))

		if("Silks Merchant")
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
			head = /obj/item/clothing/head/roguetown/hatfur
			shirt = /obj/item/clothing/suit/roguetown/armor/leather/chargah
			pants = /obj/item/clothing/under/roguetown/trou/nomadpants
			belt = /obj/item/storage/belt/rogue/leather/rope
			beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
			id = /obj/item/clothing/ring/gold
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			backl = /obj/item/storage/backpack/rogue/satchel
			backpack_contents = list(/obj/item/clothing/ring/silver = 2, /obj/item/natural/bundle/silk, /obj/item/natural/bundle/silk)
			H.change_stat("intelligence", 2)
			H.change_stat("perception", 3)
			H.change_stat("strength", -1)
			ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, TRAIT_GENERIC)
		
		if("Spice Lord")	
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
			head = /obj/item/clothing/head/roguetown/hatfur
			shirt = /obj/item/clothing/suit/roguetown/armor/leather/chargah
			pants = /obj/item/clothing/under/roguetown/trou/nomadpants
			belt = /obj/item/storage/belt/rogue/leather/rope
			beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
			id = /obj/item/clothing/ring/gold
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			backl = /obj/item/storage/backpack/rogue/satchel
			backpack_contents = list(/obj/item/reagent_containers/powder/spice = 2, /obj/item/reagent_containers/powder/ozium = 1, /obj/item/reagent_containers/powder/moondust = 2)
			H.change_stat("intelligence", 2)
			H.change_stat("perception", 3)
			H.change_stat("strength", -1)
			ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, TRAIT_GENERIC)
		
		if("Imperial Handgonner")
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/firearms, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
			gloves = /obj/item/clothing/gloves/roguetown/leather
			belt = /obj/item/storage/belt/rogue/leather
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			backl = /obj/item/storage/backpack/rogue/satchel
			backr = /obj/item/gun/ballistic/firearm/handgonne
			beltl = /obj/item/ammo_holder/bullet/lead
			beltr = /obj/item/powderflask
			shirt = /obj/item/clothing/suit/roguetown/armor/leather/hatanga_degel
			head = /obj/item/clothing/head/roguetown/helmet/nomadhelmet
			shoes = /obj/item/clothing/shoes/roguetown/armor/nomadboots
			backpack_contents = list(/obj/item/rogueweapon/huntingknife = 1)
			H.change_stat("strength", 1)
			H.change_stat("endurance", 1)
			H.change_stat("constitution", 1)
			H.change_stat("speed", 2)
			H.change_stat("intelligence", 2)

	H.set_blindness(0)
