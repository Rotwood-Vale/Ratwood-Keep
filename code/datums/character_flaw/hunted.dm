//Just the special, massively higher for a bounty
/datum/charflaw/dead_or_alive
	name = "Hunted"
	desc = "I'm currently fleeing for my life. Hunted to the ends of the realm for a bounty."

/datum/charflaw/dead_or_alive/apply_post_equipment(mob/living/carbon/human/character)
	var/reason = ""
	var/employer = "unknown employer"
	var/employer_gender
	if(prob(50))
		employer_gender = MALE
	else
		employer_gender = FEMALE
	if(employer_gender == MALE)
		employer = pick(list("King", "Prince", "Viscount", "Baron"))
	else
		employer = pick(list("Queen", "Princess", "Viscountess", "Baroness"))
	employer = "[employer] [random_human_name(employer_gender, FALSE, FALSE)]"
	var/amount = rand(250,850)
	switch(rand(1,3))
		if(1)
			reason = "Espionage"
		if(2)
			reason = "Sedition"
		if(3)
			reason = "Grand Heresy"//Can't think of a name for a Zizoid that isn't too on the nose.
	add_bounty(character.real_name, amount, FALSE, reason, employer)
	to_chat(character, span_notice("The realm knows my name, or at least those that can read Imperial. \
	I have been accused of [reason], and [employer] has put a bounty on my head!"))
