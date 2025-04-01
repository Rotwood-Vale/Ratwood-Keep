/datum/subclass/noble
	name = "Noble"
	tutorial = "You were once a person of importance in your local community, but the plague and civil strife have left you with nothing. \
				Noble in blood but no longer in wealth, you have spent your last riches to embark on a journey towards a place \
				where you can re-establish your lineage."

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	category_tags = list(CTAG_REFUGEE)

	maximum_possible_slots = 8

	outfit = /datum/outfit/job/roguetown/refugee/noble


/datum/outfit/job/roguetown/refugee/noble
	allowed_patrons = ALL_PATRONS

/datum/outfit/job/roguetown/refugee/noble/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)

	var/classes

	if(H.gender == MALE && !isdarkelf(H )|| H.gender == FEMALE && isdarkelf(H))
		classes = list("Disgraced Lord", "Failed Condottiero")
	else
		classes = list("Widowed Lady")

	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Disgraced Lord")
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			shoes = /obj/item/clothing/shoes/roguetown/armor
			belt = /obj/item/storage/belt/rogue/leather/black
			beltr = /obj/item/flashlight/flare/torch/lantern
			backl = /obj/item/storage/backpack/rogue/satchel
			backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel, /obj/item/storage/belt/rogue/pouch/coins/rich = 1)
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			id = /obj/item/clothing/ring/silver
			pants = /obj/item/clothing/under/roguetown/tights/purple
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/purple
			cloak = /obj/item/clothing/cloak/half
			head = /obj/item/clothing/head/roguetown/fancyhat
			r_hand = /obj/item/rogueweapon/woodstaff
			H.change_stat("intelligence", 1)
			H.change_stat("perception", 1)
			H.change_stat("strength", -1)
			ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)


		if("Widowed Lady")
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/music, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			shoes = /obj/item/clothing/shoes/roguetown/armor
			belt = /obj/item/storage/belt/rogue/leather/black
			beltr = /obj/item/flashlight/flare/torch/lantern
			backl = /obj/item/storage/backpack/rogue/satchel
			backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel, /obj/item/storage/belt/rogue/pouch/coins/rich = 1)
			neck = /obj/item/clothing/neck/roguetown/leather
			id = /obj/item/clothing/ring/silver
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/purple
			r_hand = /obj/item/rogueweapon/woodstaff
			pants = /obj/item/clothing/under/roguetown/tights/stockings/silk/white
			armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/purple
			head = /obj/item/clothing/head/roguetown/hatblu
			cloak = /obj/item/clothing/cloak/raincloak/purple
			beltl = /obj/item/storage/belt/rogue/pouch/food
			H.change_stat("intelligence", 2)
			H.change_stat("perception", 1)
			H.change_stat("strength", -1)
			ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)

		if("Failed Condottiero")
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
			belt = /obj/item/storage/belt/rogue/leather/black
			shoes = /obj/item/clothing/shoes/roguetown/armor/nobleboot
			pants = /obj/item/clothing/under/roguetown/tights/black
			cloak = /obj/item/clothing/cloak/heartfelt
			armor = /obj/item/clothing/suit/roguetown/armor/heartfelt/lord
			neck = /obj/item/clothing/neck/roguetown/coif
			beltl = /obj/item/rogueweapon/sword/long/marlin
			beltr = /obj/item/rogueweapon/huntingknife
			gloves = /obj/item/clothing/gloves/roguetown/leather/black
			backl = /obj/item/storage/backpack/rogue/satchel
			id = /obj/item/clothing/ring/silver
			backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/rich)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
			H.change_stat("strength", 2)
			H.change_stat("endurance", 2)
			H.change_stat("speed", -1)
			H.change_stat("perception", 2)
			H.change_stat("fortune", -1)
			ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_NOSEGRAB, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)

	H.set_blindness(0)
