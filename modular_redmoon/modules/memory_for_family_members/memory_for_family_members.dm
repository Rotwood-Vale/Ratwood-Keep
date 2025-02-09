// Check comments with "family_changes" for all related code.

/mob/living/carbon/human
	var/spouse_ckey = null // Ckey второго члена семьи (жены или мужа)
	var/family_surname = null // Фамилия семьи
	var/list/family_genitals = list()

/datum/preferences
	var/spouse_ckey = null
	var/family_surname = null
	var/list/family_genitals = list()

/datum/preferences/proc/setup_family_genitals()
	family_genitals = list()
	for(var/A in list("Male", "Female"))
		family_genitals += A

/datum/controller/subsystem/family/proc/SetupFamilies_Short(mob/living/carbon/human/newcomer)
	var/add_to_potentials_poll = TRUE
	for(var/mob/living/carbon/human/candidate in family_candidates)
		if(lowertext(candidate.client?.prefs.spouse_ckey) == newcomer.ckey) // у кандидата должен стоять ckey, который прописан у newcomer
			if(lowertext(newcomer.client.prefs.spouse_ckey) == candidate.ckey) // у newcomer должен стоять ckey, который прописан у candidate
				// Если фамилии не одинаковые, дропаем семью
				if(candidate.family_surname != newcomer.family_surname)
					break
				var/datum/family/F = makeFamily(newcomer)
				// Такая же проверка, как при создании семьи. На всякий случай, чтобы избежать знать в браке с простолюдинами и другие проблемы
				if(F.checkFamilyCompat(candidate,newcomer,REL_TYPE_SPOUSE) && F.checkFamilyCompat(newcomer,candidate,REL_TYPE_SPOUSE))
					F.addMember(candidate)
					F.addRel(newcomer,candidate,getMatchingRel(REL_TYPE_SPOUSE),TRUE)
					F.addRel(candidate,newcomer,REL_TYPE_SPOUSE,TRUE)

					family_candidates -= candidate // Remove the matched candidate
					add_to_potentials_poll = FALSE
				else
					qdel(F) // Удаляем лишнюю семью
				break
	// Если не удалось найти пару, добавляем в пулл ждунов
	if(add_to_potentials_poll)
		family_candidates += newcomer
