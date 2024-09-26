/datum/skill
	abstract_type = /datum/skill
	var/name = "Skill"
	var/desc = ""

	var/dream_cost_base = 2
	var/dream_cost_per_level = 0.5
	var/dream_legendary_extra_cost = 1
	var/list/specific_dream_costs
	var/list/dreams
	var/randomable_dream_xp = TRUE

/datum/skill/proc/get_skill_speed_modifier(level)
	return

/datum/skill/proc/get_dream_cost_for_level(level)
	if(length(specific_dream_costs) >= level)
		return specific_dream_costs[level]
	var/cost = FLOOR(dream_cost_base + (dream_cost_per_level * (level - 1)), 1)
	if(level == SKILL_LEVEL_LEGENDARY)
		cost += dream_legendary_extra_cost
	return cost

/datum/skill/proc/get_random_dream()
	if(!dreams)
		return null
	return pick(dreams)
