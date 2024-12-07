//Just the special, massively higher for a bounty
/datum/charflaw/dead_or_alive
	name = "Hunted"
	desc = "A bounty has been placed on my head, issued to the head takers of the realm. I should keep an eye over my shoulder."

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

//The fallback. Changed by the following if statements.
	var/amount = rand(45,100)
	switch(rand(1,3))
		if(1)
			reason = "Poaching"
		if(2)
			reason = "Fleecing"
		if(3)
			reason = "Debt"

	if(character.mind.assigned_role in GLOB.noble_positions)//Councillors, the Duke, etc.
		amount = rand(450, 850)
		switch(rand(1,2))
			if(1)
				reason = "Treasonous Intent"
			if(2)
				reason = "Abuse of Power"

		to_chat(character, span_notice("I've supposedly done horrid things with my power. \
		I have been accused of [reason], and [employer] has put a bounty on my head!"))

	if(character.mind.assigned_role in GLOB.courtier_positions)//Magos, Jester, etc.
		amount = rand(400,650)
		switch(rand(1,2))
			if(1)
				reason = "Espionage"
			if(2)
				reason = "Inhumen Sympathy"

		to_chat(character, span_notice("They claim I'm capable of disgusting actions. \
		I have been accused of [reason], and [employer] has put a bounty on my head!"))

	if(character.mind.assigned_role in GLOB.garrison_positions)//What do you think?
		amount = rand(125,450)//They can defend themselves.
		switch(rand(1,2))
			if(1)
				reason = "Sedition"
			if(2)
				reason = "Abandonment of Post"

		to_chat(character, span_notice("Even my brothers look down upon me. \
		I have been accused of [reason], and [employer] has put a bounty on my head!"))

	if(character.mind.assigned_role in GLOB.church_positions)//Ditto.
		amount = rand(250,500)//Killing a member of the Church is a BIG yikes.
		switch(rand(1,3))
			if(1)
				reason = "Communing with the Inhumen"
			if(2)
				reason = "Compelling the Congregation"
			if(3)
				reason = "Grand Heresy"//Can't think of a name for a Zizoid that isn't too on the nose.

		to_chat(character, span_notice("Astrata herself would be ashamed, with what I've supposedly done. \
		I have been accused of [reason], and [employer] has put a bounty on my head!"))

	if(character.mind.assigned_role in GLOB.yeoman_positions)//Merchant, Barkeep, etc.
		amount = rand(200,350)
		switch(rand(1,2))
			if(1)
				reason = "Hawking Stolen Goods"
			if(2)
				reason = "Complicit in Smuggling"

		to_chat(character, span_notice("Those of an honest heart fear me. \
		I have been accused of [reason], and [employer] has put a bounty on my head!"))

	if(character.mind.assigned_role in GLOB.peasant_positions)//Soilson, Towner, etc.
		amount = rand(120,200)
		switch(rand(1,2))
			if(1)
				reason = "Ignoring Lawful Orders"
			if(2)
				reason = "Besmirching Nobility"

		to_chat(character, span_notice("Many believe me to be another cog of a bigger problem. \
		I have been accused of [reason], and [employer] has put a bounty on my head!"))

	if(character.mind.assigned_role in GLOB.mercenary_positions)//Mercs. Simple as.
		amount = rand(125,450)//They can defend themselves, 2.0.
		switch(rand(1,3))
			if(1)
				reason = "Anonymous Request"
			if(2)
				reason = "Murder of Nobility"
			if(3)
				reason = "Abandonment of Contract"

		to_chat(character, span_notice("Employers have a hard time gaining my trust. \
		I have been accused of [reason], and [employer] has put a bounty on my head!"))

	if(character.mind.assigned_role in GLOB.youngfolk_positions)//Apprentices, Clerks, etc.
		amount = rand(150,250)
		switch(rand(1,3))
			if(1)
				reason = "Abuse of Superior"
			if(2)
				reason = "Theft from Workplace"
			if(3)
				reason = "Abuse of Ducal Trust"

		to_chat(character, span_notice("They claim I've done disgusting things. \
		I have been accused of [reason], and [employer] has put a bounty on my head!"))

	if(character.mind.assigned_role in GLOB.allmig_positions)//Adventurers and Pilgrims.
		amount = rand(100, 325)
		switch(rand(1,6))
			if(1)
				reason = "Flight from Authority"
			if(2)
				reason = "Smuggling"
			if(3)
				reason = "Trafficking"
			if(4)
				reason = "Poaching"
			if(5)
				reason = "Fleecing"
			if(6)
				reason = "Debt"

		to_chat(character, span_notice("I'm on the run from my past. No matter how recent. \
		I have been accused of [reason], and [employer] has put a bounty on my head!"))

	if(character.mind.assigned_role in GLOB.goblin_positions)//What do you think?
		amount = rand(50,250)
		switch(rand(1,3))
			if(1)
				reason = "Torture"
			if(2)
				reason = "Murder"
			if(3)
				reason = "Heretical Ideals"

		to_chat(character, span_notice("Those above know and fear my very name. \
		I have been accused of [reason], and [employer] has put a bounty on my head!"))

	add_bounty(character.real_name, amount, FALSE, reason, employer)
