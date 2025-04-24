/datum/subclass/healer
	name = "Healer"
	tutorial = "Whether you have helped people on the battlefield or concocted ailments in private, your life has been dedicated \
				to healing the sick and wounded. You've joined a refugee caravan to escape the spreading rot, a sickness which even someone \
				like you cannot truly explain."

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	category_tags = list(CTAG_REFUGEE)

	maximum_possible_slots = 15

	outfit = /datum/outfit/job/roguetown/refugee/healer

/datum/outfit/job/roguetown/refugee/healer
	allowed_patrons = ALL_PATRONS

/datum/outfit/job/roguetown/refugee/healer/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Alchemist", "War Surgeon")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Alchemist")
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			pants = /obj/item/clothing/under/roguetown/tights
			shirt = /obj/item/clothing/suit/roguetown/shirt/tunic
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
			belt = /obj/item/storage/belt/rogue/leather/rope
			shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
			neck = /obj/item/clothing/neck/roguetown/coif
			beltr = /obj/item/rogueweapon/huntingknife
			backr = /obj/item/rogueweapon/woodstaff
			backl = /obj/item/storage/backpack/rogue/backpack
			backpack_contents = list( /obj/item/reagent_containers/glass/bottle = 2, /obj/item/reagent_containers/glass/mortar = 1,  /obj/item/reagent_containers/glass/alembic = 1, /obj/item/thermometer, /obj/item/storage/belt/rogue/pouch/coins/poor = 1)
			H.change_stat("intelligence", 2)
			H.change_stat("fortune", 1)
			H.change_stat("strength", -1)

		if("War Surgeon")
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 4, TRUE)	//in line with town physicians and can now revive
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.AddSpell(new SPELL_DIAGNOSE_SECULAR)
			head = /obj/item/clothing/head/roguetown/nightman
			neck = /obj/item/clothing/neck/roguetown/coif
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
			shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
			belt = /obj/item/storage/belt/rogue/leather
			beltr = /obj/item/rogueweapon/huntingknife/cleaver
			pants = /obj/item/clothing/under/roguetown/trou
			shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
			backl = /obj/item/storage/backpack/rogue/backpack
			backpack_contents = list(/obj/item/storage/fancy/skit = 1, /obj/item/storage/fancy/ifak = 1, /obj/item/reagent_containers/glass/bottle/rogue/lesserhealthpot = 1, /obj/structure/bed/rogue/sleepingbag = 1)
			H.change_stat("strength", -1)
			H.change_stat("intelligence", 2)
			H.change_stat("perception", 1)
			ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)

	H.set_blindness(0)
