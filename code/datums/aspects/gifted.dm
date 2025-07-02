/datum/round_aspect/gifted
	name = "Legendary Duchy"
	description = "Every character has at least one Legendary skill - whatever their highest non-legendary skill would have been."
	start_or_apply_text = "The Duchy is legendary across the kingdom, perhaps even the world, for its assortment of talented people."
	weight = 50

/datum/round_aspect/gifted/on_job_finalised(mob/living/carbon/human/H)
	if (H.mind == null)
		return

	// Make a list of the highest-ranked non-legendary skills on the target mob,
	// then choose one at random and make it legendary.
	// In future we might choose to make this a list.
	var/highest_non_legendary_level = 0
	var/list/datum/skill/highest_non_legendary_skill_paths = list()
	for (var/skill in H.mind.known_skills)
		var/level = H.mind.known_skills[skill]
		if (level > highest_non_legendary_level && level < SKILL_LEVEL_LEGENDARY)
			highest_non_legendary_level = level

	// Second pass - copy any skills at the given level into the candidate list.
	for (var/datum/skill/skill in H.mind.known_skills)
		var/level = H.mind.known_skills[skill]
		if (level == highest_non_legendary_level)
			highest_non_legendary_skill_paths += skill
	
	if (highest_non_legendary_level < SKILL_LEVEL_LEGENDARY)
		var/datum/skill/skill_to_raise = pick(highest_non_legendary_skill_paths)
		if (skill_to_raise)
			H.mind.adjust_skillrank_up_to(skill_to_raise.type, SKILL_LEVEL_LEGENDARY, TRUE)
