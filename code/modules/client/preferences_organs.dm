/datum/preferences/proc/validate_organ_entries()
	organ_entries = SANITIZE_LIST(organ_entries)
	listclearnulls(organ_entries)
	var/datum/species/species = pref_species
	var/list/customizers = species.organ_customizers
	/// Check if we have any organ entries that don't match.
	for(var/datum/organ_entry/entry as anything in organ_entries)
		var/validated = FALSE
		for(var/customizer_type as anything in customizers)
			if(customizer_type != entry.organ_customizer_type)
				continue
			var/datum/organ_customizer/customizer = ORGAN_CUSTOMIZER(customizer_type)
			if(!(entry.organ_choice_type in customizer.organ_choices))
				continue
			var/datum/organ_choice/organ_choice = ORGAN_CHOICE(entry.organ_choice_type)
			if(entry.type != organ_choice.organ_entry_type)
				continue
			validated = TRUE
			break

		if(!validated)
			organ_entries -= entry

	/// Check if we have any missing organ entries
	for(var/customizer_type as anything in customizers)
		var/found = FALSE
		for(var/datum/organ_entry/entry as anything in organ_entries)
			if(entry.organ_customizer_type != customizer_type)
				continue
			found = TRUE
			break
		var/datum/organ_customizer/customizer = ORGAN_CUSTOMIZER(customizer_type)
		if(!found)
			organ_entries += customizer.make_default_organ_entry(src, FALSE)

	/// Validate the variables within organ entries
	for(var/datum/organ_entry/entry as anything in organ_entries)
		var/datum/organ_choice/organ_choice = ORGAN_CHOICE(entry.organ_choice_type)
		organ_choice.validate_entry(src, entry)

/datum/preferences/proc/print_organs_page()
	var/list/dat = list()
	. = dat
	if(!pref_species)
		return
	var/list/customizers = pref_species.organ_customizers
	if(!customizers)
		return
	for(var/customizer_type in customizers)
		var/datum/organ_customizer/customizer = ORGAN_CUSTOMIZER(customizer_type)
		var/datum/organ_entry/entry = get_organ_entry_for_customizer_type(customizer_type)
		if(!entry)
			stack_trace("Missing organ entry in preferences for customizer [customizer_type]")
			continue
		var/datum/organ_choice/choice = ORGAN_CHOICE(entry.organ_choice_type)

		var/customizer_link

		if(entry.missing_organ)
			customizer_link = "href='?_src_=prefs;task=change_organ;customizer=[customizer_type];organ=toggle_missing'"
		else
			if(customizer.allows_missing_organ)
				customizer_link = "href='?_src_=prefs;task=change_organ;customizer=[customizer_type];organ=toggle_missing' class='linkOn'"
			else
				customizer_link = "class='linkOff'"

		dat += "<hr>"
		dat += "<a [customizer_link]>[customizer.name]</a>"
		if(!entry.missing_organ)
			var/choice_link
			if(length(customizer.organ_choices) > 1)
				choice_link = "href='?_src_=prefs;task=change_organ;customizer=[customizer_type];organ=change_choice'"
			else
				choice_link = "class='linkOff'"
			if(length(customizer.organ_choices) > 1)
				dat += "<br><a [choice_link]>[choice.name]</a>"

			var/list/choice_list = choice.show_pref_choices(src, entry, customizer_type)
			if(choice_list)
				dat += choice_list

	return

/// We dont associate the entries just to be safer for save/load, so we can't lookup easily and we do this.
/datum/preferences/proc/get_organ_entry_for_customizer_type(customizer_type)
	for(var/datum/organ_entry/entry as anything in organ_entries)
		if(entry.organ_customizer_type == customizer_type)
			return entry

/// Gets an associative list of organ slots to organ dna created from organ customization
/datum/preferences/proc/get_organ_dna_list()
	var/list/organ_list = list()
	for(var/datum/organ_entry/entry as anything in organ_entries)
		var/datum/organ_customizer/customizer = ORGAN_CUSTOMIZER(entry.organ_customizer_type)
		var/datum/organ_choice/organ_choice = ORGAN_CHOICE(entry.organ_choice_type)
		organ_list[organ_choice.organ_slot] = customizer.create_organ_dna(entry, src)

	return organ_list

/datum/preferences/proc/customize_organ(obj/item/organ/organ)
	for(var/datum/organ_entry/entry as anything in organ_entries)
		var/datum/organ_choice/organ_choice = ORGAN_CHOICE(entry.organ_choice_type)
		if(organ_choice.organ_slot != organ.slot)
			continue
		organ_choice.customize_organ(organ, entry)

/datum/preferences/proc/handle_organ_topic(mob/user, href_list)
	//needs_update = TRUE
	var/customizer_type = text2path(href_list["customizer"])
	var/datum/organ_entry/entry = get_organ_entry_for_customizer_type(customizer_type)
	var/datum/organ_choice/choice = ORGAN_CHOICE(entry.organ_choice_type)
	var/datum/organ_customizer/customizer = ORGAN_CUSTOMIZER(customizer_type)
	switch(href_list["organ"])
		if("toggle_missing")
			if(customizer.allows_missing_organ)
				entry.missing_organ = !entry.missing_organ
		if("change_choice")
			var/list/choice_list = list()
			for(var/choice_type in customizer.organ_choices)
				var/datum/organ_choice/iter_choice = ORGAN_CHOICE(choice_type)
				choice_list[iter_choice.name] = choice_type
			var/chosen_input = input(user, "Choose your [lowertext(customizer.name)] organ:", "Character Preference")  as null|anything in choice_list
			if(!chosen_input)
				return
			var/choice_type = choice_list[chosen_input]
			if(choice_type == choice.type)
				return
			organ_entries -= entry
			organ_entries += customizer.create_organ_entry(src, choice_type)
		else
			choice.handle_topic(user, href_list, src, entry, customizer_type)

/datum/preferences/proc/reset_all_organ_accessory_colors()
	for(var/datum/organ_entry/entry as anything in organ_entries)
		var/datum/organ_choice/choice = ORGAN_CHOICE(entry.organ_choice_type)
		choice.reset_accessory_colors(src, entry)

/datum/preferences/proc/randomize_all_organ_accessories()
	for(var/datum/organ_entry/entry as anything in organ_entries)
		var/datum/organ_choice/choice = ORGAN_CHOICE(entry.organ_choice_type)
		choice.randomize_entry(entry, src)
