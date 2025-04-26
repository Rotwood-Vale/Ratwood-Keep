/datum/job/roguetown/magician
	ru_title = "Придворный Маг"
	ru_tutorial = "Ваша вера посвящена покорению тайн магических искусств и непрестанной жажде знаний. \
	Жизнью вы обязаны своему Герцогу, ведь именно его золото позволило продолжить учёбу в эти мрачные времена. \
	В ответ вы вновь и вновь доказывали свою верность, выступая справедливым судьёй и доверенным советником его правления."

/datum/outfit/job/roguetown/magician/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/global_message)
