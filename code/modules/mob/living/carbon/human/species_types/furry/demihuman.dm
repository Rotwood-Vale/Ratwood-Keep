/mob/living/carbon/human/species/demihuman
	race = /datum/species/demihuman

/datum/species/demihuman
	name = "Half-Kin"
	id = "demihuman"
	desc = "Half-Kin, earth-borne, magyck-touched. Many names exist for my race, characterized by our varied appearance. \
	Wild-Kin are by far the most numerous people due to the fact we are, usually, compatible with almost all other races. \
	Due to the fact we are so numerous, we are welcome almost anywhere, along with our Wild-Kin sister race \
	We are average of constitution, strength, and intellegence."
	skin_tone_wording = "Ancestry"
	default_color = "FFFFFF"
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,STUBBLE,OLDGREY,MUTCOLORS_PARTSONLY)
	inherent_traits = list(TRAIT_NOMOBSWAP)
	default_features = MANDATORY_FEATURE_LIST
	use_skintones = TRUE
	possible_ages = ALL_AGES_LIST
	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = NONE
	liked_food = NONE
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	limbs_icon_m = 'icons/mob/species/male.dmi'
	limbs_icon_f = 'icons/mob/species/female.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	soundpack_m = /datum/voicepack/male
	soundpack_f = /datum/voicepack/female
	offset_features = list(
		OFFSET_ID = list(0,1), OFFSET_GLOVES = list(0,1), OFFSET_WRISTS = list(0,1),\
		OFFSET_CLOAK = list(0,1), OFFSET_FACEMASK = list(0,1), OFFSET_HEAD = list(0,1), \
		OFFSET_FACE = list(0,1), OFFSET_BELT = list(0,1), OFFSET_BACK = list(0,1), \
		OFFSET_NECK = list(0,1), OFFSET_MOUTH = list(0,1), OFFSET_PANTS = list(0,1), \
		OFFSET_SHIRT = list(0,1), OFFSET_ARMOR = list(0,1), OFFSET_HANDS = list(0,1), OFFSET_UNDIES = list(0,1), \
		OFFSET_ID_F = list(0,-1), OFFSET_GLOVES_F = list(0,0), OFFSET_WRISTS_F = list(0,0), OFFSET_HANDS_F = list(0,0), \
		OFFSET_CLOAK_F = list(0,0), OFFSET_FACEMASK_F = list(0,-1), OFFSET_HEAD_F = list(0,-1), \
		OFFSET_FACE_F = list(0,-1), OFFSET_BELT_F = list(0,0), OFFSET_BACK_F = list(0,-1), \
		OFFSET_NECK_F = list(0,-1), OFFSET_MOUTH_F = list(0,-1), OFFSET_PANTS_F = list(0,0), \
		OFFSET_SHIRT_F = list(0,0), OFFSET_ARMOR_F = list(0,0), OFFSET_UNDIES_F = list(0,0), \
		)
	specstats = list("strength" = 0, "perception" = 1, "intelligence" = -1, "constitution" = 0, "endurance" = 1, "speed" = -1, "fortune" = 0)
	specstats_f = list("strength" = -1, "perception" = 0, "intelligence" = 2, "constitution" = -1, "endurance" = 0, "speed" = 1, "fortune" = 0)
	enflamed_icon = "widefire"
	bodypart_features = list(
		/datum/bodypart_feature/hair/head,
		/datum/bodypart_feature/hair/facial,
	)
	customizers = list(
		/datum/customizer/organ/eyes/humanoid,
		/datum/customizer/bodypart_feature/hair/head/humanoid,
		/datum/customizer/bodypart_feature/hair/facial/humanoid,
		/datum/customizer/bodypart_feature/accessory,
		/datum/customizer/bodypart_feature/face_detail,
		/datum/customizer/organ/ears/demihuman,
		/datum/customizer/organ/horns/demihuman,
		/datum/customizer/organ/tail/demihuman,
		/datum/customizer/organ/testicles/human,
		/datum/customizer/organ/penis/canine,
		/datum/customizer/organ/breasts/animal,
		/datum/customizer/organ/belly/animal,
		/datum/customizer/organ/vagina/animal,
		)
	body_marking_sets = list(
		/datum/body_marking_set/none,
		/datum/body_marking_set/socks,
	)
	body_markings = list(
		/datum/body_marking/tonage,
		/datum/body_marking/socklonger,
		/datum/body_marking/tips,
	)

/datum/species/demihuman/check_roundstart_eligible()
	return TRUE

/datum/species/demihuman/qualifies_for_rank(rank, list/features)
	return TRUE

/datum/species/demihuman/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/species/demihuman/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)

/datum/species/demihuman/get_random_features()
	var/list/returned = MANDATORY_FEATURE_LIST
	var/main_color
	var/random = rand(1,8)
	//Choose from a variety of mostly brightish, animal, matching colors
	switch(random)
		if(1)
			main_color = ORANGE_FUR
		if(2)
			main_color = LIGHTGREY_FUR
		if(3)
			main_color = DARKGREY_FUR
		if(4)
			main_color = LIGHTORANGE_FUR
		if(5)
			main_color = LIGHTBROWN_FUR
		if(6)
			main_color = WHITEBROWN_FUR
		if(7)
			main_color = DARKBROWN_FUR
		if(8)
			main_color = BLACK_FUR
	returned["mcolor"] = main_color
	returned["mcolor2"] = main_color
	returned["mcolor3"] = main_color
	return returned

/datum/species/demihuman/get_skin_list()
	return list(
		"Grenzelhoft" = SKIN_COLOR_GRENZELHOFT,
		"Hammerhold" = SKIN_COLOR_HAMMERHOLD,
		"Avar" = SKIN_COLOR_AVAR,
		"Rockhill" = SKIN_COLOR_ROCKHILL,
		"Otava" = SKIN_COLOR_OTAVA,
		"Etrusca" = SKIN_COLOR_ETRUSCA,
		"Gronn" = SKIN_COLOR_GRONN,
		"Giza" = SKIN_COLOR_GIZA,
		"Shalvistine" = SKIN_COLOR_SHALVISTINE,
		"Lalvestine" = SKIN_COLOR_LALVESTINE,
		"Ebon" = SKIN_COLOR_EBON,
	)
