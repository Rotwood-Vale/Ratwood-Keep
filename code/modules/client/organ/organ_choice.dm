/datum/organ_choice
	abstract_type = /datum/organ_choice
	/// User facing name of the organ choice.
	var/name = "Organ"
	/// Type of the entry datum which is used for save/load of information.
	var/organ_entry_type = /datum/organ_entry
	/// Typepath of the organ this choice yields.
	var/organ_type
	/// Slot of the organ.
	var/organ_slot
	/// Typepath of the organ DNA.
	var/organ_dna_type = /datum/organ_dna
	/// List of sprite accessories this choice allows. Can be null
	var/list/sprite_accessories
	/// The default sprite accessory from `sprite_accessories`.
	var/default_accessory
	/// Whether this organ choice allows to customize colors of sprite accessories.
	var/allows_accessory_color_customization = TRUE
	/// Whether to pick a random accessory from all possible ones in `sprite_accessories` rather than use the proc for randomization
	var/generic_random_pick = FALSE

/datum/organ_choice/New()
	. = ..()
	if(length(sprite_accessories))
		if(!default_accessory)
			default_accessory = sprite_accessories[1]
		if(!(default_accessory in sprite_accessories))
			CRASH("Organ choice [type] has a default accessory which is unavailable in its accessory list.")

/datum/organ_choice/proc/make_default_organ_entry(datum/preferences/prefs, customizer_type, changed_entry = TRUE)
	var/datum/organ_entry/entry = new organ_entry_type()
	entry.organ_customizer_type = customizer_type
	entry.organ_choice_type = type
	if(sprite_accessories)
		set_accessory_type(prefs, default_accessory, entry)
	return entry

/datum/organ_choice/proc/imprint_organ_dna(datum/organ_dna/organ_dna, datum/organ_entry/entry, datum/preferences/prefs)
	organ_dna.organ_type = organ_type
	if(entry.accessory_type)
		organ_dna.accessory_type = entry.accessory_type
		if(allows_accessory_color_customization)
			organ_dna.accessory_colors = entry.accessory_colors
		else
			var/datum/sprite_accessory/accessory = SPRITE_ACCESSORY(entry.accessory_type)
			organ_dna.accessory_colors = accessory.get_default_colors(color_key_source_list_from_prefs(prefs))

/datum/organ_choice/proc/randomize_entry(datum/organ_entry/entry, datum/preferences/prefs)
	var/random_accessory
	if(generic_random_pick && sprite_accessories)
		random_accessory = pick(sprite_accessories)
	else
		random_accessory = get_random_accessory(entry, prefs)
	if(random_accessory)
		set_accessory_type(prefs, random_accessory, entry)
	var/random_color = get_random_color(entry, prefs, entry.accessory_type)
	if(random_color)
		entry.accessory_colors = random_color
	on_randomize_entry(entry, prefs)

/datum/organ_choice/proc/on_randomize_entry(datum/organ_entry/entry, datum/preferences/prefs)
	return

/datum/organ_choice/proc/get_random_accessory(datum/organ_entry/entry, datum/preferences/prefs)
	return

/datum/organ_choice/proc/get_random_color(datum/organ_entry/entry, datum/preferences/prefs, accessory_type)
	return

/// When you want to customize an organ but not through DNA (hair dye for example)
/datum/organ_choice/proc/customize_organ(obj/item/organ/organ, datum/organ_entry/entry)
	return

/datum/organ_choice/proc/show_pref_choices(datum/preferences/prefs, datum/organ_entry/entry, customizer_type)
	var/list/dat = list()
	generate_pref_choices(dat, prefs, entry, customizer_type)
	return dat

/datum/organ_choice/proc/generate_pref_choices(list/dat, datum/preferences/prefs, datum/organ_entry/entry, customizer_type)
	var/datum/sprite_accessory/accessory
	if(sprite_accessories && entry.accessory_type)
		accessory = SPRITE_ACCESSORY(entry.accessory_type)

	if(accessory)
		var/accessory_link
		var/arrows_string
		if(length(sprite_accessories) > 1)
			accessory_link = "href='?_src_=prefs;task=change_organ;customizer=[customizer_type];organ=choose_acc'"
			arrows_string = "<a href='?_src_=prefs;task=change_organ;customizer=[customizer_type];organ=rotate;rotate=prev''><</a><a href='?_src_=prefs;task=change_organ;customizer=[customizer_type];organ=rotate;rotate=next''>></a>"
		else
			accessory_link = "class='linkOff'"
			arrows_string = "<a class='linkOff'><</a><a class='linkOff'>></a>"
		if(length(sprite_accessories) > 1)
			dat += "<br>[arrows_string]<a [accessory_link]>[accessory.name]</a>"

		if(allows_accessory_color_customization)
			dat += "<br><a href='?_src_=prefs;task=change_organ;customizer=[customizer_type];organ=reset_colors'>Reset colors</a>"
			var/list/color_list = color_string_to_list(entry.accessory_colors)
			for(var/index in 1 to accessory.color_keys)
				var/named_index = (accessory.color_keys == 1) ? accessory.color_key_name : accessory.color_key_names[index]
				dat += "<br>[named_index]: <a href='?_src_=prefs;task=change_organ;customizer=[customizer_type];organ=acc_color;color_index=[index]''><span class='color_holder_box' style='background-color:[color_list[index]]'></span></a>"

