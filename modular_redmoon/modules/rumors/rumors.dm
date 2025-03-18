// Для поиска связанного, использовать "rumors_addition"

/datum/preferences
	var/use_rumors = FALSE

	var/rumors_prefered_behavior_with_problems = null
	var/rumors_prefered_behavior_in_combat = null
	var/rumors_prefered_behavior_in_work = null
	var/rumors_family = null
	var/rumors_genitals = null

	var/list/rumors_secret = list()
	var/list/rumors_prefered_beginnings = list()
	var/list/rumors_prefered_races = list()
	var/list/rumors_prefered_behavior_in_bed = list()
	var/list/rumors_prefered_ways_to_relax = list()
	var/list/rumors_overal = list()
	var/list/rumors_overal_good = list()
	var/list/rumors_dangerous = list()

/mob/living/carbon/human
	var/use_rumors = FALSE

	var/rumors_prefered_behavior_with_problems = null
	var/rumors_prefered_behavior_in_combat = null
	var/rumors_prefered_behavior_in_work = null
	var/rumors_family = null
	var/rumors_genitals = null

	var/list/rumors_secret = list()
	var/list/rumors_prefered_beginnings = list()
	var/list/rumors_prefered_races = list()
	var/list/rumors_prefered_behavior_in_bed = list()
	var/list/rumors_prefered_ways_to_relax = list()
	var/list/rumors_overal = list()
	var/list/rumors_overal_good = list()
	var/list/rumors_dangerous = list()

/mob/living/carbon/human/Topic(href, href_list)
	if(href_list["task"] == "view_rumors")
		var/mob/user = usr
		var/list/dat = list()
		var/list/secret_dat = list()
		var/is_foreigner = TRUE
		if(job)
			var/datum/job/src_job = SSjob.GetJob(job)
			if(!src_job.wanderer_examine && !src_job.foreign_examine)
				is_foreigner = FALSE

		if(LAZYLEN(rumors_prefered_beginnings))
			var/rumored = "[rumors_prefered_beginnings[1]]"
			var/count = 0
			for(count = 2, count <= rumors_prefered_beginnings.len, count++)
				rumored += ", [rumors_prefered_beginnings[count]]"

			var/final_dat = "<b>...Любит фехтовать с</b> [rumored].<br>"
			if(("fencing" in rumors_secret) || is_foreigner)
				secret_dat += final_dat
			else
				dat += final_dat

		if(LAZYLEN(rumors_prefered_races))
			var/rumored = "[rumors_prefered_races[1]]"
			var/count = 0
			for(count = 2, count <= rumors_prefered_races.len, count++)
				rumored += ", [rumors_prefered_races[count]]"
			
			var/final_dat = "<b>...Предпочитает такие расы, как</b> [rumored].<br>"
			if(("species" in rumors_secret) || is_foreigner)
				secret_dat += final_dat
			else
				dat += final_dat

		if(LAZYLEN(rumors_prefered_behavior_in_bed))
			var/rumored = "[rumors_prefered_behavior_in_bed[1]]"
			var/count = 0
			for(count = 2, count <= rumors_prefered_behavior_in_bed.len, count++)
				rumored += ", [rumors_prefered_behavior_in_bed[count]]"
			
			var/final_dat = "<b>...В постели, предпочитает</b> [rumored].<br>"
			if(("bed" in rumors_secret) || is_foreigner)
				secret_dat += final_dat
			else
				dat += final_dat

		if(rumors_genitals)
			var/final_dat = "<b>...Имеет начало иного пола.</b><br>"
			if(("genitals" in rumors_secret) || is_foreigner)
				secret_dat += final_dat
			else
				dat += final_dat

		if(rumors_family)
			var/final_dat = "<b>...[rumors_family].</b><br>"
			if(("family" in rumors_secret) || is_foreigner)
				secret_dat += final_dat
			else
				dat += final_dat

		if(rumors_prefered_behavior_with_problems)
			var/final_dat = "<b>...Проблемы решает</b> [rumors_prefered_behavior_with_problems].<br>"
			if(("problems" in rumors_secret) || is_foreigner)
				secret_dat += final_dat
			else
				dat += final_dat

		if(rumors_prefered_behavior_in_combat)
			var/final_dat = "<b>...В бою</b> [rumors_prefered_behavior_in_combat].<br>"
			if(("combat" in rumors_secret) || is_foreigner)
				secret_dat += final_dat
			else
				dat += final_dat

		if(rumors_prefered_behavior_in_work)
			var/final_dat = "<b>...В труде</b> [rumors_prefered_behavior_in_work].<br>"
			if(("work" in rumors_secret) || is_foreigner)
				secret_dat += final_dat
			else
				dat += final_dat

		if(LAZYLEN(rumors_prefered_ways_to_relax))
			var/rumored = "[rumors_prefered_ways_to_relax[1]]"
			var/count = 0
			for(count = 2, count <= rumors_prefered_ways_to_relax.len, count++)
				rumored += ", [rumors_prefered_ways_to_relax[count]]"
			
			var/final_dat = "<b>...Для отдыха, предпочитает</b> [rumored].<br>"
			if(("relax" in rumors_secret) || is_foreigner)
				secret_dat += final_dat
			else
				dat += final_dat

		if(LAZYLEN(rumors_overal))
			var/rumored = "[rumors_overal[1]]"
			var/count = 0
			for(count = 2, count <= rumors_overal.len, count++)
				rumored += ", [rumors_overal[count]]"
			
			var/final_dat = "<b>...Из негативных черт характера запоминается за</b> [rumored].<br>"
			if(("rumors_bad" in rumors_secret) || is_foreigner)
				secret_dat += final_dat
			else
				dat += final_dat

		if(LAZYLEN(rumors_overal_good))
			var/rumored = "[rumors_overal_good[1]]"
			var/count = 0
			for(count = 2, count <= rumors_overal_good.len, count++)
				rumored += ", [rumors_overal_good[count]]"
			
			var/final_dat = "<b>...Из положительных черт характера запоминается за</b> [rumored].<br>"
			if(("rumors_good" in rumors_secret) || is_foreigner)
				secret_dat += final_dat
			else
				dat += final_dat

		if(LAZYLEN(rumors_dangerous))
			var/rumored = "[rumors_dangerous[1]]"
			var/count = 0
			for(count = 2, count <= rumors_dangerous.len, count++)
				rumored += ", [rumors_dangerous[count]]"
			
			var/final_dat = "<b>...Подозревается в</b> [rumored].<br>"
			if(("rumors_dangerous" in rumors_secret) || is_foreigner)
				secret_dat += final_dat
			else
				dat += final_dat

		if(secret_dat)
			dat += "<span style='width: 100%; line-height: 18px; font-size: 12pt; color: firebrick'>"
			dat += "<center><i>Следующие слухи неизвестны, но их можно брать в учёт при поиске персонажей для взаимодействия.</i></center><br>"
			dat += "</span>"
			dat += secret_dat

		var/datum/browser/popup = new(user, "rumors", "<div align='center'>Ходят слухи, что [src]...</div>", 600, 500)
		popup.set_content(dat.Join())
		popup.open(FALSE)
		return
	return ..() 
