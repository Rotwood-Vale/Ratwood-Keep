// TODO: Replace this with a skillset datum or something
/datum/mind
	var/datum/sleep_adv/sleep_adv = null
	///Assoc list of skills - level
	var/list/known_skills = list()
	///Assoc list of skills - exp
	var/list/skill_experience = list()

// Mob helpers for the mind-level skill procs, to prep for moving skillsets off minds
/mob/proc/get_skill_level(skill, default_mindless_value = SKILL_LEVEL_NONE)
	return mind? mind.get_skill_level(skill) : default_mindless_value

/mob/proc/add_sleep_experience(skill, amt, silent = FALSE)
	return mind?.add_sleep_experience(skill, amt, silent = silent)

/mob/proc/adjust_experience(skill, amt, silent = FALSE)
	return mind?.adjust_experience(skill, amt, silent = silent)

/mob/proc/adjust_skillrank_up_to(skill, amt, silent = FALSE)
	return mind?.adjust_skillrank_up_to(skill, amt, silent = silent)

/mob/proc/adjust_skillrank_down_to(skill, amt, silent = FALSE)
	return mind?.adjust_skillrank_down_to(skill, amt, silent = silent)

/mob/proc/adjust_skillrank(skill, amt, silent = FALSE)
	return mind?.adjust_skillrank(skill, amt, silent = silent)

// The actual mind-level procs
/datum/mind/proc/get_skill_level(skill)
	if(has_antag_datum(/datum/antagonist/zombie) && !current.client) // Non-player deadites don't have skills.
		return SKILL_LEVEL_NONE
	var/datum/skill/S = GetSkillRef(skill)
	return known_skills[S] || SKILL_LEVEL_NONE

/datum/mind/proc/print_levels(user)
	var/list/shown_skills = list()
	for(var/i in known_skills)
		if(known_skills[i]) //Do we actually have a level in this?
			shown_skills += i
	if(!length(shown_skills))
		to_chat(user, span_warning("I don't have any skills."))
		return
	var/msg = ""
	msg += span_info("*---------*\n")
	for(var/datum/i in shown_skills)
		var/can_advance_post = sleep_adv.enough_sleep_xp_to_advance(i.type, 1)
		var/capped_post = sleep_adv.enough_sleep_xp_to_advance(i.type, 2)
		var/rankup_postfix = capped_post ? span_nicegreen(" <b>(!!)</b>") : can_advance_post ? span_nicegreen(" <b>(!)</b>") : ""
		msg += "[i] - [SSskills.level_names[known_skills[i]]][rankup_postfix]\n"
	msg += "</span>"
	to_chat(user, msg)

/datum/mind/proc/add_sleep_experience(skill, amt, silent = FALSE)
	sleep_adv?.add_sleep_experience(skill, amt, silent)

///Adjust experience of a specific skill
/datum/mind/proc/adjust_experience(skill, amt, silent = FALSE)
	var/datum/skill/S = GetSkillRef(skill)
	skill_experience[S] = max(0, skill_experience[S] + amt) //Prevent going below 0
	var/old_level = known_skills[S]
	switch(skill_experience[S])
		if(SKILL_EXP_LEGENDARY to INFINITY)
			known_skills[S] = SKILL_LEVEL_LEGENDARY

		if(SKILL_EXP_MASTER to SKILL_EXP_LEGENDARY)
			known_skills[S] = SKILL_LEVEL_MASTER

		if(SKILL_EXP_EXPERT to SKILL_EXP_MASTER)
			known_skills[S] = SKILL_LEVEL_EXPERT

		if(SKILL_EXP_JOURNEYMAN to SKILL_EXP_EXPERT)
			known_skills[S] = SKILL_LEVEL_JOURNEYMAN

		if(SKILL_EXP_APPRENTICE to SKILL_EXP_JOURNEYMAN)
			known_skills[S] = SKILL_LEVEL_APPRENTICE

		if(SKILL_EXP_NOVICE to SKILL_EXP_APPRENTICE)
			known_skills[S] = SKILL_LEVEL_NOVICE

		if(0 to SKILL_EXP_NOVICE)
			known_skills[S] = SKILL_LEVEL_NONE

	if(isnull(old_level) || known_skills[S] == old_level)
		return //same level or we just started earning xp towards the first level.
	if(skill == /datum/skill/magic/arcane)
		var/const/SPELLPOINTS_PER_LEVEL = 1
		adjust_spellpoints((known_skills[S] - old_level) * SPELLPOINTS_PER_LEVEL)
	if(silent)
		return
	// ratio = round(skill_experience[S]/limit,1) * 100
	// to_chat(current, "<span class='nicegreen'> My [S.name] is around [ratio]% of the way there.")
	//TODO add some bar hud or something, i think i seen a request like that somewhere
	if(known_skills[S] > old_level)
		to_chat(current, span_nicegreen("My [S.name] grows to [SSskills.level_names[known_skills[S]]]!"))
	else
		to_chat(current, span_warning("My [S.name] has weakened to [SSskills.level_names[known_skills[S]]]!"))

