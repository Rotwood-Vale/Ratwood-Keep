/datum/pollutant
	/// Name of the pollutant, if null will be treated as abstract and wont be initialized as singleton
	var/name
	/// Flags of the pollutant, determine whether it has an appearance, smell, touch act, breath act
	var/pollutant_flags = NONE
	/// Below are variables for appearance
	/// What color will the pollutant be, can be left null
	var/color
	/// What is it desired alpha?
	var/alpha = 255
	/// How "thick" is it, the thicker the quicker it gets to desired alpha and is stronger than other pollutants in blending appearance
	var/thickness = 1
	///FILL THE BELOW OUT IF ITS SMELLABLE!
	/// How intense is one unit of the pollutant for smell purposes?
	var/smell_intensity
	/// Descriptor of the smell
	var/descriptor
	/// Scent of the smell
	var/scent

/datum/pollutant/proc/on_life(parent)
	return

///When a pollutant touches an unprotected mob
/datum/pollutant/proc/touch_act(mob/living/victim, amount)
	return

///When a carbon mob breathes in the pollutant
/datum/pollutant/proc/breathe_act(mob/living/carbon/victim, amount)
	return

///When a carbon mob smells scents this is called
/datum/pollutant/proc/on_smell(mob/living/carbon/victim, amount)
	return


/datum/pollutant/fragrance/on_life(parent)
	. = ..()
	for(var/mob/living/carbon/human/H in view(1, parent))
		if(!H)
			continue
		if(!considered_alive(H.mind))
			continue
		if(H.has_stress_event(/datum/stressevent/perfume))
			continue

		H.add_stress(/datum/stressevent/perfume)
		H.visible_message(span_green("The [descriptor] of [scent] bombards my nostrils."))

///Smoke coming from cigarettes and fires
/datum/pollutant/smoke //and mirrors
	name = "Smoke"
	pollutant_flags = POLLUTANT_APPEARANCE | POLLUTANT_SMELL | POLLUTANT_BREATHE_ACT
	smell_intensity = 1
	descriptor = SCENT_DESC_SMELL
	scent = "smoke"

/datum/pollutant/fragrance
	smell_intensity = 2
	pollutant_flags = POLLUTANT_SMELL

	name = "debug fragrance"
	scent = "debug scent"
	color = "#000000"

	descriptor = "fragrance"

/datum/pollutant/fragrance/lavender
	name = "lavender"
	scent = "lavender"
	color = "#967bb6"

/datum/pollutant/fragrance/cherry
	name = "cherry"
	scent = "cherries"
	color = "#B62625"

/datum/pollutant/fragrance/rose
	name = "rose"
	scent = "roses"
	color = "#F33A6A"

/datum/pollutant/fragrance/jasmine
	name = "jasmine"
	scent = "jasmine"
	color = "#F8DE7E"

/datum/pollutant/fragrance/mint
	name = "mint"
	scent = "mint"
	color = "#3EB489"

/datum/pollutant/fragrance/vanilla
	name = "vanilla"
	scent = "vanilla"
	color = "#dfd8ba"

/datum/pollutant/fragrance/pear
	name = "pear"
	scent = "pear"
	color = "#d1e231"

/datum/pollutant/fragrance/strawberry
	name = "strawberry"
	scent = "strawberries"
	color = "#fc5a8d"
