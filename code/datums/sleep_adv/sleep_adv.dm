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
	var/needed_xp = get_requried_sleep_xp_for_skill(skill_type)
	if(get_sleep_xp(skill_type) < needed_xp)
		return FALSE
	return TRUE

/datum/sleep_adv/proc/get_requried_sleep_xp_for_skill(skill_type)
	var/skill_level = mind.get_skill_level(skill_type)
	var/next_skill_level = skill_level + 1
	var/needed_xp = needed_xp_for_level(next_skill_level)
	return needed_xp

/datum/sleep_adv/proc/add_sleep_experience(skill, amt, silent = FALSE)
	var/can_advance_pre = enough_sleep_xp_to_advance(skill)
	adjust_sleep_xp(skill, amt)
	var/can_advance_post = enough_sleep_xp_to_advance(skill)
	if(!can_advance_pre && can_advance_post && !silent)
		var/datum/skill/skillref = GetSkillRef(skill)

		to_chat(mind.current, span_notice(pick(list(
			"I'm getting a better grasp at [lowertext(skillref.name)]...",
			"With some rest, I feel like I can get better at [lowertext(skillref.name)]...",
			"[skillref.name] starts making more sense to me...",
		))))

/datum/sleep_adv/proc/advance_cycle()
	// Stuff
	if(!mind.current)
		return
	if(prob(100))
		rolled_specials++
	to_chat(mind.current, span_notice("My consciousness slips and I start dreaming..."))
	to_chat(mind.current, span_notice("With no stresses throughout the day I dream vividly..."))
	sleep_adv_points += 30
	sleep_adv_cycle++
	show_ui(mind.current)

/datum/sleep_adv/proc/show_ui(mob/living/user)
	var/list/dat = list()
	dat += "<center>\Roman[sleep_adv_points]</center>"
	dat += "<br><center>Dream, for those who dream may reach higher heights</center><br>"
	var/can_buy_anything = FALSE
	for(var/skill_type in SSskills.all_skills)
		var/datum/skill/skill = GetSkillRef(skill_type)
		if(!enough_sleep_xp_to_advance(skill_type))
			continue
		var/can_buy = can_buy_skill(skill_type)
		if(can_buy)
			can_buy_anything = TRUE
		var/next_level = mind.get_skill_level(skill_type) + 1
		var/level_name = SSskills.level_names[next_level]
		dat += "<br><a [can_buy ? "" : "class='linkOff'"] href='?src=[REF(src)];task=buy_skill;skill_type=[skill_type]'>[skill.name] [level_name]</a> - \Roman[get_skill_cost(skill_type)]"
	dat += "<br>"
	if(rolled_specials > 0)
		var/can_buy = can_buy_special()
		if(can_buy)
			can_buy_anything = TRUE
		dat += "<br><a [can_buy ? "" : "class='linkOff'"] href='?src=[REF(src)];task=buy_special'>Dream something <b>special</b></a> - \Roman[get_special_cost()]"
		dat += "<br>Specials can have negative or positive effects"
	dat += "<br><br><center><a href='?src=[REF(src)];task=continue'>Continue</a></center>"
	if(!can_buy_anything)
		finish()
		return
	var/datum/browser/popup = new(user, "dreams", "<center>Dreams</center>", 300, 400)
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

/datum/sleep_adv/proc/can_buy_skill(skill_type)
	return (sleep_adv_points >= get_skill_cost(skill_type))

/datum/sleep_adv/proc/can_buy_special()
	return (sleep_adv_points >= get_special_cost())

/datum/sleep_adv/proc/get_skill_cost(skill_type)
	return 2

/datum/sleep_adv/proc/get_special_cost()
	return 3

/datum/sleep_adv/proc/buy_skill(skill_type)
	if(!can_buy_skill(skill_type))
		return
	if(!enough_sleep_xp_to_advance(skill_type))
		return
	mind.adjust_skillrank(skill_type, 1, FALSE)
	sleep_adv_points -= get_skill_cost(skill_type)
	adjust_sleep_xp(skill_type, -get_requried_sleep_xp_for_skill(skill_type))

/datum/sleep_adv/proc/buy_special()
	if(!can_buy_special())
		return
	// Apply special here
	sleep_adv_points -= get_special_cost()

/datum/sleep_adv/proc/test()
	add_sleep_experience(/datum/skill/misc/alchemy, 2000)
	advance_cycle()

/datum/sleep_adv/proc/finish()
	if(!mind.current)
		return
	to_chat(mind.current, span_notice("..and that's all I dreamt of"))
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
			buy_skill(skill_type)
		if("buy_special")
			buy_special()
		if("continue")
			finish()
			return
	show_ui(mind.current)
