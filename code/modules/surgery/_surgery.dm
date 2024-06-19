/datum/surgery
	/// Name of the surgical procedure
	var/name = "surgery"
	/// Description of the surgical procedure
	var/desc = ""
	/// Steps to be performed in order
	var/list/steps = list()
	/// Acceptable mob types
	var/list/target_mobtypes = list(/mob/living/carbon/human)
	/// Acceptable body zones
	var/list/possible_locs = list()
	/// Surgery available only when a bodypart is present
	var/requires_bodypart = TRUE
	/// Surgery available only when a bodypart is missing
	var/requires_missing_bodypart = FALSE
	/// Surgery not available on pseudoparts
	var/requires_real_bodypart = FALSE
	/// Acceptable limb statuses
	var/requires_bodypart_type = BODYPART_ORGANIC

/datum/surgery/advanced
	name = "advanced surgery"

/obj/item/disk/surgery
	name = "Surgery Procedure Disk"
	desc = ""
	icon_state = "datadisk1"
	custom_materials = list(/datum/material/iron=300, /datum/material/glass=100)
	/// Surgery steps made available by this disk
	var/list/surgery_steps

/obj/item/disk/surgery/debug
	name = "Debug Surgery Disk"
	desc = ""
	icon_state = "datadisk1"
	custom_materials = list(/datum/material/iron=300, /datum/material/glass=100)

/obj/item/disk/surgery/debug/Initialize()
	. = ..()
	surgery_steps = list()
	for(var/datum/surgery_step/surgery_step as anything in subtypesof(/datum/surgery))
		if(initial(surgery_step.requires_tech))
			surgery_steps += surgery_step

/**
 * Check /mob/living/carbon/attackby for how surgery progresses, and also /mob/living/carbon/attack_hand.
 * Other important variables are:
 * var/list/surgeries (/mob/living)
 * var/list/internal_organs (/mob/living/carbon)
 * var/list/bodyparts (/mob/living/carbon)
 */
