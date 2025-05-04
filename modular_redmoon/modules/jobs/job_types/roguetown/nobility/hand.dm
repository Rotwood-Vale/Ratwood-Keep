/datum/job/roguetown/hand
	ru_title = "Десница"
	ru_tutorial = "Вы обязаны всем своему господину. В прошлом вы скромный друг семьи, а ныне – один из самых влиятельных людей в этом королевстве. \
		Вы много лет служили своему дворянскому дому, став мастером интриг и знаете как подбирать слова, чтобы добиться своего. \
		Пусть люд не забывает, кому вы нашёптываете советы, ибо этим вы убили больше людей, чем любой мастер фехтования мог бы себе представить."
	cmode_music = 'sound/music/cmode/nobility/combat_noble.ogg'

// sethand remake
/datum/job/roguetown/hand/special_check_latejoin(client/C)
	if(SSjob.name_occupations["Duke"].current_positions <= 0)
		return
	for(var/mob/living/carbon/human/duke in GLOB.player_list)
		if(duke.mind.assigned_role == "Duke")
			if(duke.client.prefs.hand_ckey)
				if(lowertext(duke.client.prefs.hand_ckey) == C.ckey)
					return TRUE
				else
					return

// sethand remake
/datum/job/roguetown/hand/special_job_check(mob/dead/new_player/player)
	if(!player)
		return
	if(!player.ckey)
		return
	for(var/mob/dead/new_player/duke in GLOB.player_list)
		if(duke.mind.assigned_role == "Duke")
			if(duke.client.prefs.hand_ckey)
				if(lowertext(duke.client.prefs.hand_ckey) == player.ckey)
					to_chat(player, span_biginfo("[duke.mind.current.gender == MALE ? "Герцог" : "Герцогиня"] хочет видеть своей десницей именно тебя. Не подведи [duke.mind.current.gender == MALE ? "его" : "её"]."))
					return TRUE
				else
					to_chat(player, span_warning("У герцога есть другой человек, которого он хотел бы видеть своей десницей."))
					return
