/datum/job/roguetown/hand
	title = "Hand"
	flag = HAND
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_SHUNNED_UP_PLUS_SEELIE
	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/job/roguetown/hand
	display_order = JDO_HAND
	tutorial = "You owe everything to your liege. Once, you were just a humble friend- now you are one of the most important men within the realm itself. You have played spymaster and confidant to the Noble-Family for so long that you are a vault of intrigue, something you exploit with potent conviction. Let no man ever forget whose ear you whisper into. You've killed more men with those lips than any blademaster could ever claim to."
	seelie_tutorial = "It wasn't easy for a fae, but your liege saw great potential in you. Once, you were just an adventuring companion; now, you are one of the highest-status fae within the entire realm. It's come at a cost, you've lost your more mischievous spells and nature over time, but gained ones more useful to dealing with the chaos of court."
	whitelist_req = TRUE
	give_bank_account = 44
	min_pq = 3
	max_pq = null

/datum/job/roguetown/hand/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		var/index = findtext(H.real_name, " ")
		if(index)
			index = copytext(H.real_name, 1,index)
		if(!index)
			index = H.real_name
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/honorary = "Lord"
		if(H.gender == FEMALE)
			honorary = "Lady"
		H.real_name = "[honorary] [prev_real_name]"
		H.name = "[honorary] [prev_name]"

/*
/datum/job/roguetown/hand/special_job_check(mob/dead/new_player/player)
	if(!player)
		return
	if(!player.ckey)
		return
	for(var/mob/dead/new_player/duke in GLOB.player_list)
		if(duke.mind.assigned_role == "Duke")
			if(duke.brohand == player.ckey)
				return TRUE
*/

/datum/outfit/job/roguetown/hand/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/under/roguetown/tights/black
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shoes = /obj/item/clothing/shoes/roguetown/armor/nobleboot
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/storage/belt/rogue/pouch/coins/rich
	beltr = /obj/item/storage/keyring/hand
	gloves = /obj/item/clothing/gloves/roguetown/leather/black
	backl = /obj/item/clothing/suit/roguetown/armor/leather/hand
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/lockpick = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
		if(!isseelie(H)) //No stat changes for Seelie hands
			H.change_stat("strength", 2)
			H.change_stat("perception", 3)
			H.change_stat("intelligence", 3)
		else 
			H.mind.AddSpell(new SPELL_PUSH_SPELL) //Repulse, good for getting people away from the King
			H.mind.AddSpell(new SPELL_ROUSTAME) //Rous taming still makes sense for a Hand, a 'master of words' vibe. Summoning rats however does not - its undignified
			H.mind.AddSpell(new SPELL_SLOWDOWN_SPELL_AOE) //Immobilizes for 3 seconds in a 3x3, seems fitting for a Hand to be able to calm the court room when theres chaos
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	if(!isseelie(H)) //Only give heavy armor trait for non-seelie hands
		ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
		if(isdarkelf(H))
			backpack_contents.Add(/obj/item/clothing/mask/rogue/spectacles/delf)
	else //Since seelie hands no longer get heavy armor, giving them dodge expert instead
		ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
