/datum/patron/inhumen
	name = null
	associated_faith = /datum/faith/inhumen
	undead_hater = FALSE
	confess_lines = list(
		"PSYDON IS THE DEMIURGE!",
		"THE TEN ARE WORTHLESS COWARDS!",
		"THE TEN ARE DECEIVERS!",
	)

/datum/patron/inhumen/zizo
	name = "Zizo"
	domain = "God of Necromancy and Left Hand Magicks"
	desc = "Snow Elf turned God, Zizo taught dark elves to bend the natural world to their will."
	worshippers = "Necromancers, Warlocks, and the Undead"
	confess_lines = list(
		"PRAISE ZIZO!",
		"LONG LIVE ZIZO!",
		"ZIZO IS KING!",
	)

/datum/patron/inhumen/graggar
	name = "Graggar"
	domain = "God of Conquest, Murder and Pillaging"
	desc = "The Heartless One, Graggar taught dark elves that might makes right and created goblins in his image."
	worshippers = "Prisoners, Murderers and the Cruel"
	mob_traits = list(TRAIT_ORGAN_EATER)
	confess_lines = list(
		"GRAGGAR IS THE BEAST I WORSHIP!",
		"GRAGGAR BRINGS UNHOLY DESTRUCTION!",
		"THE BLACK SUN DEMANDS BLOOD!",
	)

/datum/patron/inhumen/matthios		// Removing 'class warfare' language in favor of 'uncivilized v civilized' language.
	name = "Matthios"
	domain = "God of Fire, Sacrifice and those who prey upon Civilization"
	desc = "Man turned God, the 'Giver' Matthios stole fire from Astrata and gave it to primitive Man huddled in darkness and demands the riches flame creates in sacrifice."
	worshippers = "Free-Men, Outlaws and Frontiersmen"
	mob_traits = list(TRAIT_COMMIE)
	confess_lines = list(
		"I SACRIFICE GLADLY TO THE GIVER!",
		"MATTHIOS'S GIFT CONSUME YOU!",
		"THE GIVER IS OWED HIS SACRIFICE!",
	)

/datum/patron/inhumen/baotha
    name = "Baotha"
    domain = "Goddess of Degeneracy, Debauchery and Addiction"
    desc = "Woman turned God, Baotha taught man that life is too short to care for the consequences of their pleasures and leads them to peculiar vices and perversions. "
    worshippers = "Perverts, Gamblers, Drunkards, and Bards"
    mob_traits = list(TRAIT_CRACKHEAD)
    confess_lines = list(
        "BAOTHA DEMANDS PLEASURE!",
        "LIVE, LAUGH, LOVE!",
        "BAOTHA IS MY JOY!",
	)


/* RATWOOD EDIT - Back to the main pantheon
/datum/patron/inhumen/eora
	name = "Eora"
	domain = "Goddess of Degeneracy, Debauchery and Addiction"
	desc = "The Fallen Daughter of Psydon, once used to be a goddess of love and family but has now fallen from grace as she leads mortals to hedonism."
	worshippers = "Drunkards, Junkies, Gamblers and Bards"
	confess_lines = list(
		"EORA BRINGS ME PLEASURE!",
		"EORA BRINGS ME LUCK!",
		"EORA IS MY HAPPINESS!",
	)
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal
*/
