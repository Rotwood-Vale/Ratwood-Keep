/datum/job/roguetown/marshal
	title = "Royal Marshal"
	flag = MARSHAL
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_sexes = list(MALE)
	allowed_races = RACES_TOLERATED_UP
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	display_order = JDO_MARSHAL
	tutorial = "You and your Councillors are the judge and jury, only overruled by His Majesty. \
				Plan with the Councillors on any issues, laws, judgements, and construction that are required to adapt to the new world. \
				Your two assistant Councillors are there to fuel your wonderful ideas, lifting the weight of responsibility off your shoulders. \
				Delegate tasks, enforce taxes and justice upon the unruly. Keep the town running, and enrich it with new architecture. \
				After all, the Duke entrusted you with leading and maintaining his military might. \
				It may be the Duke's land, but you pull the strings in this town. \
				All in the name of fulfilling your duty to your Duke."
	whitelist_req = FALSE

	spells = list(/obj/effect/proc_holder/spell/self/convertrole/guard, /obj/effect/proc_holder/spell/self/convertrole/bog)
	outfit = /datum/outfit/job/roguetown/marshal

	give_bank_account = 40
	min_pq = 4
	max_pq = null

	cmode_music = 'sound/music/combat_guard.ogg'

/datum/outfit/job/roguetown/marshal/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	pants = /obj/item/clothing/under/roguetown/tights/black
	shoes = /obj/item/clothing/shoes/roguetown/armor/nobleboot
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather/plaquegold
	beltl = /obj/item/keyring/marshal
	beltr = /obj/item/rogueweapon/mace
	cloak = /obj/item/clothing/cloak/stabard/surcoat/marshal
	gloves = /obj/item/clothing/gloves/roguetown/leather/angle
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.change_stat("strength", 3)
		H.change_stat("perception", 2)
		H.change_stat("intelligence", 3)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 1)
		H.change_stat("speed", 1)
		H.change_stat("fortune", 1)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	H.verbs |= /mob/proc/haltyell
	H.verbs |= list(/mob/living/carbon/human/proc/request_outlaw, /mob/living/carbon/human/proc/request_law, /mob/living/carbon/human/proc/request_law_removal, /mob/living/carbon/human/proc/request_purge)

/mob/living/carbon/human/proc/request_law()
	set name = "Request Law"
	set category = "Martial Law"
	if(stat)
		return
	var/inputty = input("Write a new law", "MARTIAL LAW") as text|null
	if(inputty)
		if(hasomen(OMEN_NOLORD))
			make_law(inputty)
		else
			var/lord = find_lord()
			if(lord)
				INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(lord_law_requested), src, lord, inputty)
			else
				make_law(inputty)

/mob/living/carbon/human/proc/request_law_removal()
	set name = "Request Law Removal"
	set category = "Martial Law"
	if(stat)
		return
	var/inputty = input("Remove a law", "MARTIAL LAW") as text|null
	var/law_index = text2num(inputty) || 0
	if(law_index && GLOB.laws_of_the_land[law_index])
		if(hasomen(OMEN_NOLORD))
			remove_law(law_index)
		else
			var/lord = find_lord()
			if(lord)
				INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(lord_law_removal_requested), src, lord, law_index)
			else
				remove_law(law_index)

/mob/living/carbon/human/proc/request_purge()
	set name = "Request Purge"
	set category = "Martial Law"
	if(stat)
		return
	if(hasomen(OMEN_NOLORD))
		purge_laws()
	else
		var/lord = find_lord()
		if(lord)
			INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(lord_purge_requested), src, lord)
		else
			purge_laws()

/mob/living/carbon/human/proc/request_outlaw()
	set name = "Request Outlaw"
	set category = "Martial Law"
	if(stat)
		return
	var/inputty = input("Outlaw a person", "MARTIAL LAW") as text|null
	if(inputty)
		if(hasomen(OMEN_NOLORD))
			make_outlaw(inputty)
		else
			var/lord = find_lord()
			if(lord)
				INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(lord_outlaw_requested), src, lord, inputty)
			else
				make_outlaw(inputty)
				
/proc/find_lord(required_stat = CONSCIOUS)
	var/mob/living/lord
	for(var/mob/living/carbon/human/H in GLOB.human_list)
		if(!H.mind || H.job != "Duke" || (H.stat > required_stat))
			continue
		lord = H
		break
	return lord

/proc/lord_law_requested(mob/living/marshal, mob/living/carbon/human/lord, requested_law)
	var/choice = alert(lord, "The Royal Marshal requests a new law!\n[requested_law]", "MARTIAL LAW REQUEST", "Yes", "No")
	if(choice != "Yes" || QDELETED(lord) || lord.stat > CONSCIOUS)
		if(marshal)
			to_chat(marshal, span_warning("The Duke has denied the request for a new law!"))
		return
	make_law(requested_law)

/proc/lord_law_removal_requested(mob/living/marshal, mob/living/carbon/human/lord, requested_law)
	if(!requested_law || !GLOB.laws_of_the_land[requested_law])
		return
	var/choice = alert(lord, "The Royal Marshal requests the removal of a law!\n[GLOB.laws_of_the_land[requested_law]]", "MARTIAL LAW REQUEST", "Yes", "No")
	if(choice != "Yes" || QDELETED(lord) || lord.stat > CONSCIOUS)
		if(marshal)
			to_chat(marshal, span_warning("The Duke has denied the request for a law removal!"))
		return
	remove_law(requested_law)

/proc/lord_purge_requested(mob/living/marshal, mob/living/carbon/human/lord)
	var/choice = alert(lord, "The Royal Marshal requests a purge of all laws!", "MARSHAL PURGE REQUEST", "Yes", "No")
	if(choice != "Yes" || QDELETED(lord) || lord.stat > CONSCIOUS)
		if(marshal)
			to_chat(marshal, span_warning("The Duke has denied the request for a purge of all laws!"))
		return
	purge_laws()

/proc/lord_outlaw_requested(mob/living/marshal, mob/living/carbon/human/lord, requested_outlaw)
	var/choice = alert(lord, "The Royal Marshal requests to outlaw someone!\n[requested_outlaw]", "MARSHAL OUTLAW REQUEST", "Yes", "No")
	if(choice != "Yes" || QDELETED(lord) || lord.stat > CONSCIOUS)
		if(marshal)
			to_chat(marshal, span_warning("The Duke has denied the request for declaring an outlaw!"))
		return
	make_outlaw(requested_outlaw)
