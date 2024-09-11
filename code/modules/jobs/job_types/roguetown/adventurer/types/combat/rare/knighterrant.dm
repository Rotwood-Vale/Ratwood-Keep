/datum/advclass/knighterrant
	name = "Knight-errant"
	tutorial = "You fashion yourself a knight from a distant land, a scion of a noble house. Whether or not that's true is irrelevant; manner maketh man, bandit. Carry yourself with dignity and remind the land that chivalry still exists, or give everyone a cruel reality check as they decry you as a blackguard under the weight of a steel boot. After selection you receive a choice between a shining knight or a black knight, which is entirely aesthetic."
	allowed_races = RACES_ALL_KINDS
	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/job/roguetown/adventurer/knighterrant
	maximum_possible_slots = 4		
	traits_applied = list(TRAIT_HEAVYARMOR, TRAIT_NOBLE)
	category_tags = list(CTAG_ADVENTURER)


/datum/outfit/job/roguetown/adventurer/knighterrant/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Normal Knight","Black Knight")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Normal Knight")
			head = /obj/item/clothing/head/roguetown/helmet/heavy/knight
			gloves = /obj/item/clothing/gloves/roguetown/plate
			pants = /obj/item/clothing/under/roguetown/platelegs
			cloak = /obj/item/clothing/cloak/tabard
			neck = /obj/item/clothing/neck/roguetown/bervor
			shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
			armor = /obj/item/clothing/suit/roguetown/armor/plate
			shoes = /obj/item/clothing/shoes/roguetown/boots/armor
			belt = /obj/item/storage/belt/rogue/leather
			beltr = /obj/item/rogueweapon/sword/long
			backr = /obj/item/storage/backpack/rogue/satchel/black
			backl = /obj/item/rogueweapon/shield/tower/metal
			backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger = 1)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
			H.change_stat("strength", 2)
			H.change_stat("endurance", 1)
			H.change_stat("constitution", 2)
			H.change_stat("intelligence", 1)
			H.change_stat("speed", 1)
			H.dna.species.soundpack_m = new /datum/voicepack/male/knight()

		if("Black Knight")
			head = /obj/item/clothing/head/roguetown/helmet/heavy/knight/black
			gloves = /obj/item/clothing/gloves/roguetown/plate/blk/death
			pants = /obj/item/clothing/under/roguetown/platelegs/blk
			cloak = /obj/item/clothing/cloak/tabard/blkknight
			neck = /obj/item/clothing/neck/roguetown/bervor
			shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
			armor = /obj/item/clothing/suit/roguetown/armor/plate/blkknight
			shoes = /obj/item/clothing/shoes/roguetown/boots/armor/blkknight
			belt = /obj/item/storage/belt/rogue/leather
			beltr = /obj/item/rogueweapon/sword/long/death // ow the edge. it's just spraypainted.
			backr = /obj/item/storage/backpack/rogue/satchel/black
			backl = /obj/item/rogueweapon/shield/tower/metal
			backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger = 1)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
			H.change_stat("strength", 2)
			H.change_stat("endurance", 1)
			H.change_stat("constitution", 2)
			H.change_stat("intelligence", 1)
			H.change_stat("speed", 1)
			H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
