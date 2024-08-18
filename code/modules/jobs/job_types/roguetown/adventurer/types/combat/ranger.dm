/datum/advclass/ranger
	name = "Ranger"
	tutorial = "Rangers are a mix of hunters and rogues, staying in the shadows, but often being more friendly to others than a rogue, much more in touch with nature and more skilled in the arts of survival."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/ranger
	traits_applied = list(TRAIT_MEDIUMARMOR, TRAIT_DODGEEXPERT)
	category_tags = list(CTAG_ADVENTURER)

/datum/outfit/job/roguetown/adventurer/ranger/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Ranger","Gloom Stalker",) // Ranger Knight is the unique subclass. Gives you steel breastplate and a sword.
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)
	
		if("Ranger")
			H.set_blindness(0)
			to_chat(H, span_warning("Rangers are masters of nature, often hired as pathfinders, bodyguards and mercenaries in areas of wilderness untraversable to common soldiery."))
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			gloves = /obj/item/clothing/gloves/roguetown/leather
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
			cloak = /obj/item/clothing/cloak/raincloak/brown
			cloak = /obj/item/clothing/cloak/raincloak/green
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
			backl = /obj/item/storage/backpack/rogue/satchel
			beltr = /obj/item/flashlight/flare/torch/lantern
			backpack_contents = list(/obj/item/bait = 1, /obj/item/rogueweapon/huntingknife = 1)
			beltl = /obj/item/quiver/arrows
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(4,5,5,6), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/traps, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, rand(1,2), TRUE)
			H.change_stat("perception", 4)
			H.change_stat("endurance", 2)
			H.change_stat("speed", 2)
		if("Gloom Stalker")
			H.set_blindness(0)
			to_chat(H, span_warning("Rangers are masters of nature, often hired as pathfinders, bodyguards and mercenaries in areas of wilderness untraversable to common soldiery."))
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			gloves = /obj/item/clothing/gloves/roguetown/leather
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather/studded
			cloak = /obj/item/clothing/cloak/raincloak/mortus
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
			backl = /obj/item/storage/backpack/rogue/satchel
			beltr = /obj/item/flashlight/flare/torch/lantern
			backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1)
			beltl = /obj/item/quiver/arrows
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/traps, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, rand(1,2), TRUE)
			H.change_stat("perception", 2)
			H.change_stat("endurance", 1)
			H.change_stat("speed", 3)
		
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/trou/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	else
		pants = /obj/item/clothing/under/roguetown/tights
		if(prob(50))
			pants = /obj/item/clothing/under/roguetown/tights/black
			gloves = /obj/item/clothing/gloves/roguetown/fingerless
	
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	if(prob(23))
		if(!H.has_language(/datum/language/elvish))
			H.grant_language(/datum/language/elvish)
			to_chat(H, span_info("I can speak Elfish with ,e before my speech."))
