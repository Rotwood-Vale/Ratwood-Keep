/datum/round_aspect/rot_abates
	name = "The Rot Abates"
	description = "Player characters cannot become deadites."
	start_or_apply_text = "It's been some time since anybody became a deadite... Has the Godhead been weakened? Is it finally over?"
	weight = 30

/datum/round_aspect/rot_abates/on_mob_spawn(mob/living/carbon/human/H)
	ADD_TRAIT(H, TRAIT_ZOMBIE_IMMUNE, name)
