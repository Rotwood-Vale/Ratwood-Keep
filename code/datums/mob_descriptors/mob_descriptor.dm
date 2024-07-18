/datum/mob_descriptor
	abstract_type = /datum/mob_descriptor
	var/name = "Descriptor"
	var/lowertext_singular
	var/slot = MOB_DESCRIPTOR_SLOT_NOTHING

/datum/mob_descriptor/New()
	. = ..()
	if(!lowertext_singular)
		lowertext_singular = lowertext(name)

/datum/mob_descriptor/proc/can_describe(mob/living/described)
	return TRUE
	
/datum/mob_descriptor/proc/get_standalone_text(mob/living/described)
	return "%THEY% %HAVE% [get_coalesce_text(described)]"

/datum/mob_descriptor/proc/get_coalesce_text(mob/living/described)
	return lowertext_singular
