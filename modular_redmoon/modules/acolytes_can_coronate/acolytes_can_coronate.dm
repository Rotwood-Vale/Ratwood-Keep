/datum/outfit/job/roguetown/monk/pre_equip(mob/living/carbon/human/H)
	..()
	H.verbs += list(/mob/living/carbon/human/proc/lesser_coronate_lord)

/mob/living/carbon/human/proc/lesser_coronate_lord()
	set name = "Coronate Heir"
	set category = "Cleric"
	if(!mind)
		return

	// Если нет плохого знамения из-за отсутствия лорда, коронация невозможна
	if(!hasomen(OMEN_NOLORD))
		to_chat(src, span_warning("I can only coronate a heir if we will be punished by the ten for having no ruler..."))
		return FALSE

	if(!istype(get_area(src), /area/rogue/indoors/town/church/chapel))
		to_chat(src, span_warning("I need to do this in the chapel."))
		return FALSE

	// Если в раунде была жрица, то коронация силами аколита невозможна
	if(SSjob.type_occupations[/datum/job/roguetown/priest].current_positions)
		to_chat(src, span_warning("Our church has the priest... My connection with the Ten is not strong enough for such act."))
		return FALSE

	for(var/mob/living/carbon/human/HU in get_step(src, src.dir))
		if(!HU.mind)
			continue
		if(HU.mind.assigned_role == "Duke")
			continue
		if(!HU.head)
			continue
		if(!istype(HU.head, /obj/item/clothing/head/roguetown/crown/serpcrown))
			continue
		// коронация возможна только для наследников
		if(HU.mind.assigned_role != "Heir")
			to_chat(src, span_warning("Only noble heirs can become new baron!"))
			return FALSE

		//Abdicate previous Duke
		for(var/mob/living/carbon/human/HL in GLOB.human_list)
			if(HL.mind)
				if(HL.mind.assigned_role == "Duke" || HL.mind.assigned_role == "Duke Consort")
					HL.mind.assigned_role = "Towner" //So they don't get the innate traits of the lord
			//would be better to change their title directly, but that's not possible since the title comes from the job datum
			if(HL.job == "Duke")
				HL.job = "Duke Emeritus"
			if(HL.job == "Duke Consort")
				HL.job = "Consort Dowager"
			SSjob.type_occupations[/datum/job/roguetown/ruler].remove_spells(HL)

		//Coronate new Lord (or Lady)
		HU.mind.assigned_role = "Duke"
		HU.job = "Duke"
		SSjob.type_occupations[/datum/job/roguetown/ruler].add_spells(HU)

		switch(HU.gender)
			if("male")
				SSticker.rulertype = "Duke"
			if("female")
				SSticker.rulertype = "Duchess"
		SSticker.rulermob = HU
		var/dispjob = mind.assigned_role
		removeomen(OMEN_NOLORD)
		say("By the authority of the gods, I pronounce you [SSticker.rulertype] of Rockhill!")
		priority_announce("[real_name] the [dispjob] has named [HU.real_name] the [SSticker.rulertype] of Rockhill!", title = "Long Live [HU.real_name]!", sound = 'sound/misc/bell.ogg')
		TITLE_LORD = SSticker.rulertype
