/datum/job/roguetown/mercenary/guildmaster
	title = "Mercenary Guildmaster"
	flag = GUILDMASTER
	department_flag = MERCENARIES
	tutorial = "Being either appointed or earned through combat. You are leader of the Guild. Ensure that the Guild's reputation and coin continues flowing."
	allowed_ages = list(AGE_OLD)
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_TOLERATED_UP
	outfit = null
	display_order = JDO_GUILDMASTER
	selection_color = JCOLOR_MERCENARY
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	min_pq = null //Leadership
	max_pq = null
	cmode_music = 'sound/music/combat_guard2.ogg'

/datum/job/roguetown/mercenary/guildmaster
	allowed_patrons = list(ALL_DIVINE_PATRONS, /datum/patron/old_god, /datum/patron/inhumen/graggar)
	
/datum/job/roguetown/mercenary/guildmaster/pre_equip(mob/living/carbon/human/H)
	var/classes = list("Quartermaster","Grenzelhoftian Veteran","Desert Rider Veteran",)
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes
	H.adjust_blindness(-3)
	switch(classchoice)

		if("Quartermaster") // Non-Combat focused rich supporter character.
			to_chat(H, span_warning("Being assigned, hired, or earned your way through the Guild you've finally found yourself at the very top. Ensure that the men assigned beneath you are properly handled. You may not be as strong as them, but with the backing of both the Desert Rider Commander and the Empire of Grenzelhoft your words hold power."))
			H.set_blindness(0) 
			to_chat(H, span_warning("You are the Quartermaster of the Mercenary Guild."))
			//Skills - Adjusted Merchant skills.
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/labor/mathematics, 5, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			ADD_TRAIT(H, TRAIT_SEEPRICES, type)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			H.change_stat("strength", -1) //Effectively -2 due to racial.
			H.change_stat("speed", 1) // -1 Since they are not meant to be in combat, but to run around and handle things.
			H.change_stat("perception", 1) // 0
			H.change_stat("constitution", 1) //-1
			H.change_stat("intelligence", 2) // +4
			// Gear - Mixed Hand/Captain Gear + Money
			l_hand = /obj/item/storage/belt/rogue/pouch/coins/rich // Max of 150(?) mammons
			r_hand = /obj/item/storage/belt/rogue/pouch/coins/rich
			head = /obj/item/clothing/head/roguetown/fancyhat
			pants = /obj/item/clothing/under/roguetown/tights/black
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/guard
			shoes = /obj/item/clothing/shoes/roguetown/boots
			armor = /obj/item/clothing/suit/roguetown/armor/brigandine
			belt = /obj/item/storage/belt/rogue/leather/hand
			beltl = /obj/item/rogueweapon/sword/sabre/dec
			id = /obj/item/clothing/ring/gold
			backl = /obj/item/storage/backpack/rogue/backpack
			// Two pies. Two wine. One healing. One mana. Spare keys keyring(Told that keys are being touched. WIL)
			backpack_contents = list(/obj/item/reagent_containers/food/snacks/rogue/pie/cooked/meat=2, /obj/item/reagent_containers/glass/bottle/rogue/wine=2, /obj/item/reagent_containers/glass/bottle/rogue/healthpot=1, /obj/item/reagent_containers/glass/bottle/rogue/manapot=1, /obj/item/roguekey/mercenary=1)

		if("Grenzelhoftian Veteran") //BIG SWOOOORD
			to_chat(H, span_warning("A veteran of the Guild. Professionalism and good conduct with a bit of luck has allowed you the honor of leading the next generation to coin and glory. Your expertise and knowledge of the trade will be useful. For the Emperiate."))
			H.set_blindness(0) 
			to_chat(H, span_warning("You are a Grenzelhoftian Veteran"))
			//Skills
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.change_stat("strength", 3) // + 2 since they are a proper veteran.
			H.change_stat("constitution", 3) // +1
			H.change_stat("perception", -2) // -3 
			H.change_stat("speed", -2) //-4 You are old, man. Life ain't shit. Also +2 Int from Age.
			H.change_stat("fortune", 2) // Beware of an old man in a profession where men usually die young
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
			// Gear - Grenzelhoft modified.
			wrists = /obj/item/clothing/wrists/roguetown/bracers
			belt = /obj/item/storage/belt/rogue/leather
			beltl = /obj/item/rogueweapon/huntingknife/idagger
			beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
			neck = /obj/item/clothing/neck/roguetown/bervor
			shirt = /obj/item/clothing/suit/roguetown/shirt/grenzelhoft
			head = /obj/item/clothing/head/roguetown/grenzelhofthat
			armor = /obj/item/clothing/suit/roguetown/armor/plate/half/grenzelhoft
			pants = /obj/item/clothing/under/roguetown/grenzelpants
			shoes = /obj/item/clothing/shoes/roguetown/grenzelhoft
			gloves = /obj/item/clothing/gloves/roguetown/grenzelgloves
			backl = /obj/item/storage/backpack/rogue/satchel
			backpack_contents = list(/obj/item/roguekey/mercenary)
			r_hand = /obj/item/rogueweapon/greatsword

			if(H.gender == FEMALE)
				var/acceptable = list("Tomboy", "Bob", "Curly Short")
				if(!(H.hairstyle in acceptable))
					H.hairstyle = pick(acceptable)
					H.update_hair()
			//Humie grenzelhofts are always set to be, well, grenzelhoft
			if(ishumannorthern(H))
				var/list/skin_slop = H.dna.species.get_skin_list()
				H.skin_tone = skin_slop["Grenzelhoft"]
				H.update_body()

		if("Desert Rider Veteran") // Least worked out role.
			to_chat(H, span_warning(""))
			H.set_blindness(0) 
			to_chat(H, span_warning("You are a Desert Rider Veteran"))
			//Skills
			H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
			H.change_stat("strength", 3) // + 2 since they are a proper veteran.
			H.change_stat("constitution", 3) // +1
			H.change_stat("perception", -2) // -3
			H.change_stat("endurance", 2)
			H.change_stat("speed", -1) //-3 You are old, man. Life ain't shit. Also +2 Int from Age.
			H.change_stat("fortune", 2) // Beware of an old man in a profession where men usually die young
			//Equipment
			horse = /mob/living/simple_animal/hostile/retaliate/rogue/saigabuck/tame/saddled
			wrists = /obj/item/clothing/wrists/roguetown/bracers
			shoes = /obj/item/clothing/shoes/roguetown/shalal
			head = /obj/item/clothing/head/roguetown/roguehood/shalal
			gloves = /obj/item/clothing/gloves/roguetown/angle
			belt = /obj/item/storage/belt/rogue/leather/shalal
			armor = /obj/item/clothing/suit/roguetown/armor/plate/scale
			beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
			backl = /obj/item/rogueweapon/sword/long/rider
			beltl = /obj/item/flashlight/flare/torch/lantern
			shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
			pants = /obj/item/clothing/under/roguetown/platelegs
			neck = /obj/item/clothing/neck/roguetown/shalal
			backl = /obj/item/storage/backpack/rogue/satchel
			backpack_contents = list(/obj/item/roguekey/mercenary)
			//
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
			// A quick check to make sure the desert rider is canonical
			var/static/list/canonical_heritage_check_list = list(
			SKIN_COLOR_GIZA,
			SKIN_COLOR_LALVESTINE,
			SKIN_COLOR_SHALVISTINE,
			SKIN_COLOR_EBON
			)
			if(ishumannorthern(H) && !(H.skin_tone in canonical_heritage_check_list))
			H.skin_tone = pick(canonical_heritage_check_list)
			H.update_body()

			if(H.gender == FEMALE)
				var/acceptable = list("Tomboy", "Bob", "Curly Short")
				if(!(H.hairstyle in acceptable))
					H.hairstyle = pick(acceptable)
					H.update_hair()


					


					







