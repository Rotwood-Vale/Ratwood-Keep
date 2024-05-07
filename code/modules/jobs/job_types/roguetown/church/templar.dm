//shield flail or longsword, tief can be this with red cross

/datum/job/roguetown/templar
	title = "Templar"
	department_flag = CHURCHMEN
	faction = "Station"
	tutorial = "Templars are warriors who have forsaken wealth and title in lieu of service to the church, due to either zealotry or a past shame. They guard the church and its priest, while keeping a watchful eye against heresy and nite-creechers. Within troubled dreams, they wonder if the blood they shed makes them holy or stained."
	allowed_sexes = list("male")
	allowed_races = list("Humen",
	"Tiefling",
	"Aasimar",
	"Lizardfolk",
	"Tabaxi")
	allowed_patrons = list("Astrata", "Dendor", "Necra", "Pestra","Noc")
	outfit = /datum/outfit/job/roguetown/templar
	min_pq = 2
	total_positions = 2
	spawn_positions = 2
	display_order = JDO_TEMPLAR
	give_bank_account = TRUE

/datum/outfit/job/roguetown/templar/pre_equip(mob/living/carbon/human/H)
	..()
	var/allowed_patrons = list("Astrata", "Dendor", "Necra", "Pestra", "Noc")
	
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
	
	head = /obj/item/clothing/head/roguetown/helmet/heavy/bucket
	neck = /obj/item/clothing/neck/roguetown/psicross/astrata
	switch(ourpatron.name)
		if("Astrata")
			neck = /obj/item/clothing/neck/roguetown/psicross/astrata
			head = /obj/item/clothing/head/roguetown/helmet/heavy/astratahelm
		if("Dendor")
			neck = /obj/item/clothing/neck/roguetown/psicross/dendor
			head = /obj/item/clothing/head/roguetown/helmet/heavy/dendorhelm
		if("Necra")
			neck = /obj/item/clothing/neck/roguetown/psicross/necra
			head = /obj/item/clothing/head/roguetown/helmet/heavy/necrahelm
		if("Pestra")
			neck = /obj/item/clothing/neck/roguetown/psicross/pestra
		if("Noc")
			neck = /obj/item/clothing/neck/roguetown/psicross/noc
			head = /obj/item/clothing/head/roguetown/helmet/heavy/nochelm
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	pants = /obj/item/clothing/under/roguetown/tights/black
	shoes = /obj/item/clothing/shoes/roguetown/boots
	backl = /obj/item/storage/backpack/rogue/satchel
	backr = /obj/item/rogueweapon/shield/tower/metal
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
	beltr = /obj/item/rogueweapon/sword/long
	id = /obj/item/clothing/ring/silver
	cloak = /obj/item/clothing/cloak/tabard/crusader/tief
	gloves = /obj/item/clothing/gloves/roguetown/chain
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	backpack_contents = list(/obj/item/roguekey/church = 1, /obj/item/clothing/neck/roguetown/chaincoif = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("perception", 2)
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", 2)
		H.change_stat("endurance", 3)
		H.change_stat("speed", -2)
	ADD_TRAIT(H, RTRAIT_HEAVYARMOR, TRAIT_GENERIC)
	if(H.dna?.species)
		if(H.dna.species.id == "human")
			H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.PATRON)
	//Max devotion limit - Templars are stronger but cannot pray to gain more abilities beyond t1
	C.max_devotion = 250
	C.max_progression = CLERIC_REQ_1
	C.update_devotion(50, 0)
	C.holder_mob = H
	C.grant_spells_templar(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
