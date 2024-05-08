//shield flail or longsword, tief can be this with red cross

/datum/advclass/paladin
	name = "Paladin"
	tutorial = "Paladins are holy warriors who have taken sacred vows to uphold justice and righteousness. Often, they were promised redemption for past sins if they crusaded in the name of the gods."	
	allowed_sexes = list("male", "female")
	allowed_races = list("Humen",
	"Tiefling",
	"Aasimar",
	"Lizardfolk")
	outfit = /datum/outfit/job/roguetown/adventurer/paladin
	allowed_patrons = list("Astrata", "Dendor", "Necra", "Pestra", "Noc")

/datum/outfit/job/roguetown/adventurer/paladin/pre_equip(mob/living/carbon/human/H)
	..()
	var/allowed_patrons = list("Astrata", "Dendor", "Necra", "Pestra","Noc")
	
	var/datum/patrongods/ourpatron
	if(istype(H.PATRON, /datum/patrongods))
		ourpatron = H.PATRON

	if(!ourpatron || !(ourpatron.name in allowed_patrons))
		var/list/datum/patrongods/possiblegods = list()
		for(var/god in GLOB.patronlist)
			var/datum/patrongods/patron = GLOB.patronlist[god]
			if(patron.name in allowed_patrons)
				possiblegods |= patron
		ourpatron = pick(possiblegods)
		H.PATRON = ourpatron
		to_chat(H, "<span class='warning'>My patron had not endorsed my practices in my younger years. I've since grown acustomed to [H.PATRON].")
	
	switch(ourpatron.name)
		if("Astrata")
			neck = /obj/item/clothing/neck/roguetown/psicross/astrata
		if("Dendor")
			neck = /obj/item/clothing/neck/roguetown/psicross/dendor
		if("Necra")
			neck = /obj/item/clothing/neck/roguetown/psicross/necra
		if("Pestra")
			neck = /obj/item/clothing/neck/roguetown/psicross/pestra
		if("Noc")
			neck = /obj/item/clothing/neck/roguetown/psicross/noc


	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	pants = /obj/item/clothing/under/roguetown/chainlegs
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather/hand
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltr = /obj/item/rogueweapon/huntingknife
	id = /obj/item/clothing/ring/silver
	cloak = /obj/item/clothing/cloak/tabard/crusader
	backr = /obj/item/rogueweapon/sword
	backl = /obj/item/storage/backpack/rogue/satchel
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("perception", 1)
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", 2)
		H.change_stat("endurance", 2)
		H.change_stat("speed", -2)
	ADD_TRAIT(H, RTRAIT_HEAVYARMOR, TRAIT_GENERIC)
	if(H.dna?.species)
		if(H.dna.species.id == "human")
			H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
		if(H.dna.species.id == "tiefling")
			cloak = /obj/item/clothing/cloak/tabard/crusader/tief
	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.PATRON)
	//Max devotion limit - Paladins are stronger but cannot pray to gain all abilities beyond t1
	C.max_devotion = 250
	C.max_progression = CLERIC_REQ_1
	C.update_devotion(50, 0)
	C.holder_mob = H
	C.grant_spells_templar(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
