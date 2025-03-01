// Связанное искать через "lich_fixes"

/datum/antagonist/lich/proc/redmoon_lich_fixes()
	var/mob/living/carbon/human/lich = owner.current

	// телепорт на точку спавна беженца
	var/list/obj/effect/landmark/start/refugeelate/spawn_points = list()
	for(var/A in GLOB.start_landmarks_list)
		spawn_points += A
	var/obj/target_point = pick(spawn_points)
	lich.forceMove(target_point.loc)
	lich.delete_equipment() // удаление экипировки из прошлой жизни

	owner.known_skills = list() // удаление навыков из прошлой жизни
	owner.skill_experience = list() // удаление опыта из прошлой жизни
	owner.RemoveAllSpells() // удаление спеллов из прошлой жизни

	// Стартер-пак из двух трупов рядом
	new /obj/effect/mob_spawn/human/corpse/damaged(get_step(lich.loc, lich.dir))
	new /obj/effect/mob_spawn/human/corpse/damaged(get_step(lich.loc, lich.dir))
	// Освобождение слота предыдущей профессии
	var/datum/job/lich_previous_job = SSjob.GetJob(lich.job)
	if(lich_previous_job)
		lich_previous_job.current_positions = max(lich_previous_job.current_positions-1, 0)
