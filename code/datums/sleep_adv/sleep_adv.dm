/datum/sleep_adv
	var/sleep_adv_cycle = 0
	var/sleep_adv_points = 0
	var/list/skill_floors = list()
	var/mood_amount = 0
	var/mood_cycles = 0
	var/rolled_specials = 0
	var/list/sleep_exp = list()
	var/datum/mind/mind = null

/datum/sleep_adv/New(datum/mind/passed_mind)
	. = ..()
	mind = passed_mind

/datum/sleep_adv/Destroy(force)
	mind = null
	. = ..()

/datum/sleep_adv/proc/add_mood_cycle(moodlet_amount)
	mood_amount += moodlet_amount
	message_admins("adds [moodlet_amount] to mood amount")
	mood_cycles++

/datum/sleep_adv/proc/get_sleep_xp(skill)
	if(!sleep_exp[skill])
		sleep_exp[skill] = 0
	return sleep_exp[skill]

/datum/sleep_adv/proc/adjust_sleep_xp(skill, adjust)
	var/current_xp = get_sleep_xp()
	sleep_exp[skill] = current_xp + adjust

/datum/sleep_adv/proc/needed_xp_for_level(skill_level)
	switch(skill_level)
		if(SKILL_LEVEL_NOVICE)
			return SLEEP_EXP_NOVICE
		if(SKILL_LEVEL_APPRENTICE)
			return SLEEP_EXP_APPRENTICE
		if(SKILL_LEVEL_JOURNEYMAN)
			return SLEEP_EXP_JOURNEYMAN
		if(SKILL_LEVEL_EXPERT)
			return SLEEP_EXP_EXPERT
		if(SKILL_LEVEL_MASTER)
			return SLEEP_EXP_MASTER
		if(SKILL_LEVEL_LEGENDARY)
			return SLEEP_EXP_LEGENDARY

/datum/sleep_adv/proc/enough_sleep_xp_to_advance(skill)
	var/skill_level = mind.get_skill_level(skill)
	if(skill_level == SKILL_LEVEL_LEGENDARY)
		return FALSE
	var/next_skill_level = skill_level
	var/needed_xp = needed_xp_for_level(next_skill_level)
	if(get_sleep_xp(skill) < needed_xp)
		return FALSE
	return TRUE

/datum/sleep_adv/proc/add_sleep_experience(skill, amt, silent = FALSE)
	var/can_advance_pre = enough_sleep_xp_to_advance(skill)
	adjust_sleep_xp(skill, amt)
	var/can_advance_post = enough_sleep_xp_to_advance(skill)
	if(!can_advance_pre && can_advance_post && !silent)
		to_chat(mind.current, span_notice("I feel like I can advance [skill] if i get a good sleep."))

/datum/sleep_adv/proc/advance_cycle(mob/living/user)
	// Stuff
	if(prob(100))
		rolled_specials++
	sleep_adv_cycle++
	show_ui(user)

/datum/sleep_adv/proc/show_ui(mob/living/user)
	return

/datum/sleep_adv/Topic(href, list/href_list)
	. = ..()
