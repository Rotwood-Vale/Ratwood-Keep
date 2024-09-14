/datum/pollutant
	/// Name of the pollutant
	var/name
	/// Descriptor of the smell
	var/descriptor
	/// Scent of the smell
	var/scent
	/// Color of the pollutant
	var/color

/datum/pollutant/proc/on_life(parent)
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

/datum/pollutant/fragrance
	name = "debug fragrance"
	scent = "debug scent"
	color = "#000000"

	descriptor = "scent"

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
