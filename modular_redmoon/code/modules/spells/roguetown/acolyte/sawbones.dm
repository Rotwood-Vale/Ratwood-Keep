/datum/reagent/medicine/purify/on_mob_life(mob/living/carbon/human/M)
	. = ..()
	if(M.mind.has_antag_datum(/datum/antagonist/werewolf))
		M.mind.remove_antag_datum(/datum/antagonist/werewolf)
