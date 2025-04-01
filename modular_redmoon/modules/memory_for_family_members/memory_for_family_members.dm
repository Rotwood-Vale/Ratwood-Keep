// Check comments with "family_changes" for all related code.

/mob/living/carbon/human
	var/spouse_ckey = null // Ckey второго члена семьи (жены или мужа)
	var/family_surname = null // Фамилия семьи
	var/list/family_genitals = list("Male", "Female") // Допустимые гениталии у партнёра
	var/allow_latejoin_family = TRUE // Разрешается ли формирование семьи после начала раунда
	var/old_real_name = null // Имя, которое присвоилось до выставления имени семьи

/datum/preferences
	var/spouse_ckey = null
	var/family_surname = null
	var/list/family_genitals = list("Male", "Female")
	var/allow_latejoin_family = TRUE
	var/detailed_family_loging = TRUE // Детальный отчёт о причинах провала подбора семьи

/datum/controller/subsystem/family/proc/SetupFamilies_Short(mob/living/carbon/human/newcomer)
	var/add_to_potentials_poll = TRUE
	var/datum/family/F = new() // Виртуальная семья, нужная только для сравнения кандидатов на совместимость
	for(var/mob/living/carbon/human/candidate in family_candidates)
		if(lowertext(newcomer.client.prefs.spouse_ckey))
			if(lowertext(newcomer.client.prefs.spouse_ckey) == candidate.ckey) // у newcomer должен стоять ckey, который прописан у candidate
				if(lowertext(candidate.client?.prefs.spouse_ckey) == newcomer.ckey) // у кандидата должен стоять ckey, который прописан у newcomer
					// Если фамилии не одинаковые, дропаем семью
					if(candidate.family_surname != newcomer.family_surname)
						to_chat(newcomer, span_danger("Вы чувствуете, что только что была попытка создать семью... Но ваши фамилии оказались разными."))
						to_chat(candidate, span_danger("Вы чувствуете, что только что была попытка создать семью... Но ваши фамилии оказались разными."))
						add_to_potentials_poll = FALSE
						break
			else
				continue
		// Чтобы бандит или заключенный не имели семью кроме случаев, когда это предусмотрено наличием spouse_ckey
		if(!candidate.allow_latejoin_family)
			continue
		if(SSjob.GetJob(newcomer.job).family_blacklisted && !newcomer.client.prefs.spouse_ckey)
			break
		// Такая же проверка, как при создании семьи. На всякий случай, чтобы избежать знать в браке с простолюдинами и другие проблемы
		if(F.checkFamilyCompat(candidate,newcomer,REL_TYPE_SPOUSE) && F.checkFamilyCompat(newcomer,candidate,REL_TYPE_SPOUSE))
			var/mob/family_head = candidate
			var/mob/family_member = newcomer
			if(candidate.family_surname)
				for(var/datum/mind/MF in get_minds()) // Т.к. со старта раунд известны под другим именем, удаляем его
					newcomer.mind.become_unknown_to(MF)
				
				newcomer.real_name = "[newcomer.old_real_name] [candidate.family_surname]" // Меняем имя на имя + фамилия у главы семьи
				for(var/X in SSjob.GetJob(newcomer.job).peopleknowme) // добавляем новое имя в списки
					for(var/datum/mind/MF in get_minds(X))
						newcomer.mind.person_knows_me(MF)
			else
				family_head = newcomer
				family_member = candidate
			var/datum/family/real_family = makeFamily(family_head)
			real_family.addMember(family_member)
			real_family.addRel(newcomer,candidate,getMatchingRel(REL_TYPE_SPOUSE),TRUE)
			real_family.addRel(candidate,newcomer,REL_TYPE_SPOUSE,TRUE)

			family_candidates -= candidate
			add_to_potentials_poll = FALSE
			break
	qdel(F)
	// Если не удалось найти пару, добавляем в пулл ждунов
	if(add_to_potentials_poll)
		family_candidates += newcomer

// Начисление триумфов супругам за соитие
/datum/sex_controller/after_intimate_climax()
	. = ..()
	if(user.isFamily(target))
		if(!target.mob_timers["cumfamily"])
			target.mob_timers["cumfamily"] = world.time
			to_chat(target, "I have been with my spouse!")
			target.adjust_triumphs(3)
		if(!user.mob_timers["cumfamily"])
			user.mob_timers["cumfamily"] = world.time
			to_chat(user, "I have been with my spouse!")
			user.adjust_triumphs(3)

// Детальный отчёт о причинах провала подбора семьи
/datum/family/proc/detailed_log(var/mob/living/carbon/human/target, var/message)
	if(!target.client?.prefs?.detailed_family_loging)
		return
	to_chat(target, span_small("Family Log: [message]"))
