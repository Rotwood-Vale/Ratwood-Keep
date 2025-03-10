/datum/job/roguetown/goblinsmith
	ru_title = "Племенной Кузнец"
	ru_tutorial = "Вы – опытный кузнец, выбранный гоблинским Вождём для снабжения лагеря всем необходимым. \
		Постарайтесь не подвести Вождя и многих существ, что вы обслуживаете под его командованием и милостью."
	announce_latejoin = FALSE
	family_blacklisted = TRUE

/datum/outfit/job/roguetown/goblinsmith/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/labor/mining, 2, TRUE) // economy_fix - гоблины-кузнецы умеют копать на случай малого онлайна
