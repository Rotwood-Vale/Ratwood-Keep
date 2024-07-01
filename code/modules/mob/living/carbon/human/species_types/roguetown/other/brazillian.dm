/mob/living/carbon/human/species/brazillian
	race = /datum/species/lizard/brazil

/datum/species/lizard/brazil
	name = "Argonian"
	id = "argonian"
	desc = "<b>Argonian</b><br>\
	A mysterious species of reptilian humanoids hailing from bogs all over Enigma. \
	They speak a strange tongue and are said to be a creation of Dendor himself."

	skin_tone_wording = "Bog"

	species_traits = list(EYECOLOR,LIPS)
	inherent_traits = list(TRAIT_NOMOBSWAP,TRAIT_RETARD_ANATOMY,TRAIT_NASTY_EATER)
	use_skintones = TRUE
	disliked_food = NONE
	liked_food = NONE
	possible_ages = ALL_AGES_LIST
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	limbs_icon_m = 'icons/roguetown/mob/bodies/m/ma.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/f/fa.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	soundpack_m = /datum/voicepack/male/elf
	soundpack_f = /datum/voicepack/female/elf
	exotic_bloodtype = null
	default_features = list("tail_lizard" = "Smooth", "snout" = "Round", "horns" = "None", "frills" = "None", "spines" = "None", "body_markings" = "None")
	mutant_bodyparts = list("tail_lizard", "snout", "frills", "spines", "body_markings")
	mutanttongue = /obj/item/organ/tongue/lizard
	mutanteyes = /obj/item/organ/eyes/night_vision/argonian
	specstats = list(
		"strength" = 0, 
		"perception" = 3, 
		"intelligence" = -3, 
		"constitution" = 0, 
		"endurance" = 1, 
		"speed" = 3, 
		"fortune" = -3,
	)
	specstats_f = list(
		"strength" = 0, 
		"perception" = 3, 
		"intelligence" = -3, 
		"constitution" = 0, 
		"endurance" = 1, 
		"speed" = 3, 
		"fortune" = -3,
	)
	enflamed_icon = "widefire"

/datum/species/lizard/brazil/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/species/lizard/brazil/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)

/datum/species/lizard/brazil/qualifies_for_rank(rank, list/features)
	return TRUE

/datum/species/lizard/brazil/get_skin_list()
	return list(
		"Amazonia" = SKIN_COLOR_AMAZONIA,
		"Serra" = SKIN_COLOR_SERRA,
		"Aquarela" = SKIN_COLOR_AQUARELA,
		"Amor" = SKIN_COLOR_AMOR,
		"Sangue" = SKIN_COLOR_SANGUE,
		"Lama" = SKIN_COLOR_LAMA,
	)

/datum/species/lizard/brazil/random_name(gender,unique,lastname)

	var/randname
	if(unique)
		if(gender == MALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/other/argm.txt") )
				if(!findname(randname))
					break
		if(gender == FEMALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/other/argf.txt") )
				if(!findname(randname))
					break
	else
		if(gender == MALE)
			randname = pick( world.file2list("strings/rt/names/other/argm.txt") )
		if(gender == FEMALE)
			randname = pick( world.file2list("strings/rt/names/other/argf.txt") )
	return randname

/datum/species/lizard/brazil/random_surname()
	return " [pick(world.file2list("strings/rt/names/other/arglast.txt"))]"
