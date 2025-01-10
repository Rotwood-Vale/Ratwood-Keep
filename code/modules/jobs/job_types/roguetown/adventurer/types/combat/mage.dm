/datum/advclass/mage
	name = "Mage"
	tutorial = "Mages are skilled in the arcane. Scholars all over the world spend years studying magic - most do not succeed."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/mage
	category_tags = list(CTAG_ADVENTURER)
	traits_applied = list(TRAIT_OUTLANDER)

/datum/outfit/job/roguetown/adventurer/mage/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Sorcerer","Spellsinger","Necromancer")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)
	
		if("Sorcerer")
			to_chat(H, span_warning("You are a learned mage and a scholar, having spent your life studying the arcane and its ways."))
			head = /obj/item/clothing/head/roguetown/roguehood/mage
			shoes = /obj/item/clothing/shoes/roguetown/boots
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/mage
			belt = /obj/item/storage/belt/rogue/leather
			beltr = /obj/item/reagent_containers/glass/bottle/rogue/manapot
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltl = /obj/item/rogueweapon/huntingknife
			backl = /obj/item/storage/backpack/rogue/satchel
			backr = /obj/item/rogueweapon/woodstaff
			backpack_contents = list(/obj/item/flashlight/flare/torch = 1, /obj/item/spellbook_unfinished/pre_arcyne = 1)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
			H.dna.species.soundpack_m = new /datum/voicepack/male/wizard()
			if(H.age == AGE_OLD)
				H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
				H.mind.adjust_spellpoints(1)
			H.change_stat("intelligence", 3)
			H.change_stat("perception", 2)
			H.change_stat("speed", 1)
			H.mind.adjust_spellpoints(1)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
		if("Spellsinger")
			to_chat(H, span_warning("You belong to a school of bards renowned for their study of both the arcane and the arts."))
			head = /obj/item/clothing/head/roguetown/bucklehat
			shoes = /obj/item/clothing/shoes/roguetown/boots
			pants = /obj/item/clothing/under/roguetown/tights/black
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/puritan
			gloves = /obj/item/clothing/gloves/roguetown/fingerless
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/white
			cloak = /obj/item/clothing/cloak/raincloak/purple
			backl = /obj/item/storage/backpack/rogue/satchel
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltr = /obj/item/rogueweapon/sword/sabre
			backpack_contents = list(/obj/item/flashlight/flare/torch = 1)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/mockery)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/music, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
			H.change_stat("intelligence", 2)
			H.change_stat("endurance", 1)
			H.change_stat("speed", 2)
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

		if("Necromancer")
			H.set_patron(/datum/patron/inhumen/zizo)
			to_chat(H, span_warning("You have been ostracized and hunted by society for your dark magics and perversion of life."))
			head = /obj/item/clothing/head/roguetown/roguehood/mage
			shoes = /obj/item/clothing/shoes/roguetown/boots
			pants = /obj/item/clothing/under/roguetown/trou/leather
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/mage
			belt = /obj/item/storage/belt/rogue/leather
			beltr = /obj/item/reagent_containers/glass/bottle/rogue/manapot
			neck = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltl = /obj/item/rogueweapon/huntingknife
			backl = /obj/item/storage/backpack/rogue/satchel
			backr = /obj/item/rogueweapon/woodstaff
			backpack_contents = list(/obj/item/spellbook_unfinished/pre_arcyne = 1, /obj/item/roguegem/amethyst = 1, /obj/item/roguekey/inhumen = 1)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 4, TRUE)
			ADD_TRAIT(H, TRAIT_ZOMBIE_IMMUNE, TRAIT_GENERIC)
			if(H.age == AGE_OLD)
				H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
				H.mind.adjust_spellpoints(1)
			H.change_stat("intelligence", 4)
			H.change_stat("endurance", 1)
			H.change_stat("speed", 1)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/bonechill)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/raise_lesser_undead)
			H.faction |= "undead"
			H.mind.adjust_spellpoints(1)
			GLOB.excommunicated_players += H.real_name
