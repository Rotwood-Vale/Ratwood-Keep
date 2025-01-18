// Check comments with "start_reports_with_gender_lists" for all related code.

/datum/controller/subsystem/ticker
	var/males = 0
	var/females = 0
	var/males_with_vagina = 0
	var/females_with_penis = 0

/mob/living/carbon/human/proc/add_gender_genitals_to_round_end_statistics()
	switch(gender)
		if(MALE)
			if(getorganslot(ORGAN_SLOT_VAGINA))
				SSticker.males_with_vagina++
			else
				SSticker.males++
		if(FEMALE)
			if(getorganslot(ORGAN_SLOT_PENIS))
				SSticker.females_with_penis++
			else
				SSticker.females++
