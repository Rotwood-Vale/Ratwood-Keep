/datum/patron/divine/noc
	name = "Noc"
	domain = "God of the Moon, Night, and Knowledge"
	desc = "The Firstborn of Psydon, twin of Astrata, gifted man divine knowledge."
	worshippers = "Wizards and Scholars"
	mob_traits = list(TRAIT_NOCTURNAL) //lighting alpha 245. DV spell is 220, DV spell w/noc or DV special is 200
	t1 = /obj/effect/proc_holder/spell/invoked/blindness
	t2 = /obj/effect/proc_holder/spell/invoked/invisibility
	confess_lines = list(
		"NOC IS NIGHT!",
		"NOC SEES ALL!",
		"I SEEK THE MYSTERIES OF THE MOON!",
	)

