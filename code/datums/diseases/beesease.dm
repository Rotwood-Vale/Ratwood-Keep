/datum/disease/beesease
	name = "Beesease"
	form = "Infection"
	max_stages = 4
	spread_text = "On contact"
	spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_SKIN | DISEASE_SPREAD_CONTACT_FLUIDS
	cure_text = "Sugar"
	cures = list(/datum/reagent/consumable/sugar)
	agent = "Apidae Infection"
	viable_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	desc = ""
	severity = DISEASE_SEVERITY_MEDIUM
	infectable_biotypes = MOB_ORGANIC|MOB_UNDEAD //bees nesting in corpses

/datum/disease/beesease/stage_act()
	..()
	switch(stage)
		if(2) //also changes say, see say.dm
			if(prob(2))
				to_chat(affected_mob, span_notice("I taste honey in my mouth."))
		if(3)
			if(prob(10))
				to_chat(affected_mob, span_notice("My stomach rumbles."))
			if(prob(2))
				to_chat(affected_mob, span_danger("My stomach stings painfully."))
				if(prob(20))
					affected_mob.adjustToxLoss(2)
					affected_mob.updatehealth()
		if(4)
			if(prob(10))
				affected_mob.visible_message(span_danger("[affected_mob] buzzes."), \
												span_danger("My stomach buzzes violently!"))
			if(prob(5))
				to_chat(affected_mob, span_danger("I feel something moving in my throat."))
	return
