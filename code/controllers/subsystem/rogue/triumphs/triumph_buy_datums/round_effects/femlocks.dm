/datum/triumph_buy/female_power
	triumph_buy_id = "female_power"
	desc = "Females can be in any job and class!"
	triumph_cost = 25
	category = TRIUMPH_CAT_ROUND_EFX
	pre_round_only = TRUE
	visible_on_active_menu = TRUE

	var/list/changed_jobs = list()
	var/list/changed_advclasses = list()

/datum/triumph_buy/female_power/on_buy()
	// go thru the jobs
	for(var/datum/job/cur_job in SSjob.occupations)
		if(length(cur_job.allowed_sexes))
			if(!(FEMALE in cur_job.allowed_sexes))
				cur_job.allowed_sexes += FEMALE
				changed_jobs += cur_job
	// go thru the classes
	for(var/datum/advclass/cur_class in SSrole_class_handler.sorted_class_categories[CTAG_ALLCLASS])
		if(length(cur_class.allowed_sexes))
			if(!(FEMALE in cur_class.allowed_sexes))
				cur_class.allowed_sexes += FEMALE
				changed_advclasses += cur_class

/datum/triumph_buy/female_power/on_removal()
	var/found_duplicate = FALSE
	for(var/datum/triumph_buy/cur_datum in SStriumphs.active_triumph_buy_queue)
		if(cur_datum.category != TRIUMPH_CAT_ROUND_EFX)
			continue
		if(cur_datum == src)
			continue
		if(istype(cur_datum, src.type))
			found_duplicate = TRUE

	// We found no same type effects in there outside of us
	if(!found_duplicate)
		for(var/datum/job/cur_job in changed_jobs)
			cur_job.allowed_sexes -= FEMALE

		for(var/datum/advclass/cur_class in changed_advclasses)
			cur_class.allowed_sexes -= FEMALE

/datum/triumph_buy/female_power/on_activate(mob/living/carbon/human/H)
	..()
