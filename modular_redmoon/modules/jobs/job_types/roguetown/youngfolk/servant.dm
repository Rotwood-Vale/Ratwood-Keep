/datum/job/roguetown/servant
	ru_title = "Слуга"
	ru_f_title = "Домохозяйка"
	ru_tutorial = "Вы были награждены прекрасной должностью слуги в доме лорда.\
	Вы слушаете приказы главного слуги/домохозяйки и проводите день, выполняя необходимые, но рутинные задания."

/datum/outfit/job/roguetown/servant/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