/datum/organ_choice/proc/handle_topic(mob/user, list/href_list, datum/preferences/prefs, datum/organ_entry/entry, customizer_type)
	switch(href_list["organ"])
		if("choose_acc")
			if(!sprite_accessories)
				return
			var/list/choice_list = list()
			for(var/choice_type in sprite_accessories)
				var/datum/sprite_accessory/accessory = SPRITE_ACCESSORY(choice_type)
				choice_list[accessory.name] = choice_type
			var/chosen_input = input(user, "Choose your organ appearance:", "Character Preference")  as null|anything in choice_list
			if(!chosen_input)
				return
			var/choice_type = choice_list[chosen_input]
			set_accessory_type(prefs, choice_type, entry)

		if("rotate")
			if(!sprite_accessories)
				return
			var/current_index
			var/i = 0
			for(var/accessory_type in sprite_accessories)
				i++
				if(entry.accessory_type != accessory_type)
					continue
				current_index = i
				break
			var/target_index = current_index

			switch(href_list["rotate"])
				if("next")
					target_index++
				if("prev")
					target_index--
			if(target_index > sprite_accessories.len)
				target_index = 1
			else if (target_index <= 0)
				target_index = sprite_accessories.len
			var/datum/organ_choice/organ_choice = ORGAN_CHOICE(entry.organ_choice_type)
			organ_choice.set_accessory_type(prefs, sprite_accessories[target_index], entry)

		if("acc_color")
			if(!sprite_accessories || !allows_accessory_color_customization)
				return
			var/index = text2num(href_list["color_index"])
			var/datum/sprite_accessory/accessory = SPRITE_ACCESSORY(entry.accessory_type)
			if(index > accessory.color_keys)
				return
			var/list/color_list = color_string_to_list(entry.accessory_colors)
			var/new_color = input(user, "Choose your organ color:", "Character Preference","[color_list[index]]") as color|null
			if(!new_color)
				return
			color_list[index] = sanitize_hexcolor(new_color, 6, TRUE)
			entry.accessory_colors = color_list_to_string(color_list)
		if("reset_colors")
			if(!sprite_accessories || !allows_accessory_color_customization)
				return
			reset_accessory_colors(prefs, entry)

/datum/organ_choice/proc/validate_entry(datum/preferences/prefs, datum/organ_entry/entry)
	/// Validate chosen accessory
	if(entry.accessory_type && !sprite_accessories)
		entry.accessory_type = null
		entry.accessory_colors = null
	else if (sprite_accessories && !(entry.accessory_type in sprite_accessories))
		set_accessory_type(prefs, default_accessory, entry)
	/// Validate colors
	if(entry.accessory_type)
		var/datum/sprite_accessory/accessory = SPRITE_ACCESSORY(entry.accessory_type)
		if(accessory.color_keys != 0)
			var/reset_colors = FALSE
			if(!entry.accessory_colors)
				reset_colors = TRUE
			else
				var/list/color_list = color_string_to_list(entry.accessory_colors)
				if(color_list.len != accessory.color_keys)
					reset_colors = TRUE
			if(reset_colors)
				entry.accessory_colors = accessory.get_default_colors(color_key_source_list_from_prefs(prefs))

/datum/organ_choice/proc/set_accessory_type(datum/preferences/prefs, new_accessory_type, datum/organ_entry/entry)
	if(entry.accessory_type == new_accessory_type)
		return
	if(!entry.organ_choice_type)
		CRASH("Tried to set an organ entry accessory without an organ choice.")
	if(!(new_accessory_type in sprite_accessories))
		CRASH("Tried to set an organ entry accessory that isn't allowed for the organ choice.")

	entry.accessory_type = new_accessory_type
	var/datum/sprite_accessory/accessory = SPRITE_ACCESSORY(entry.accessory_type)
	entry.accessory_colors = accessory.get_default_colors(color_key_source_list_from_prefs(prefs))

/datum/organ_choice/proc/reset_accessory_colors(datum/preferences/prefs, datum/organ_entry/entry)
	if(!entry.accessory_type)
		return
	var/datum/sprite_accessory/accessory = SPRITE_ACCESSORY(entry.accessory_type)
	entry.accessory_colors = accessory.get_default_colors(color_key_source_list_from_prefs(prefs))
