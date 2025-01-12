/datum/advclass/trader
	name = "Trader"
	tutorial = "A traveling salesman, a peddler of goods - commerce is your expertise, and you've come to this land to make a fortune."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/trader
	category_tags = list(CTAG_ADVENTURER, CTAG_COURTAGENT)
	traits_applied = list(TRAIT_OUTLANDER, TRAIT_SEEPRICES)
	classes = list("Peddler" = "You make your coin peddling in spices and illicit wares.",
					"Brewer" = "You make your coin peddling imported alcohols from all over the world.",
					"Jeweler" = "You make your coin peddling exotic jewelry and gems.")

/datum/outfit/job/roguetown/adventurer/trader/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Peddler","Brewer","Jeweler")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)
	
		if("Peddler")
			to_chat(H, span_warning("You make your coin peddling in spices and illicit wares."))
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 3, TRUE)
			head = /obj/item/clothing/head/roguetown/roguehood
			mask = /obj/item/clothing/mask/rogue/facemask/steel
			shoes = /obj/item/clothing/shoes/roguetown/boots
			pants = /obj/item/clothing/under/roguetown/tights/black
			shirt = /obj/item/clothing/suit/roguetown/shirt/robe
			belt = /obj/item/storage/belt/rogue/leather
			backl = /obj/item/storage/backpack/rogue/satchel
			backr = /obj/item/storage/backpack/rogue/satchel
			beltr = /obj/item/rogueweapon/huntingknife/idagger
			beltl = /obj/item/flashlight/flare/torch/lantern
			backpack_contents = list(/obj/item/reagent_containers/powder/spice = 2, /obj/item/reagent_containers/powder/ozium = 1, /obj/item/reagent_containers/powder/moondust = 2)
			H.change_stat("intelligence", 3)
			H.change_stat("perception", 2)
			H.change_stat("speed", 1)

		if("Brewer")
			to_chat(H, span_warning("You make your coin peddling imported alcohols from all over the world."))
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			mask = /obj/item/clothing/mask/rogue/ragmask
			shoes = /obj/item/clothing/shoes/roguetown/boots
			pants = /obj/item/clothing/under/roguetown/tights/black
			cloak = /obj/item/clothing/suit/roguetown/armor/longcoat
			shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/red
			belt = /obj/item/storage/belt/rogue/leather/black
			backl = /obj/item/storage/backpack/rogue/satchel
			backr = /obj/item/storage/backpack/rogue/satchel
			beltr = /obj/item/rogueweapon/mace/cudgel
			beltl = /obj/item/flashlight/flare/torch/lantern
			backpack_contents = list(/obj/item/reagent_containers/glass/bottle/rogue/beer/gronnmead = 1, /obj/item/reagent_containers/glass/bottle/rogue/beer/voddena = 1, /obj/item/reagent_containers/glass/bottle/rogue/beer/blackgoat = 1, /obj/item/reagent_containers/glass/bottle/rogue/elfred = 1, /obj/item/reagent_containers/glass/bottle/rogue/elfblue = 1)
			H.change_stat("intelligence", 3)
			H.change_stat("perception", 1)
			H.change_stat("strength", 1)
			H.change_stat("constitution", 1)

		if ("Jeweler")
			to_chat(H, span_warning("You make your coin peddling exotic jewelry and gems."))
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			mask = /obj/item/clothing/mask/rogue/facemask/goldmask
			shoes = /obj/item/clothing/shoes/roguetown/boots
			pants = /obj/item/clothing/under/roguetown/tights/black
			shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/purple
			belt = /obj/item/storage/belt/rogue/leather/black
			cloak = /obj/item/clothing/cloak/raincloak/purple
			backl = /obj/item/storage/backpack/rogue/satchel
			backr = /obj/item/storage/backpack/rogue/satchel
			neck = /obj/item/storage/belt/rogue/pouch/coins/mid
			beltl = /obj/item/flashlight/flare/torch/lantern
			beltr = /obj/item/rogueweapon/hammer
			backpack_contents = list(/obj/item/clothing/ring/silver = 2, /obj/item/roguegem/yellow = 1, /obj/item/roguegem/green = 1, /obj/item/rogueweapon/tongs = 1)
			H.change_stat("intelligence", 3)
			H.change_stat("perception", 1)
			H.change_stat("strength", 1)
			H.change_stat("endurance", 1)

