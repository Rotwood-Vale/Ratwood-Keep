/datum/round_aspect/womans_world
	name = "Woman's World"
	description = "Slightly enhances the physical attributes of women, and slightly reduces them for men."
	start_or_apply_text = "Their physical might has left women the dominant gender in our world - other than those curious dark elves."
	weight = 10
	var/const/female_strength_mod = 1
	var/const/female_constitution_mod = 1
	var/const/male_strength_mod = -1
	var/const/male_constitution_mod = -1

/datum/round_aspect/womans_world/on_mob_spawn(mob/living/carbon/human/H, latejoin = FALSE)
	if (isdarkelf(H))
		if (H.getorganslot(ORGAN_SLOT_VAGINA))
			H.change_stat("strength", male_strength_mod, "[name] ["strength"]")
			H.change_stat("constitution", male_constitution_mod, "[name] ["constitution"]")
		if (H.getorganslot(ORGAN_SLOT_PENIS))
			H.change_stat("strength", female_strength_mod, "[name] ["strength"]")
			H.change_stat("constitution", female_constitution_mod, "[name] ["constitution"]")
	else
		if (H.getorganslot(ORGAN_SLOT_VAGINA))
			H.change_stat("strength", female_strength_mod, "[name] ["strength"]")
			H.change_stat("constitution", female_constitution_mod, "[name] ["constitution"]")
		if (H.getorganslot(ORGAN_SLOT_PENIS))
			H.change_stat("strength", male_strength_mod, "[name] ["strength"]")
			H.change_stat("constitution", male_constitution_mod, "[name] ["constitution"]")
