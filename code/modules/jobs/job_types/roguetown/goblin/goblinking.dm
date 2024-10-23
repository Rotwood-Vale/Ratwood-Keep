
/datum/job/roguetown/goblinking
	title = "Goblin King"
	flag = GOBLINKING
	department_flag = GOBLIN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_sexes = list(MALE)
	allowed_races = list(/datum/species/goblinp)
	allowed_patrons = list(/datum/patron/inhumen/graggar)
	tutorial = "Lord above, it's good to be King. You don't have to do anything beyond lifting a finger for your subjects to move. \
	Should they ignore you or disobey, you've your guards to handle them. Try to provide some manner of order to the camp and your subjects. \
	Ideally, you should focus inwards, ignoring the town and keep to the north, for your own sake, and develop what land you have in the mire."
	whitelist_req = FALSE
	outfit = /datum/outfit/job/roguetown/goblinking
	display_order = JDO_GOBLINKING
	min_pq = 4
	max_pq = null
	always_show_on_latechoices = TRUE

/datum/outfit/job/roguetown/goblinking/pre_equip(mob/living/carbon/human/H)
	..()
	H.verbs |= /mob/living/carbon/human/proc/goblinannouncement
	//H.verbs |= /mob/living/carbon/human/proc/goblinopenslot
	beltl = /obj/item/rogueweapon/huntingknife/idagger/steel/special
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	armor = /obj/item/clothing/suit/roguetown/armor/leather/hide/goblin
	pants = /obj/item/clothing/under/roguetown/loincloth/brown
	head = /obj/item/clothing/head/roguetown/crown/surplus
	cloak = /obj/item/clothing/cloak/heartfelt
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.change_stat("strength", -1)
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", 6)
		H.change_stat("endurance", 1)
		H.change_stat("speed", -2)

/mob/living/carbon/human/proc/goblinannouncement()
	set name = "Announcement"
	set category = "Goblin King"
	if(stat)
		return
	var/inputty = input("Make an announcement", "ROGUETOWN") as text|null
	if(inputty)
		if(!istype(get_area(src), /area/rogue/under/town/goblin))
			to_chat(src, span_warning("I need to do this from the encampment."))
			return FALSE
		priority_announce("[inputty]", title = "The Goblin King Squeals", sound = 'sound/misc/dun.ogg')
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


