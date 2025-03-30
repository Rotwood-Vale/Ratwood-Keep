//////////////////////////////////////////////////////////////////////////////////////////
					// HERB REAGENTS
//////////////////////////////////////////////////////////////////////////////////////

/datum/reagent/herb/
	name = "herb"
	metabolization_rate = 0.1
	taste_description = "herbs"

// chamomile variants

/datum/reagent/herb/chamomile
	name = "chamomile extract"
	description = ""
	color = "#e7bc53"
	taste_description = "flowers"

/datum/reagent/herb/chamomile/ground
	name = "chamomile extract"
	description = ""
	color = "#e7bc53"
	taste_description = "flowers"

/datum/reagent/herb/chamomile/good
	name = "chamomile extract"
	description = ""
	color = "#e7bc53"
	taste_description = "tea"

/datum/reagent/herb/chamomile/bad
	name = "chamomile extract"
	description = ""
	color = "#e7bc53"
	taste_description = "burnt flowers"

/datum/reagent/herb/chamomile/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(-0.2*REM, 0)
	..()
	. = 1
// marigold, no variants

/datum/reagent/herb/marigold
	name = "marigold extract"
	description = ""
	color = "#E4A234"
	taste_description = "citrus"

/datum/reagent/herb/marigold/ground
	name = "marigold extract"
	description = ""
	color = "E4A234"
	taste_description = "citrus"

/datum/reagent/herb/chamomile/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(-0.2*REM, 0)
	..()
	. = 1

// nettle variants

/datum/reagent/herb/nettle
	name = "nettle extract"
	description = ""
	color = "#64816F"
	taste_description = "grass"

/datum/reagent/herb/nettle/good
	name = "nettle extract"
	description = ""
	color = "#64816F"
	taste_description = "earth"

/datum/reagent/herb/nettle/bad
	name = "nettle extract"
	description = ""
	color = "#64816F"
	taste_description = "burnt grass"

// sage variants

/datum/reagent/herb/sage
	name = "sage extract"
	description = ""
	color = "#c698dc"
	taste_description = "herbs"

/datum/reagent/herb/sage/ground
	name = "sage extract"
	description = ""
	color = "#c698dc"
	taste_description = "herbs"

/datum/reagent/herb/sage/good
	name = "sage extract"
	description = ""
	color = "#c698dc"
	taste_description = "sweet grass"

/datum/reagent/herb/sage/bad
	name = "sage extract"
	description = ""
	color = "#c698dc"
	taste_description = "earth"

// belladonna

/datum/reagent/herb/belladonna
	name = "belladonna extract"
	description = ""
	color = "#371648"
	taste_description = "death"

/datum/reagent/herb/belladonna/ground
	name = "belladonna extract"
	description = ""
	color = "#371648"
	taste_description = "death"

/datum/reagent/herb/belladonna/good
	name = "belladonna extract"
	description = ""
	color = "#371648"
	taste_description = "death"

/datum/reagent/herb/belladonna/bad
	name = "belladonna extract"
	description = ""
	color = "#371648"
	taste_description = "death"


/datum/reagent/herb/belladonna/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M, TRAIT_NASTY_EATER))
		M.add_nausea(9)
		M.adjustToxLoss(3, 0)
	return ..()

// valerian variants

/datum/reagent/herb/valerian
	name = "valerian extract"
	description = ""
	color = "#f0dafb"
	taste_description = "bitterness"

/datum/reagent/herb/valerian/ground
	name = "valerian extract"
	description = ""
	color = "#f0dafb"
	taste_description = "bitterness"

/datum/reagent/herb/valerian/good
	name = "valerian extract"
	description = ""
	color = "#f0dafb"
	taste_description = "bitterness"

/datum/reagent/herb/valerian/bad
	name = "valerian extract"
	description = ""
	color = "#f0dafb"
	taste_description = "bitterness"

// herb drow variants

/datum/reagent/herb/herbdrow
	name = "herb drow extract"
	description = ""
	color = "#23142b"
	taste_description = "repulsive berries"

/datum/reagent/herb/herbdrow/ground
	name = "herb drow extract"
	description = ""
	color = "#23142b"
	taste_description = "repulsive berries"

/datum/reagent/herb/herbdrow/good
	name = "herb drow extract"
	description = ""
	color = "#23142b"
	taste_description = "repulsive berries"

/datum/reagent/herb/herbdrow/bad
	name = "herb drow extract"
	description = ""
	color = "#23142b"
	taste_description = "repulsive berries"

/datum/reagent/herb/herbdrow/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M, TRAIT_NASTY_EATER))
		M.add_nausea(9)
		M.adjustToxLoss(3, 0)
	return ..()

// eyebright variants

/datum/reagent/herb/eyebright
	name = "eyebright extract"
	description = ""
	color = "#f6eafd"
	taste_description = "weeds"

/datum/reagent/herb/eyebright/ground
	name = "eyebright extract"
	description = ""
	color = "#f6eafd"
	taste_description = "weeds"

/datum/reagent/herb/eyebright/good
	name = "eyebright extract"
	description = ""
	color = "#f6eafd"
	taste_description = "weeds"

/datum/reagent/herb/eyebright/bad
	name = "eyebright extract"
	description = ""
	color = "#f6eafd"
	taste_description = "weeds"

// poppy variants

/datum/reagent/herb/poppy
	name = "poppy extract"
	description = ""
	color = "#de5673"
	taste_description = "flowers"

/datum/reagent/herb/poppy/ground
	name = "poppy extract"
	description = ""
	color = "#de5673"
	taste_description = "flowers"

/datum/reagent/herb/poppy/good
	name = "poppy extract"
	description = ""
	color = "#de5673"
	taste_description = "flowers"

/datum/reagent/herb/poppy/bad
	name = "poppy extract"
	description = ""
	color = "#de5673"
	taste_description = "flowers"

// thistle variants

/datum/reagent/herb/thistle
	name = "thistle extract"
	description = ""
	color = "#ecade7"
	taste_description = "weeds"

/datum/reagent/herb/thistle/ground
	name = "thistle extract"
	description = ""
	color = "#ecade7"
	taste_description = "weeds"

/datum/reagent/herb/thistle/good
	name = "thistle extract"
	description = ""
	color = "#ecade7"
	taste_description = "weeds"

/datum/reagent/herb/thistle/bad
	name = "thistle extract"
	description = ""
	color = "#ecade7"
	taste_description = "weeds"
