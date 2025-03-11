/datum/job/roguetown/bandit
	ru_title = "Разбойник"
	ru_f_title = "Разбойница"
	ru_tutorial = "На Энигме, где не хватает ресурсов - дезертиры, изгнанники, воры, преступники \
	или бывшие наемники обращаются к последним средствам выживания. Объединившись под общим поклонением \
	смертному, ставшему легендой Маттиосу, эта грозная банда изгнанников зарабатывает достаточно средств через кражи, \
	грабежи, убийства, вымогательства и другие преступления, чтобы обеспечить себе лучшую жизнь."

	tutorial = "On the barren Enigma lands, there are deserters, exiled one, thiefs, evildoers and former mercenaries \
	who resorts to the last measures of surviving. United by worshipping former mortal one, the legendary Mattios, \
	these fearsome band earns enough through plundering, robbery, murdering, racket and other felonies. All to \
	ensure a better life for themselfs."
	total_positions = 2
	spawn_positions = 2

/datum/outfit/job/roguetown/bandit/proc/hunted(mob/living/carbon/human/character, silent)
	var/reason = ""
	var/employer = "unknown employer"
	var/employer_gender
	if(prob(65))
		employer_gender = MALE
	else
		employer_gender = FEMALE
	if(employer_gender == MALE)
		employer = pick(list("Baron", "Lord", "Nobleman", "Heir"))
	else
		employer = pick(list("Duchess", "Lady", "Noblelady", "Heiress"))
	employer = "[employer] [random_human_name(employer_gender, FALSE, FALSE)]"
	var/amount = rand(250,1000)
	switch(rand(1,7))
		if(1)
			reason = "Murder"
		if(2)
			reason = "Kinslaying"
		if(3)
			reason = "Besmirching a Noble's name"
		if(4)
			reason = "Treason"
		if(5)
			reason = "Arson"
		if(6)
			reason = "Heresy"
		if(7)
			reason = "Robbing a Noble"
	add_bounty(character.real_name, amount, FALSE, reason, employer)
	ADD_TRAIT(character, TRAIT_WANTED, TRAIT_GENERIC)
	if(!silent)
		to_chat(character, span_notice("Whether I've done it or not, I have been accused of [reason] and the [employer] put a bounty on my head!"))
