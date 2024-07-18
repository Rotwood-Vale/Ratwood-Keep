/datum/mob_descriptor
	abstract_type = /datum/mob_descriptor
	var/name = "Descriptor"
	var/show_obscured = FALSE
	var/describe
	var/prefix
	var/suffix
	var/verbage
	var/slot = MOB_DESCRIPTOR_SLOT_NOTHING
	var/pre_string
	var/post_string

/datum/mob_descriptor/New()
	. = ..()
	if(!describe)
		describe = lowertext(name)
	if(prefix)
		pre_string = "[prefix] "
	if(verbage)
		pre_string = "[verbage] [pre_string]"
	if(suffix)
		post_string = " [suffix]"

/datum/mob_descriptor/proc/can_describe(mob/living/described)
	return TRUE

/datum/mob_descriptor/proc/get_standalone_text(mob/living/described)
	return "%THEY% [get_coalesce_text(described)]"

/datum/mob_descriptor/proc/get_coalesce_text(mob/living/described)
	return "[pre_string][get_description(described)][post_string]"

/datum/mob_descriptor/proc/get_description(mob/living/described)
	return describe
