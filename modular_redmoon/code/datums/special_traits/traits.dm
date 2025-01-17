/datum/special_trait/tiny
	name = "Tiny"
	greet_text = span_notice("I've always been called a tiny. I am valued for my stature, but, this world made for smaller folk has forced me to move cautiously.")
	req_text = "Not a kobold, seelie, verminvolk or a dwarf"
	restricted_races = list(/datum/species/anthromorphsmall, /datum/species/dwarf/mountain, /datum/species/kobold, /datum/species/seelie)
	weight = 50

/datum/special_trait/backproblems/on_apply(mob/living/carbon/human/character)
	character.mob_size -= 1
	character.change_stat("strength", -2)
	character.change_stat("constitution", -2)
	character.change_stat("speed", 4)
	character.transform = character.transform.Scale(0.75, 0.75)
	character.transform = character.transform.Translate(0, (-0.25 * 16))
	character.update_transform()
