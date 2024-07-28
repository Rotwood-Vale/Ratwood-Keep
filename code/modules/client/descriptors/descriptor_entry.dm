/datum/descriptor_entry
	// The choice type this entry belongs to
	var/descriptor_choice_type
	// The chosen descriptor type this entry got
	var/descriptor_type

/datum/descriptor_entry/proc/set_values(choice_type, desc_type)
	descriptor_choice_type = choice_type
	descriptor_type = desc_type
