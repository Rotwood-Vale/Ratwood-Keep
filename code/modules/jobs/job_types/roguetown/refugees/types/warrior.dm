/datum/subclass/deserter
	name = "Deserter"
	tutorial = "You deserted your post and fled from the battlefield \
				after having witnessed first hand the horrors of war and the disastrous campaigns against the deadite hordes of the south.\
				You now seek refuge in a place where your past allegiance wont be recognized, hoping that the rot hasn't followed you.\ "

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	category_tags = list(CTAG_REFUGEE)

	outfit = /datum/outfit/job/roguetown/refugee/deserter

/datum/outfit/job/roguetown/refugee/deserter
	allowed_patrons = ALL_PATRONS

/datum/outfit/job/roguetown/refugee/deserter/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Footman", "Crossbowman", "Pikeman", "Handgonner", "Warrior","Monster Hunter")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Footman")
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
			pants = /obj/item/clothing/under/roguetown/tights/black
			shoes = /obj/item/clothing/shoes/roguetown/armor
			gloves = /obj/item/clothing/gloves/roguetown/leather
			belt = /obj/item/storage/belt/rogue/leather
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
			head = /obj/item/clothing/head/roguetown/helmet/skullcap
			backl = /obj/item/storage/backpack/rogue/satchel
			backr = /obj/item/rogueweapon/shield/wood
			beltl = /obj/item/rogueweapon/huntingknife
			beltr = /obj/item/rogueweapon/sword/iron/messer
			H.change_stat("strength", 2)
			H.change_stat("endurance", 2)
			H.change_stat("constitution", 1)
			H.change_stat("speed", 1)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

		if("Crossbowman")
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
			pants = /obj/item/clothing/under/roguetown/tights/black
			shoes = /obj/item/clothing/shoes/roguetown/armor
			gloves = /obj/item/clothing/gloves/roguetown/leather
			belt = /obj/item/storage/belt/rogue/leather
			neck = /obj/item/clothing/neck/roguetown/gorget
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
			head = /obj/item/clothing/head/roguetown/helmet/sallet/visored
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
			backr = /obj/item/rogueweapon/shield/tower
			beltl = /obj/item/ammo_holder/quiver/bolts
			beltr = /obj/item/storage/backpack/rogue/satchel
			backpack_contents = list(/obj/item/rogueweapon/huntingknife = 1)
			H.change_stat("strength", 1)
			H.change_stat("endurance", 2)
			H.change_stat("constitution", 1)
			H.change_stat("speed", 1)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		
		if("Pikeman")	
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
			r_hand = /obj/item/rogueweapon/spear
			pants = /obj/item/clothing/under/roguetown/tights/black
			shoes = /obj/item/clothing/shoes/roguetown/armor
			gloves = /obj/item/clothing/gloves/roguetown/chain
			belt = /obj/item/storage/belt/rogue/leather
			neck = /obj/item/clothing/neck/roguetown/gorget
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
			head = /obj/item/clothing/head/roguetown/helmet/bascinet
			backl = /obj/item/storage/backpack/rogue/satchel
			beltl = /obj/item/rogueweapon/huntingknife
			H.change_stat("strength", 2)
			H.change_stat("endurance", 2)
			H.change_stat("constitution", 1)
			H.change_stat("speed", 1)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		
		if("Handgonner")
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
			shirt = /obj/item/clothing/suit/roguetown/shirt/grenzelhoft
			head = /obj/item/clothing/head/roguetown/grenzelhofthat
			pants = /obj/item/clothing/under/roguetown/grenzelpants
			shoes = /obj/item/clothing/shoes/roguetown/armor/grenzelhoft
			gloves = /obj/item/clothing/gloves/roguetown/grenzelgloves
			backpack_contents = list(/obj/item/rogueweapon/huntingknife = 1)
			H.change_stat("strength", 1)
			H.change_stat("endurance", 1)
			H.change_stat("constitution", 1)
			H.change_stat("speed", 2)
			H.change_stat("intelligence", 2)
			
		if("Warrior")
			to_chat(H, span_warning("Warriors are well rounded fighters, experienced often in many theaters of warfare and battle they are capable of rising to any challenge that might greet them on the path."))
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, rand(1,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, rand(1,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, pick(1,1,2), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, pick(2,3), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
			H.change_stat("strength", 2)
			H.change_stat("endurance", 2) // Slightly worse stats since they're now actually skilled
			H.change_stat("constitution", 1)
			H.change_stat("speed", 1)
			shoes = /obj/item/clothing/shoes/roguetown/armor
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
			else if(prob(30))
				beltr = /obj/item/rogueweapon/sword/iron/messer
			else if(prob(30))
				beltr = /obj/item/rogueweapon/mace
			else if(prob(30))
				beltr = /obj/item/rogueweapon/stoneaxe/handaxe
			else
				beltr = /obj/item/rogueweapon/flail

		if("Monster Hunter")
			H.set_blindness(0)
			to_chat(H, span_warning("Monsters Hunters are typically contracted champions of the common folk dedicated to the slaying of both lesser vermin and greater beasts of the wilds."))
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, rand(3,4), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, rand(3,4), TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, pick(2,3), TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.change_stat("strength", 2) 
			H.change_stat("endurance", 1)// Weaker endurance compared to a traditional warrior/soldier. Smarter due to study of rare magical beasts.
			H.change_stat("constitution", 1)
			H.change_stat("intelligence", 1)
			H.change_stat("speed", 1)
			shoes = /obj/item/clothing/shoes/roguetown/armor
			gloves = /obj/item/clothing/gloves/roguetown/leather
			belt = /obj/item/storage/belt/rogue/leather
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
			if(prob(40))
				armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
				backr = /obj/item/rogueweapon/sword/iron
			else if(prob(60))
				armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
				r_hand = /obj/item/rogueweapon/spear
			else
				armor = /obj/item/clothing/suit/roguetown/armor/plate/scale // No helms for monster hunters.
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
				backr = /obj/item/rogueweapon/stoneaxe/woodcut
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

	H.set_blindness(0)