/datum/mind/proc/adjust_skillrank_up_to(skill, amt, silent = FALSE)
	var/proper_amt = amt - get_skill_level(skill)
	if(proper_amt <= 0)
		return
	adjust_skillrank(skill, proper_amt, silent)

/datum/mind/proc/adjust_skillrank_down_to(skill, amt, silent = FALSE)
	var/proper_amt = get_skill_level(skill) - amt
	if(proper_amt < 0)
		return
	adjust_skillrank(skill, -proper_amt, silent)

/datum/mind/proc/adjust_skillrank(skill, amt, silent = FALSE)
	var/datum/skill/S = GetSkillRef(skill)
	var/amt2gain = 0
	if(skill == /datum/skill/magic/arcane)
		adjust_spellpoints(amt)
	if(amt == 0)
		skill_experience[S] = 0
	if(amt > 0) //positive at
		for(var/i in 1 to amt)
			switch(skill_experience[S])
				if(SKILL_EXP_MASTER to SKILL_EXP_LEGENDARY)
					amt2gain = SKILL_EXP_LEGENDARY-skill_experience[S]
				if(SKILL_EXP_EXPERT to SKILL_EXP_MASTER)
					amt2gain = SKILL_EXP_MASTER-skill_experience[S]
				if(SKILL_EXP_JOURNEYMAN to SKILL_EXP_EXPERT)
					amt2gain = SKILL_EXP_EXPERT-skill_experience[S]
				if(SKILL_EXP_APPRENTICE to SKILL_EXP_JOURNEYMAN)
					amt2gain = SKILL_EXP_JOURNEYMAN-skill_experience[S]
				if(SKILL_EXP_NOVICE to SKILL_EXP_APPRENTICE)
					amt2gain = SKILL_EXP_APPRENTICE-skill_experience[S]
				if(0 to SKILL_EXP_NOVICE)
					amt2gain = SKILL_EXP_NOVICE-skill_experience[S] + 1
			if(!skill_experience[S])
				amt2gain = SKILL_EXP_NOVICE+1
			skill_experience[S] = max(0, skill_experience[S] + amt2gain) //Prevent going below 0
	else //negative amt
		for(var/i in amt to -1 step 1)
			switch(skill_experience[S])
				if(0 to SKILL_EXP_NOVICE)
					amt2gain = skill_experience[S]
				if(SKILL_EXP_NOVICE to SKILL_EXP_APPRENTICE)
					amt2gain = skill_experience[S]-SKILL_EXP_NOVICE
				if(SKILL_EXP_APPRENTICE to SKILL_EXP_JOURNEYMAN)
					amt2gain = skill_experience[S]-SKILL_EXP_APPRENTICE
				if(SKILL_EXP_JOURNEYMAN to SKILL_EXP_EXPERT)
					amt2gain = skill_experience[S]-SKILL_EXP_JOURNEYMAN
				if(SKILL_EXP_EXPERT to SKILL_EXP_MASTER)
					amt2gain = skill_experience[S]-SKILL_EXP_EXPERT
				if(SKILL_EXP_MASTER to SKILL_EXP_LEGENDARY)
					amt2gain = skill_experience[S]-SKILL_EXP_MASTER
			skill_experience[S] = max(0, skill_experience[S] - amt2gain) //Prevent going below 0
	var/old_level = get_skill_level(skill)
	switch(skill_experience[S])
		if(SKILL_EXP_LEGENDARY to INFINITY)
			known_skills[S] = SKILL_LEVEL_LEGENDARY
		if(SKILL_EXP_MASTER to SKILL_EXP_LEGENDARY)
			known_skills[S] = SKILL_LEVEL_MASTER
		if(SKILL_EXP_EXPERT to SKILL_EXP_MASTER)
			known_skills[S] = SKILL_LEVEL_EXPERT
		if(SKILL_EXP_JOURNEYMAN to SKILL_EXP_EXPERT)
			known_skills[S] = SKILL_LEVEL_JOURNEYMAN
		if(SKILL_EXP_APPRENTICE to SKILL_EXP_JOURNEYMAN)
			known_skills[S] = SKILL_LEVEL_APPRENTICE
		if(SKILL_EXP_NOVICE to SKILL_EXP_APPRENTICE)
			known_skills[S] = SKILL_LEVEL_NOVICE
		if(0 to SKILL_EXP_NOVICE)
			known_skills[S] = SKILL_LEVEL_NONE
	if(known_skills[S] == old_level)
		return //same level or we just started earning xp towards the first level.
	if(silent)
		return
	if(known_skills[S] >= old_level)
		to_chat(current, span_nicegreen("I feel like I've become more proficient at [S.name]!"))
	else
		to_chat(current, span_warning("I feel like I've become worse at [S.name]!"))
