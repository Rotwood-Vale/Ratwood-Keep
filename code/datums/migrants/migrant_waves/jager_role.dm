/datum/migrant_role/grenzelhoft/grenzelhoft_kommandant
	name = "Grenzelhoft Kommandant"
	greet_text = "Unbreakable. Resolute. Master of the field. Fearless. \
	These are the first words that come to mind when one mentions the Kommandant, the leader of the well reputed, \
	expensive and noble Grenzelhoft mercenaries of the Free Corps of the Grenzel empire. \
	The mercenaries of Grenzel rightfully fear and respect their Kommandant, walking to certain death on his one word."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		/datum/species/axian,
		/datum/species/vulpkanin,
		/datum/species/lupian,
		/datum/species/dracon,
		/datum/species/moth, //grenzelmoft?
		/datum/species/dwarf/mountain,
		/datum/species/human/northern,
		/datum/species/demihuman,
		/datum/species/anthromorph,
		/datum/species/tabaxi
	)
	outfit = /datum/outfit/job/roguetown/mercenary/grenzelhoft/grenzelhoft_kommandant
	show_wanderer_examine = FALSE
	show_foreign_examine = TRUE

/datum/outfit/job/roguetown/mercenary/grenzelhoft/pre_equip(mob/living/carbon/human/H)
	..()
	H.cmode_music = 'sound/music/combat_grenzelhoft.ogg'

/datum/outfit/job/roguetown/mercenary/grenzelhoft/grenzelhoft_kommandant/pre_equip(mob/living/carbon/human/H)
	..()
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/storage/keyring/mercenary_boss
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	neck = /obj/item/clothing/neck/roguetown/bervor
	shirt = /obj/item/clothing/suit/roguetown/shirt/grenzelhoft //Gives them back this so they can color again.
	head = /obj/item/clothing/head/roguetown/grenzelhofthat
	armor = /obj/item/clothing/suit/roguetown/armor/blacksteel/cuirass/hardened //Buffs this to instead be like a chainmaille and cuirass together
	pants = /obj/item/clothing/under/roguetown/blacksteel/platelegs
	shoes = /obj/item/clothing/shoes/roguetown/boots/blacksteel/plateboots
	gloves = /obj/item/clothing/gloves/roguetown/grenzelgloves
	backr = /obj/item/storage/backpack/rogue/satchel
	backl = /obj/item/rogueweapon/sword/long/rider/messer

	var/weapons = list("billhook", "halberd", "zweihander", "estoc")
	var/weaponschoice = input("Choose your weapon", "Available weapons") as anything in weapons

	switch(weaponschoice)
		if("billhook")
			r_hand = /obj/item/rogueweapon/spear/billhook
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		if("halberd")
			r_hand = /obj/item/rogueweapon/halberd
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		if("zweihander")
			r_hand = /obj/item/rogueweapon/greatsword/zwei
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		if("estoc")
			r_hand = /obj/item/rogueweapon/estoc
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		else
			r_hand = /obj/item/rogueweapon/halberd
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)

	//Humie grenzelhofts are always set to be, well, grenzelhoft
	if(ishumannorthern(H))
		var/list/skin_slop = H.dna.species.get_skin_list()
		H.skin_tone = skin_slop["Grenzelhoft"]
		H.update_body()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE) //Sword Grenz Mercs are 4.
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("endurance", 3)
		H.change_stat("constitution", 3)
		H.change_stat("perception", 2)
		H.change_stat("speed", 2)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

/datum/migrant_role/grenzelhoft/grenzelhoft_jager
	name = "Grenzelhoft Jäger"
	greet_text = "Trackers, Huntsmen, Marksmen. Those are the first words that describe a Jäger of the Free Corps. \
	Jägers are skilled handgonners and scouts of the Companies of the Grenzel Emperiate. Beastmen and elves are commonly found to \
	fill the Auxiliary ranks, however you are one of the lucky few that was allowed to join the Free Corps. \
	You are expected to provide the Guild with your expertise in tracking, and scouting. Alongside your marksmanship."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		/datum/species/axian,
		/datum/species/vulpkanin,
		/datum/species/lupian,
		/datum/species/moth, //grenzelmoft?
		/datum/species/dwarf/mountain,
		/datum/species/human/northern,
		/datum/species/demihuman,
		/datum/species/anthromorph,
		/datum/species/tabaxi,
		/datum/species/kobold,
		/datum/species/elf/wood,
		/datum/species/elf/dark,
	)
	outfit = /datum/outfit/job/roguetown/mercenary/grenzelhoft/grenzelhoft_jager

