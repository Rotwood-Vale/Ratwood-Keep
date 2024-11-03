/datum/patron/lost
	name = "The Gods"
	domain = "The Ones Provided"
	desc = "Although gods obviously exist in this world, none have specifically earned your unconditional devotion. You are more grounded in a broad spectrum. This is not to say you don't believe in them or even dislike them. You have just yet to be convinced by one. You even speak with whichever one will listen."
	worshippers = "the neutral, the inquisitive, the indecisive"
	associated_faith = /datum/faith/lost
	preference_accessible = TRUE
	mob_traits = list(TRAIT_NOMOOD)
	undead_hater = FALSE
	t1 = /obj/effect/proc_holder/spell/targeted/blesscrop /////////////////// this is ment to simulate as a cleric/acolyte asking each for their favor. only thing I could think of a lil from all with praying for anyone to revive someone as the last.
	t2 = /obj/effect/proc_holder/spell/invoked/heatmetal
	t3 = /obj/effect/proc_holder/spell/targeted/churn
	t4 = /obj/effect/proc_holder/spell/invoked/revive
	confess_lines = list(
		"THE GOD THAT STOPS YOU!",
		"I DON'T KNOW!",
		"NO GOD WOULD ALLOW THIS!",
		"ANY OF THEM! JUST STOP!",
	)
