/datum/job/roguetown/goblinchief
	title = "Goblin Chief"
	f_title = "Goblin Chieftess"
	flag = GOBLINCHIEF
	department_flag = GOBLIN
	selection_color = JCOLOR_GOBLIN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/goblinp, /datum/species/halforc)
	tutorial = "You're the Chief of the local Goblin tribe. A representation of Graggar's rule, you are the biggest and strongest. You ensure the spread of his dominion over others where you can. \
	Currently, you're in hiding, beneath the town and, thankfully, bypassing the Mire's gate. \
	Have your subjects trudge through the sewers and elsewhere, robbing and kidnapping passersby. Spread your will upon the weak fools. Bring glory and slaves to your tribe in Graggar's name!"
	whitelist_req = FALSE
	outfit = /datum/outfit/job/roguetown/goblinchief
	display_order = JDO_GOBLINCHIEF
	min_pq = 6
	max_pq = null
	announce_latejoin = FALSE

/datum/outfit/job/roguetown/goblinchief
	allowed_patrons = list(/datum/patron/inhumen/graggar)

/datum/outfit/job/roguetown/goblinchief/pre_equip(mob/living/carbon/human/H)
	..()
	H.faction += "orcs"
	//H.verbs |= /mob/living/carbon/human/proc/goblinannouncement
	//H.verbs |= /mob/living/carbon/human/proc/goblinopenslot
	beltl = /obj/item/rogueweapon/huntingknife/idagger/steel/special
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	armor = /obj/item/clothing/suit/roguetown/armor/leather/hide/goblin
	pants = /obj/item/clothing/under/roguetown/loincloth/brown
	head = /obj/item/clothing/head/roguetown/crown/surplus
	cloak = /obj/item/clothing/cloak/heartfelt
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/storage/keyring/goblinchief = 1)
	ADD_TRAIT(H, TRAIT_GOBLINCAMP, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DARKVISION, TRAIT_GENERIC)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		if(istype(H.dna.species, /datum/species/halforc)) // Horc with +4 strength might be too strong.
			H.change_stat("strength", 2)
		else
			H.change_stat("strength", 4)
			H.ventcrawler = VENTCRAWLER_ALWAYS
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", 3)
		H.change_stat("endurance", 2)
		H.change_stat("speed", 1)

//If a non-Goblin or Horc gets control by admin intervention.
	if(!H.has_language(/datum/language/orcish))
		H.grant_language(/datum/language/orcish)
		to_chat(H, span_info("I can speak Orchish with ,o before my speech."))

/*
/mob/living/carbon/human/proc/goblinannouncement()
	set name = "Announcement"
	set category = "Goblin Chief"
	if(stat)
		return
	var/inputty = input("Make an announcement", "ROGUETOWN") as text|null
	if(inputty)
		if(!istype(get_area(src), /area/rogue/under/town/goblin))
			to_chat(src, span_warning("I need to do this from the encampment."))
			return FALSE
		priority_announce("[inputty]", title = "The Goblin Chief Speaks", sound = 'sound/misc/dun.ogg')
*/
/*
/mob/living/carbon/human/proc/goblinopenslot()
	set name = "Open Slot"
	set category = "Goblin King"
	if(stat)
		return
	var/datum/job/cookjob = SSjob.GetJob("Goblin Cook")
	var/datum/job/guardjob = SSjob.GetJob("Goblin Guard")
	var/datum/job/smithjob = SSjob.GetJob("Goblin Smith")
	var/list/souloptions = list("Goblin Cook", "Goblin Guard", "Goblin Smith")
	var/pickedsoul = input("Which worker shall join kingdom?", "Available workers") as null|anything in souloptions
	if(!istype(get_area(src), /area/rogue/indoors/shelter/mountains/decap))
		to_chat(src, span_warning("I need to do this from the Goblin Kingdom."))
		return FALSE
	if(!pickedsoul)
		return
	switch(pickedsoul)
		if("Goblin Cook")
			cookjob.total_positions += 1
			priority_announce("Goblin Cook shall join our Kingdom", title = "The Goblin King Hires", sound = 'sound/misc/dun.ogg')
		if("Goblin Guard")
			guardjob.total_positions += 1
			priority_announce("Goblin Guard shall join our Kingdom", title = "The Goblin King Hires", sound = 'sound/misc/dun.ogg')
		if("Goblin Smith")
			smithjob.total_positions += 1
			priority_announce("Goblin Smith shall join our Kingdom", title = "The Goblin King Hires", sound = 'sound/misc/dun.ogg')
*/


