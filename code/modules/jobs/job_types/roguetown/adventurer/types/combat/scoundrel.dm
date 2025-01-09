/datum/advclass/rogue
	name = "Scoundrel"
	tutorial = "Thieves, scoundrels, and silver-tongued charlatans from all walks of life."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/rogue
	traits_applied = list(TRAIT_OUTLANDER)
	category_tags = list(CTAG_ADVENTURER)

/datum/outfit/job/roguetown/adventurer/rogue/pre_equip(mob/living/carbon/human/H)
	..()
	var/classchoice
	H.adjust_blindness(-3)
	var/classes = list("Treasure Hunter","Rogue","Bard","Outlaw")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes
	switch(classchoice)
	
		if("Treasure Hunter")
			to_chat(H, span_warning("You are a treasure hunter trained in hunting for valuables. Discern what is treasure or not, your fortune could be hidden anywhere."))
			pants = /obj/item/clothing/under/roguetown/trou/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
			backl = /obj/item/storage/backpack/rogue/satchel
			belt = /obj/item/storage/belt/rogue/leather
			gloves = /obj/item/clothing/gloves/roguetown/fingerless
			shoes = /obj/item/clothing/shoes/roguetown/boots
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			backr = /obj/item/rogueweapon/shovel
			head = /obj/item/clothing/head/roguetown/puritan
			beltl = /obj/item/flashlight/flare/torch/lantern
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			backpack_contents = list(/obj/item/lockpick)
			H.mind.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 5, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
			var/weapons = list("Sabre","Whip")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			H.set_blindness(0)
			switch(weapon_choice)
				if("Sabre")
					H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
					beltr = /obj/item/rogueweapon/sword/sabre
				if("Whip")
					H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
					beltr = /obj/item/rogueweapon/whip
			H.change_stat("strength", -1)
			H.change_stat("intelligence", 1)
			H.change_stat("perception", 1)
			H.change_stat("endurance", 1)
			H.change_stat("speed", 3)

		if("Rogue")
			to_chat(H, span_warning("You are a scoundrel and a thief. A master in getting into places you shouldn't be and taking things that aren't rightfully yours."))
			pants = /obj/item/clothing/under/roguetown/trou/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather
			cloak = /obj/item/clothing/cloak/raincloak/mortus
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
			backl = /obj/item/storage/backpack/rogue/satchel
			belt = /obj/item/storage/belt/rogue/leather
			gloves = /obj/item/clothing/gloves/roguetown/fingerless
			shoes = /obj/item/clothing/shoes/roguetown/boots
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			beltl = /obj/item/lockpickring
			beltr = /obj/item/rogueweapon/huntingknife/idagger/steel
			backpack_contents = list(/obj/item/flashlight/flare/torch = 1)
			H.mind.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 6, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/traps, 4, TRUE)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			H.change_stat("strength", -1)
			H.change_stat("intelligence", 1)
			H.change_stat("perception", 1)
			H.change_stat("endurance", 1)
			H.change_stat("speed", 3)

		if("Bard")
			to_chat(H, span_warning("You make your fortune in brothels, flop houses, and taverns – gaining fame for your songs and legends. If there is any truth to them, that is."))
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/music, 5, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
			head = /obj/item/clothing/head/roguetown/bardhat
			shoes = /obj/item/clothing/shoes/roguetown/boots
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
			gloves = /obj/item/clothing/gloves/roguetown/fingerless
			belt = /obj/item/storage/belt/rogue/leather
			beltl = /obj/item/flashlight/flare/torch/lantern
			beltr = /obj/item/rogueweapon/huntingknife/idagger/steel
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
			cloak = /obj/item/clothing/cloak/half/red
			backpack_contents = list(/obj/item/lockpick)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/mockery)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
			var/weapons = list("Harp","Lute","Accordion","Guitar","Hurdy-Gurdy","Viola","Vocal Talisman")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			H.set_blindness(0)
			switch(weapon_choice)
				if("Harp")
					backr = /obj/item/rogue/instrument/harp
				if("Lute")
					backr = /obj/item/rogue/instrument/lute
				if("Accordion")
					backr = /obj/item/rogue/instrument/accord
				if("Guitar")
					backr = /obj/item/rogue/instrument/guitar
				if("Hurdy-Gurdy")
					backr = /obj/item/rogue/instrument/hurdygurdy
				if("Viola")
					backr = /obj/item/rogue/instrument/viola
				if("Vocal Talisman")
					backr = /obj/item/rogue/instrument/vocals
			H.change_stat("intelligence", 2)
			H.change_stat("endurance", 1)
			H.change_stat("speed", 2)

		if("Outlaw")
			to_chat(H, span_warning("You're a seasoned criminal known for your heinous acts, your face plasted on wanted posters across the region. A life of theft, robbery, and ill-gotten-gains comes naturally to you."))
			pants = /obj/item/clothing/under/roguetown/trou/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather/studded
			cloak = /obj/item/clothing/cloak/raincloak/mortus
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
			backl = /obj/item/storage/backpack/rogue/satchel
			belt = /obj/item/storage/belt/rogue/leather
			gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
			shoes = /obj/item/clothing/shoes/roguetown/boots
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			beltl = /obj/item/lockpickring
			backpack_contents = list(/obj/item/flashlight/flare/torch = 1)
			H.mind.adjust_skillrank(/datum/skill/misc/tracking, 5, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 6, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 5, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 5, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 5, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/traps, 5, TRUE)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_OUTLAW, TRAIT_GENERIC)
			var/weapons = list("Rapier","Dagger")
			var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
			H.set_blindness(0)
			switch(weapon_choice)
				if("Rapier")
					H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
					beltr = /obj/item/rogueweapon/sword/sabre
				if("Dagger")
					H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
					beltr = /obj/item/rogueweapon/huntingknife/idagger/silver/elvish
			H.change_stat("strength", -1)
			H.change_stat("constitution", 1)
			H.change_stat("endurance", 2)
			H.change_stat("speed", 3)
