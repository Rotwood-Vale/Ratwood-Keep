/datum/reagent/miasmagas
	name = "miasmagas"
	description = "."
	color = "#801E28" // rgb: 128, 30, 40
	taste_description = "ugly"
	metabolization_rate = 1

/datum/reagent/miasmagas/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M, TRAIT_NOSTINK))
		if(M.has_flaw(/datum/charflaw/addiction/maniac))
			M.add_stress(/datum/stressevent/miasmagasmaniac)
		else
			M.add_nausea(15)
			M.add_stress(/datum/stressevent/miasmagas)
	return ..()
