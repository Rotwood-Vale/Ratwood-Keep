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
	tutorial = "Вы всем обязаны своему монарху. Когда-то вы были просто скромным другом, а теперь стали одним из самых важных людей в герцогстве. \
	Вы так долго были шпионом и доверенным лицом благородного семейства, что стали хранилищем интриг, которыми вы пользуетесь с особой убежденностью. \
	Пусть никто никогда не забудет, в чье ухо вы шепчете. Этими губами вы убили больше людей, чем мог бы притязать на это любой искусный мечник»."

	whitelist_req = TRUE
	give_bank_account = 44
	min_pq = 3
	max_pq = null

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
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/lockpick = 1)
	backl = /obj/item/clothing/suit/roguetown/armor/leather/hand
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
		if(!isseelie(H))	//No stat changes for Seelie hands
			H.change_stat("strength", 2)
			H.change_stat("perception", 3)
			H.change_stat("intelligence", 3)
		else if(isseelie(H)) //Could just be an else, but prefer the extra layer
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/push_spell)			//Repulse, good for getting people away from the King
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/roustame)			//Rous taming still makes sense for a Hand, a 'master of words' vibe. Summoning rats however does not - its undignified
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/slowdown_spell_aoe)	//Immobilizes for 3 seconds in a 3x3, seems fitting for a Hand to be able to calm the court room when theres chaos
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	if(!isseelie(H))	//Only give heavy armor trait for non-seelie hands
		ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	else if(isseelie(H))	//Since seelie hands no longer get heavy armor, giving them dodge expert instead
		ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