/datum/outfit/job/roguetown/mercenary/grenzelhoft/grenzelhoft_jager/pre_equip(mob/living/carbon/human/H)
	..()
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/ammo_holder/bullet/lead
	beltr = /obj/item/rogueweapon/stoneaxe/woodcut/steel
	backl = /obj/item/storage/backpack/rogue/backpack
	neck = /obj/item/clothing/neck/roguetown/gorget
	shirt = /obj/item/clothing/suit/roguetown/shirt/grenzelhoft
	head = /obj/item/clothing/head/roguetown/grenzelhofthat
	armor = /obj/item/clothing/suit/roguetown/armor/leather/studded
	pants = /obj/item/clothing/under/roguetown/grenzelpants
	shoes = /obj/item/clothing/shoes/roguetown/armor/grenzelhoft
	gloves = /obj/item/clothing/gloves/roguetown/grenzelgloves
	backr = /obj/item/gun/ballistic/firearm/flintgonne
	backpack_contents = list(/obj/item/storage/keyring/mercenary = 1, /obj/item/powderflask = 1, /obj/item/rogueweapon/huntingknife = 1, /obj/item/flint = 1, /obj/item/bedroll = 1, /obj/item/storage/belt/rogue/pouch/coins/poor = 1)


	//Humie grenzelhofts are always set to be, well, grenzelhoft
	if(ishumannorthern(H))
		var/list/skin_slop = H.dna.species.get_skin_list()
		H.skin_tone = skin_slop["Grenzelhoft"]
		H.update_body()
	if(isdemihuman(H))
		var/list/skin_slop = H.dna.species.get_skin_list()
		H.skin_tone = skin_slop["Grenzelhoft"]
		H.update_body()
	if(iswoodelf(H))
		H.change_stat("strength", 1)
		H.change_stat("speed", -1)
	if(isdwarfmountain(H))
		H.change_stat("speed", 1)
		H.change_stat("endurance", -1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/firearms, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/hunting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 1, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("endurance", 2)
		H.change_stat("speed", 3)
		H.change_stat("perception", 2)
		H.change_stat("constitution", 1) // 9 Points with no armor skill.

/datum/migrant_role/grenzelhoft/grenzelhoft_jager/outrider
	name = "Grenzelhoft Outrider"
	greet_text = "The Outriders of the Grenzelhoft Free Corps are picked from either the most skilled or the most insane of the Jägers.\
	Their task: be a highly mobile scout, emissary, and revenue stream. They set out alone, trusting in their skills and their steed to guide\
	them through the wilderness, through the butchered remains of their opponents, and to the nearest horde of mammons."
	outfit = /datum/outfit/job/roguetown/mercenary/grenzelhoft/grenzelhoft_jager/outrider

/datum/outfit/job/roguetown/mercenary/grenzelhoft/grenzelhoft_jager/outrider

// easter egg; you thought it was just a turn of phrase to say they pick some of the outriders from the insane?
/datum/pseudo_maniac_vision_handler
	var/mob/living/attached_to
	var/atom/movable/screen/fullscreen/maniac/hallucinations

/datum/pseudo_maniac_vision_handler/proc/attach_to(mob/living/attached)
	attached_to = attached
	hallucinations = attached.overlay_fullscreen("maniac", /atom/movable/screen/fullscreen/maniac)
	load_strings_file("maniac.json")
	START_PROCESSING(SSobj, src)

/datum/pseudo_maniac_vision_handler/Destroy()
	STOP_PROCESSING(SSobj, src)
	attached_to = null
	hallucinations = null
	..()

/datum/pseudo_maniac_vision_handler/process()
	if(!attached_to)
		STOP_PROCESSING(SSobj, src)
		qdel(src)
		return
	handle_maniac_visions(attached_to, hallucinations)
	handle_maniac_hallucinations(attached_to)
	handle_maniac_floors(attached_to)
	handle_maniac_walls(attached_to)

/datum/outfit/job/roguetown/mercenary/grenzelhoft/grenzelhoft_jager/outrider/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	H.change_stat("strength", 1)
	H.change_stat("constitution", 1)
	H.change_stat("perception", 2)
	// they get a saigabuck instead of just a saiga
	new /mob/living/simple_animal/hostile/retaliate/rogue/saigabuck/tame/saddled(get_turf(H))
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	if(!H.mind)
		return
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	//they weren't joking about half of the outriders being fucking crazy
	//but damn if they aren't good at their job!
	if(prob(50))
		H.ambushable = FALSE
		ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
		H.change_stat("constitution", 2)
		H.change_stat("endurance", 2)
		H.mind.adjust_skillrank(/datum/skill/misc/treatment, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 5, TRUE)
		H.cmode_music = 'sound/music/combat_maniac2.ogg'
		// they don't actually get any objectives or anything, just the ambience fucking with them
		var/datum/pseudo_maniac_vision_handler/sickbrain = new
		sickbrain.attach_to(H)

/datum/migrant_role/grenzelhoft/grenzelhoft_foot
	name = "Grenzelhoft Mercenary"
	greet_text = "Experts, Professionals, Expensive. Those are the first words that come to mind when the emperiate Grenzelhoft Free Corps is mentioned. While you may work for coin like any common sellsword, maintaining the honor of the Company will be of the utmost priority."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		/datum/species/axian,
		/datum/species/vulpkanin,
		/datum/species/lupian,
		/datum/species/dracon,
		/datum/species/moth, //grenzelmoft?
		/datum/species/dwarf/mountain,
		/datum/species/human/northern,
		/datum/species/demihuman,
		/datum/species/anthromorph,
		/datum/species/tabaxi
	)
	outfit = /datum/outfit/job/roguetown/mercenary/grenzelhoft/grenzelhoft

