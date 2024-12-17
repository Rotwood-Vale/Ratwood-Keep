/datum/subclass/merchant
	name = "Merchant"
	tutorial = "Whether you once had a shop or have always been a traveling salesman, exchange of goods is your expertise. \
				Before it was overtaken by the rot, you managed to flee your old settlement with a few goods to be sold along the way. \
				Seeking refuge in a rumored safe haven, you hope to find a place where to continue plying your trade, dubious it may be."

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	category_tags = list(CTAG_REFUGEE)
	allowed_patrons = ALL_PATRONS

	maximum_possible_slots = 5

	outfit = /datum/outfit/job/roguetown/refugee/merchant

/datum/outfit/job/roguetown/refugee/merchant/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Peddler", "Spicer")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Peddler")
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
			head = /obj/item/clothing/head/roguetown/chaperon
			cloak = /obj/item/clothing/cloak/raincloak/blue
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/merchant
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor
			pants = /obj/item/clothing/under/roguetown/tights/sailor
			belt = /obj/item/storage/belt/rogue/leather/rope
			beltl = /obj/item/storage/keyring/merchant
			beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
			id = /obj/item/clothing/ring/gold
			shoes = /obj/item/clothing/shoes/roguetown/armor/leather
			// TODO: randomized content table
			backpack_contents = list(/obj/item/clothing/ring/silver = 2, /obj/item/reagent_containers/glass/bottle/rogue/healthpot = 2, /obj/item/reagent_containers/glass/bottle/rogue/manapot = 2)
			H.change_stat("intelligence", 2)
			H.change_stat("perception", 3)
			H.change_stat("strength", -1)
			ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, TRAIT_GENERIC)

		if("Spicer")
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
			shoes = /obj/item/clothing/shoes/roguetown/armor
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
			gloves = /obj/item/clothing/gloves/roguetown/fingerless
			belt = /obj/item/storage/belt/rogue/leather
			cloak = /obj/item/clothing/cloak/raincloak/mortus
			backl = /obj/item/storage/backpack/rogue/satchel
			beltr = /obj/item/rogueweapon/huntingknife/idagger
			head = /obj/item/clothing/head/roguetown/puritan
			backpack_contents = list(/obj/item/reagent_containers/powder/spice = 2, /obj/item/reagent_containers/powder/ozium = 1, /obj/item/reagent_containers/powder/moondust = 2)
			ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, TRAIT_GENERIC)

		// TODO: add useless trinkets before this class makes sense
		// if("Hoaxer")
		// 	ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, TRAIT_GENERIC)

	H.set_blindness(0)
