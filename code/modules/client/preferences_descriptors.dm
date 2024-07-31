/datum/preferences/proc/validate_descriptors()
	for(var/choice_type in pref_species.descriptor_choices)
		var/datum/descriptor_choice/choice = DESCRIPTOR_CHOICE(choice_type)
		var/datum/descriptor_entry/entry = get_descriptor_entry_for_choice(choice_type)
		if(entry)
			continue
		entry = new /datum/descriptor_entry()
		entry.set_values(choice_type, pick(choice.descriptors))
		descriptor_entries += entry

	for(var/datum/descriptor_entry/entry as anything in descriptor_entries)
		var/datum/descriptor_choice/choice = DESCRIPTOR_CHOICE(entry.descriptor_choice_type)
		if(entry.descriptor_type == null || !(entry.descriptor_type in choice.descriptors))
			entry.descriptor_type = pick(choice.descriptors)

/datum/preferences/proc/reset_descriptors()
	descriptor_entries = list()
	for(var/choice_type in pref_species.descriptor_choices)
		var/datum/descriptor_choice/choice = DESCRIPTOR_CHOICE(choice_type)
		var/datum/descriptor_entry/entry = new /datum/descriptor_entry()
		entry.set_values(choice_type, pick(choice.descriptors))
		descriptor_entries += entry

/datum/preferences/proc/handle_descriptors_topic(mob/user, href_list)
	switch(href_list["preference"])
		if("choose_descriptor")
			var/choice_type = text2path(href_list["descriptor_choice"])
			if(!(choice_type in pref_species.descriptor_choices))
				return
			var/datum/descriptor_choice/choice = DESCRIPTOR_CHOICE(choice_type)
			if(!choice)
				return
			var/list/picklist = list()
			for(var/desc_type in choice.descriptors)
				var/datum/mob_descriptor/descriptor = MOB_DESCRIPTOR(desc_type)
				picklist[descriptor.name] = desc_type
			var/picked_descriptor_name = input(user, "Describe my [lowertext(choice.name)]", "Describe myself") as null|anything in picklist

			if(!picked_descriptor_name)
				return
			var/picked_type = picklist[picked_descriptor_name]
			var/datum/descriptor_entry/entry = get_descriptor_entry_for_choice(choice_type)
			entry.descriptor_type = picked_type

/datum/preferences/proc/print_descriptors_page()
	var/list/dat = list()
	for(var/choice_type in pref_species.descriptor_choices)
		var/datum/descriptor_choice/choice = DESCRIPTOR_CHOICE(choice_type)
		var/datum/descriptor_entry/entry = get_descriptor_entry_for_choice(choice_type)
		var/datum/mob_descriptor/descriptor = MOB_DESCRIPTOR(entry.descriptor_type)
		dat += "<b>[choice.name]:</b> <a href='?_src_=prefs;descriptor_choice=[choice_type];preference=choose_descriptor;task=change_descriptor'>[descriptor.name]</a><br>"
	
	dat += "<br><center>Descriptors can vary based on gender<br>Some don't appear if you don't match a requirement<center>"
	return dat

/datum/preferences/proc/show_descriptors_ui(mob/user)
	var/list/dat = list()
	dat += print_descriptors_page()
	var/datum/browser/popup = new(user, "descriptors_customization", "<div align='center'>Describe myself</div>", 280, 345)
	popup.set_content(dat.Join())
	popup.open(FALSE)

/datum/preferences/proc/get_descriptor_entry_for_choice(choice_type)
	for(var/datum/descriptor_entry/entry as anything in descriptor_entries)
		if(entry.descriptor_choice_type != choice_type)
			continue
		return entry
	return null

/datum/preferences/proc/apply_descriptors(mob/living/character)
	character.clear_mob_descriptors()
	for(var/choice_type in pref_species.descriptor_choices)
		var/datum/descriptor_entry/entry = get_descriptor_entry_for_choice(choice_type)
		character.add_mob_descriptor(entry.descriptor_type)
