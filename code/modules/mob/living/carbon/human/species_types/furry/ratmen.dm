/mob/living/carbon/human/species/ratpeople
	race = /datum/species/ratpeople

/datum/species/ratpeople
	name = "Rhodian" 
	id = "ratpeople"
	desc = "<b>Rhodian</b><br>\
	The Rodent-Like Rhodians are a race that had faced the rise and fall of their grand capital and survived with a distinct and deep religious divide. \
	Once they were considered no more than Demi-humans that only appeared during the darkest hours of the night to steal and kill, until the one day they broke out of their hovels during the midday sun. \
	Enraptured by the allure of gold in the sky, they built up a city constructed from their previous ill gotten gains, spires of gold and homes of marble, where they worshipped Astrata.<br><br>\
	But lo, did the calling of their old goddess creep into their ears, clawing at the mortar of their empire and their minds. \
	Kretch struck the final blow to their foundations, resulting in 'The Final Feast' that ruined their kingdom, burned their halls, and saw their king cannibalized by his people. \
	Today Rhodians are nothing more than Vagabonds that can never find themselves settled and organized for long. \
	Astrata promises succor, and Kretch subverts it every time."
	default_color = "444"
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAIR,
	)
	inherent_traits = list(TRAIT_NOMOBSWAP)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	attack_verb = "slash"
	liked_food = GROSS | MEAT | FRIED
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	possible_ages = ALL_AGES_LIST
	limbs_icon_m = 'icons/mob/species/male.dmi'
	limbs_icon_f = 'icons/mob/species/female.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'

	offset_features = list(
		OFFSET_ID = list(0,1), OFFSET_GLOVES = list(0,1), OFFSET_WRISTS = list(0,1),\
		OFFSET_CLOAK = list(0,1), OFFSET_FACEMASK = list(0,1), OFFSET_HEAD = list(0,1), \
		OFFSET_FACE = list(0,1), OFFSET_BELT = list(0,1), OFFSET_BACK = list(0,1), \
		OFFSET_NECK = list(0,1), OFFSET_MOUTH = list(0,1), OFFSET_PANTS = list(0,1), \
		OFFSET_SHIRT = list(0,1), OFFSET_ARMOR = list(0,1), OFFSET_HANDS = list(0,1), OFFSET_UNDIES = list(0,1), \
		OFFSET_ID_F = list(0,-1), OFFSET_GLOVES_F = list(0,0), OFFSET_WRISTS_F = list(0,0), OFFSET_HANDS_F = list(0,0), \
		OFFSET_CLOAK_F = list(0,0), OFFSET_FACEMASK_F = list(0,-1), OFFSET_HEAD_F = list(0,-1), \
		OFFSET_FACE_F = list(0,-1), OFFSET_BELT_F = list(0,-1), OFFSET_BACK_F = list(0,-1), \
		OFFSET_NECK_F = list(0,-1), OFFSET_MOUTH_F = list(0,-1), OFFSET_PANTS_F = list(0,0), \
		OFFSET_SHIRT_F = list(0,0), OFFSET_ARMOR_F = list(0,0), OFFSET_UNDIES_F = list(0,0), \
		)
	specstats = list("strength" = 0, "perception" = 1, "intelligence" = -1, "constitution" = 0, "endurance" = 0, "speed" = 1, "fortune" = 1)
	specstats_f = list("strength" = -1, "perception" = 0, "intelligence" = 1, "constitution" = -1, "endurance" = 0, "speed" = 1, "fortune" = 0)
	enflamed_icon = "widefire"
	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes,
		ORGAN_SLOT_EARS = /obj/item/organ/ears,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
		ORGAN_SLOT_TESTICLES = /obj/item/organ/testicles,
		ORGAN_SLOT_PENIS = /obj/item/organ/penis,
		ORGAN_SLOT_BREASTS = /obj/item/organ/breasts,
		ORGAN_SLOT_VAGINA = /obj/item/organ/vagina,
		)
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
		/datum/customizer/organ/tail/ratpeople,
		/datum/customizer/organ/snout/ratpeople,
		/datum/customizer/organ/ears/ratpeople,
		/datum/customizer/organ/testicles/external,
		/datum/customizer/organ/penis/ratpeople,
		/datum/customizer/organ/breasts/animal,
		/datum/customizer/organ/vagina/animal,
		)

	body_marking_sets = list(
		/datum/body_marking_set/none,
		/datum/body_marking_set/bellysocks,
		/datum/body_marking_set/bellysockstertiary,
		/datum/body_marking_set/belly,
	)
	body_markings = list(
		/datum/body_marking/tips,
		/datum/body_marking/belly,
		/datum/body_marking/bellyslim,
		/datum/body_marking/socklonger,
		/datum/body_marking/sock,
		/datum/body_marking/butt,
		/datum/body_marking/tie,
		/datum/body_marking/tiesmall,
		/datum/body_marking/backspots,
		/datum/body_marking/tonage,
	)

/datum/species/ratpeople/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/species/ratpeople/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)

/datum/species/ratpeople/check_roundstart_eligible()
	return TRUE

/datum/species/ratpeople/qualifies_for_rank(rank, list/features)
	return TRUE

/datum/species/ratpeople/get_random_features()
	var/list/returned = MANDATORY_FEATURE_LIST
	var/main_color
	var/second_color
	var/third_color
	var/random = rand(1,6)
	switch(random)
		if(1)
			main_color = "2B2B2B"
			second_color = "32B2B2B"
			third_color = "574533"
		if(2)
			main_color = "2B2B2B"
			second_color = "C0C0C0"
			third_color = "6C4D2E"
		if(3)
			main_color = "DDDACB"
			second_color = "DDDACB"
			third_color = "D89C9E"
		if(4)
			main_color = "7D4B33"
			second_color = "D4BDA8"
			third_color = "D89C9E"
		if(5)
			main_color = "B08771"
			second_color = "D4BDA8"
			third_color = "D89C9E"
		if(6)
			main_color = "603A2D"
			second_color = "785E46"
			third_color = "B86E70"
	returned["mcolor"] = main_color
	returned["mcolor2"] = second_color
	returned["mcolor3"] = third_color
	return returned

/datum/species/vulpkanin/get_random_body_markings(list/passed_features)
	return assemble_body_markings_from_set(GLOB.body_marking_sets_by_type[/datum/body_marking_set/bellysockstertiary], passed_features, src)
