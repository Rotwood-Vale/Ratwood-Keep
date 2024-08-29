//shield sword
/datum/advclass/sfighter
	name = "Warrior"
	tutorial = "Warriors are well balanced fighters, skilled in blades and capable of most other weapons. \
	They are an important member to most parties for their combat prowess, but not for much more."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/sfighter
	traits_applied = list(TRAIT_HEAVYARMOR)

	category_tags = list(CTAG_ADVENTURER)


/datum/outfit/job/roguetown/adventurer/sfighter/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Warrior","Monster Hunter",) // To Do - knight errant unique archetype(5 percent chance)
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)
	
		if("Warrior")
			H.set_blindness(0)
			to_chat(H, span_warning("Warriors are well rounded fighters, experienced often in many theaters of warfare and battle they are capable of rising to any challenge that might greet them on the path."))
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, rand(1,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, rand(1,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, rand(1,3), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, pick(1,1,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, pick(2,3), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
			H.change_stat("strength", 2)
			H.change_stat("endurance", 2) // 7 stat points total as a low-skill martial role without magic. Compared to Pally with 5 points.
			H.change_stat("constitution", 2)
			H.change_stat("speed", 1)
			shoes = /obj/item/clothing/shoes/roguetown/boots
			gloves = /obj/item/clothing/gloves/roguetown/leather
			belt = /obj/item/storage/belt/rogue/leather
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
			if(prob(70))
				armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
			else if(prob(50))
				armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
			else
				armor = /obj/item/clothing/suit/roguetown/armor/plate/scale
			if(prob(20))
				mask = /obj/item/clothing/mask/rogue/facemask
			else if(prob(60))
				head = /obj/item/clothing/head/roguetown/helmet/leather
			else if(prob(20))
				head = /obj/item/clothing/head/roguetown/helmet/skullcap
			else
				head = /obj/item/clothing/head/roguetown/helmet/kettle
			backl = /obj/item/storage/backpack/rogue/satchel
			backr = /obj/item/rogueweapon/shield/wood
			beltl = /obj/item/rogueweapon/huntingknife
			if(prob(50))
				beltr = /obj/item/rogueweapon/sword/iron
			else
				beltr = /obj/item/rogueweapon/sword/sabre
		if("Monster Hunter")
			H.set_blindness(0)
			to_chat(H, span_warning("Monsters Hunters are typically contracted champions of the common folk dedicated to the slaying of both lesser vermin and greater beasts of the wilds."))
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, rand(1,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, rand(1,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, rand(1,3), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, pick(1,1,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, pick(2,3), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
			H.change_stat("strength", 2)
			H.change_stat("endurance", 1) // Weaker endurance compared to a traditional warrior/soldier. Smarter due to study of rare magical beasts.
			H.change_stat("constitution", 2)
			H.change_stat("intelligence", 1)
			H.change_stat("speed", 1)
			shoes = /obj/item/clothing/shoes/roguetown/boots
			gloves = /obj/item/clothing/gloves/roguetown/leather
			belt = /obj/item/storage/belt/rogue/leather
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
			if(prob(40))
				armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
				backr = /obj/item/rogueweapon/sword/long
			else if(prob(60))
				armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
				r_hand = /obj/item/rogueweapon/spear/billhook
			else
				armor = /obj/item/clothing/suit/roguetown/armor/plate/scale // No helms for monster hunters.
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
				backr = /obj/item/rogueweapon/stoneaxe/battle
			backl = /obj/item/storage/backpack/rogue/satchel
			beltl = /obj/item/rogueweapon/huntingknife
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights/black
	else
		H.underwear = "Femleotard"
		H.underwear_color = CLOTHING_BLACK
		H.update_body()
		pants = /obj/item/clothing/under/roguetown/tights/black

	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
