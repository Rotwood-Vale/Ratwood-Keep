/datum/curse/baotha
	name = "Baotha's Curse"
	description = "I'm in a constant state of arousal, and I cannot control my urges."
	trait = TRAIT_BAOTHA_CURSE

//////////////////////
/// ON GAIN / LOSS ///
//////////////////////
/datum/curse/baotha/on_life(mob/living/carbon/human/owner)
	. = ..()
	if(owner.mob_timers["baotha_curse_passive"])
		if(world.time < owner.mob_timers["baotha_curse"] + rand(2,10)SECONDS)
			return
	owner.mob_timers["baotha_curse_passive"] = world.time
	owner.sexcon.arousal += 1

	if(owner.mob_timers["baotha_curse"])
		if(world.time < owner.mob_timers["baotha_curse"] + rand(15,90)SECONDS)
			return
	owner.mob_timers["baotha_curse"] = world.time

	owner.sexcon.arousal += rand(-20,50)
	owner.sexcon.charge += rand(20, 50)

	var/effect = rand(1, 3)
	if(owner.gender == "female")
		switch(effect)
			if(1)
				owner.emote("sexmoanhvy")
			if(2)
				owner.emote("sexmoanlight")
			if(3)
				owner.emote("sexmoanlight")
	//else //we dont have male moans yet

