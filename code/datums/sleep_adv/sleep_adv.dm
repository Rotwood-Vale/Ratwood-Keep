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
	process_sleep()//This could get hooked somewhere else

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

/datum/sleep_adv/proc/enough_sleep_xp_to_advance(skill_type)
	var/skill_level = mind.get_skill_level(skill_type)
	if(skill_level == SKILL_LEVEL_LEGENDARY)
		return FALSE
	var/next_skill_level = skill_level
	var/needed_xp = needed_xp_for_level(next_skill_level)
	if(get_sleep_xp(skill_type) < needed_xp)
		return FALSE
	return TRUE

/datum/sleep_adv/proc/add_sleep_experience(skill, amt, silent = FALSE)
	var/can_advance_pre = enough_sleep_xp_to_advance(skill)
	adjust_sleep_xp(skill, amt)
	var/can_advance_post = enough_sleep_xp_to_advance(skill)
	if(!can_advance_pre && can_advance_post && !silent)
		to_chat(mind.current, span_notice("I feel like I can advance [skill] if I get a good nights sleep."))

/datum/sleep_adv/proc/advance_cycle()
	// Stuff
	if(!mind.current)
		return
	if(prob(100))
		rolled_specials++
	sleep_adv_points += 3
	sleep_adv_cycle++
	show_ui(mind.current)

/datum/sleep_adv/proc/show_ui(mob/living/user)
	var/list/dat = list()
	dat += "<center>\Roman[sleep_adv_points]</center>"
	for(var/skill_type in SSskills.all_skills)
		var/datum/skill/skill = GetSkillRef(skill_type)
		if(!enough_sleep_xp_to_advance(skill_type))
			continue
		var/can_buy = (sleep_adv_points >= 3) 
		dat += "<br><a [can_buy ? "" : "class='linkOff'"] href='?src=[REF(src)];task=buy_skill;skill_type=[skill_type]'>[skill.name]</a>"
	dat += "<br>"
	if(rolled_specials > 0)
		var/can_buy = (sleep_adv_points >= 3)
		dat += "<br><a [can_buy ? "" : "class='linkOff'"] href='?src=[REF(src)];task=buy_special'>Dream something <b>special</b></a>"
		dat += "<br>Specials can have negative or positive effects"
	dat += "<br><br><a href='?src=[REF(src)];task=continue'>Continue</a>"
	var/datum/browser/popup = new(user, "dreams", "Dreams", 300, 400)
	popup.set_window_options("can_close=0")
	popup.set_content(dat.Join())
	popup.open(FALSE)

/datum/sleep_adv/proc/close_ui()
	if(!mind.current)
		return
	mind.current << browse(null, "window=dreams")

/datum/sleep_adv/proc/process_sleep()
	if(!mind.current)
		return
	if(mind.current.IsSleeping())
		return
	close_ui()

/datum/sleep_adv/Topic(href, list/href_list)
	. = ..()
	if(!mind.current)
		close_ui()
		return
	if(!mind.current.IsSleeping())
		close_ui()
		return
	switch(href_list["task"])
		if("buy_skill")
			var/skill_type = text2path(href_list["skill_type"])
			if(!skill_type)
				return
			message_admins("buy skill [skill_type]")
			sleep_adv_points -= 3
		if("buy_special")
			message_admins("buy special")
			sleep_adv_points -= 3
		if("continue")
			close_ui()
			return
	show_ui(mind.current)
