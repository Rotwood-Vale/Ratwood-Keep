/datum/charflaw/addiction/lovefiend
	name = "Love Fiend"
	desc = "My heart aches have consensual love with someone..."
	time = 1 HOURS
	needsate_text = "My heart aches for love!.."

/datum/sex_controller/proc/consensual_act_check()
	var/mob/living/carbon/human/partner = null

	// Поиск партнёра на том же тайле
	for(var/mob/living/carbon/human/potential_partner in range(1, src))
		// Вычеркиваем себя из списка
		if(potential_partner == user)
			continue
		// Только добровольная любовь во имя Эоры
		if(need_to_be_violated(potential_partner))
			continue
		else
			partner = potential_partner
			break

	// Если не удаётся найти на одном и том же тайле партнёра, ищем на тайлах вокруг
	if(!partner)
		for(var/mob/living/carbon/human/potential_partner in range(2, src))
			// Вычеркиваем себя из списка
			if(potential_partner == user)
				continue
			// Только добровольная любовь во имя Эоры
			if(need_to_be_violated(potential_partner))
				continue
			else
				partner = potential_partner
				break

	// Всё ещё не смогли найти партнёра. Проверка не пройдена
	if(!partner)
		if(user.has_flaw(/datum/charflaw/addiction/lovefiend))
			to_chat(user, span_boldred("I want to have consensual love with someone..."))
			return

	// What the fuck have you done
	if(partner.stat == DEAD)
		if(user.has_flaw(/datum/charflaw/addiction/lovefiend))
			to_chat(user, span_boldred("I want to love someone ALIVE!"))
			return FALSE

	// TODO - в будущем нужно реализовать привязку к партнёру, делающему действие, а не к поиску людей вокруг
	if(user.has_flaw(/datum/charflaw/addiction/lovefiend))
		user.sate_addiction()
