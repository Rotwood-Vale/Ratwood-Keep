/datum/patron/inhumen
	name = null
	associated_faith = /datum/faith/inhumen
	undead_hater = FALSE
	confess_lines = list()

/datum/patron/inhumen/baotha
    name = "Baotha"
    domain = "Goddess of Addiction, Debauchery, Degeneracy, Depraved Artistic Expression"
    desc = "Baotha taught Her followers that life is too short to care for the consequences of their pleasures and expressions. Baotha leads them to peculiar vices and perversions without care for consequences."
    worshippers = "Addicts, Depraved Artists, and Perverts"
    mob_traits = list(TRAIT_CRACKHEAD) // prevents overdoses
    confess_lines = list(
        "BAOTHA DEMANDS PLEASURE!",
        "BAOTHA IS MY QUEEN!",
        "BAOTHA IS MY JOY!",
	)

/datum/patron/inhumen/graggar
	name = "Graggar"
	domain = "God of Conquest, Domination, Murder"
	desc = "Graggar taught His followers that strength is the primary element that one needs to achieve their wants and desires, and that the stronger should dominate the weaker for their own ends."
	worshippers = "Assassins, Conquerors, and Tribals"
	mob_traits = list(TRAIT_ORGAN_EATER) // allows you to eat organs
	confess_lines = list(
		"GRAGGAR IS THE BEAST I WORSHIP!",
		"GRAGGAR SHALL DOMINATE!",
		"THE BLACK SUN DEMANDS BLOOD!",
	)

/datum/patron/inhumen/matthios 
	name = "Matthios"
	domain = "God of Absolute Freedom, Camaraderie, Robbery"
	desc = "Matthios taught His followers that only through robbery and rebellion can one rise above their lot in life, and that the Divine Order of Astrata must be torn down and society rebuilt so that people may attain divinity."
	worshippers = "Brigands, the Greedy, and Revolutionaries"
	mob_traits = list(TRAIT_MATTHIOS_EYES) // shows most expensive item
	confess_lines = list(
		"MATTHIOS STEALS FROM THE WORTHLESS!",
		"MATTHIOS IS JUSTICE!",
		"MATTHIOS IS MY LORD, I SHALL BE HIS MARTYR!",
	)
