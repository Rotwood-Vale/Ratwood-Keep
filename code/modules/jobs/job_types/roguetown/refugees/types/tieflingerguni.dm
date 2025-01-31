/datum/subclass/tieflingerguni
	name = "Tiefling Erguni"
	tutorial = "You and your families had been always those of wanderlust, tossed out from every town or city. Yet still one must find way to make a living, and so to the next place you go."

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/tieberian)
	category_tags = list(CTAG_REFUGEE)

	maximum_possible_slots = 5

	outfit = /datum/outfit/job/roguetown/refugee/tieflingerguni

/datum/outfit/job/roguetown/refugee/tieflingerguni
	allowed_patrons = ALL_PATRONS

/datum/outfit/job/roguetown/refugee/tieflingerguni/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Vaquero", "Erguni Fortune Teller", "Erguni Prostitute", "Erguni")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)
		if("Vaquero")
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/hunting, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/music, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
			head = /obj/item/clothing/head/roguetown/bardhat
			shoes = /obj/item/clothing/shoes/roguetown/ridingboots
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			pants = /obj/item/clothing/under/roguetown/tights
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
			gloves =/obj/item/clothing/gloves/roguetown/leather
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather/advanced
			backl = /obj/item/storage/backpack/rogue/satchel
			backr = /obj/item/rogue/instrument/guitar
			beltl = /obj/item/flashlight/flare/torch/lantern
			r_hand = /obj/item/rogueweapon/sword/rapier/dec
			H.change_stat("strength", 2)
			H.change_stat("endurance", 1)
			H.change_stat("speed", 2) //These guys are fast both mounted and not mounted
			H.change_stat("fortune", 1) //Negates racial bad luck
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)

		if("Erguni Fortune Teller")
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/music, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			head = /obj/item/clothing/head/roguetown/helmet/bandana
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/magered
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			pants = /obj/item/clothing/under/roguetown/tights
			belt = /obj/item/storage/belt/rogue/leather/rope
			id = /obj/item/clothing/ring/gold
			shoes = /obj/item/clothing/shoes/roguetown/shortboots
			backl = /obj/item/storage/backpack/rogue/satchel
			r_hand = /obj/item/rogueweapon/woodstaff
			backpack_contents = list(/obj/item/reagent_containers/powder/ozium = 1, /obj/item/toy/cards/deck/syndicate, /obj/item/scrying) // replaced the love potion with an actual deck
			H.change_stat("intelligence", 2) // Every tiefling would get +3 int
			H.change_stat("perception", 1) 
			H.change_stat("strength", -1) // As weak as magos arcanist
			H.change_stat("endurance", -1) // You need end for spells, arcanist also has this
			H.change_stat("speed", 1) // Nice to have as a mage
			H.change_stat("fortune", 2) // +1 fortune due racial -1
			ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, TRAIT_GENERIC)
			H.mind.adjust_spellpoints(-1)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/learnspell)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/message)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/nondetection)


		if("Erguni Prostitute")	
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/music, 3, TRUE)
			head = /obj/item/clothing/head/roguetown/helmet/bandana
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			armor = /obj/item/clothing/suit/roguetown/armor/gambeson/light
			belt = /obj/item/storage/belt/rogue/leather/rope
			beltr = /obj/item/rogueweapon/huntingknife
			pants = /obj/item/clothing/under/roguetown/loincloth
			shoes = /obj/item/clothing/shoes/roguetown/shortboots
			backl = /obj/item/storage/backpack/rogue/satchel
			H.change_stat("speed", 1)
			H.change_stat("perception", 1)
			H.change_stat("constitution", 2) // Can take a beating
			H.change_stat("endurance", 2) // Normal whores have this
			H.change_stat("strength", -1) // Bait
			ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
		
		if("Erguni")
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/music, 3, TRUE)
			head = /obj/item/clothing/head/roguetown/helmet/bandana
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
			belt = /obj/item/storage/belt/rogue/leather/rope
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			backl = /obj/item/storage/backpack/rogue/satchel
			beltl = /obj/item/rogueweapon/huntingknife
			pants = /obj/item/clothing/under/roguetown/tights/vagrant
			H.change_stat("strength", 1)
			H.change_stat("endurance", 1)
			H.change_stat("speed", 2)
			H.change_stat("intelligence", 1)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)

	H.set_blindness(0)