/datum/outfit/job/roguetown/mercenary/grenzelhoft/grenzelhoft/pre_equip(mob/living/carbon/human/H)
	..()
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/storage/keyring/mercenary
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	neck = /obj/item/clothing/neck/roguetown/gorget
	shirt = /obj/item/clothing/suit/roguetown/shirt/grenzelhoft
	head = /obj/item/clothing/head/roguetown/grenzelhofthat
	armor = /obj/item/clothing/suit/roguetown/armor/blacksteel/cuirass
	pants = /obj/item/clothing/under/roguetown/grenzelpants
	shoes = /obj/item/clothing/shoes/roguetown/armor/grenzelhoft
	gloves = /obj/item/clothing/gloves/roguetown/grenzelgloves
	backr = /obj/item/storage/backpack/rogue/satchel


	var/weapons = list("billhook", "halberd", "zweihander")
	var/weaponschoice = input("Choose your weapon", "Available weapons") as anything in weapons

	switch(weaponschoice)

		if("billhook")
			r_hand = /obj/item/rogueweapon/spear/billhook
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		if("halberd")
			r_hand = /obj/item/rogueweapon/halberd
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		if("zweihander")
			r_hand = /obj/item/rogueweapon/greatsword/zwei
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		else
			r_hand = /obj/item/rogueweapon/halberd
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)

	//Humie grenzelhofts are always set to be, well, grenzelhoft
	if(ishumannorthern(H))
		var/list/skin_slop = H.dna.species.get_skin_list()
		H.skin_tone = skin_slop["Grenzelhoft"]
		H.update_body()
	if(isdemihuman(H))
		var/list/skin_slop = H.dna.species.get_skin_list()
		H.skin_tone = skin_slop["Grenzelhoft"]
		H.update_body()

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("endurance", 1)
		H.change_stat("constitution", 2)
		H.change_stat("perception", 2)
		H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
